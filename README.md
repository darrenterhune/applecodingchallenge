# README

Apple Coding Challenge

## Install

```
git clone git@github.com:darrenterhune/applecodechallenge.git
cd applecodechallenge
bin/setup
rails s
```

Turn caching on: `rails dev:cache`

http://localhost:3000

Unfortunately the API I choose, only allows you to enter a name of a city etc. Regardless this stil does the same functionality requested. Should have read the API docs before diving into it.

## Notes

Some things I'd do differently

- Write system specs for integration testing the search and results better.
- I would not normally test APIs directly, like in the request spec. I would normally use webmock and block requests and define a response object.
- I'd probably have better error responses/unity between the two ruby classes that do the API requests.
- Look at the API docs more closely before jumping in, I unfortunately did this and spent a good hour before I knew I'd be making two requests to get the data I needed.

I know the request said not to use Ai/ChatGPT, but I wanted to use d3 and get some charts up to show the data better instead of just displaying the data in plain text in erb. So I did use Grok to help with the chart generation part of d3. Honesty here.
