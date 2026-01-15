# sentistock-infra
Sentistock 인프라

```
📦sentistock-infra
 ┣ 📂.git
 ┃ ┣ 📂hooks
 ┃ ┃ ┣ 📜applypatch-msg.sample
 ┃ ┃ ┣ 📜commit-msg.sample
 ┃ ┃ ┣ 📜fsmonitor-watchman.sample
 ┃ ┃ ┣ 📜post-update.sample
 ┃ ┃ ┣ 📜pre-applypatch.sample
 ┃ ┃ ┣ 📜pre-commit.sample
 ┃ ┃ ┣ 📜pre-merge-commit.sample
 ┃ ┃ ┣ 📜pre-push.sample
 ┃ ┃ ┣ 📜pre-rebase.sample
 ┃ ┃ ┣ 📜pre-receive.sample
 ┃ ┃ ┣ 📜prepare-commit-msg.sample
 ┃ ┃ ┣ 📜push-to-checkout.sample
 ┃ ┃ ┣ 📜sendemail-validate.sample
 ┃ ┃ ┗ 📜update.sample
 ┃ ┣ 📂info
 ┃ ┃ ┗ 📜exclude
 ┃ ┣ 📂logs
 ┃ ┃ ┣ 📂refs
 ┃ ┃ ┃ ┣ 📂heads
 ┃ ┃ ┃ ┃ ┗ 📜main
 ┃ ┃ ┃ ┗ 📂remotes
 ┃ ┃ ┃ ┃ ┗ 📂origin
 ┃ ┃ ┃ ┃ ┃ ┗ 📜HEAD
 ┃ ┃ ┗ 📜HEAD
 ┃ ┣ 📂objects
 ┃ ┃ ┣ 📂info
 ┃ ┃ ┗ 📂pack
 ┃ ┃ ┃ ┣ 📜pack-8ca655fd375fe35c00462e30a2693254bd85889c.idx
 ┃ ┃ ┃ ┣ 📜pack-8ca655fd375fe35c00462e30a2693254bd85889c.pack
 ┃ ┃ ┃ ┗ 📜pack-8ca655fd375fe35c00462e30a2693254bd85889c.rev
 ┃ ┣ 📂refs
 ┃ ┃ ┣ 📂heads
 ┃ ┃ ┃ ┗ 📜main
 ┃ ┃ ┣ 📂remotes
 ┃ ┃ ┃ ┗ 📂origin
 ┃ ┃ ┃ ┃ ┗ 📜HEAD
 ┃ ┃ ┗ 📂tags
 ┃ ┣ 📜config
 ┃ ┣ 📜description
 ┃ ┣ 📜HEAD
 ┃ ┣ 📜index
 ┃ ┗ 📜packed-refs
 ┣ 📂envs
 ┃ ┣ 📂dev
 ┃ ┃ ┣ 📜backend.tf
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┃ ┗ 📂prod
 ┃ ┃ ┣ 📜backend.tf
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┣ 📜provider.tf
 ┃ ┃ ┗ 📜variables.tf
 ┣ 📂globals
 ┃ ┣ 📜backend.tf
 ┃ ┣ 📜locals.tf
 ┃ ┗ 📜provider.tf
 ┣ 📂k8s
 ┃ ┗ 📂eks
 ┃ ┃ ┣ 📜backend.yaml
 ┃ ┃ ┣ 📜community.yaml
 ┃ ┃ ┣ 📜gateway.yaml
 ┃ ┃ ┣ 📜ingress-gateway.yaml
 ┃ ┃ ┣ 📜sentistock-news-crawler-cronjob.yaml
 ┃ ┃ ┣ 📜sentistock-score.yaml
 ┃ ┃ ┗ 📜sentistock-stock-cronjob.yaml
 ┣ 📂modules
 ┃ ┣ 📂eks
 ┃ ┃ ┣ 📜alb_controller_policy.json
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┃ ┣ 📂frontend_static
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┃ ┣ 📂rds
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┃ ┣ 📂route53
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┃ ┗ 📂vpc
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┣ 📂scripts
 ┃ ┣ 📜apply-dev.sh
 ┃ ┣ 📜init-dev.sh
 ┃ ┗ 📜plan-dev.sh
 ┣ 📜.gitignore
 ┣ 📜README.md
 ┗ 📜versions.tf
```
