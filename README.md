Google Cloud short lived token helper
=====================================

The usual way of creating infrastructure as code in GCP (e.g. Terraform) involves having a long term access token stored on the initiating computer. These service account tokens often need very powerful permissions to make changes to the infrastructure.

This tool simplifies the use of short-lived oauth2 tokens without maintaining a long term token. It will authenticate using gcloud sdk (with appropriate 2FA etc.), obtain an oauth2 token for the desired service account and then revoke the authenticated account from the sdk. You can then use the oauth2 token to perform infrastructure updates.

Tip: make sure the principal you're trying to use has the `iam.serviceAccounts.getAccessToken` permission on the desired resource. This permission is granted by the `Service Account Token Creator` role.

**Usage:**

```
./create-oauth-token.sh [service-account-email-or-unique-id]
```

**Dependencies:**

[Google Cloud SDK](https://cloud.google.com/sdk/) ([pyenv](https://github.com/pyenv/pyenv) and/or [direnv](https://direnv.net/) may come handy)
