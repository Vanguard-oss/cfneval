Feature: Resources can be conditional

  Scenario: A resource with a true condition
    Given the inline cfn template:
      """
      Conditions:
        myCondition: !Equals [ "us-east-1", !Ref AWS::Region ]
      Resources:
        MyPS:
          Type: AWS::SSM::Parameter
          Condition: myCondition
          Properties:
            Name: MyParamStoreEntry
            Type: String
            Value: "ABC"
      """
    When I evaluate the template
    Then the Resource "MyPS" will be created

  Scenario: A resource with a false condition
    Given the inline cfn template:
      """
      Conditions:
        myCondition: !Equals [ "us-east-2", !Ref AWS::Region ]
      Resources:
        MyPS:
          Type: AWS::SSM::Parameter
          Condition: myCondition
          Properties:
            Name: MyParamStoreEntry
            Type: String
            Value: "ABC"
      """
    When I evaluate the template
    Then the Resource "MyPS" will not be created
