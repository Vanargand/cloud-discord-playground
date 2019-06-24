provider "google" {
    project = "${gcp_project_id}" #from var-file
    region = "us-central1"
}

# container registry resources not supported
# tracking cloudrun terraform implementation here: https://github.com/GoogleCloudPlatform/magic-modules/pull/1820