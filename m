From: ckelley@ibnads.com (Craig Kelley)
Date: Wed, 12 Oct 2005 17:36:13 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.14-rc2-mm2] hwmon: add a new ID to SMSC
Message-Id: <434D2D22.2040805@ibnads.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012032205.GA20051@jupiter.solarsys.private>
In-Reply-To: <20051012032205.GA20051@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks again Mark;

  -Craig

Mark M. Hoffman wrote:

>This patch adds a new ID to the SMSC LPC47B397-NC hardware
>monitoring driver - for a chip that is claimed to be 100%
>compatible otherwise.
>
>Signed-off-by: Bryan Young (Utilitek Systems, Inc.)
>Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
>
>---
>
>Hi Jean: I should have sent this some time ago.  Please queue it
>up for 2.6.15.
>
>--- linux-2.6.14-rc2-mm2.orig/drivers/hwmon/smsc47b397.c
>+++ linux-2.6.14-rc2-mm2/drivers/hwmon/smsc47b397.c
>@@ -299,7 +299,7 @@ static int __init smsc47b397_find(unsign
> 	superio_enter();
> 	id = superio_inb(SUPERIO_REG_DEVID);
> 
>-	if (id != 0x6f) {
>+	if ((id != 0x6f) && (id != 0x81)) {
> 		superio_exit();
> 		return -ENODEV;
> 	}
>@@ -310,8 +310,16 @@ static int __init smsc47b397_find(unsign
> 	*addr = (superio_inb(SUPERIO_REG_BASE_MSB) << 8)
> 		 |  superio_inb(SUPERIO_REG_BASE_LSB);
> 
>-	printk(KERN_INFO "smsc47b397: found SMSC LPC47B397-NC "
>-		"(base address 0x%04x, revision %u)\n", *addr, rev);
>+	switch (id) {
>+	case 0x6f:
>+		printk(KERN_INFO "smsc47b397: found SMSC LPC47B397-NC "
>+			"(base address 0x%04x, revision %u)\n", *addr, rev);
>+		break;
>+	case 0x81:
>+		printk(KERN_INFO "smsc47b397: found SMSC SCH5307-NS"
>+			"(base address 0x%04x, revision %u)\n", *addr, rev);
>+		break;
>+	}
> 
> 	superio_exit();
> 	return 0;
>  
>


-- 
Craig Kelley
In-Store Broadcasting Network
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051012/f95f4419/attachment.html
