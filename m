From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 08 Jan 2007 17:39:45 +0000
Subject: [lm-sensors] generic chip support for sensors
Message-Id: <20070108183945.84115dfc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061210000539.1f2f2bbd@ws01.atreidis.nl.eu.org>
In-Reply-To: <20061210000539.1f2f2bbd@ws01.atreidis.nl.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sun, 7 Jan 2007 14:36:26 -0500, Mark M. Hoffman wrote:
> Hi Bob:
> 
> * Bob Schl?rmann <bob2 at dsv.nl> [2006-12-24 18:29:39 +0100]:
> > The following patch changes all of the lib/chips.c entries and any function
> > that uses sensors_chip_feature. Most of the conversion was done through a
> > perl script, so if you don't agree with the syntax it'll be easy to change.
> > 
> > It's a diff against current svn.
> 
> Very nice, thanks for doing this.  I have some minor requests though...
> 
> * please CC the lm-sensors list with all patches
> * always prepare patches with lm-sensors as CWD, even if it only touches lib
> * attach patches as plain text instead of base64 if possible
> 
> I fixed up your patch so it applies to latest SVN (adm1029 support was added
> since then), and IMO we should apply this prior to releasing 2.10.2 even.
> 
> BTW: A binary diff between SVN and patched revisions of lib/chips.ao,
> lib/proc.ao, and lib/access.ao comes up clean.  That is proof enough for me
> that this transformation was done correctly.
> 
> Thanks again Bob.  Here's the revised patch; comments anyone?

If you feel like it is safe and can be merged, fine with me, just apply
that patch. After that, the repository is frozen and the pre-release
tests can begin. I'd really like to stick to the schedule.

-- 
Jean Delvare

