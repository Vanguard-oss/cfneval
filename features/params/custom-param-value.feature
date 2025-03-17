Feature: Parameters can have values set

  Scenario: Copy the default param value to an output
    Given the inline cfn template:
      """
      Parameters:
        MyParam:
          Type: String
          Default: something
      Outputs:
        MyOutput:
          Value: !Ref MyParam
      """
    And I have params
      | key     | value |
      | MyParam | else  |
    When I evaluate the template
    Then the Output "MyOutput" will be created
    And the Output "MyOutput" will be set to "else"

  Scenario: Copy the default param value to the input of a resource
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
      """
    And I have params
      | key     | value |
      | MyParam | else  |
    When I evaluate the template
    Then the Resource "MyPS" path "Properties.Value" matches "else"
