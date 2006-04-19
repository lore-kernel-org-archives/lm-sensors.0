From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 19 Apr 2006 11:08:57 +0000
Subject: [lm-sensors] [PATCH] i2c-i801: Fix resume when PEC is used
Message-Id: <20060419130857.7f2db2d4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060418140629.7cb21736.khali@linux-fr.org>
	<20060418170331.GA3915@jupiter.solarsys.private>
	<20060418211546.fa5a76df.khali@linux-fr.org>
In-Reply-To: <20060418211546.fa5a76df.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Quoting myself: 
> Anyway, on second thought I believe you're right, the most simple
> approach will be fine for 2.6.17 too. There's little point in trying
> to handle suspend/resume if we don't prevent it from happening in the
> middle of a transaction. Fixing that is beyond the scope of 2.6.17.
> 
> I'll send a new patch soon.

Here it is. This must go in 2.6.17.

* * * * *

Fix for bug #6395:
Fail to resume on Tecra M2 with ADM1032 and Intel 82801DBM

The BIOS of the Tecra M2 doesn't like it when it has to reboot or
resume after the i2c-i801 driver has left the SMBus in PEC mode. The
most simple fix is to clear the PEC bit after after every transaction.
That's what this driver was doing up to 2.6.15 (inclusive).

Thanks to Daniele Gaffuri for the very good report.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-i801.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.16.5.orig/drivers/i2c/busses/i2c-i801.c	2006-03-22 17:07:28.000000000 +0100
+++ linux-2.6.16.5/drivers/i2c/busses/i2c-i801.c	2006-04-17 11:11:06.000000000 +0200
@@ -478,6 +478,11 @@
 		ret = i801_transaction();
 	}
 
+	/* Some BIOSes don't like it when PEC is enabled at reboot or resume
+	   time, so we forcibly disable it after every transaction. */
+	if (hwpec)
+		outb_p(0, SMBAUXCTL);
+
 	if(block)
 		return ret;
 	if(ret)



-- 
Jean Delvare

