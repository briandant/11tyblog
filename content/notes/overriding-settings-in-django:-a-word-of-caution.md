---
tags: note
layout: layouts/note.liquid
title: "overriding settings in django: a word of caution"
date: "git Created"
---

We've been using a pattern for stubs in `settings.py`.  It allows us to create a stub class for, e.g., the a LLM wrapper—we don't want to actually hit the API. Then, if we're running tests, the stub class will be used.  It looks something like this:

```python
# settings.py
if len(sys.argv) > 1 and sys.argv[0] == "tests":
    LLM = stubs.LLMStub()
else:
    LLM = real.LLM()
```

The idea is that, throughout our code, we can use this setting, and the rest will fall in place:

```python
from django.conf import settings

class IUseAnLLM:
    def __init__(self):
        self.llm = settings.LLM

    def do_stuff(self):
        response = self.llm.query("foo")
```

In `do_stuff()`, the stub will be used, when we're testing.

That's all good, but when I want to raise an exception in `do_stuff()`, and test that the code is responding well, I have to "mock" that stub.  Since the class to be mocked is in `settings.py`, you can't mock it; Django doesn't treat that like a normal model, so there's warnings to not treat it as a module.  Instead, Django offers alternative interfaces to override settings.  In a test, one way to do it is like this:

```python
class MyTestCase:
    def test_a_thing(self):
        with self.settings(MYSETTING="anothervalue")
```

It all works rather seemlessly, until I do the following.  There's some service class that wants to take an alternate llm; you might want to hit Gemini, then ChatGPT in the next call.

```python
class ServiceThatUsesLLM:
    def __init__(self, llm: LLMBase = settings.LLM):
        self.llm = llm 
```

Then, in the test, I want to mock the `llm.query` method, so that it raises an exception and I can test that the code does what it should.

```python
class LLMExceptionTestCase(TestCase):
    def test_exception(self):
        class ExceptionLLM:
            def query(*args):
                raise ResourceExhausted
        
        service = IUseAnLLM()
        with self.settings(LLM=ExceptionLLM()):
            self.assertRaises(ResourceExhausted):
                service.do_stuff()
```

The test will fail, because the service is instantiated outside of the `self.settings` modification.  

Maybe that's obvious, in hindsight, but there was enough complexity here that I was thrown off for a minute (er, maybe a little longer ;).

I thought for a second that the issue was related to [`function-call-in-default-argument`](https://docs.astral.sh/ruff/rules/function-call-in-default-argument/#function-call-in-default-argument-b008), from `flake-8-bugbear`.  But that's a little different.  My issue was with handling Django settings properly, not with the function definition, though it's worth noting the rationale against the `function-call-in-def`:

> Any function call that's used in a default argument will only be performed once, at definition time. The returned value will then be reused by all calls to the function, which can lead to unexpected behaviour.

So you'd be thinking "my function, under these conditions, will return X," but it's actually that your function will return whatever it would under the conditions as they were at definition time.
