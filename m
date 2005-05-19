From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: Centrino (855PM, ICH4-M): 82801DBM w/o LPC Bridge/SMBus?
Message-Id: <20040420125056.GB16053@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040412152503.GD6820@neu.nirvana>
In-Reply-To: <20040412152503.GD6820@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 20, 2004 at 02:31:53PM +0200, Jean Delvare wrote:
> > you are right about the CVS renaming pain. I've renamed it back to
> > it original name.
> > 
> > Are you considering switching to subversion?
> 
> No.
> 
> Now, if you tell me that we can switch to subversion and keep all
> the history we have in CVS at the moment (including all branches)
> and that subversion allows renaming files without losing their
> history, we might reconsider.

I think this is the case. Renaming is one of the major benefits of svn
in comparison to CVS (along with atomic commits, changesets
etc.). There is a cvs2svn script that trasnforms *,v RCS files from a
CVS repo to the svn equivalent.

> However, this means extra work for Philip Edelbrock (installing
> subversion, migrating data, updating webcvs - BTW is there a
> subversion equivalent?)

Yes, there is mod_dav_svn and viewcvs. Have a look at my test
subversion repos at

http://devel.atrpms.net/viewcvs/
http://devel.atrpms.net/svn/test1/
http://devel.atrpms.net/svn/test2/
http://devel.atrpms.net/svn/test3/

If anyone wants to test it send me a username/password off-list. I
wouldn't mind helping out with the involved infrastructure.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040420/3f14b24c/attachment.bin
