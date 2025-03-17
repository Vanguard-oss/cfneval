# behave steps

## Given the cfn template "path"

Load the CloudFormation template in either json or yaml format.

**Parameters**

- filename - relative path to the CloudFormation template to load

## Given the resource "name" will output

Mock out a resource so that it will output specific attributes.  This will work for custom and standard resources.

**Parameters**

- name - name of the resource that will be mocked out

**Examples**
*Template*
```
  Resources:
    MyPS:
      Type: Custom::Parameter
  Outputs:
    MyOutput1:
      Value: !GetAtt MyPS.MyAttribute
```

*Feature file*
```
Feature: Example mock
  Scenario: A resource is mocked out
  Given the cfn template "my-template.yaml"
  And the resource "MyPS" will output:
  """
  {
    "MyAttribute": "MyValue"
  }
  """
  When I evaluate the template
  Then the Output "MyOutput1" will be set to "MyValue"
```

## Given I have params

Add the table of parameters to the set that will be used when evaluating the template.  You can all this step multiple times to accumulate parameters.

**Examples**

*Template*
```
Parameters:
  MyParam:
    Type: String
    Default: something
Resources:
  MyPS:
    Type: AWS::SSM::Parameter
    Properties:
      Name: MyParamStoreEntry
      Type: String
      Value: !Ref MyParam
```

*Feature file*
```
Feature: Add parameters
  Scenario: Parameter table
  Given the cfn template "my-template.yaml"
  And I have params:
    | key         | value   |
    | MyParam     | MyValue |
  When I evaluate the template
  Then the Resource "MyPS" path "Properties.Value" matches "MyValue"
```

## When I evaluate the template

Evaluates the template and generates the effective template.

## Then the Condition "name" is true

Verifies that the Condition was on in the effective template.

**Parameters**

- name - name of the condition that will be checked

## Then the Condition "name" is false

Verifies that the Condition was off in the effective template.

**Parameters**

- name - name of the condition that will be checked

## Then the Resource "name" will not be created

Verifies that the Resource will not be created because it has a Condition that was evaluated to be off

**Parameters**

- name - name of the resource that will be checked

## Then the Resource "name" will be created

Verifies that the Resource will be created because it has a Condition that was evaluated to be on

**Parameters**

- name - name of the resource that will be checked

## Then the Resource "name" path "expr" exists

Verifies that the effective template for the resource contains something at the path.

**Parameters**

- name - name of the resource that will be checked
- expr - A JsonPath expression for the path that will be validated

## Then the Resource "name" path "expr" does not exist

Verifies that the effective template for the resource does not contain something at the path.

**Parameters**

- name - name of the resource that will be checked
- expr - A JsonPath expression for the path that will be validated

## Then the Resource "name" path "expr" contains "value"

Verifies that the effective value for the path inside of the resource is an array that contains the value

**Parameters**

- name - name of the resource that will be checked
- expr - A JsonPath expression for the path that will be validated
- value - the value that should be in the list

## Then the Resource "name" path "expr" length is "value"

Verifies that the effective value for the path inside of the resource is an array that has the specific length

**Parameters**

- name - name of the resource that will be checked
- expr - A JsonPath expression for the path that will be validated
- value - the length that the list should have

## Then the Resource "name" path "expr" matches "value"

Verifies that the effective value for the path inside of the resource matches the expected value

**Parameters**

- name - name of the resource that will be checked
- expr - A JsonPath expression for the path that will be validated
- value - the value that should exist in the effective template

## Then the Output "name" will be set to "value"

Verifies that the specified Output in the effective template has the expected value.

**Parameters**

- name - name of the output that will be checked
- value - expected value of the output

**Examples**
*Template*
```
  Resources:
    MyPS:
      Type: Custom::Parameter
  Outputs:
    MyOutput1:
      Value: !GetAtt MyPS.MyAttribute
```

*Feature file*
```
Feature: Example mock
  Scenario: A resource is mocked out
  Given the cfn template "my-template.yaml"
  And the resource "MyPS" will output:
  """
  {
    "MyAttribute": "MyValue"
  }
  """
  When I evaluate the template
  Then the Output "MyOutput1" will be set to "MyValue"
```

## Then the Output "name" will not be created

Verifies that the Output will not be created because it has a Condition that was evaluated to be off

**Parameters**

- name - name of the output that will be checked

## Then the Output "name" will be created

Verifies that the Output will be created because it has a Condition that was evaluated to be on

**Parameters**

- name - name of the output that will be checked
