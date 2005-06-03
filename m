From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Fri, 03 Jun 2005 17:59:11 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2 3/5] w1 enhancements
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9076C5EB@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Adds a sysfs entry (w1_master_search) that allows you to disable/enable
periodic searches.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
-------------- next part --------------
--- linux-2.6.12-rc5-mm2-w1defaultfam/drivers/w1/w1.c	2005-06-03 08:50:02.000000000 -0500
+++ linux-2.6.12-rc5-mm2/drivers/w1/w1.c	2005-06-03 10:26:11.812696760 -0500
@@ -161,6 +161,39 @@
 	return count;
 }
 
+static ssize_t w1_master_attribute_store_search(struct device * dev, 
+						struct device_attribute *attr,
+						const char * buf, size_t count)
+{
+	struct w1_master *md = container_of(dev, struct w1_master, dev);
+
+	if (down_interruptible (&md->mutex))
+		return -EBUSY;
+
+	md->search_count = simple_strtol(buf, NULL, 0);
+
+	up(&md->mutex);
+
+	return count;
+}
+
+static ssize_t w1_master_attribute_show_search(struct device *dev, 
+					       struct device_attribute *attr, 
+					       char *buf)
+{
+	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	ssize_t count;
+
+	if (down_interruptible (&md->mutex))
+		return -EBUSY;
+
+	count = sprintf(buf, "%d\n", md->search_count);
+
+	up(&md->mutex);
+
+	return count;
+}
+
 static ssize_t w1_master_attribute_show_pointer(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
@@ -255,6 +288,12 @@
 		__ATTR(w1_master_##_name, _mode,		\
 		       w1_master_attribute_show_##_name, NULL)
 
+#define W1_MASTER_ATTR_RW(_name, _mode)				\
+	struct device_attribute w1_master_attribute_##_name =	\
+		__ATTR(w1_master_##_name, _mode,		\
+		       w1_master_attribute_show_##_name,	\
+		       w1_master_attribute_store_##_name)
+
 static W1_MASTER_ATTR_RO(name, S_IRUGO);
 static W1_MASTER_ATTR_RO(slaves, S_IRUGO);
 static W1_MASTER_ATTR_RO(slave_count, S_IRUGO);
@@ -262,6 +301,7 @@
 static W1_MASTER_ATTR_RO(attempts, S_IRUGO);
 static W1_MASTER_ATTR_RO(timeout, S_IRUGO);
 static W1_MASTER_ATTR_RO(pointer, S_IRUGO);
+static W1_MASTER_ATTR_RW(search, S_IRUGO | S_IWUGO);
 
 static struct attribute *w1_master_default_attrs[] = {
 	&w1_master_attribute_name.attr,
@@ -271,6 +311,7 @@
 	&w1_master_attribute_attempts.attr,
 	&w1_master_attribute_timeout.attr,
 	&w1_master_attribute_pointer.attr,
+	&w1_master_attribute_search.attr,
 	NULL
 };
 
@@ -658,11 +699,14 @@
 		if (!dev->initialized)
 			continue;
 
+		if (dev->search_count = 0)
+			continue;
+
 		if (down_interruptible(&dev->mutex))
 			continue;
 
 		list_for_each_entry(sl, &dev->slist, w1_slave_entry)
-				clear_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
+			clear_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
 
 		w1_search_devices(dev, w1_slave_found);
 
@@ -677,6 +721,10 @@
 			} else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
 				sl->ttl = dev->slave_ttl;
 		}
+
+		if (dev->search_count > 0)
+			dev->search_count--;
+
 		up(&dev->mutex);
 	}
 
--- linux-2.6.12-rc5-mm2-w1defaultfam/drivers/w1/w1.h	2005-06-03 10:23:52.648695064 -0500
+++ linux-2.6.12-rc5-mm2/drivers/w1/w1.h	2005-06-03 09:06:50.110814756 -0500
@@ -162,6 +162,7 @@
 	int			slave_ttl;
 	int			initialized;
 	u32			id;
+	int			search_count;
 
 	atomic_t		refcnt;
 
--- linux-2.6.12-rc5-mm2-touchbit/drivers/w1/w1_int.c	2005-06-03 08:37:30.000000000 -0500
+++ linux-2.6.12-rc5-mm2/drivers/w1/w1_int.c	2005-06-03 09:19:31.000000000 -0500
@@ -69,6 +69,7 @@
 	dev->initialized	= 0;
 	dev->id			= id;
 	dev->slave_ttl		= slave_ttl;
+        dev->search_count	= -1; /* continual scan */
 
 	atomic_set(&dev->refcnt, 2);
 
