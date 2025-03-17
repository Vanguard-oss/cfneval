Feature: ECS::Cluster has auto-generated attributes

  Scenario: An output Refs an un-named resource
    Given the inline cfn template:
      """
      Parameters:
        MyName:
          Type: String
          Default: something
      Resources:
        MyResource:
          Type: AWS::ElasticLoadBalancingV2::TargetGroup
          Properties: {}
      Outputs:
        MyRef:
          Value: !Ref MyResource
        TargetGroupArn:
          Value: !GetAtt MyResource.TargetGroupArn
        TargetGroupFullName:
          Value: !GetAtt MyResource.TargetGroupFullName
        TargetGroupName:
          Value: !GetAtt MyResource.TargetGroupName
      """
    When I evaluate the template
    Then the Output "MyRef" will be set to "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/mystack-MyResource-ABCDEF/1234"
    And the Output "TargetGroupArn" will be set to "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/mystack-MyResource-ABCDEF/1234"
    And the Output "TargetGroupFullName" will be set to "targetgroup/mystack-MyResource-ABCDEF/1234"
    And the Output "TargetGroupName" will be set to "mystack-MyResource-ABCDEF"

  Scenario: An output Refs an named resource
    Given the inline cfn template:
      """
      Parameters:
        MyName:
          Type: String
          Default: something
      Resources:
        MyResource:
          Type: AWS::ElasticLoadBalancingV2::TargetGroup
          Properties:
            Name: !Ref MyName
      Outputs:
        MyRef:
          Value: !Ref MyResource
        TargetGroupArn:
          Value: !GetAtt MyResource.TargetGroupArn
        TargetGroupFullName:
          Value: !GetAtt MyResource.TargetGroupFullName
        TargetGroupName:
          Value: !GetAtt MyResource.TargetGroupName
      """
    When I evaluate the template
    Then the Output "MyRef" will be set to "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/something/1234"
    And the Output "TargetGroupArn" will be set to "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/something/1234"
    And the Output "TargetGroupFullName" will be set to "targetgroup/something/1234"
    And the Output "TargetGroupName" will be set to "something"
