#!bin/sh -x

# Output versions.
hugo version

# Retrieve the input arguments/parameters.
FIREBASE_DEPLOY_TOKEN=$1
HUGO_PARAMS=${2:-hugo-params}

# Build the Hugo site.
hugo $HUGO_PARAMS

# Publish to Google Firebase.
firebase use --token $FIREBASE_DEPLOY_TOKEN
firebase deploy -m "
  Successful Deployment: 
  Event: $GITHUB_EVENT_NAME,
  Commit SHA: $GITHUB_SHA,
  User: $GITHUB_ACTOR
" --non-interactive --token $FIREBASE_DEPLOY_TOKEN
