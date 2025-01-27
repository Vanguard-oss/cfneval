Feature: You can use a mock response for the attributes of a custom resource

  Scenario: An output gets a param store resource's attributes
  Given the inline cfn template:
  """
  Resources:
    MyPS:
      Type: Custom::Parameter
  Outputs:
    MyOutput1:
      Value: !GetAtt MyPS.Type
  """
  And the resource "MyPS" will output:
  """
  {
    "Type": "String"
  }
  """
  When I evaluate the template
  Then the Output "MyOutput1" will be set to "String"
