From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:10:49 +0000
Subject: [lm-sensors] [PATCH v2 01/24] hwmon: (hwmon-vid) Determine vrm during initialization, and add vrm mo
Message-Id: <1328123472-27816-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The vrm value is system-wide and only needs to be calculated once. Do it when
the module is loaded. Provide a module parameter to enable overwriting the
default value in case it is wrong or can not be calculated.

Modify the vid_from_reg and vid_to_reg API functions to accept the vrm value as
optional parameter using varargs, but ignore the vrm parameter and use the
internal value instead. This will enable us to drop the vrm attribute from
individual drivers one at a time.

Cc: Rudolf Marek <r.marek@assembler.cz>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: vrm module parameter is now writable.
    Updated module parameter description.
    Added Documentation/hwmon/hwmon-vid.
    Updated Documentation/hwmon/sysfs-interface (removed vrm from ABI).
    vid_from_reg() now returns an error code if vrm is unknown.
    module load now fails if the vrm module parameter is invalid.
    The vrm parameter to vid_from_reg is now optional and ignored.
    Moved vid_to_reg from hwmon-vid.h to hwmon-vid.c. Its vrm parameter is now
    optional and ignored.
    
 Documentation/hwmon/hwmon-vid       |   70 +++++++++++++++++++++++++++++++++++
 Documentation/hwmon/sysfs-interface |    8 ----
 drivers/hwmon/hwmon-vid.c           |   70 +++++++++++++++++++++++++++++------
 include/linux/hwmon-vid.h           |   19 +--------
 4 files changed, 130 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/hwmon/hwmon-vid

diff --git a/Documentation/hwmon/hwmon-vid b/Documentation/hwmon/hwmon-vid
new file mode 100644
index 0000000..aa1a34a
--- /dev/null
+++ b/Documentation/hwmon/hwmon-vid
@@ -0,0 +1,70 @@
+VID pin settings
+--------------------
+
+The VID (Voltage Identification) pins on sensor chips
+are used to read the CPU Core voltage setting.
+
+The VID setting can be controlled by jumpers on the board,
+or, in newer motherboards, by settings in the BIOS.
+On these newer boards, the BIOS programs some device's
+pins which in turn controls a DC-DC Converter to set its
+output to a certain voltage. These pins are also connected to
+the sensor chip so that the VID setting can be read back
+by applications.
+
+There are between 4 and 8 VID pins (the more recent the CPU, the more
+numerous the VID pins.) The VID codes are defined by Intel in documents
+titled "VRM X.X DC-DC Converter Design Guidelines".
+(VRM = Voltage Regulator Module), or
+"Voltage Regulator-Down (VRD) X.X Design Guide".
+These documents are available at http://developer.intel.com.
+There are equivalent documents for AMD processors (look for a table
+named "VID Code Voltages" in processor specifications.)
+
+There are several different VRM document versions.
+The common versions are as follows:
+
+Document Version	Voltage Range	Increment	Processors
+----------------	-------------	---------	----------
+"2.4"			0.8 - 1.55	0.025V		AMD Opteron 24x
+
+8.2 (8.1, 8.3)		1.30 - 2.05V    0.05V		PII, PIII, Celeron
+			2.1 - 3.5V	0.10V
+
+8.4			1.30 - 2.05V    0.05V		PIII, Celeron
+							4 pins only
+
+8.5			1.050 - 1.825V	0.05V		PIII-S Tualatin
+
+9.0, (9.1)		1.100 - 1.850V	0.025V		P4, AMD Socket A
+
+10.0			0.8375 - 1.6000 0.0125V		Desktop Socket 478
+
+11.0			0.5 - 1.6V	0.00625V	Intel Conroe and later
+
+
+"2.4" is not an actual document version but simply a way to identify
+AMD Opteron 24x processors.
+Note that versions 8.1 - 8.4 are compatible.
+
+Since Linux 2.6.9, the correct VRM version is selected automatically
+based on the CPU brand and model. Thus you shouldn't have to care about
+it. If you are using a brand new CPU and even the latest kernel complains
+("Unknown VRM version of your CPU"), this means that the kernel must be
+taught about this new CPU model. Please report to us in this case.
+
+Starting with kernel version 3.4, you can specify the vrm model as parameter
+to the hwmon-vid kernel module.
+
+Example:
+	modprobe hwmon-vid vrm0
+selects vrm version 11.0.
+
+Only known vrm values will be accepted. hwmon-vid will fail to load if an
+unknown or unsupported vrm version is provided.
+
+Remember, the VID pins on the sensor chips are inputs only.
+You cannot use them to manipulate the actual processor core voltage.
+
+------------------
+Copyright (c) 2002-2004 Mark D. Studebaker
diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index 1f4dd85..4e08ec5 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -175,14 +175,6 @@ cpu[0-*]_vid	CPU core reference voltage.
 		RO
 		Not always correct.
 
-vrm		Voltage Regulator Module version number. 
-		RW (but changing it should no more be necessary)
-		Originally the VRM standard version multiplied by 10, but now
-		an arbitrary number, as not all standards have a version
-		number.
-		Affects the way the driver calculates the CPU core reference
-		voltage from the vid pins.
-
 Also see the Alarms section for status flags associated with voltages.
 
 
diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index 9f26400..2029256 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -73,13 +73,19 @@
  * http://www.intel.com/design/processor/applnots/313214.htm
  */
 
