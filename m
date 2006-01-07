From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sat, 07 Jan 2006 12:13:05 +0000
Subject: [lm-sensors] CVS vs. Subversion
Message-Id: <20060107121305.GC19598@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060107115522.15c559b2.khali@linux-fr.org>
In-Reply-To: <20060107115522.15c559b2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sat, Jan 07, 2006 at 11:55:22AM +0100, Jean Delvare wrote:
> We now have two different pairs of repositories for our i2c and
> lm_sensors development trees: the old CVS ones and the new Subversion
> ones. This is a bit confusing as to where we are supposed to commit our
> changes.

CVS is still the production repo, trac & svn are in testing phase.

> So I'd suggest that we all switch to using the new Subversion
> repositories for development. If possible, we could turn the (i2c and
> lm_sensors2) CVS repositories read-only so as to make sure that nobody
> commits there anymore.

Well, I haven't received even one ssh key for enabling svn write
access :/

> I will be checking all patches which just went into Linux 2.6.15-git3
> and backport everything which needs to be, so I'd like a decision to be
> taken quickly, before I do. I'd hate my work to be lost in a repository
> resync.

I suggest to commit to CVS, then decide on what to migrate to svn and
whether the chosen paths are OK that way. (Re)migrating from CVS to
svn isn't an issue.

> BTW, do we really need a Subversion repository for the 7 year old
> lm_sensors (not 2) project? Having it hanging around is probably adding
> to confusion, and I see no benefit in even mentionning it on our new
> website. So I'd suggest that we don't convert this repository to
> Subversion at all, and that we drop all references to it.

OK.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060107/740e2d03/attachment.bin
