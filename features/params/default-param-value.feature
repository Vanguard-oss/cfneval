Feature: Parameters can have default values

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
  When I evaluate the template
  Then the Output "MyOutput" will be created
  And the Output "MyOutput" will be set to "something"

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
  When I evaluate the template
  Then the Resource "MyPS" path "Properties.Value" matches "something"