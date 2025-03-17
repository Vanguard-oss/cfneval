Feature: When you Ref an SSM::Parameter, you get the name of the parameter

  Scenario: An output can chain two GetAtt calls together
    Given the inline cfn template:
      """
      Parameters:
        MyName:
          Type: String
          Default: something
      Resources:
        MyResourceA:
          Type: AWS::SSM::Parameter
          Properties:
            Type: String
            Value: ABC
        MyResourceB:
          Type: AWS::SSM::Parameter
          Properties:
            Type: String
            Value: !GetAtt MyResourceA.Value
      Outputs:
        MyResourceValue:
          Value: !GetAtt MyResourceB.Value
      """
    When I evaluate the template
    Then the Output "MyResourceValue" will be set to "ABC"

  Scenario: An output can chain a GetAtt call with a Ref call
    Given the inline cfn template:
      """
      Parameters:
        MyName:
          Type: String
          Default: something
      Resources:
        MyResourceA:
          Type: AWS::SSM::Parameter
          Properties:
            Type: String
            Value: ABC
        MyResourceB:
          Type: AWS::SSM::Parameter
          Properties:
            Type: String
            Value: !Ref MyResourceA
      Outputs:
        MyResourceValue:
          Value: !GetAtt MyResourceB.Value
      """
    When I evaluate the template
    Then the Output "MyResourceValue" will be set to "mystack-MyResourceA-ABCDEF"

  Scenario: An output can chain a Ref call with a GetAtt call
    Given the inline cfn template:
      """
      Parameters:
        MyName:
          Type: String
          Default: something
      Resources:
        MyResourceA:
          Type: AWS::SSM::Parameter
          Properties:
            Type: String
            Value: !Ref MyName
        MyResourceB:
          Type: AWS::SSM::Parameter
          Properties:
            Name: !GetAtt MyResourceA.Value
      Outputs:
        MyResourceValue:
          Value: !Ref MyResourceB
      """
    When I evaluate the template
    Then the Output "MyResourceValue" will be set to "something"
