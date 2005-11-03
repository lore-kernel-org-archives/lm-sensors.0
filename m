From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 03 Nov 2005 05:42:15 +0000
Subject: [lm-sensors] PEC support in i2c/lm_sensors CVS
Message-Id: <20051103044206.GB8138@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051030171335.34da6461.khali@linux-fr.org>
In-Reply-To: <20051030171335.34da6461.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2005-10-30 17:13:35 +0100]:
(snip)
> So, unless someone comes up with good reasons for not backporting the
> new PEC code to i2c/lm_sensors CVS, I will probably do so. I would
> appreciate if someone could take a look at the new Linux 2.6 code
> (2.6.14-git1 and later) and confirm that I got it right. I don't think
> it got any form of review so far, except for the fact that It Works For
> Me (TM).

I finally reviewed those patches; one suggestion, to apply if you like...

This patch tweaks i2c-i801.c so that the driver always sets the SMBAUXCTL
register (which enables/disables PEC) explicitly before each transaction.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

--- linux-2.6.14-git5.orig/drivers/i2c/busses/i2c-i801.c
+++ linux-2.6.14-git5/drivers/i2c/busses/i2c-i801.c
@@ -468,8 +468,7 @@ static s32 i801_access(struct i2c_adapte
 		return -1;
 	}
 
-	if (hwpec)
-		outb_p(1, SMBAUXCTL);	/* enable hardware PEC */
+	outb_p(hwpec, SMBAUXCTL);	/* enable/disable hardware PEC */
 
 	if(block)
 		ret = i801_block_transaction(data, read_write, size, hwpec);
@@ -478,9 +477,6 @@ static s32 i801_access(struct i2c_adapte
 		ret = i801_transaction();
 	}
 
-	if (hwpec)
-		outb_p(0, SMBAUXCTL);	/* disable hardware PEC */
-
 	if(block)
 		return ret;
 	if(ret)
-- 
Mark M. Hoffman
mhoffman@lightlink.com

