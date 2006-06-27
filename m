From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Tue, 27 Jun 2006 10:32:41 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <2299.194.45.26.221.1151404361.squirrel@webmail.otaku42.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all.

> I'll return on the subject of snapshots in another mail.

If it helps I can provide a bash script that we use at madwifi.org for
generating snapshots once a day (see [1]). Snapshot tarballs are only
generated if there were changes since the last generated tarball. The
script is kept as general as possible and makes use of "configuration
files", so it's easy to reuse it for generating snapshots of more than one
repository and/or several directory trees in one repository.

Bye, Mike

[1] http://snapshots.madwifi.org



