From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] Fix for i2c-piix4 with on some boards
Message-Id: <20030811230208.GG807@ip68-0-152-218.tc.ph.cox.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 11, 2003 at 01:37:19PM -0700, Greg KH wrote:

> On Mon, Aug 11, 2003 at 11:10:01AM -0700, Tom Rini wrote:
> > +		printk("Fixed I2C problem on Force CPCI735\n");
> 
> Shame on adding a printk() without a proper level value.  I'll convert
> this to a dev_info() message and apply it (the 2.6 patch, not the cvs
> patch.)

D'oh.  I actually forgot to change the printk to not be Force
CPCI735-centric.  Would you mind chaning it to something more generic?
Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030811/c7b333f2/attachment.bin
