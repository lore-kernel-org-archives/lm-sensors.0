From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Wed, 31 May 2006 10:16:30 +0000
Subject: [lm-sensors] svn resync
Message-Id: <20060531101630.GB23302@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <44621B6E.6070500@sh.cvut.cz>
In-Reply-To: <44621B6E.6070500@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 30, 2006 at 06:20:46PM -0700, Philip Edelbrock wrote:
> OK, I fixed up the Trac database to eliminate the bad characters.   
> I'm sure it was some non-utf-8 symbols in the text that went from my  
> ticket system to this one which was screwing stuff up.

Thanks!

> Alex, I'm not sure how strict you are with permissions, but I made  
> the trac.db r/w to the world.  I didn't have the permissions to make  
> it owned by Apache.

I fixe dthe permissions. There are other non-lm-sensors accounts on
this system, and I wouldn't want different projects to be able to
accidentially shoot of the neighbor :)

It's group writable, so you (Phil), Jean, Rudolf, Mark and I can
perform any trac administrative action. These will also be the people
that can administer commit rights to i2c and lm-sensors (personally
I'll always defer decisions about commit rights to the others, so
don't really count me in :).
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060531/0b0e5425/attachment.bin