+static ushort vrm;
+module_param(vrm, ushort, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(vrm, "VRM/VRD version");
+
 /*
  * vrm is the VRM/VRD document version multiplied by 10.
  * val is the 4-bit or more VID code.
  * Returned value is in mV to avoid floating point in the kernel.
  * Some VID have some bits in uV scale, this is rounded to mV.
+ *
+ * Returns -EINVAL if vrm is not supported or unknown.
  */
-int vid_from_reg(int val, u8 vrm)
+int vid_from_reg(int val, ...)
 {
 	int vid;
 
@@ -150,15 +156,25 @@ int vid_from_reg(int val, u8 vrm)
 				/* compute in uV, round to mV */
 		val &= 0x7f;
 		return val > 0x77 ? 0 : (1500000 - (val * 12500) + 500) / 1000;
-	default:		/* report 0 for unknown */
-		if (vrm)
-			pr_warn("Requested unsupported VRM version (%u)\n",
-				(unsigned int)vrm);
-		return 0;
+	default:		/* unknown/unsupported */
+		return -EINVAL;
 	}
 }
 EXPORT_SYMBOL(vid_from_reg);
 
+int vid_to_reg(int val, ...)
+{
+	switch (vrm) {
+	case 91:		/* VRM 9.1 */
+	case 90:		/* VRM 9.0 */
+		return ((val >= 1100) && (val <= 1850) ?
+			((18499 - val * 10) / 25 + 5) / 10 : -1);
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL(vid_to_reg);
+
 /*
  * After this point is the code to automatically determine which
  * VRM/VRD specification should be used depending on the CPU.
@@ -234,7 +250,7 @@ static struct vrm_model vrm_models[] = {
  * + quirk for Eden ULV 500 MHz).
  * Note: something similar might be needed for model A, I'm not sure.
  */
-static u8 get_via_model_d_vrm(void)
+static u8 __init get_via_model_d_vrm(void)
 {
 	unsigned int vid, brand, dummy;
 	static const char *brands[4] = {
@@ -259,7 +275,7 @@ static u8 get_via_model_d_vrm(void)
 	}
 }
 
-static u8 find_vrm(u8 family, u8 model, u8 stepping, u8 vendor)
+static u8 __init find_vrm(u8 family, u8 model, u8 stepping, u8 vendor)
 {
 	int i;
 
@@ -275,11 +291,25 @@ static u8 find_vrm(u8 family, u8 model, u8 stepping, u8 vendor)
 	return 0;
 }
 
-u8 vid_which_vrm(void)
+static int __init vid_init(void)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
 	u8 vrm_ret;
 
+	if (vrm) {
+		/*
+		 * Validate vrm by calling vid_from_reg() with an arbitrary vid.
+		 * If it returns a non-negative value, we know that vrm is
+		 * valid. If the configured vrm is invalid, refuse to load the
+		 * module.
+		 */
+		if (vid_from_reg(0) < 0) {
+			pr_err("Requested unsupported VRM version (%u)\n", vrm);
+			return -ENODEV;
+		}
+		return 0;
+	}
+
 	if (c->x86 < 6)		/* Any CPU with family lower than 6 */
 		return 0;	/* doesn't have VID */
 
@@ -288,19 +318,35 @@ u8 vid_which_vrm(void)
 		vrm_ret = get_via_model_d_vrm();
 	if (vrm_ret = 0)
 		pr_info("Unknown VRM version of your x86 CPU\n");
-	return vrm_ret;
+
+	vrm = vrm_ret;
+
+	return 0;
 }
 
 /* and now for something completely different for the non-x86 world */
 #else
-u8 vid_which_vrm(void)
+
+static int __init vid_init(void)
 {
-	pr_info("Unknown VRM version of your CPU\n");
 	return 0;
 }
+
 #endif
+
+static void __exit vid_exit(void)
+{
+}
+
+u8 vid_which_vrm(void)
+{
+	return vrm;
+}
 EXPORT_SYMBOL(vid_which_vrm);
 
+module_init(vid_init);
+module_exit(vid_exit);
+
 MODULE_AUTHOR("Rudolf Marek <r.marek@assembler.cz>");
 
 MODULE_DESCRIPTION("hwmon-vid driver");
diff --git a/include/linux/hwmon-vid.h b/include/linux/hwmon-vid.h
index f346e4d..7e08ce4 100644
--- a/include/linux/hwmon-vid.h
+++ b/include/linux/hwmon-vid.h
@@ -23,23 +23,8 @@
 #ifndef _LINUX_HWMON_VID_H
 #define _LINUX_HWMON_VID_H
 
-int vid_from_reg(int val, u8 vrm);
+int vid_from_reg(int val, ...);
 u8 vid_which_vrm(void);
-
-/* vrm is the VRM/VRD document version multiplied by 10.
-   val is in mV to avoid floating point in the kernel.
-   Returned value is the 4-, 5- or 6-bit VID code.
-   Note that only VRM 9.x is supported for now. */
-static inline int vid_to_reg(int val, u8 vrm)
-{
-	switch (vrm) {
-	case 91:		/* VRM 9.1 */
-	case 90:		/* VRM 9.0 */
-		return ((val >= 1100) && (val <= 1850) ?
-			((18499 - val * 10) / 25 + 5) / 10 : -1);
-	default:
-		return -1;
-	}
-}
+int vid_to_reg(int val, ...);
 
 #endif /* _LINUX_HWMON_VID_H */
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
