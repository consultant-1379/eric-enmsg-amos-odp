#!/bin/bash
export ISO_VERSION=0.0.0

if [ "$#" -eq  "0" ]; then
    echo "No arguments supplied, provide either main or httpd or desktop"
    exit 0
fi

current_folder_name=$(basename "$PWD")

build_context=""
image_name=""

if [[ $1 = "main" ]]; then
   build_context=${current_folder_name}
   image_name=${current_folder_name}
elif [ $1 = "httpd" ]; then
   image_name=${current_folder_name}-services-httpd
   build_context=./${image_name}
elif [ $1 = "services" ]; then
   image_name=${current_folder_name}-services
   build_context=.
else
   echo "Invalid image identifier provided"
   exit 1
fi

echo ${build_context} ${image_name}
export image_path=armdocker.rnd.ericsson.se/proj_oss_releases/enm/${image_name}

git tag | grep "$(cat VERSION_PREFIX)-" &> /dev/null

if [ $? -gt 0 ]; then
  export image_version="$(cat VERSION_PREFIX)-1"
else
  export image_version=$(git tag | grep "$(cat VERSION_PREFIX)-" | sort --version-sort --field-separator=- --key=2,2 | tail -n1)-zpiakar
fi

rm -rf image_id
time docker build --iidfile=image_id --pull -f ${build_context}/Dockerfile -t "$image_path:$image_version" ${build_context}

STATUS=$?

if [ $STATUS -eq 0 ]; then
   echo "Pushing image to remote registry."
   IMAGE_ID=$(cat image_id)
   time docker push "$image_path:$image_version"
   docker images | grep ${IMAGE_ID}
fi



