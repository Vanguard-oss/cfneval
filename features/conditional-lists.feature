Feature: Lists that have conditions will have the null values removed

  Scenario: A list with no NoValues will remain the same length
    Given the inline cfn template:
      """
      Parameters:
        MyParam:
          Type: String
          Default: something
      Conditions:
        myCondition: !Equals [ "us-east-1", !Ref AWS::Region ]
      Resources:
        MyResource:
          Type: Custom::Resource
          Properties:
            ListValue: [ "A", !If [ myCondition, "B", "C" ] ]
      """
    When I evaluate the template
    Then the Resource "MyResource" path "Properties.ListValue[0]" matches "A"
    And the Resource "MyResource" path "Properties.ListValue[1]" matches "B"
    And the Resource "MyResource" path "Properties.ListValue" length is "2"

  Scenario: A list with a NoValue will change length
    Given the inline cfn template:
      """
      Parameters:
        MyParam:
          Type: String
          Default: something
      Conditions:
        myCondition: !Equals [ "us-east-1", !Ref AWS::Region ]
      Resources:
        MyResource:
          Type: Custom::Resource
          Properties:
            ListValue: [ "A", !If [ myCondition, !Ref AWS::NoValue, "C" ] ]
      """
    When I evaluate the template
    Then the Resource "MyResource" path "Properties.ListValue[0]" matches "A"
    And the Resource "MyResource" path "Properties.ListValue" contains "A"
    And the Resource "MyResource" path "Properties.ListValue" length is "1"

  Scenario: A list can drop to zero length
    Given the inline cfn template:
      """
      Parameters:
        MyParam:
          Type: String
          Default: something
      Conditions:
        myCondition: !Equals [ "us-east-1", !Ref AWS::Region ]
      Resources:
        MyResource:
          Type: Custom::Resource
          Properties:
            ListValue: [ !If [ myCondition, !Ref AWS::NoValue, "C" ] ]
      """
    When I evaluate the template
    Then the Resource "MyResource" path "Properties.ListValue" length is "0"

  Scenario Outline: Selects are lazy-evaluated
    Some libraries that evaluate CloudFormation will evaluate Select intrinsics
    even when the If condition should prevent it from evaluating.  This test
    case ensures that when a Condition is off, then the Select isn't evaluated.
    If it were evaluated, then this scenario would throw an IndexError.

    Given the inline cfn template:
      """
      Parameters:
        MyParams:
          Type: String
          Default: <param>
        MyParam1Enabled:
          Type: String
          Default: <p1>
        MyParam2Enabled:
          Type: String
          Default: <p2>
        MyParam3Enabled:
          Type: String
          Default: <p3>
      Conditions:
        myCondition1: !Equals [ Y, !Ref MyParam1Enabled ]
        myCondition2: !Equals [ Y, !Ref MyParam2Enabled ]
        myCondition3: !Equals [ Y, !Ref MyParam3Enabled ]
      Resources:
        MyResource:
          Type: Custom::Resource
          Properties:
            Value: !Join
              - "/"
              - - !If [ myCondition1, !Select [ 0, !Split [ ",", !Ref MyParams ] ], !Ref AWS::NoValue ]
                - !If [ myCondition2, !Select [ 1, !Split [ ",", !Ref MyParams ] ], !Ref AWS::NoValue ]
                - !If [ myCondition3, !Select [ 2, !Split [ ",", !Ref MyParams ] ], !Ref AWS::NoValue ]
      """
    When I evaluate the template
    Then the Resource "MyResource" path "Properties.Value" matches "<output>"

    Examples:
      | param | p1 | p2 | p3 | output |
      | A     | Y  | N  | N  | A      |
      | A,B   | Y  | Y  | N  | A/B    |
      | A,B,C | Y  | Y  | N  | A/B    |
      | A,B,C | Y  | Y  | Y  | A/B/C  |
