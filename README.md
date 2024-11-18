# uag-terraform

Omnissa® has developed a custom tooling for lifecycle management of Unified Access Gateway with Terraform . Using this tooling, you can deploy UAGs or upgrade the existing instance. The provider is developed and maintained by Omnissa® . 

## Downloads

By downloading, installing, or using the Software, you agree to be bound by the terms of Omnissa’s Software Development Kit License Agreement unless there is a different license provided in or specifically referenced by the downloaded file or package. If you disagree with any terms of the agreement, then do not use the Software.

## License

This project is licensed under the Creative Commons Attribution 4.0 International as described in [LICENSE](https://github.com/euc-dev/.github/blob/main/LICENSE); you may not use this file except in compliance with the License.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

## Steps

Add module (resource pool) for UAGs to deploy
Update sensitive_inputs.ini with UAG passwords
Update uag.ini with uag configuration
terrraform init to initialize module
terraform plan to view configuration of changes made to terraform file
terraform apply (-auto-approve) to apply the changes
terraform refresh to refresh the configuration to show the ip addresses allotted to deployed UAGs
terraform output to view the ip addresses