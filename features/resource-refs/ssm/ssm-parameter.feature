Feature: When you Ref an SSM::Parameter, you get the name of the parameter

  Scenario: An output Refs an un-named resource
    Given the inline cfn template:
      """
      Parameters:
        MyName:
          Type: String
          Default: something
      Resources:
        MyResource:
          Type: AWS::SSM::Parameter
          Properties:
            Type: String
            Value: ABC
      Outputs:
        MyRef:
          Value: !Ref MyResource
        MyResourceType:
          Value: !GetAtt MyResource.Type
        MyResourceValue:
          Value: !GetAtt MyResource.Value
      """
    When I evaluate the template
    Then the Output "MyRef" will be set to "mystack-MyResource-ABCDEF"
    And the Output "MyResourceType" will be set to "String"
    And the Output "MyResourceValue" will be set to "ABC"

  Scenario: An output Refs an named resource
    Given the inline cfn template:
      """
      Parameters:
        MyName:
          Type: String
          Default: something
      Resources:
        MyResource:
          Type: AWS::SSM::Parameter
          Properties:
            Name: !Ref MyName
            Type: String
            Value: ABC
      Outputs:
        MyRef:
          Value: !Ref MyResource
        MyResourceType:
          Value: !GetAtt MyResource.Type
        MyResourceValue:
          Value: !GetAtt MyResource.Value
      """
    When I evaluate the template
    Then the Output "MyRef" will be set to "something"
    And the Output "MyResourceType" will be set to "String"
    And the Output "MyResourceValue" will be set to "ABC"
