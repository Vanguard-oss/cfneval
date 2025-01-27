# cfneval Compatability

| Status  | Description |
| ------- | ----------- |
| Yes     | Fully Supported |
| No      | Not Supported |
| Ignored | Value can be set, but it not actually used/validated |
| Partial | The value will be used and validated in some situations |

## Top Level Fields

| Field | Status |
| ----- | ------ |
| Conditions | Yes |
| Mappings | Yes |
| Outputs | Yes |
| Parameters | Yes |
| Resources | Yes |

## Intrinsics

| Field                | Condition | Fn::If | Resource | Output | Notes |
| -------------------- | --------- | ------ | -------- | ------ | ----- |
| Fn::And              | Yes       |        |          |        |       |
| Fn::Base64           |           | No     | No       | No     |       |
| Fn::Cidr             |           | No     | No       | No     |       |
| Fn::Equals           | Yes       |        |          |        |       |
| Fn::FindInMap        | No        | Yes    | Yes      | Yes    |       |
| Fn::ForEach          |           | No     | No       | No     | Transforms are not supported |
| Fn::GetAtt           |           | No     | Yes      | Yes    |       |
| Fn::GetAZs           |           | No     | No       | No     |       |
| Fn::If               | No        |        | Yes      | Yes    |       |
| Fn::ImportValue      |           |        | No       | No     |       |
| Fn::Join             | Yes       | Yes    | Yes      | Yes    |       |
| Fn::Length           |           |        | No       | No     |       |
| Fn::Not              | Yes       |        |          |        |       |
| Fn::Or               | Yes       |        |          |        |       |
| Fn::Select           | Yes       | Yes    | Yes      | Yes    |       |
| Fn::Split            | Yes       | Yes    | Yes      | Yes    |       |
| Fn::Sub              | No        | Yes    | Yes      | Yes    |       |
| Fn::ToJsonString     |           |        | No       | No     |       |
| Fn::Transform        |           | No     | No       | No     | Transforms are not supported |
| Ref                  | Yes       | Yes    | Yes      | Yes    |       |

## Pseudo parameters

| Parameter                | Status |
| ------------------------ | ------ |
| AWS::AccountId           | Yes    |
| AWS::NotificationARNs    | No     |
| AWS::NoValue             | Yes    |
| AWS::Partition           | No     |
| AWS::Region              | Yes    |
| AWS::StackId             | No     |
| AWS::StackName           | Yes    |
| AWS::URLSuffix           | No     |
