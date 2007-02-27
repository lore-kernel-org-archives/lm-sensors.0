From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Feb 2007 17:49:14 +0000
Subject: [lm-sensors] hwmon-vid: Unknown VRM version of your x86 CPU
Message-Id: <20070227184914.eba4acff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43834A86.6090205@sh.cvut.cz>
In-Reply-To: <43834A86.6090205@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I now have a VIA Epia EN12000 which shows in dmesg:
> >
> > hwmon-vid: Unknown VRM version of your x86 CPU
> >
> > # cat /proc/cpuinfo
> > processor       : 0
> > vendor_id       : CentaurHauls
> > cpu family      : 6
> > model           : 10
> > model name      : VIA Esther processor 1200MHz

Reading the document "EPIA-EN User's Manual v.1.10" from
http://www.via.com.tw/en/products/mainboards/downloads.jsp?motherboard_id99
there is a list of possible CPU core voltages which reminds me the VRM
table of the Intel Pentium M / Core. Rudolf, what do you think? What
about this patch:

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/hwmon-vid.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.21-rc1.orig/drivers/hwmon/hwmon-vid.c	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.21-rc1/drivers/hwmon/hwmon-vid.c	2007-02-27 18:40:05.000000000 +0100
@@ -176,6 +176,7 @@ static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_CENTAUR, 0x6, 0x8, 0x7, 85},	/* Ezra T */
 	{X86_VENDOR_CENTAUR, 0x6, 0x9, 0x7, 85},	/* Nemiah */
 	{X86_VENDOR_CENTAUR, 0x6, 0x9, ANY, 17},	/* C3-M */
+	{X86_VENDOR_CENTAUR, 0x6, 0xA, ANY, 13},	/* Esther */
 	{X86_VENDOR_UNKNOWN, ANY, ANY, ANY, 0}		/* stop here */
 };
 


-- 
Jean Delvare

