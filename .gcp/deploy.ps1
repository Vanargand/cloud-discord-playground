param (
    [Parameter(Mandatory=$true)][string]$projectId,
    [string]$tag
)

$hostname = "gcr.io";
$image = "discord-bot";
$region = "us-central1";
$buildnumber = "";

if($tag) {
    $buildnumber = $tag
} else {
    #get latest tag
    $tags = (gcloud container images list-tags $hostname/$projectId/$image --limit=1 --format=json) | ConvertFrom-Json
    $buildnumber = $tags[0].tags[0]
}
Write-Host $buildnumber

#build
docker build .. -t "$($hostname)/$($projectId)/$($image):$($buildnumber)"
gcloud docker -- push "$($hostname)/$($projectId)/$($image):$($buildnumber)"
gcloud beta run deploy --image "$($hostname)/$($projectId)/$($image):$($buildnumber)" --platform=managed --no-allow-unauthenticated --region="$($region)" "$($image)"