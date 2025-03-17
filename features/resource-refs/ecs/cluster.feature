Feature: When you Ref an ECS::Cluster, you get the name of the resource

  Scenario: An output Refs an un-named resource
    Given the inline cfn template:
      """
      Parameters:
        MyName:
          Type: String
          Default: something
      Resources:
        MyResource:
          Type: AWS::ECS::Cluster
          Properties: {}
      Outputs:
        MyOutput:
          Value: !Ref MyResource
      """
    When I evaluate the template
    Then the Output "MyOutput" will be set to "mystack-MyResource-ABCDEF"

  Scenario: An output Refs an named resource
    Given the inline cfn template:
      """
      Parameters:
        MyName:
          Type: String
          Default: something
      Resources:
        MyResource:
          Type: AWS::ECS::Cluster
          Properties:
            ClusterName: !Ref MyName
      Outputs:
        MyOutput:
          Value: !Ref MyResource
      """
    When I evaluate the template
    Then the Output "MyOutput" will be set to "something"
