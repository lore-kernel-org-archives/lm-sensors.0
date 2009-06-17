From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 17 Jun 2009 11:08:46 +0000
Subject: [lm-sensors] [PATCH] hwmon-vid: Ignore 6th VID pin of AMD family
Message-Id: <20090617130846.398be4bf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We had a report about a mainboard for AMD family 0Fh processors not
routing the 6th VID pin from the CPU to the hardware monitoring chip.

While the vendor should have wired the pin (or, failing that, should
have hardwired it to level high rather than low), the fact is that
none of these processors are currently known to operate at the lower
voltage levels which require the 6th VID pin. So, as a practical
workaround, I propose to ignore the 6th VID pin for these CPUs.

If this decision ever causes problems, we'll reconsider.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Frank Myhr <fmyhr@fhmtech.com>
Cc: Hleb Valoshka <375gnu@gmail.com>
Cc: Rudolf Marek <r.marek@assembler.cz>
Cc: Andreas Herrmann <andreas.herrmann3@amd.com>
---
I know this is technically incorrect, but this seems to be the easiest
solution in practice.

 drivers/hwmon/hwmon-vid.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- linux-2.6.31-pre.orig/drivers/hwmon/hwmon-vid.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.31-pre/drivers/hwmon/hwmon-vid.c	2009-06-17 12:45:36.000000000 +0200
@@ -179,8 +179,14 @@ struct vrm_model {
 static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_AMD, 0x6, ANY, ANY, 90},		/* Athlon Duron etc */
 	{X86_VENDOR_AMD, 0xF, 0x3F, ANY, 24},		/* Athlon 64, Opteron */
-	{X86_VENDOR_AMD, 0xF, ANY, ANY, 25},		/* NPT family 0Fh */
+	/* In theory, all NPT family 0Fh processors have 6 VID pins and should
+	   thus use vrm 25, however in practice not all mainboards route the
+	   6th VID pin because it is never needed. So we use the 5 VID pin
+	   variant (vrm 24) for the models which exist today. */
+	{X86_VENDOR_AMD, 0xF, 0x7F, ANY, 24},		/* NPT family 0Fh */
+	{X86_VENDOR_AMD, 0xF, ANY, ANY, 25},		/* future fam. 0Fh */
 	{X86_VENDOR_AMD, 0x10, ANY, ANY, 25},		/* NPT family 10h */
+
 	{X86_VENDOR_INTEL, 0x6, 0x9, ANY, 13},		/* Pentium M (130 nm) */
 	{X86_VENDOR_INTEL, 0x6, 0xB, ANY, 85},		/* Tualatin */
 	{X86_VENDOR_INTEL, 0x6, 0xD, ANY, 13},		/* Pentium M (90 nm) */
@@ -191,12 +197,14 @@ static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_INTEL, 0xF, 0x1, ANY, 90},		/* P4 Willamette */
 	{X86_VENDOR_INTEL, 0xF, 0x2, ANY, 90},		/* P4 Northwood */
 	{X86_VENDOR_INTEL, 0xF, ANY, ANY, 100},		/* Prescott and above assume VRD 10 */
+
 	{X86_VENDOR_CENTAUR, 0x6, 0x7, ANY, 85},	/* Eden ESP/Ezra */
 	{X86_VENDOR_CENTAUR, 0x6, 0x8, 0x7, 85},	/* Ezra T */
 	{X86_VENDOR_CENTAUR, 0x6, 0x9, 0x7, 85},	/* Nemiah */
 	{X86_VENDOR_CENTAUR, 0x6, 0x9, ANY, 17},	/* C3-M, Eden-N */
 	{X86_VENDOR_CENTAUR, 0x6, 0xA, 0x7, 0},		/* No information */
 	{X86_VENDOR_CENTAUR, 0x6, 0xA, ANY, 13},	/* C7, Esther */
+
 	{X86_VENDOR_UNKNOWN, ANY, ANY, ANY, 0}		/* stop here */
 };
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
