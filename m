From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:19:02 +0000
Subject: [lm-sensors] [PATCH] I2C: add i2c module alias for i2c drivers to
Message-Id: <1130533664960@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: add i2c module alias for i2c drivers to use

This is the start of adding hotplug-like support for i2c devices.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a9d1b24d91f91b77db3da8aeacb414764f789b9c
tree a7400c6154b7e5b6839b3c25fecc2daac75c4a2b
parent 0dc9a32d9a975ccd25b9f531451165c93e1c7313
author Greg Kroah-Hartman <gregkh@suse.de> Sat, 22 Oct 2005 00:23:27 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:15 -0700

 include/linux/i2c.h             |    1 +
 include/linux/mod_devicetable.h |    5 +++++
 scripts/mod/file2alias.c        |   10 ++++++++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 32977fb..f88577c 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/i2c-id.h>
+#include <linux/mod_devicetable.h>
 #include <linux/device.h>	/* for struct device */
 #include <asm/semaphore.h>
 
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 2f0299a..7b08c11 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -244,4 +244,9 @@ struct pcmcia_device_id {
 #define PCMCIA_DEV_ID_MATCH_FAKE_CIS	0x0200
 #define PCMCIA_DEV_ID_MATCH_ANONYMOUS	0x0400
 
+/* I2C */
+struct i2c_device_id {
+	__u16 id;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index f2ee673..e3d144a 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -359,6 +359,13 @@ static int do_vio_entry(const char *file
 	return 1;
 }
 
+static int do_i2c_entry(const char *filename, struct i2c_device_id *i2c, char *alias)
+{
+	strcpy(alias, "i2c:");
+	ADD(alias, "id", 1, i2c->id);
+	return 1;
+}
+
 /* Ignore any prefix, eg. v850 prepends _ */
 static inline int sym_is(const char *symbol, const char *name)
 {
@@ -443,6 +450,9 @@ void handle_moddevtable(struct module *m
         else if (sym_is(symname, "__mod_vio_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct vio_device_id),
 			 do_vio_entry, mod);
+	else if (sym_is(symname, "__mod_i2c_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct i2c_device_id),
+			 do_i2c_entry, mod);
 
 }
 

