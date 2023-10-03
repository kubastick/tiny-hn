# TinyHN - Tiny HackerNews - Flutter Client App
A Tiny [HackerNews](https://news.ycombinator.com/news) client app created for fun using Flutter.  
Work in progress

## Goals/non-goals of this project
- This app should support offline caching of HackerNews articles
- It should support background refresh and updating cache of articles through official HackerNews API
- It shouldn't require any backend infrastructure other than official HackerNews API
- It should support local notifications
- It should use MaterialUI from Flutter with minimal customization - creating heavily customised UI  
with custom components is time consuming, and not very important for fun side-project like this

## Code requirements
- Try to target at least 60% code coverage using all four test kinds - i.e. unit, widget, golden and
integration tests
- Try following Uncle's Bob clean code and clean architecture principles

## Code formatting
- Run `dart format . -l 120`

## Commit names
https://www.conventionalcommits.org/en/v1.0.0/