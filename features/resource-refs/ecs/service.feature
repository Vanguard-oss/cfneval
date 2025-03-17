Feature: When you Ref an ECS::Service, you get the name of the service

  Scenario: An output Refs an un-named resource
    Given the inline cfn template:
      """
      Parameters:
        MyName:
          Type: String
          Default: something
      Resources:
        MyResource:
          Type: AWS::ECS::Service
          Properties: {}
      Outputs:
        MyOutput:
          Value: !Ref MyResource
      """
    When I evaluate the template
    Then the Output "MyOutput" will be set to "aws:aws:ecs:us-east-1:123456789012:service/mystack-MyResource-ABCDEF"

  Scenario: An output Refs an named resource
    Given the inline cfn template:
      """
      Parameters:
        MyName:
          Type: String
          Default: something
      Resources:
        MyResource:
          Type: AWS::ECS::Service
          Properties:
            ServiceName: !Ref MyName
      Outputs:
        MyOutput:
          Value: !Ref MyResource
      """
    When I evaluate the template
    Then the Output "MyOutput" will be set to "aws:aws:ecs:us-east-1:123456789012:service/something"
