# sentistock-infra
<img width="1871" height="1075" alt="image" src="https://github.com/user-attachments/assets/84e734c2-4910-4990-9ac0-df162e7ef61b" />

>SentiStock 서비스의 AWS 인프라를 **Terraform(IaC)** 로 프로비저닝하고,
>EKS 위에 애플리케이션을 배포하기 위한 **Kubernetes manifests**를 함께 관리하는 레포지토리입니다.

- Terraform: VPC / EKS / RDS / (S3+CloudFront 기반 정적 프론트) / Route53 등 인프라 구성
- Kubernetes: Gateway/Backend 배포 및 CronJob 기반 데이터 파이프라인 실행

## ⭐ Repository Purpose

- AWS 인프라를 코드로 관리하여 **재현 가능한 배포 환경** 구성
- VPC 퍼블릭/프라이빗 분리 및 NAT를 통한 아웃바운드 제어로 **보안 강화**
- EKS 기반으로 서비스 컴포넌트를 컨테이너로 운영하여 **확장성 확보**
- CronJob을 통해 **뉴스 크롤러/주가 수집/스코어 집계** 배치 작업 자동화
- 도메인(Route53) 및 정적 배포(S3+CloudFront)를 통해 **실서비스 접근 경로 제공**

---

## 🧱 Infrastructure Overview

### Provisioned by Terraform
- **VPC**: Public / Private(App) / Private(DB) Subnet 분리
- **EKS**: Managed NodeGroup 기반 Kubernetes 클러스터
- **RDS(MariaDB)**: 애플리케이션 데이터 저장소
- **Frontend Static**: S3 + CloudFront 정적 호스팅 (선택 적용)
- **Route53**: 서비스 도메인 연결 (선택 적용)
- **ALB Controller**: Ingress를 통한 외부 트래픽 라우팅

### Deployed on EKS (Kubernetes)
- `gateway.yaml`: Spring Cloud Gateway (API Gateway)
- `backend.yaml`: Backend API 서버
- `ingress-gateway.yaml`: ALB Ingress 리소스
- `sentistock-*-cronjob.yaml`: 크롤러/집계 배치 작업 CronJob

---

### Excute

- Terraform

/envs/prod 위치에서 실행
```
terrafrom init
terraform plan
terraform apply

#삭제시
terraform destroy
```
- k8s
```
kubectl apply -f backend.yaml
kubectl apply -f gateway.yaml
kubectl apply -f ingress-gateway.yaml
kubectl apply -f sentistock-news-crawler-cronjob.yaml
kubectl apply -f sentistock-stock-cronjob.yaml
kubectl apply -f sentistock-score.yaml
```

### :file_folder: Data Structure
```
📦sentistock-infra
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
