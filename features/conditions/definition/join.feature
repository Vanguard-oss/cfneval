Feature: The Join intrinsic can be used inside of a Condition

  Scenario: Equals with Join evaluates to true
  Given the inline cfn template:
  """
  Parameters:
    MyParam:
      Default: "a,b"
      Type: CommaDelimitedList
  Conditions:
    myCondition: !Equals [ "a_b", !Join [ "_", !Ref MyParam ] ]
  """
  When I evaluate the template
  Then the Condition "myCondition" is true