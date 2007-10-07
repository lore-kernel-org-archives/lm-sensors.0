From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Oct 2007 20:44:33 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix the code examples in documentation
Message-Id: <20071007224433.1471452a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sun, 7 Oct 2007 14:28:46 -0400, Mark M. Hoffman wrote:
> Hi Jean:
> 
> > Jean Delvare wrote:
> > > Additionally, I think that the examples are a bit difficult to read,
> > > one level of indentation would probably be better than the begin/end
> > > code markers. Thus, I propose the following incremental patch:
> > > 
> > >  Documentation/hwmon/sysfs-interface |   30 ++++++++++++++----------------
> > >  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> * Hans de Goede <j.w.r.degoede@hhs.nl> [2007-10-07 13:37:53 +0200]:
> > I agree with all changes, Mark pleaee apply:
> > 
> > Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> Could you please re-generate this one against the hwmon testing tree and
> w/ a Signed-off-by?

Sorry, I expected Hans or you to merge my changes into Hans' original
patch, that's why I omitted the Signed-off-by and the log message.

* * * * *

Fix a bug in the code examples, make them comply with CodingStyle,
and indent them for a better redability.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>
---
 Documentation/hwmon/sysfs-interface |   30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

--- linux-2.6.23-rc9.orig/Documentation/hwmon/sysfs-interface	2007-10-07 10:12:33.000000000 +0200
+++ linux-2.6.23-rc9/Documentation/hwmon/sysfs-interface	2007-10-07 10:13:43.000000000 +0200
@@ -450,22 +450,20 @@ continuous like for example a tempX_type
 written, -EINVAL should be returned.
 
 Example1, temp1_max, register is a signed 8 bit value (-128 - 127 degrees):
---- begin code ---
-long v = simple_strtol(buf, NULL, 10) / 1000;
-SENSORS_LIMIT(v, -128, 127);
-/* write v to register */
---- end code ---
+
+	long v = simple_strtol(buf, NULL, 10) / 1000;
+	v = SENSORS_LIMIT(v, -128, 127);
+	/* write v to register */
 
 Example2, fan divider setting, valid values 2, 4 and 8:
---- begin code ---
-unsigned long v = simple_strtoul(buf, NULL, 10);
 
-switch (v) {
-       case 2: v = 1; break;
-       case 4: v = 2; break;
-       case 8: v = 3; break;
-       default:
-               return -EINVAL;
-}
-/* write v to register */
---- end code ---
+	unsigned long v = simple_strtoul(buf, NULL, 10);
+
+	switch (v) {
+	case 2: v = 1; break;
+	case 4: v = 2; break;
+	case 8: v = 3; break;
+	default:
+		return -EINVAL;
+	}
+	/* write v to register */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
