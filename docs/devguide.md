# Development Guide

## Development Tools

### Python Code Formatter

`black` is used as the Python code formatter.  All code should be formatted prior to submitting a PR.

### Python Import Organization

`importanize` is used as the Python import organizer.  All imports should be organized prior to submitting a PR.

### Gherkins Code Formatter

`reformat-gherkin` is used as the Gherkins/Feature code formatter.  All feature files should be formatted prior to submitting a PR.

### Markdown Formatter

`mdformat` is used as the Markdown formatter.  All docs should be formatted prior to submitting a PR.

## Compatability

`cfneval` supports Python >= 3.9.  It should also run on Linux, Mac and Windows

## Test Suite

`cfneval` uses behave to test itself.

### Internal steps

There are some internal `Given`, `When`, `Then` steps that are used to make it easier to test the `cfneval` code base.

