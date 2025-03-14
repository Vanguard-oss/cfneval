Feature: You can And two existing Conditions inside of a new Condition

  Scenario: One condition is true
    Given the inline cfn template:
      """
      Conditions:
        myCondition1: !Equals [ "us-east-1", !Ref AWS::Region ]
        myCondition2: !Equals [ "123456789012", !Ref AWS::AccountId ]
        myAndCondition: !And [ !Condition myCondition1, !Condition myCondition2 ]
      """
    When I evaluate the template
    Then the Condition "myAndCondition" is true

  Scenario: One condition is true
    Given the inline cfn template:
      """
      Conditions:
        myCondition1: !Equals [ "us-east-1", !Ref AWS::Region ]
        myCondition2: !Equals [ "us-east-2", !Ref AWS::Region ]
        myAndCondition: !And [ !Condition myCondition1, !Condition myCondition2 ]
      """
    When I evaluate the template
    Then the Condition "myAndCondition" is false

  Scenario: Both conditions are false
    Given the inline cfn template:
      """
      Conditions:
        myCondition1: !Equals [ "us-west-1", !Ref AWS::Region ]
        myCondition2: !Equals [ "us-east-2", !Ref AWS::Region ]
        myAndCondition: !And [ !Condition myCondition1, !Condition myCondition2 ]
      """
    When I evaluate the template
    Then the Condition "myAndCondition" is false
