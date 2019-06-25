$hostname="gcr.io"
#env var
$projectId=$env:GCP_PROJECT_ID
$image="discord_bot"
$tag="0.0.1"

#get latest tag
$tags= (gcloud container images list-tags $hostname/$projectId/$image --limit=1 --format=json) | Out-String
Write-Host $tags

#build
#docker build .. -t "$($hostname)/$($projectId)/$($image):$($tag)"

#gcloud docker -- push "$($hostname)/$($projectId)/$($image):$($tag)"

#gcloud beta run deploy --image "$($hostname)/$($projectId)/$($image):$($tag)" --platform-managed