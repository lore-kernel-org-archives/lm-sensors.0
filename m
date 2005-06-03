From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Fri, 03 Jun 2005 23:32:49 +0000
Subject: [lm-sensors] [4/6] w1: Adds a default family so that new slave
Message-Id: <20050604013126.1298c78f@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Adds a default family so that new slave families will show up in sysfs.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

--- linux-2.6.12-rc5-mm2-triplet/drivers/w1/w1.c	2005-06-03 08:33:13.254988573 -0500
+++ linux-2.6.12-rc5-mm2-w1defaultfam/drivers/w1/w1.c	2005-06-03 08:50:02.943448247 -0500
@@ -59,6 +59,19 @@
 static int control_needs_exit;
 static DECLARE_COMPLETION(w1_control_complete);
 
+/* stuff for the default family */
+static ssize_t w1_famdefault_read_name(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	return(sprintf(buf, "%s\n", sl->name));
+}
+static struct w1_family_ops w1_default_fops = {
+	.rname = &w1_famdefault_read_name,
+};
+static struct w1_family w1_default_family = {
+	.fops = &w1_default_fops,
+};
+
 static int w1_master_match(struct device *dev, struct device_driver *drv)
 {
 	return 1;
@@ -319,14 +332,16 @@
 		return err;
 	}
 
-	err = sysfs_create_bin_file(&sl->dev.kobj, &sl->attr_bin);
-	if (err < 0) {
-		dev_err(&sl->dev,
-			"sysfs file creation for [%s] failed. err=%d\n",
-			sl->dev.bus_id, err);
-		device_remove_file(&sl->dev, &sl->attr_name);
-		device_unregister(&sl->dev);
-		return err;
+	if ( sl->attr_bin.read ) {
+		err = sysfs_create_bin_file(&sl->dev.kobj, &sl->attr_bin);
+		if (err < 0) {
+			dev_err(&sl->dev,
+				"sysfs file creation for [%s] failed. err=%d\n",
+				sl->dev.bus_id, err);
+			device_remove_file(&sl->dev, &sl->attr_name);
+			device_unregister(&sl->dev);
+			return err;
+		}
 	}
 
 	list_add_tail(&sl->w1_slave_entry, &sl->master->slist);
@@ -362,12 +377,10 @@
 	spin_lock(&w1_flock);
 	f = w1_family_registered(rn->family);
 	if (!f) {
-		spin_unlock(&w1_flock);
+		f= &w1_default_family;
 		dev_info(&dev->dev, "Family %x for %02x.%012llx.%02x is not registered.\n",
 			  rn->family, rn->family,
 			  (unsigned long long)rn->id, rn->crc);
-		kfree(sl);
-		return -ENODEV;
 	}
 	__w1_family_get(f);
 	spin_unlock(&w1_flock);
@@ -408,7 +421,9 @@
 			flush_signals(current);
 	}
 
-	sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
+	if ( sl->attr_bin.read ) {
+		sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
+	}
 	device_remove_file(&sl->dev, &sl->attr_name);
 	device_unregister(&sl->dev);
 	w1_family_put(sl->family);



	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
