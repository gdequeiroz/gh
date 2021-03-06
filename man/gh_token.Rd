% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gh_token.R
\name{gh_token}
\alias{gh_token}
\title{Return the local user's GitHub Personal Access Token (PAT)}
\usage{
gh_token(api_url = NULL)
}
\arguments{
\item{api_url}{Github API url. Defaults to \code{GITHUB_API_URL}
environment variable if set, otherwise \url{https://api.github.com}.}
}
\value{
A string, with the token, or a zero length string scalar,
if no token is available.
}
\description{
You can read more about PATs here:
\url{https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/}
and you can access your PATs here (if logged in to GitHub):
\url{https://github.com/settings/tokens}.
}
\details{
Set the \code{GITHUB_PAT} environment variable to avoid having to include
your PAT in the code. If you work with multiple GitHub deployments,
e.g. via GitHub Enterprise, then read 'PATs for GitHub Enterprise' below.

If you want a more secure solution than putting authentication tokens
into environment variables, read 'Storing PATs in the system keyring'
below.
}
\section{PATs for GitHub Enterprise}{


gh lets you use different PATs for different GitHub API URLs, by looking
for the PAT in an URL specific environment variable first. It uses
\code{\link[=slugify_url]{slugify_url()}} to compute a suffix from the API URL, by extracting the
host name and removing the protocol and the path from it, and replacing
special characters with underscores. This suffix is added to
\code{GITHUB_PAT_} then. For example for the default API URL:
\url{https://api.github.com}, the \code{GITHUB_PAT_API_GITHUB_COM} environment
variable is consulted first.

You can set the default API URL via the \code{GITHUB_API_URL} environment
variable.

If the API URL specific environment variable is not set, then gh falls
back to \code{GITHUB_PAT} and then to `GITHUB_TOKEN'.
}

\section{Storing PATs in the system keyring}{


gh supports storing your PAT in the system keyring, on Windows, macOS
and Linux, using the keyring package. To turn on keyring support, you
need to set the \code{GH_KEYRING} environment variables to \code{true}, in your
\code{.Renviron} file or profile.

If keyring support is turned on, then for each PAT environment variable,
gh first checks whether the key with that value is set in the system
keyring, and if yes, it will use its value as the PAT. I.e. without a
custom \code{GITHUB_API_URL} variable, it checks the
\code{GITHUB_PAT_API_GITHUB_COM} key first, then the env var with the same
name, then the \code{GITHUB_PAT} key, etc. Such a check looks like this:\if{html}{\out{<div class="r">}}\preformatted{keyring::key_get("GITHUB_PAT_API_GITHUB_COM")
}\if{html}{\out{</div>}}

and it uses the default keyring backend and the default keyring within
that backend. See \code{\link[keyring:default_backend]{keyring::default_backend()}} for details and changing
these defaults.

If the selected keyring is locked, and the session is interactive,
then gh will try to unlock it. If the keyring is locked, and the session
is not interactive, then gh will not use the keyring. Note that some
keyring backends cannot be locked (e.g. the one that uses environment
variables).

On some OSes, e.g. typically on macOS, you need to allow R to access the
system keyring. You can allow this separately for each access, or for
all future accesses, until you update or re-install R. You typically
need to give access to each R GUI (e.g. RStudio) and the command line
R program separately.

To store your PAT on the keyring run\if{html}{\out{<div class="r">}}\preformatted{keyring::key_set("GITHUB_PAT")
}\if{html}{\out{</div>}}
}

\seealso{
\code{\link[=slugify_url]{slugify_url()}} for computing the environment variables that
gh uses to search for API URL specific PATs.
}
