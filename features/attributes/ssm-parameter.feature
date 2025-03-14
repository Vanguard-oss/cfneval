Feature: When you GetAtt an SSM::Parameter, you get the type and value

  Scenario: An output gets a param store resource's attributes
    Given the inline cfn template:
      """
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
      Outputs:
        MyOutput1:
          Value: !GetAtt MyPS.Type
        MyOutput2:
          Value: !GetAtt MyPS.Value
      """
    When I evaluate the template
    Then the Output "MyOutput1" will be set to "String"
    And the Output "MyOutput2" will be set to "something"
