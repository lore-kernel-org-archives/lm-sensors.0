From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Fri, 03 Jun 2005 23:33:06 +0000
Subject: [lm-sensors] [6/6] w1: reconnect feature.
Message-Id: <20050604012925.4fa23525@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've created reconnect feature - if on start there are no
registered families all new devices will have defailt family,
later when driver for appropriate family is loaded, slaves,
which were faound earlier, will still have defult family instead 
of right one. Reconnect feature will force control thread to 
run through all master devices and all slaves found 
and search for slaves with default family id and try to reconnect
them.
It does not store newly registered family and does not check
only those slaves which have reg_num.family the same as being
registered one - all slaves with default family are reconnected.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff -ru ../linux-2.6.11-orig/linux-2.6.11/drivers/w1/ds_w1_bridge.c drivers/w1/ds_w1_bridge.c
--- ../linux-2.6.11-orig/linux-2.6.11/drivers/w1/ds_w1_bridge.c	2005-03-02 10:37:31.000000000 +0300
+++ ./drivers/w1/ds_w1_bridge.c	2005-06-04 00:36:23.000000000 +0400
@@ -83,11 +83,11 @@
 	return byte;
 }
 
-static void ds9490r_write_block(unsigned long data, u8 *buf, int len)
+static void ds9490r_write_block(unsigned long data, const u8 *buf, int len)
 {
 	struct ds_device *dev = (struct ds_device *)data;
 
-	ds_write_block(dev, buf, len);
+	ds_write_block(dev, (u8 *)buf, len);
 }
 
 static u8 ds9490r_read_block(unsigned long data, u8 *buf, int len)
diff -ru ../linux-2.6.11-orig/linux-2.6.11/drivers/w1/w1.c drivers/w1/w1.c
--- ../linux-2.6.11-orig/linux-2.6.11/drivers/w1/w1.c	2005-06-04 01:06:55.000000000 +0400
+++ ./drivers/w1/w1.c	2005-06-04 00:52:29.000000000 +0400
@@ -468,6 +468,8 @@
 	device_remove_file(&sl->dev, &sl->attr_name);
 	device_unregister(&sl->dev);
 	w1_family_put(sl->family);
+				
+	sl->master->slave_count--;
 
 	memcpy(&msg.id.id, &sl->reg_num, sizeof(msg.id.id));
 	msg.type = W1_SLAVE_REMOVE;
@@ -492,6 +494,20 @@
 	return (found)?dev:NULL;
 }
 
