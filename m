From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sat, 02 Sep 2006 21:33:07 +0000
Subject: [lm-sensors] wiki pages - update
Message-Id: <20060902213307.GS28210@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F09CBA.60301@sh.cvut.cz>
In-Reply-To: <44F09CBA.60301@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Aug 27, 2006 at 02:17:55PM +0200, Jean Delvare wrote:
> > THE biggest problem is that there is not any registration function. 
> > Wikis are for collaborative efforts but apparently Trac does not have a
> > simple registration function. All I saw was that the admin has to run
> > an admin script to assign permisssions. I certainly hope that is robust
> > enough to be automated, :).
> 
> We disabled that feature of trac on purpose, because it made it very
> easy for spammers to create fake accounts and ruin our site. I agree it
> pretty much voids the point of having a wiki, and we need to find a
> solution to this problem.

trac's wiki indeed has currently little support for
registration/authetication and anti-spam measures. But trac 0.10 is
almost done and there will be a couple of plugins helping out a bit
more.

We do use a pre 0.10 version for various reasons, but during
development the abi changes and the plugins don't much up well. And
for the stable trac version 0.9.x most of these plugins are not
available.

In short: For now we should use some workaround like creating accounts
manually, and once 0.10 and the plugins ship we can automate some
parts (until the spammers port auto-registration spam software for
trac's wiki ...).
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060902/2806e7d8/attachment.bin 
