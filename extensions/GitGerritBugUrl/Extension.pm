# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This Source Code Form is "Incompatible With Secondary Licenses", as
# defined by the Mozilla Public License, v. 2.0.

package Bugzilla::Extension::GitGerritBugUrl;

use 5.10.0;
use strict;
use warnings;

use parent qw(Bugzilla::Extension);

use constant MORE_SUB_CLASSES => qw(
    Bugzilla::Extension::GitGerritBugUrl::cGit
    Bugzilla::Extension::GitGerritBugUrl::Gerrit
);

# We need to update bug_see_also table because both
# Rietveld and ReviewBoard were originally under Bugzilla/BugUrl/.
sub install_update_db {
    my $dbh = Bugzilla->dbh;

    my $should_rename = $dbh->selectrow_array(
        q{SELECT 1 FROM bug_see_also
          WHERE class IN ('Bugzilla::BugUrl::cGit', 
                          'Bugzilla::BugUrl::Gerrit')});

    if ($should_rename) {
        my $sth = $dbh->prepare('UPDATE bug_see_also SET class = ?
                                 WHERE class = ?');
        $sth->execute('Bugzilla::Extension::GitGerritBugUrl::cGit',
                      'Bugzilla::BugUrl::cGit');

        $sth->execute('Bugzilla::Extension::GitGerritBugUrl::Gerrit',
                      'Bugzilla::BugUrl::Gerrit');
    }
}

sub bug_url_sub_classes {
    my ($self, $args) = @_;
    push @{ $args->{sub_classes} }, MORE_SUB_CLASSES;
}

__PACKAGE__->NAME;
