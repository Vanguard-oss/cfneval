Feature: CertificateManager::Certificate can be Ref'ed

  Scenario: An output Refs an un-named resource
    Given the inline cfn template:
      """
      Parameters:
        MyName:
          Type: String
          Default: something
      Resources:
        MyResource:
          Type: AWS::CertificateManager::Certificate
          Properties: {}
      Outputs:
        MyRef:
          Value: !Ref MyResource
      """
    When I evaluate the template
    Then the Output "MyRef" will be set to "arn:aws:acm:us-east-1:123456789012:certificate/1234"
