# Demo of automatically updating image in Dockerfile via Minimus Actions

This is a sample and not production-ready.  This illustrates a use case, "I need to update the image that my Dockerfile consumes every time Minimus ships a new Node 22 image.  I want to pin to SHA256s rather than version tags."

## Prerequisites

1. The SHA256 is stored in a repository variable.  In order to update it, you'll need a fine-grained PAT that is scoped for "Read and Write access to actions variables".   It does not need other permissions.
2. Store the PAT in a repository secret named REPO_UPDATE_PAT.
3. If you're pulling directly from Minimus's registry, create a Minimus registry access token and store it in a repository secret named MINIMUS_TOKEN.
4. Create repository variables named NODE_SHA and NODE_SHA_DEV.  Set them to the current SHA256s of the Minimus node:22 image and the Minimus node:22-dev image, respectively.
5. Create a Minimus action to trigger a GitHub workflow when the node:22 image is updated
![Screenshot of creating an action in Minimus to trigger workflows in this repo for new node:22 images.](/images/node-22-update-action.jpg)

## Operation

When the Minimus Action triggers, the update-node-sha action will run.  This will only execute if it's triggered via a newImageAction trigger (although, this could be changed out for triggering when a CVE is fixed, if desired).  The action stores new node:22 SHA256s in NODE_SHA and new node:22-dev SHA256s in NODE_SHA_DEV.

The Dockerfile is parameterized with ARG arguments.  When the docker-image action runs, it inserts NODE_SHA and NODE_SHA_DEV as arguments.
