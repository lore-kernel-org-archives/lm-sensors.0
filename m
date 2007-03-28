From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Wed, 28 Mar 2007 17:09:57 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <4dfa50520703281009j5cb96741l2a9333100b88caa8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo, Hans,

> It is true that sqlite needs to be installed on the client's pc in order to
> make it run, adding an extra dependency. However, we don't see this is a big
> drawback, since most distributions come with it anyway. As far as I can see
> on my machine:
>
>         libsqlite3.so.0 is needed by (installed) rpm-libs-4.4.2-32.i386
>         libsqlite3.so.0 is needed by (installed) rpm-4.4.2-32.i386
>         libsqlite3.so.0 is needed by (installed)
> python-sqlite-1.1.7-1.2.1.i386
>         libsqlite3.so.0 is needed by (installed)
> yum-metadata-parser-1.0.3-1.fc6.i386
>         libsqlite3.so.0 is needed by (installed) apr-util-1.2.8-1.fc6.i386
>         sqlite is needed by (installed) mono-data-sqlite-1.1.17.1-4.fc6.i386
>         sqlite >= 3.3.1 is needed by (installed) beagle-0.2.13-1.fc6.i386
>
> So it seems like both rpm and yum already use it, which covers most
> distributions, doesn't it?

I have access to Debian and SuSe machines but I haven't taken the time
to look at the dependencies for sqlite. However, for Gentoo systems,
sqlite won't be there unless the user chooses one of a few packages --
none of which guarantee sqlite will be installed like rpm / yum would
for a Ubuntu, Fedora, or RHEL system. :-(

app-admin/conary
app-misc/beagle
app-misc/cdcollect
app-misc/tracker
app-pda/libopensync
dev-db/sqlitebrowser
dev-db/sqliteodbc
dev-haskell/hdbc-sqlite
dev-haskell/hsql-sqlite
dev-php4/pecl-sqlite
dev-php5/pecl-pdo-sqlite
dev-python/apsw
dev-python/axiom
dev-python/pysqlite
dev-ruby/sqlite-ruby
dev-ruby/sqlite3-ruby
dev-util/nemiver
games-board/slibo
gnustep-apps/gworkspace
kde-misc/katalog
mail-client/mailody
media-gfx/digikam
media-gfx/f-spot
media-sound/banshee
media-sound/bossogg
media-sound/listen
media-sound/monopod
media-tv/dvbstreamer
media-video/mmsv2
net-proxy/vultureng
sys-cluster/csync2

Or, the following packages will use sqlite functionality if the user
configures them to (but don't, by default -- sqlite would be pulled in
when the user is trying to build a system around sqlite, not the other
way around). I notice some important ones here, like rpm, trac, and
qt, but they are probably installed without the sqlite dependency in
most cases.

app-arch/rpm
app-backup/bacula
app-cdr/cdw
app-mobilephone/kannel
app-office/qhacc
app-portage/eix
dev-cpp/sptk
dev-db/hk_classes
dev-db/libdbi-drivers
dev-db/opendbx
dev-db/sqliteodbc
dev-lang/php
dev-lang/python
dev-libs/apr-util
dev-libs/libpreludedb
dev-libs/redland
dev-lisp/cl-sql
dev-ruby/ruby-dbi
dev-util/gambas
games-kids/gcompris
gnome-extra/libgda
kde-misc/krecipes
mail-client/balsa
mail-filter/bogofilter
mail-filter/dspam
mail-mta/exim
media-libs/libsndfile
media-sound/mt-daapd
net-analyzer/ipac-ng
net-analyzer/pmacct
net-dns/pdns
net-im/ekg2
net-im/jabberd
net-mail/dbmail
net-misc/asterisk
net-misc/logjam
net-p2p/gnunet
net-p2p/gtk-gnutella
sci-geosciences/grass
sci-libs/gdal
www-apps/trac
www-servers/lighttpd
x11-libs/qt

Also, look at how sensors uses sensors.conf already. It is a form of
database without needing sqlite. If dmi-detect had a sqlite
dependency, then sensors might one day move the configuration to
sqlite -- reasons why this would be good or bad apply equally to both
apps.

All this is just my opinion, though.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
