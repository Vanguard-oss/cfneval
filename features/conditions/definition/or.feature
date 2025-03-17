Feature: You can Or two existing Conditions inside of a new Condition

  Scenario: One condition is true
    Given the inline cfn template:
      """
      Conditions:
        myCondition1: !Equals [ "us-east-1", !Ref AWS::Region ]
        myCondition2: !Equals [ "us-east-2", !Ref AWS::Region ]
        myOrCondition: !Or [ !Condition myCondition1, !Condition myCondition2 ]
      """
    When I evaluate the template
    Then the Condition "myOrCondition" is true

  Scenario: Both conditions are false
    Given the inline cfn template:
      """
      Conditions:
        myCondition1: !Equals [ "us-west-1", !Ref AWS::Region ]
        myCondition2: !Equals [ "us-east-2", !Ref AWS::Region ]
        myOrCondition: !Or [ !Condition myCondition1, !Condition myCondition2 ]
      """
    When I evaluate the template
    Then the Condition "myOrCondition" is false
