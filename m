From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 17 Dec 2009 14:12:20 +0000
Subject: [lm-sensors] [PATCH v2] hwmon(asus_atk0110): debugfs interface
Message-Id: <20091217141220.GA8416@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Expose the raw GGRP/GITM interface via debugfs. The hwmon interface is
reverse engineered and the driver tends to break on newer boards...
Using this interface it's possible to poke directly at the ACPI methods without
the need to recompile, reducing the guesswork and the round trips needed to
support a new revisions of the interface.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
---
 I should have addressed all you comments

 drivers/hwmon/asus_atk0110.c |  191 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)

Index: linux-2.6.git/drivers/hwmon/asus_atk0110.c
=================================--- linux-2.6.git.orig/drivers/hwmon/asus_atk0110.c	2009-12-14 17:38:59.000000000 +0100
+++ linux-2.6.git/drivers/hwmon/asus_atk0110.c	2009-12-14 17:50:54.000000000 +0100
@@ -5,6 +5,7 @@
  * See COPYING in the top level directory of the kernel tree.
  */
 
+#include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/hwmon.h>
 #include <linux/list.h>
@@ -101,6 +102,11 @@
 	int temperature_count;
 	int fan_count;
 	struct list_head sensor_list;
+
+	struct {
+		struct dentry *root;
+		u32 id;
+	} debugfs;
 };
 
 
@@ -624,6 +630,187 @@
 	return err;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static int atk_debugfs_gitm_get(void *p, u64 *val)
+{
+	struct atk_data *data = p;
+	union acpi_object *ret;
+	struct atk_acpi_ret_buffer *buf;
+	int err = 0;
+
+	if (!data->read_handle)
+		return -ENODEV;
+
+	if (!data->debugfs.id)
+		return -EINVAL;
+
+	ret = atk_gitm(data, data->debugfs.id);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	buf = (struct atk_acpi_ret_buffer *)ret->buffer.pointer;
+	if (buf->flags)
+		*val = buf->value;
+	else
+		err = -EIO;
+
+	return err;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(atk_debugfs_gitm,
+			atk_debugfs_gitm_get,
+			NULL,
+			"0x%08llx\n")
+
+static int atk_acpi_print(char *buf, size_t sz, union acpi_object *obj)
+{
+	int ret = 0;
+
+	switch (obj->type) {
+	case ACPI_TYPE_INTEGER:
+		ret = snprintf(buf, sz, "0x%08llx\n", obj->integer.value);
+		break;
+	case ACPI_TYPE_STRING:
+		ret = snprintf(buf, sz, "%s\n", obj->string.pointer);
+		break;
+	}
+
+	return ret;
+}
+
+static void atk_pack_print(char *buf, size_t sz, union acpi_object *pack)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < pack->package.count; i++) {
+		union acpi_object *obj = &pack->package.elements[i];
+
+		ret = atk_acpi_print(buf, sz, obj);
+		if (ret >= sz)
+			break;
+		buf += ret;
+		sz -= ret;
+	}
+}
+
+static int atk_debugfs_ggrp_open(struct inode *inode, struct file *file)
+{
+	struct atk_data *data = inode->i_private;
+	char *buf = NULL;
+	union acpi_object *ret;
+	u8 cls;
+	int i;
+
+	if (!data->enumerate_handle)
+		return -ENODEV;
+	if (!data->debugfs.id)
+		return -EINVAL;
+
+	cls = (data->debugfs.id & 0xff000000) >> 24;
+	ret = atk_ggrp(data, cls);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	for (i = 0; i < ret->package.count; i++) {
+		union acpi_object *pack = &ret->package.elements[i];
+		union acpi_object *id;
+
+		if (pack->type != ACPI_TYPE_PACKAGE)
+			continue;
+		if (!pack->package.count)
+			continue;
+		id = &pack->package.elements[0];
+		if (id->integer.value = data->debugfs.id) {
+			/* Print the package */
+			buf = kzalloc(512, GFP_KERNEL);
+			if (!buf) {
+				ACPI_FREE(ret);
+				return -ENOMEM;
+			}
+			atk_pack_print(buf, 512, pack);
+			break;
+		}
+	}
+	ACPI_FREE(ret);
+
+	if (!buf)
+		return -EINVAL;
+
+	file->private_data = buf;
+
+	return nonseekable_open(inode, file);
+}
+
+static ssize_t atk_debugfs_ggrp_read(struct file *file, char __user *buf,
+		size_t count, loff_t *pos)
+{
+	char *str = file->private_data;
+	size_t len = strlen(str);
+
+	return simple_read_from_buffer(buf, count, pos, str, len);
+}
+
+static int atk_debugfs_ggrp_release(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+static const struct file_operations atk_debugfs_ggrp_fops = {
+	.read		= atk_debugfs_ggrp_read,
+	.open		= atk_debugfs_ggrp_open,
+	.release	= atk_debugfs_ggrp_release,
+};
+
+static void atk_debugfs_init(struct atk_data *data)
+{
+	struct dentry *d;
+	struct dentry *f;
+
+	data->debugfs.id = 0;
+
+	d = debugfs_create_dir("asus_atk0110", NULL);
+	if (!d || IS_ERR(d))
+		return;
+
+	f = debugfs_create_x32("id", S_IRUSR | S_IWUSR, d, &data->debugfs.id);
+	if (!f || IS_ERR(f))
+		goto cleanup;
+
+	f = debugfs_create_file("gitm", S_IRUSR, d, data,
+			&atk_debugfs_gitm);
+	if (!f || IS_ERR(f))
+		goto cleanup;
+
+	f = debugfs_create_file("ggrp", S_IRUSR, d, data,
+			&atk_debugfs_ggrp_fops);
+	if (!f || IS_ERR(f))
+		goto cleanup;
+
+	data->debugfs.root = d;
+
+	return;
+cleanup:
+	debugfs_remove_recursive(d);
+}
+
+static void atk_debugfs_cleanup(struct atk_data *data)
+{
+	debugfs_remove_recursive(data->debugfs.root);
+}
+
+#else /* CONFIG_DEBUG_FS */
+
+static void atk_debugfs_init(struct atk_data *data)
+{
+}
+
+static void atk_debugfs_cleanup(struct atk_data *data)
+{
+}
+#endif
+
 static int atk_add_sensor(struct atk_data *data, union acpi_object *obj)
 {
 	struct device *dev = &data->acpi_dev->dev;
@@ -1180,6 +1367,8 @@
 	if (err)
 		goto cleanup;
 
+	atk_debugfs_init(data);
+
 	device->driver_data = data;
 	return 0;
 cleanup:
@@ -1198,6 +1387,8 @@
 
 	device->driver_data = NULL;
 
+	atk_debugfs_cleanup(data);
+
 	atk_remove_files(data);
 	atk_free_sensors(data);
 	hwmon_device_unregister(data->hwmon_dev);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
