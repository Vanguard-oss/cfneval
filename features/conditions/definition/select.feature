Feature: The Select intrinsic can be used inside of a Condition

  Scenario: Equals with Select evaluates to true
    Given the inline cfn template:
      """
      Parameters:
        MyParam:
          Default: "a,b"
          Type: CommaDelimitedList
      Conditions:
        myCondition: !Equals [ "b", !Select [ 1, !Ref MyParam ] ]
      """
    When I evaluate the template
    Then the Condition "myCondition" is true

  Scenario: Equals with Select evaluates to false
    Given the inline cfn template:
      """
      Parameters:
        MyParam:
          Default: "a,b"
          Type: CommaDelimitedList
      Conditions:
        myCondition: !Equals [ "a", !Select [ 1, !Ref MyParam ] ]
      """
    When I evaluate the template
    Then the Condition "myCondition" is false

  Scenario: An Or will lazy evaluate Select statements
    Given the inline cfn template:
      """
      Parameters:
        MyParam:
          Default: "a,b"
          Type: CommaDelimitedList
      Conditions:
        myCondition: !Or
          - !Equals [ "us-east-1", !Ref AWS::Region ]
          - !Equals [ "b", !Select [ 2, !Ref MyParam ] ]
      """
    When I evaluate the template
    Then the Condition "myCondition" is true
