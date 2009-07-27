From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 27 Jul 2009 13:34:03 +0000
Subject: Re: [lm-sensors] Same problem, different form factor.
Message-Id: <20090727153403.5bd571fc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <537754.36624.qm@web111504.mail.gq1.yahoo.com>
In-Reply-To: <537754.36624.qm@web111504.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nuzhna,

On Sun, 26 Jul 2009 17:20:34 -0700 (PDT), Nuzhna Pomoshch wrote:
> --- On Sun, 7/26/09, Jean Delvare <khali@linux-fr.org> wrote:
> 
> > It shouldn't be too difficult to extend the PCI quirk to
> > apply to your machine as well. Please send the output of
> > "lspci -vnn" and acpidump.
> 
> Thanks. I hope I have these in the right format.

Alright (although compressing the lspci output wasn't terribly needed).
Here's a patch to try. If applies on top of the other related patches.
It should apply right away on top of kernel >= 2.6.30. For kernels >2.6.27 you'll need to add the line manually due to changing context.

From: Jean Delvare <khali@linux-fr.org>
Subject: PCI: Unhide the SMBus on the Compaq Evo D510 USDT

One more form factor for Compaq Evo D510, which needs the same quirk
as the other form factors.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/pci/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.31-rc4.orig/drivers/pci/quirks.c	2009-07-14 10:26:41.000000000 +0200
+++ linux-2.6.31-rc4/drivers/pci/quirks.c	2009-07-27 14:47:15.000000000 +0200
@@ -1201,6 +1201,7 @@ static void __init asus_hides_smbus_host
 			switch(dev->subsystem_device) {
 			case 0x00b8: /* Compaq Evo D510 CMT */
 			case 0x00b9: /* Compaq Evo D510 SFF */
+			case 0x00ba: /* Compaq Evo D510 USDT */
 				/* Motherboard doesn't have Host bridge
 				 * subvendor/subdevice IDs and on-board VGA
 				 * controller is disabled if an AGP card is


Then please report if it worked OK or not. If you get lm-sensors to
work, please include the output of "sensors".

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
