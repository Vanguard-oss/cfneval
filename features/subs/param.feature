Feature: A Sub can use a parameter

  Scenario: Copy the default param value to an output
    Given the inline cfn template:
      """
      Parameters:
        MyParam:
          Type: String
          Default: something
      Outputs:
        MyOutput:
          Value: !Sub "${MyParam}"
      """
    When I evaluate the template
    Then the Output "MyOutput" will be created
    And the Output "MyOutput" will be set to "something"

  Scenario: Make sure extra brackets don't mess things up
    Given the inline cfn template:
      """
      Parameters:
        MyParam:
          Type: String
          Default: something
      Resources: {}
      Outputs:
        MyOutput:
          Value: !Sub "{not_a_ref} ${MyParam}"
      """
    When I evaluate the template
    Then the Output "MyOutput" will be created
    And the Output "MyOutput" will be set to "{not_a_ref} something"

  Scenario: Make sure dollar sign don't mess things up
    Given the inline cfn template:
      """
      Parameters:
        MyParam:
          Type: String
          Default: something
      Resources: {}
      Outputs:
        MyOutput:
          Value: !Sub "$not_a_ref ${MyParam}"
      """
    When I evaluate the template
    Then the Output "MyOutput" will be created
    And the Output "MyOutput" will be set to "$not_a_ref something"
