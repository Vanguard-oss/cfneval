Feature: When you Ref an SSM::Parameter, you get the name of the parameter

  Scenario: An output Refs a param store resource
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
        MyOutput:
          Value: !Ref MyPS
      """
    When I evaluate the template
    Then the Output "MyOutput" will be set to "MyParamStoreEntry"
