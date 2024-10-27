tailwindwatch: 
	npx tailwindcss -i ./input.css -o ./_site/output.css --watch

eleventyserve:
	npx @11ty/eleventy --serve

build: 
	npm install
	npx tailwindcss -i ./input.css -o ./_site/output.css
	npx @11ty/eleventy
