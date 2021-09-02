# CodeHerd API

This API provides data storage and retrieval for the CodeHerd frontend. This project is a project management solution for Turing students allowing them to keep all necessary project materials and links in one place to combat the split nature of typical project management.

## Setup

- clone repo
- bundle install

## Testing

- rspec

## Seeing the graphql queries and mutations

https://codeherdapi.herokuapi.com

## Generate Graphql docs

make sure you download the npm package graphdocs npm install -g @2fd/graphdoc

you'll need to start a local server or ping the deployed. This will put the files in the public folder for rails to serve

```
graphdoc -e http://localhost:3000/graphql -o ./public
```

