From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: [1/1] w1: netlink update - changed event generating/processing.
Message-Id: <20040726223253.68656ba1@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Added following self-explanatory netlink events.

	W1_SLAVE_ADD = 0,
	W1_SLAVE_REMOVE,
	W1_MASTER_ADD,
	W1_MASTER_REMOVE,

Patch is on top of the previous 2 big patches.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
-------------- next part --------------
--- ./drivers/w1/w1.c
+++ ./drivers/w1/w1.c
@@ -387,6 +387,7 @@
 	struct w1_slave *sl;
 	struct w1_family *f;
 	int err;
+	struct w1_netlink_msg msg;
 
 	sl = kmalloc (sizeof (struct w1_slave), GFP_KERNEL);
 	if (!sl) {
@@ -431,12 +432,18 @@
 	}
 
 	dev->slave_count++;
+		
+	msg.id.id = *rn;
+	msg.type = W1_SLAVE_ADD;
+	w1_netlink_send (dev, &msg);
 
 	return 0;
 }
 
 static void w1_slave_detach (struct w1_slave *sl)
 {
+	struct w1_netlink_msg msg;
+
 	dev_info (&sl->dev, "%s: detaching %s [%p].\n", __func__, sl->name, sl->family);
 
 	while (atomic_read (&sl->refcnt))
@@ -447,6 +454,10 @@
 	device_remove_file (&sl->dev, &sl->attr_val);
 	device_unregister (&sl->dev);
 	w1_family_put (sl->family);
+	
+	msg.id.id = sl->reg_num;
+	msg.type = W1_SLAVE_REMOVE;
+	w1_netlink_send (sl->master, &msg);
 }
 
 static void w1_search (struct w1_master *dev)
@@ -458,12 +469,9 @@
 	struct list_head *ent;
 	struct w1_slave *sl;
 	int family_found = 0;
-	struct w1_netlink_msg msg;
 
 	dev->attempts++;
 
-	memset (&msg, 0, sizeof (msg));
-
 	search_bit = id_bit = comp_bit = 0;
 	rn = tmp = last = 0;
 	last_device = last_zero = last_family_desc = 0;
@@ -489,8 +497,6 @@
 		}
 
 #if 1
-		memset (&msg, 0, sizeof (msg));
-
 		w1_write_8 (dev, W1_SEARCH);
 		for (i = 0; i < 64; ++i) {
 			/*
@@ -534,9 +540,6 @@
 
 		}
 #endif
-		msg.id.w1_id = rn;
-		msg.val = w1_calc_crc8 ((u8 *) & rn, 7);
-		w1_netlink_send (dev, &msg);
 
 		if (desc_bit = last_zero)
 			last_device = 1;
@@ -567,7 +570,7 @@
 		}
 
 		if (slave_count = dev->slave_count &&
-		    msg.val && (*((__u8 *) & msg.val) = msg.id.id.crc)) {
+		    ((rn >> 56) & 0xff) = w1_calc_crc8((u8 *)&rn, 7)) {
 			w1_attach_slave_device (dev, (struct w1_reg_num *) &rn);
 		}
 	}


--- ./drivers/w1/w1_int.c
+++ ./drivers/w1/w1_int.c
@@ -24,6 +24,7 @@
 
 #include "w1.h"
 #include "w1_log.h"
+#include "w1_netlink.h"
 
 static u32 w1_ids = 1;
 
@@ -118,6 +119,7 @@
 {
 	struct w1_master *dev;
 	int retval = 0;
+	struct w1_netlink_msg msg;
 
 	if (!(master->read_bit && master->write_bit)) {
 		printk(KERN_ERR "Master does not support functionality.\n");
@@ -164,6 +166,11 @@
 		w1_attach_slave_device (dev, &rn);
 	}
 #endif
+	msg.id.mst.id = dev->id;
+	msg.id.mst.pid = dev->kpid;
+	msg.type = W1_MASTER_ADD;
+	w1_netlink_send (dev, &msg);
+	
 	return 0;
 
 err_out_kill_thread:
@@ -184,6 +191,7 @@
 __w1_remove_master_device (struct w1_master *dev)
 {
 	int err;
+	struct w1_netlink_msg msg;
 
 	dev->need_exit = 1;
 	err = kill_proc (dev->kpid, SIGTERM, 1);
@@ -195,6 +203,12 @@
 	while (atomic_read (&dev->refcnt))
 		schedule_timeout (10);
 
+	
+	msg.id.mst.id = dev->id;
+	msg.id.mst.pid = dev->kpid;
+	msg.type = W1_MASTER_REMOVE;
+	w1_netlink_send (dev, &msg);
+	
 	w1_free_dev (dev);
 }
 


--- ./drivers/w1/w1_netlink.h
+++ ./drivers/w1/w1_netlink.h
@@ -26,14 +26,27 @@
 
 #include "w1.h"
 
+enum w1_netlink_message_types {
+	W1_SLAVE_ADD = 0,
+	W1_SLAVE_REMOVE,
+	W1_MASTER_ADD,
+	W1_MASTER_REMOVE,
+};
+
 struct w1_netlink_msg 
 {
+	__u8				type;
+	__u8				reserved[3];
 	union
 	{
 		struct w1_reg_num 	id;
 		__u64			w1_id;
+		struct
+		{
+			__u32		id;
+			__u32		pid;
+		} mst;
 	} id;
-	__u64				val;
 };
 
 #ifdef __KERNEL__

