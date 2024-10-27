#!/bin/bash

TYPE=$1
TITLE=$2
TEMPLATE_FILE="./templates/page.md.template"

slugify() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]' | tr ' ' '-'
}

SLUG=$(slugify "$TITLE")

OUTPUT_FILE="./content/${TYPE}s/${SLUG}.md"
cp $TEMPLATE_FILE $OUTPUT_FILE

# Replace the placeholder with the title
sed -i '' "s/{{TITLE}}/${TITLE}/g" $OUTPUT_FILE
sed -i '' "s/{{TYPE}}/${TYPE}/g" $OUTPUT_FILE
code $OUTPUT_FILE
