# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="user for sci-mathematics/rstudio"
ACCT_USER_ID=466
ACCT_USER_GROUPS=( rstudio-server )

acct-user_add_deps
