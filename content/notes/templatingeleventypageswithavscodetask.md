---
tags: note
layout: layouts/note.liquid
title: templating eleventy pages with a vs code task
---

With VS Code open, I want to quickly create a note.  I created a VS Code Task and a shell script to do the templating work.

The workflow is:

1. Type `task init page` in the VS Code command pallette
2. Select a page type from the dropdown
3. Give it a tile

The templating script then takes that info, makes the file, puts it in the right directory, and modifies the content.  

```javascript
.vscode/tasks.json
---
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "init page",
            "type": "shell",
            "command": "./makepage.sh",
            "args": [
                "${input:type}",
                "${input:title}"
            ],
            "problemMatcher": []
        }
    ],
    "inputs": [
        {
            "id": "type",
            "type": "pickString",
            "description": "Select the type of page",
            "options": [
                "note",
                "link"
            ]
        },
        {
            "id": "title",
            "type": "promptString",
            "description": "Enter the title"
        },
    ]
}
```

The shell script:

```sh
#!/bin/bash

TYPE=$1
TITLE=$2
TEMPLATE_FILE="./templates/page.md.template"

slugify() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '-'
}

SLUG=$(slugify "$TITLE")

OUTPUT_FILE="./content/${TYPE}s/${SLUG}.md"
cp $TEMPLATE_FILE $OUTPUT_FILE

# Replace the placeholder with the title
sed -i '' "s/TITLE/${TITLE}/g" $OUTPUT_FILE
sed -i '' "s/TYPE/${TYPE}/g" $OUTPUT_FILE
code $OUTPUT_FILE
```

The template:

```md
---
tags: TYPE
layout: layouts/TYPE.liquid
title: TITLE
---
```

Grab all this from [the repo](https://github.com/briandant/11tyblog), if you'd like.

An even better workflow would be:

1. Run the task from any VS Code Workspace
2. Have it create the `.md` file in my local blog repo
3. Open the `.md` in the current Workspace, so I can keep open whatever code I'm working on
4. Be able to save, commit, and push the page from that open Workspace

This brought to mind an [old question](https://unix.stackexchange.com/questions/30127/whats-the-quickest-way-to-add-text-to-a-file-from-the-command-line) I asked on `unix.stackexchange`.  I got 44 upvotes for asking how to create a quick note from the command line.  I'm always fascinated with where questions go—how many ppl. they reach, and so on.  In this case, I guess I'm still thinking about how to take notes, 13 years later.
