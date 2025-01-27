Feature: When you GetAtt an SSM::Parameter, you get the type and value

  Scenario: An output with a true condition will be created
  Given the inline cfn template:
  """
  Parameters:
    MyParam:
      Type: String
      Default: something
  Conditions:
    myCondition: !Equals [ "us-east-1", !Ref AWS::Region ]
  Resources:
    MyPS:
      Type: AWS::SSM::Parameter
      Properties:
        Name: MyParamStoreEntry
        Type: String
        Value: !Ref MyParam
  Outputs:
    MyOutput1:
      Condition: myCondition
      Value: !Ref MyParam
  """
  When I evaluate the template
  Then the Output "MyOutput1" will be created

  Scenario: An output with a false condition will not be created
  Given the inline cfn template:
  """
  Parameters:
    MyParam:
      Type: String
      Default: something
  Conditions:
    myCondition: !Equals [ "us-east-2", !Ref AWS::Region ]
  Resources:
    MyPS:
      Type: AWS::SSM::Parameter
      Properties:
        Name: MyParamStoreEntry
        Type: String
        Value: !Ref MyParam
  Outputs:
    MyOutput1:
      Condition: myCondition
      Value: !Ref MyParam
  """
  When I evaluate the template
  Then the Output "MyOutput1" will not be created
