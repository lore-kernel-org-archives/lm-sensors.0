From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 07 Jan 2006 10:55:22 +0000
Subject: [lm-sensors] CVS vs. Subversion
Message-Id: <20060107115522.15c559b2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

We now have two different pairs of repositories for our i2c and
lm_sensors development trees: the old CVS ones and the new Subversion
ones. This is a bit confusing as to where we are supposed to commit our
changes.

So I'd suggest that we all switch to using the new Subversion
repositories for development. If possible, we could turn the (i2c and
lm_sensors2) CVS repositories read-only so as to make sure that nobody
commits there anymore.

I will be checking all patches which just went into Linux 2.6.15-git3
and backport everything which needs to be, so I'd like a decision to be
taken quickly, before I do. I'd hate my work to be lost in a repository
resync.

BTW, do we really need a Subversion repository for the 7 year old
lm_sensors (not 2) project? Having it hanging around is probably adding
to confusion, and I see no benefit in even mentionning it on our new
website. So I'd suggest that we don't convert this repository to
Subversion at all, and that we drop all references to it.

Thanks,
-- 
Jean Delvare