+void w1_reconnect_slaves(struct w1_family *f)
+{
+	struct w1_master *dev;
+	
+	spin_lock_bh(&w1_mlock);
+	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
+		dev_info(&dev->dev, "Reconnecting slaves in %s into new family %02x.\n", 
+				dev->name, f->fid);
+		set_bit(W1_MASTER_NEED_RECONNECT, &dev->flags);
+	}
+	spin_unlock_bh(&w1_mlock);
+}
+
+
 static void w1_slave_found(unsigned long data, u64 rn)
 {
 	int slave_count;
@@ -637,7 +653,7 @@
 			flush_signals(current);
 
 		list_for_each_entry_safe(dev, n, &w1_masters, w1_master_entry) {
-			if (!control_needs_exit && !dev->need_exit)
+			if (!control_needs_exit && !dev->flags)
 				continue;
 			/*
 			 * Little race: we can create thread but not set the flag.
@@ -648,12 +664,8 @@
 				continue;
 			}
 
-			spin_lock_bh(&w1_mlock);
-			list_del(&dev->w1_master_entry);
-			spin_unlock_bh(&w1_mlock);
-
 			if (control_needs_exit) {
-				dev->need_exit = 1;
+				set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
 
 				err = kill_proc(dev->kpid, SIGTERM, 1);
 				if (err)
@@ -662,16 +674,42 @@
 						 dev->kpid);
 			}
 
-			wait_for_completion(&dev->dev_exited);
-
-			list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
-				list_del(&sl->w1_slave_entry);
+			if (test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
+				wait_for_completion(&dev->dev_exited);
+				spin_lock_bh(&w1_mlock);
+				list_del(&dev->w1_master_entry);
+				spin_unlock_bh(&w1_mlock);
+
+				list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
+					list_del(&sl->w1_slave_entry);
+
+					w1_slave_detach(sl);
+					kfree(sl);
+				}
+				w1_destroy_master_attributes(dev);
+				atomic_dec(&dev->refcnt);
+				continue;
+			}
 
-				w1_slave_detach(sl);
-				kfree(sl);
+			if (test_bit(W1_MASTER_NEED_RECONNECT, &dev->flags)) {
+				dev_info(&dev->dev, "Reconnecting slaves in device %s.\n", dev->name);
+				down(&dev->mutex);
+				list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
+					if (sl->family->fid = W1_FAMILY_DEFAULT) {
+						struct w1_reg_num rn;
+						list_del(&sl->w1_slave_entry);
+						w1_slave_detach(sl);
+
+						memcpy(&rn, &sl->reg_num, sizeof(rn));
+						
+						kfree(sl);
+
+						w1_attach_slave_device(dev, &rn);
+					}
+				}
+				clear_bit(W1_MASTER_NEED_RECONNECT, &dev->flags);
+				up(&dev->mutex);
 			}
-			w1_destroy_master_attributes(dev);
-			atomic_dec(&dev->refcnt);
 		}
 	}
 
@@ -686,14 +724,14 @@
 	daemonize("%s", dev->name);
 	allow_signal(SIGTERM);
 
-	while (!dev->need_exit) {
+	while (!test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
 		try_to_freeze(PF_FREEZE);
 		msleep_interruptible(w1_timeout * 1000);
 
 		if (signal_pending(current))
 			flush_signals(current);
 
-		if (dev->need_exit)
+		if (test_bit(W1_MASTER_NEED_EXIT, &dev->flags))
 			break;
 
 		if (!dev->initialized)
diff -ru ../linux-2.6.11-orig/linux-2.6.11/drivers/w1/w1.h drivers/w1/w1.h
--- ../linux-2.6.11-orig/linux-2.6.11/drivers/w1/w1.h	2005-06-04 01:06:50.000000000 +0400
+++ ./drivers/w1/w1.h	2005-06-04 00:31:32.000000000 +0400
@@ -151,6 +151,9 @@
 	void		(*search)(unsigned long, w1_slave_found_callback);
 };
 
+#define W1_MASTER_NEED_EXIT		0
+#define W1_MASTER_NEED_RECONNECT	1
+
 struct w1_master
 {
 	struct list_head	w1_master_entry;
@@ -169,7 +172,8 @@
 	void			*priv;
 	int			priv_size;
 
-	int			need_exit;
+	long			flags;
+	
 	pid_t			kpid;
 	struct semaphore	mutex;
 
diff -ru ../linux-2.6.11-orig/linux-2.6.11/drivers/w1/w1_family.c drivers/w1/w1_family.c
--- ../linux-2.6.11-orig/linux-2.6.11/drivers/w1/w1_family.c	2005-06-03 23:03:29.000000000 +0400
+++ ./drivers/w1/w1_family.c	2005-06-04 00:15:27.000000000 +0400
@@ -60,9 +64,10 @@
 		newf->need_exit = 0;
 		list_add_tail(&newf->family_entry, &w1_families);
 	}
-
 	spin_unlock(&w1_flock);
 
+	w1_reconnect_slaves(newf);
+
 	return ret;
 }
 
diff -ru ../linux-2.6.11-orig/linux-2.6.11/drivers/w1/w1_int.c drivers/w1/w1_int.c
--- ../linux-2.6.11-orig/linux-2.6.11/drivers/w1/w1_int.c	2005-06-04 01:06:50.000000000 +0400
+++ ./drivers/w1/w1_int.c	2005-06-04 00:32:24.000000000 +0400
@@ -124,10 +124,9 @@
 
         /* validate minimum functionality */
         if (!(master->touch_bit && master->reset_bus) &&
-            !(master->write_bit && master->read_bit))
-        {
-           printk(KERN_ERR "w1_add_master_device: invalid function set\n");
-           return(-EINVAL);
+            !(master->write_bit && master->read_bit)) {
+		printk(KERN_ERR "w1_add_master_device: invalid function set\n");
+		return(-EINVAL);
         }
 
 	dev = w1_alloc_dev(w1_ids++, w1_max_slave_count, w1_max_slave_ttl, &w1_driver, &w1_device);
@@ -163,7 +162,7 @@
 	return 0;
 
 err_out_kill_thread:
-	dev->need_exit = 1;
+	set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
 	if (kill_proc(dev->kpid, SIGTERM, 1))
 		dev_err(&dev->dev,
 			 "Failed to send signal to w1 kernel thread %d.\n",
@@ -181,7 +180,7 @@
 	int err;
 	struct w1_netlink_msg msg;
 
-	dev->need_exit = 1;
+	set_bit(W1_MASTER_NEED_EXIT, &dev->flags);
 	err = kill_proc(dev->kpid, SIGTERM, 1);
 	if (err)
 		dev_err(&dev->dev,


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
