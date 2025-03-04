# README

Apple Coding Challenge

ruby 3.3.6
rails 8.0.1

## Install

```
git clone git@github.com:darrenterhune/applecodingchallenge.git
cd applecodingchallenge
bin/setup
bin/dev
```

Turn caching on: `rails dev:cache`

http://localhost:3000

Run rubocop, fasterer, bundle-audit, erb-lint and brakeman:

```
script/lint
```

## Notes

Some things I'd do differently

- Write system specs for integration testing the search and results better.
- I would not normally test APIs directly, like in the request spec. I would normally use webmock and block requests and define a response object.
- Look at the API docs more closely before jumping in, I unfortunately didn't do this and spent a good hour before I knew I'd be making two requests to get the data I needed.

I know the request said not to use Ai/ChatGPT, but I wanted to use d3 and get some charts up to show the data better instead of just displaying the data in plain text in erb. So I did use Grok to help with the chart generation part of d3. Honesty here.
