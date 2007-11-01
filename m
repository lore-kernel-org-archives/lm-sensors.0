From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 Nov 2007 23:00:34 +0000
Subject: Re: [lm-sensors] PATCH:
Message-Id: <20071102000034.0b613a38@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3DD44.4070307@hhs.nl>
In-Reply-To: <46F3DD44.4070307@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 31 Oct 2007 16:29:44 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > Assuming that you definitely excluded the possibility to retrieve the
> > DMI data from the kernel
> 
> Definitely is a big word, I've looked at the DMI parser currently in the 
> kernel, tried to come up with a way to get the info there which would be more 
> generic then just being an fschmd specific hack and couldn't. Then I slept a 
> night on it and still couldn't come up with something clean, esp since there 
> are many type 185 entries in the DMI table of FSC machines, of which we need 
> only one.

Please take a look at this completely untested patch. It might need
some cleanups before it's ready for submission, but is there any reason
why something like this wouldn't do the job?

---
 drivers/firmware/dmi_scan.c |   50 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/hwmon/fschmd.c      |    9 +++++++
 include/linux/dmi.h         |    3 ++
 3 files changed, 61 insertions(+), 1 deletion(-)

--- linux-2.6.24-rc1.orig/drivers/firmware/dmi_scan.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc1/drivers/firmware/dmi_scan.c	2007-11-01 23:51:46.000000000 +0100
@@ -86,6 +86,50 @@ static int __init dmi_checksum(const u8 
 static char *dmi_ident[DMI_STRING_MAX];
 static LIST_HEAD(dmi_devices);
 int dmi_available;
+static u32 dmi_base;
+static u16 dmi_len;
+static u16 dmi_num;
+
+/* Similar to dmi_table, but for use at a later time */
+int dmi_walk(void (*decode)(const struct dmi_header *))
+{
+	u8 *buf, *data;
+	int i = 0;
+
+	if (!dmi_available)
+		return -1;
+
+	buf = ioremap(dmi_base, dmi_len);
+	if (buf = NULL)
+		return -1;
+
+	data = buf;
+
+	/*
+	 *	Stop when we see all the items the table claimed to have
+	 *	OR we run off the end of the table (also happens)
+	 */
+	while ((i < dmi_num) &&
+	       (data - buf + sizeof(struct dmi_header)) <= dmi_len) {
+		const struct dmi_header *dm = (const struct dmi_header *)data;
+
+		/*
+		 *  We want to know the total length (formated area and strings)
+		 *  before decoding to make sure we won't run off the table in
+		 *  dmi_decode or dmi_string
+		 */
+		data += dm->length;
+		while ((data - buf < dmi_len - 1) && (data[0] || data[1]))
+			data++;
+		if (data - buf < dmi_len - 1)
+			decode(dm);
+		data += 2;
+		i++;
+	}
+	iounmap(buf);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dmi_walk);
 
 /*
  *	Save a DMI string
@@ -287,8 +331,12 @@ static int __init dmi_present(const char
 			       buf[14] >> 4, buf[14] & 0xF);
 		else
 			printk(KERN_INFO "DMI present.\n");
-		if (dmi_table(base,len, num, dmi_decode) = 0)
+		if (dmi_table(base,len, num, dmi_decode) = 0) {
+			dmi_base = base;
+			dmi_len = len;
+			dmi_num = num;
 			return 0;
+		}
 	}
 	return 1;
 }
--- linux-2.6.24-rc1.orig/drivers/hwmon/fschmd.c	2007-11-01 23:16:54.000000000 +0100
+++ linux-2.6.24-rc1/drivers/hwmon/fschmd.c	2007-11-01 23:56:02.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/dmi.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
@@ -768,8 +769,16 @@ static struct fschmd_data *fschmd_update
 	return data;
 }
 
+static void __init fschmd_get_dmi_data(const struct dmi_header *h)
+{
+	if (h->type = 185) {
+		/* Do stuff */
+	}
+}
+
 static int __init fschmd_init(void)
 {
+	dmi_walk(fschmd_get_dmi_data);
 	return i2c_add_driver(&fschmd_driver);
 }
 
--- linux-2.6.24-rc1.orig/include/linux/dmi.h	2007-10-24 09:59:51.000000000 +0200
+++ linux-2.6.24-rc1/include/linux/dmi.h	2007-11-01 23:52:54.000000000 +0100
@@ -78,6 +78,7 @@ extern const struct dmi_device * dmi_fin
 extern void dmi_scan_machine(void);
 extern int dmi_get_year(int field);
 extern int dmi_name_in_vendors(const char *str);
+extern int dmi_walk(void (*decode)(const struct dmi_header *));
 
 #else
 
@@ -87,6 +88,8 @@ static inline const struct dmi_device * 
 	const struct dmi_device *from) { return NULL; }
 static inline int dmi_get_year(int year) { return 0; }
 static inline int dmi_name_in_vendors(const char *s) { return 0; }
+static inline int dmi_walk(void (*decode)(const struct dmi_header *))
+	{ return -1; }
 
 #endif
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
