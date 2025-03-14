Feature: The Equals intrinsic can be used in a Condition

  Scenario: Equals evaluates to true
    Given the inline cfn template:
      """
      Conditions:
        myCondition: !Equals [ "us-east-1", !Ref AWS::Region ]
      """
    When I evaluate the template
    Then the Condition "myCondition" is true

  Scenario: Equals evaluates to false
    Given the inline cfn template:
      """
      Conditions:
        myCondition: !Equals [ "us-east-2", !Ref AWS::Region ]
      """
    When I evaluate the template
    Then the Condition "myCondition" is false
