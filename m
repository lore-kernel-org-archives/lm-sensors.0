From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Jun 2011 18:00:34 +0000
Subject: Re: [lm-sensors] sensor details for W83627HG-AW
Message-Id: <20110620200034.29685c8b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <838315.8004.qm@web95806.mail.in.yahoo.com>
In-Reply-To: <838315.8004.qm@web95806.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krunal,

On Sat, 4 Jun 2011 13:08:18 +0200, Jean Delvare wrote:
> Brilly, Kary, can you help us here, please? Where can we get the VID pin
> codes -> Vcore voltage conversion table for VIA CPU family 6, model 13?
> This is needed to update drivers/hwmon/hwmon-vid.c.

I received information from VIA and was able to update hwmon-vid to
support your CPU. Patch below. I couldn't test it as I don't have the
hardware. I've also made the modified hwmon-vid driver available as a
standalone driver at:
  http://khali.linux-fr.org/devel/misc/hwmon-vid/
with instructions at:
  http://khali.linux-fr.org/devel/misc/INSTALL

Please test if you can, and report.


From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon-vid: Add support for VIA C7-D

The VIA C7-D CPU (Eden 90 nm) can use two different VID tables, we
have to check the value of a MSR to decide which one to use.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/hwmon-vid.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- linux-3.0-rc3.orig/drivers/hwmon/hwmon-vid.c	2011-06-20 13:43:24.000000000 +0200
+++ linux-3.0-rc3/drivers/hwmon/hwmon-vid.c	2011-06-20 17:58:18.000000000 +0200
@@ -206,10 +206,30 @@ static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_CENTAUR, 0x6, 0x9, ANY, 17},	/* C3-M, Eden-N */
 	{X86_VENDOR_CENTAUR, 0x6, 0xA, 0x7, 0},		/* No information */
 	{X86_VENDOR_CENTAUR, 0x6, 0xA, ANY, 13},	/* C7, Esther */
+	{X86_VENDOR_CENTAUR, 0x6, 0xD, ANY, 134},	/* C7-D, Eden (90 nm) */
 
 	{X86_VENDOR_UNKNOWN, ANY, ANY, ANY, 0}		/* stop here */
 };
 
+/*
+ * Special case for VIA C7-D: there are two different possible
+ * VID tables, so we have to figure out first, which one must
+ * be used.
+ */
+static u8 get_via_c7d_vrm(void)
+{
+	unsigned int eax, edx;
+
+	rdmsr(0x198, eax, edx);
+	if ((edx & 0xff) > 0x3f) {
+		pr_info("Using %d-bit VID table for VIA C7-D CPU\n", 7);
+		return 14;
+	} else {
+		pr_info("Using %d-bit VID table for VIA C7-D CPU\n", 6);
+		return 13;
+	}
+}
+
 static u8 find_vrm(u8 eff_family, u8 eff_model, u8 eff_stepping, u8 vendor)
 {
 	int i = 0;
@@ -249,6 +269,9 @@ u8 vid_which_vrm(void)
 	vrm_ret = find_vrm(eff_family, eff_model, eff_stepping, c->x86_vendor);
 	if (vrm_ret = 0)
 		pr_info("Unknown VRM version of your x86 CPU\n");
+	if (vrm_ret = 134)
+		vrm_ret = get_via_c7d_vrm();
+
 	return vrm_ret;
 }
 


-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
