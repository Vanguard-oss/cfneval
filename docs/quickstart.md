# Quickstart Guide

## Folder Structure

The base of your CloudFormation project should have a folder called **features**.  Within the **features** folder, you can put Feature files or folders containing feature files.  For example, your directory structure could look like this:

```
templates/myStack.yaml
features/basic.feature
features/ec2/asg.feature
```


## Your First Feature

Create your first feature called **features/basic.feature** and put the following:

```
Feature: Basic test case

  Scenario: Basic Scenario
    Given the cfn template "templates/myStack.yaml"
    When I evaluate the template
    Then the Output "MyOutput" will be set to "something"
```

Change the path to the template and the output you want to check.  For a full list of steps that you can do, go to the [Step Reference](https://github.com/Vanguard-oss/cfneval/blob/master/docs/reference.md).

## Run the tests

Run the *behave-cfn* command to run the behavior tests.  Every feature file will get run.  If any scenarios don't meet their expectations, then the command will fail.