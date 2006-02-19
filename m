From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sun, 19 Feb 2006 13:28:52 +0000
Subject: [lm-sensors] move to new website - status?
Message-Id: <20060219132852.GE26231@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <43D15E0D.1020309@sh.cvut.cz>
In-Reply-To: <43D15E0D.1020309@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sun, Feb 19, 2006 at 01:47:07PM +0100, Jean Delvare wrote:
> > On Fri, Jan 20, 2006 at 11:02:53PM +0100, Rudolf Marek wrote:
> > > What is missing to complete the move to trac? Here is the list what
> > > I think needs to be fixed:
> > > 
> > > 1) picture issue?
> > > 2) "extended formating" wiki feature is not enabled?
> > > 3) port the newdrivers/supported table (implies 2 is enabled)
> > > 4) port ticket system
> > > 5) switch to svn completely
> > > 
> > > Anything else?
> > 
> > The flipping picture issue in trac seems to be a known issue, but
> > there is still no upstream fix for it. I'd place that further back in
> > the queue to give upstream a chance to fix it. OR to allow
> > experimenting with switching from cgi to mod_python serving, which
> > might fix the issue (since the bug seems to be in trac's cgi methods).
> 
> Any news about this? I don't see the picture flipping anymore myself,
> so it seems to be fixed. Anyone still having the problem?

There was no feedback on the list, but the latest trac release fixed
this apparently.

> Axel, did you enable the extended formating as Rudolf asked? We need it.

Not yet, I found out I have to build some bits to support this like
python-docutils.

> > The switch to svn can be done as soon as everyone with current CVS
> > write access is comfortable with the test svn repo. The repo can be
> > remigrated from current CVS within short time, so as soon as there is
> > agreement, give us the go, and we'll set it up for good.
> 
> Do you have enough ssh key by now? We can't switch until you have at
> least mine, Rudolf's and Mark Hoffman's.

No, only you sent a key and I already had Phil's.

> Others can send their key later, after we have collectively agreed
> to grant them write access, of course.
> 
> BTW, will it be possible to have different permissions for the i2c and
> lm_sensors2 repositories? I'd like to grant more people developer
> access to lm_sensors2, but write access to the i2c repository needs to
> be restricted as changes to it are supposed to be very rare now.

Not through ssh access. In this case the developer only sees a
database there is no fine grained per file/directory access. If you
want to go that way there are two possibilities:

o Have separate repos for lm_sensors and i2c. That would not be nice,
  as it would effectively mean separate trac installs, too.

o don't use ssh access, but http & dav

I think if there will be ACLs then we'd need to go with http &
dav. For the users/developers this might be even nicer, as the URL is
the same as the ones for the anonymous access.

In that case, authentication wouldn't happen anymore with ssh keys,
but via http/https methods.

I'd recommend to make sure the repo layout is compatible with the idea
of different ACLs for i2c and lm_sensors (e.g. top level dirs are
lm_sensors/i2c and trunk/branch/tag comes beneath), and start with ssh
key authentication for now, which is already set up. We can later
switch to a different authentication schemes to allow for ACLs.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 191 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060219/7ecda881/attachment.bin
