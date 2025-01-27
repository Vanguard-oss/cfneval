Feature: You can Not an existing Condition inside of a new Condition

  Scenario: Not a Condition
  Given the inline cfn template:
  """
  Conditions:
    myCondition: !Equals [ "us-east-1", !Ref AWS::Region ]
    myNotCondition: !Not [ !Condition myCondition ]
  """
  When I evaluate the template
  Then the Condition "myNotCondition" is false
