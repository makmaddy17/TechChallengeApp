# This is the order of arguments
build_folder=$1
aws_ecr_repository_url_with_tag=$2

# Connect into aws
$(aws ecr get-login --no-include-email) || { echo 'ERROR: aws ecr login failed' ; exit 1; }

# Build image
docker build -t $aws_ecr_repository_url_with_tag $build_folder

# Push image
docker push $aws_ecr_repository_url_with_tag
