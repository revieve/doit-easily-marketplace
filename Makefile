context:
	docker build . -t revieve-gcp-simple-terraform

run:
	docker run -it --rm \
	    -v "$$PWD":/root/ops \
	    revieve-gcp-simple-terraform

auth:
	gcloud auth application-default login

build-images:
	docker build -t europe-docker.pkg.dev/revieve-public/docker-registry-europe/doi-it-easy:latest api

push-to-registry:
	docker push europe-docker.pkg.dev/revieve-public/docker-registry-europe/doi-it-easy:latest 

registry-login:
	gcloud auth configure-docker europe-docker.pkg.dev

gcloud-auth:
	gcloud auth login
	gcloud config set project revieve-public

# gcloud projects add-iam-policy-binding revieve-public \
#     --member="serviceAccount:doit-easily@revieve-public.iam.gserviceaccount.com" \
#     --role="roles/artifactregistry.admin"

gcloud projects add-iam-policy-binding revieve-public \
    --member="serviceAccount:doit-easily@revieve-public.iam.gserviceaccount.com" \
    --role="roles/iam.serviceAccountTokenCreator"

# gcloud projects add-iam-policy-binding revieve-public \
# --member="serviceAccount:doit-easily@revieve-public.iam.gserviceaccount.com" \
# --role="roles/iam.serviceAccountUser"

gcloud projects add-iam-policy-binding revieve-public \
    --member="user:esteve@revieve.com" \
    --role="roles/iam.serviceAccountTokenCreator"