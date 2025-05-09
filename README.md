# 🌍 Terraform Infrastructure Repository

이 레포지토리는 Terraform을 사용하여 클라우드 인프라를 코드로 관리하기 위한 프로젝트입니다.

---

## 📦 Terraform 설치 방법

### macOS

1. **Homebrew**를 사용하여 설치:

    ```bash
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
    ```

2. 설치 확인:

    ```bash
    terraform -v
    ```

---

### Windows

1. [Terraform 공식 다운로드 페이지](https://developer.hashicorp.com/terraform/downloads)에서 Windows용 ZIP 파일 다운로드  
2. 압축 해제 후 `terraform.exe`를 시스템의 PATH가 지정된 디렉토리에 이동  
   (예: `C:\Program Files\Terraform\`)
3. 환경 변수 설정:

    - `시스템 속성 > 고급 > 환경 변수`에서 `PATH`에 Terraform 경로 추가

4. 설치 확인 (CMD 또는 PowerShell에서 실행):

    ```powershell
    terraform -v
    ```

---

## 🚀 Terraform 기본 사용 방법

1. **Terraform 초기화**  
   프로젝트 디렉토리 내에서 실행:

    ```bash
    terraform init
    ```

2. **실행 계획 확인**  
   어떤 리소스가 생성/변경/삭제될지 확인:

    ```bash
    terraform plan
    ```

3. **인프라 적용**  
   계획된 내용을 실제로 반영:

    ```bash
    terraform apply
    ```

4. **인프라 삭제**  
   리소스를 모두 제거:

    ```bash
    terraform destroy
    ```
