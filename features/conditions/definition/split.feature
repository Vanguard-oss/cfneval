Feature: The Split intrinsic can be used inside of a Condition

  Scenario: Splitting then selecting something that Equals
  Given the inline cfn template:
  """
  Parameters:
    MyParam:
      Default: "a,b"
      Type: String
  Conditions:
    myCondition: !Equals [ "b", !Select [ 1, !Split [ ",", !Ref MyParam ] ] ]
  """
  When I evaluate the template
  Then the Condition "myCondition" is true

  Scenario: Splitting then selecting something that does not Equal
  Given the inline cfn template:
  """
  Parameters:
    MyParam:
      Default: "a,b"
      Type: String
  Conditions:
    myCondition: !Equals [ "a", !Select [ 1, !Split [ ",", !Ref MyParam ] ] ]
  """
  When I evaluate the template
  Then the Condition "myCondition" is false