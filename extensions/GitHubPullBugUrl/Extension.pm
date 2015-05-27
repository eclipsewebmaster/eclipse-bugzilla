# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This Source Code Form is "Incompatible With Secondary Licenses", as
# defined by the Mozilla Public License, v. 2.0.

package Bugzilla::Extension::GitHubPullBugUrl;

use 5.10.0;
use strict;
use warnings;

use parent qw(Bugzilla::Extension);

use constant MORE_SUB_CLASSES => qw(
    Bugzilla::Extension::GitHubPullBugUrl::GitHubPull
);


sub install_update_db {
}

sub bug_url_sub_classes {
    my ($self, $args) = @_;
    push @{ $args->{sub_classes} }, MORE_SUB_CLASSES;
}

__PACKAGE__->NAME;
