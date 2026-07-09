#!/bin/bash

rm -rf public
mkdir -p public

cp src/index.html public/index.html
cp src/style.css public/style.css

for project in src/projects/*; do
  [ -d "$project" ] || continue

  slug=$(basename "$project")

  mkdir -p "public/projects/$slug"
  mkdir -p "public/projects/$slug/posts"

  cp "$project/style.css" "public/projects/$slug/style.css"

  pandoc "$project/index.md" \
    --standalone \
    --template="$project/template.html" \
    -o "public/projects/$slug/index.html"

  for post in "$project"/posts/*.md; do
    [ -f "$post" ] || continue

    name=$(basename "$post" .md)

    pandoc "$post" \
      --standalone \
      --template="$project/template.html" \
      -o "public/projects/$slug/posts/$name.html"
  done
done
