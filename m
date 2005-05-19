From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: [PATCH] Connector and SuperIO inclusion.
Message-Id: <20040921095933.GA6274@uganda.factory.vocord.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, Greg, Andrew, developers..

Connector driver adds possibility to connect various agents using
netlink based network.
One must register callback and identificator. When driver receives
special netlink message with appropriate identificator, appropriate
callback will be called.
I think that the code better explains what I'm trying to say.

Kind of mega-picture can be found at 
http://tservice.net.ru/~s0mbre/?section=gallery&item=connector_design

cn_queue.[ch] - main queue processing routings.
connector.[ch] - interface to the external modules.

Attached:
ucon.c - userspace daemon. It is broken a bit, but the main idea is 
        very clear.
cn_test.c - module to test new connector. It is quite ugly since it was
	created only for testing. Real users should use
	cn_netlink_send().

P.S. Noone at netdev@oss.sgi.com does not object. Suggested feature was
implemented and tested.

http://marc.theaimsgroup.com/?l=linux-netdev&m9533183509006&w=2


Second patch adds SuperIO subsystem. It currently supports GPIO and
Access Bus logical devices in PC8736x and SCx200/SC1100 chips.
It depends on connector patch, since it provides unified architecture
independent userspace <-> kernelsapce messaging mechanism.

If it will be included I will write bits of documentation for driver
writers with examples of connector usage.

Please apply to -mm tree for testing.
Thank you.

P.P.S. All patches can easily pass through anyone's coding style yuck-o-meter at one dash.

-- 
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

--- linux-2.6/drivers/Kconfig.orig	2004-09-21 13:56:46.000000000 +0400
+++ linux-2.6/drivers/Kconfig	2004-09-21 13:55:18.000000000 +0400
@@ -44,6 +44,10 @@
 
 source "drivers/w1/Kconfig"
 
+source "drivers/connector/Kconfig"
+
+source "drivers/superio/Kconfig"
+
 source "drivers/misc/Kconfig"
 
 source "drivers/media/Kconfig"

--- linux-2.6/drivers/Makefile.orig	2004-09-12 01:14:07.000000000 +0400
+++ linux-2.6/drivers/Makefile	2004-09-11 22:49:32.000000000 +0400
@@ -43,6 +43,8 @@
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
+obj-$(CONFIG_CONNECTOR)		+= connector/
+obj-$(CONFIG_SC_SUPERIO)	+= superio/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/

diff -Nru /tmp/empty/Kconfig linux-2.6/drivers/connector/Kconfig
--- /tmp/empty/Kconfig	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/Kconfig	2004-09-09 08:43:37.000000000 +0400
@@ -0,0 +1,13 @@
+menu "Connector - unified userspace <-> kernelspace linker"
+
+config CONNECTOR
+	tristate "Connector - unified userspace <-> kernelspace linker"
+	depends on NET
+	---help---
+	  This is unified userspace <-> kernelspace connector working on top
+	  of the netlink socket protocol.
+
+	  Connector support can also be built as a module.  If so, the module
+	  will be called connector.ko.
+
+endmenu
diff -Nru /tmp/empty/Makefile linux-2.6/drivers/connector/Makefile
--- /tmp/empty/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/Makefile	2004-09-10 08:59:26.000000000 +0400
@@ -0,0 +1,2 @@
+obj-$(CONFIG_CONNECTOR)		+= cn.o
+cn-objs		:= cn_queue.o connector.o
diff -Nru /tmp/empty/cn_queue.c linux-2.6/drivers/connector/cn_queue.c
--- /tmp/empty/cn_queue.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/cn_queue.c	2004-09-21 13:38:57.000000000 +0400
@@ -0,0 +1,218 @@
+/*
+ * 	cn_queue.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/skbuff.h>
+#include <linux/suspend.h>
+
+#include "cn_queue.h"
+
+static void cn_queue_wrapper(void *data)
+{
+	struct cn_callback_entry *cbq = (struct cn_callback_entry *)data;
+
+	atomic_inc(&cbq->cb->refcnt);
+	cbq->cb->callback(cbq->cb->priv);
+	atomic_dec(&cbq->cb->refcnt);
+
+	cbq->destruct_data(cbq->ddata);
+}
+
+static struct cn_callback_entry *cn_queue_alloc_callback_entry(struct
+							       cn_callback *cb)
+{
+	struct cn_callback_entry *cbq;
+
+	cbq = kmalloc(sizeof(*cbq), GFP_KERNEL);
+	if (!cbq) {
+		printk(KERN_ERR "Failed to create new callback queue.\n");
+		return NULL;
+	}
+
+	memset(cbq, 0, sizeof(*cbq));
+
+	cbq->cb = cb;
+
+	INIT_WORK(&cbq->work, &cn_queue_wrapper, cbq);
+
+	return cbq;
+}
+
+static void cn_queue_free_callback(struct cn_callback_entry *cbq)
+{
+	cancel_delayed_work(&cbq->work);
+
+	while (atomic_read(&cbq->cb->refcnt)) {
+		printk(KERN_INFO "Waiting %s to became free: refcnt=%d.\n",
+		       cbq->pdev->name, atomic_read(&cbq->cb->refcnt));
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
+
+	kfree(cbq);
+}
+
+int cn_cb_equal(struct cb_id *i1, struct cb_id *i2)
+{
+	return ((i1->idx = i2->idx) && (i1->val = i2->val));
+}
+
+int cn_queue_add_callback(struct cn_queue_dev *dev, struct cn_callback *cb)
+{
+	struct cn_callback_entry *cbq, *n, *__cbq;
+	int found = 0;
+
+	cbq = cn_queue_alloc_callback_entry(cb);
+	if (!cbq)
+		return -ENOMEM;
+
+	atomic_inc(&dev->refcnt);
+	cbq->pdev = dev;
+
+	spin_lock(&dev->queue_lock);
+	list_for_each_entry_safe(__cbq, n, &dev->queue_list, callback_entry) {
+		if (cn_cb_equal(&__cbq->cb->id, &cb->id)) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found) {
+		atomic_set(&cbq->cb->refcnt, 1);
+		list_add_tail(&cbq->callback_entry, &dev->queue_list);
+	}
+	spin_unlock(&dev->queue_lock);
+
+	if (found) {
+		atomic_dec(&dev->refcnt);
+		atomic_set(&cbq->cb->refcnt, 0);
+		cn_queue_free_callback(cbq);
+		return -EINVAL;
+	}
+
+	cbq->nls = dev->nls;
+	cbq->seq = 0;
+	cbq->group = ++dev->netlink_groups;
+
+	return 0;
+}
+
+void cn_queue_del_callback(struct cn_queue_dev *dev, struct cn_callback *cb)
+{
+	struct cn_callback_entry *cbq = NULL, *n;
+	int found = 0;
+
+	spin_lock(&dev->queue_lock);
+	list_for_each_entry_safe(cbq, n, &dev->queue_list, callback_entry) {
+		if (cn_cb_equal(&cbq->cb->id, &cb->id)) {
+			list_del(&cbq->callback_entry);
+			found = 1;
+			break;
+		}
+	}
+	spin_unlock(&dev->queue_lock);
+
+	if (found) {
+		atomic_dec(&cbq->cb->refcnt);
+		cn_queue_free_callback(cbq);
+		atomic_dec(&dev->refcnt);
+	}
+}
+
+struct cn_queue_dev *cn_queue_alloc_dev(char *name, struct sock *nls)
+{
+	struct cn_queue_dev *dev;
+
+	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		printk(KERN_ERR "%s: Failed to allocte new struct cn_queue_dev.\n",
+		       name);
+		return NULL;
+	}
+
+	memset(dev, 0, sizeof(*dev));
+
+	snprintf(dev->name, sizeof(dev->name), "%s", name);
+
+	atomic_set(&dev->refcnt, 0);
+	INIT_LIST_HEAD(&dev->queue_list);
+	spin_lock_init(&dev->queue_lock);
+
+	dev->nls = nls;
+	dev->netlink_groups = 0;
+
+	dev->cn_queue = create_workqueue(dev->name);
+	if (!dev->cn_queue) {
+		printk(KERN_ERR "Failed to create %s queue.\n", dev->name);
+		kfree(dev);
+		return NULL;
+	}
+
+	return dev;
+}
+
+void cn_queue_free_dev(struct cn_queue_dev *dev)
+{
+	struct cn_callback_entry *cbq, *n;
+
+	flush_workqueue(dev->cn_queue);
+	destroy_workqueue(dev->cn_queue);
+
+	spin_lock(&dev->queue_lock);
+	list_for_each_entry_safe(cbq, n, &dev->queue_list, callback_entry) {
+		list_del(&cbq->callback_entry);
+		atomic_dec(&cbq->cb->refcnt);
+	}
+	spin_unlock(&dev->queue_lock);
+
+	while (atomic_read(&dev->refcnt)) {
+		printk(KERN_INFO "Waiting %s to became free: refcnt=%d.\n",
+		       dev->name, atomic_read(&dev->refcnt));
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
+
+	memset(dev, 0, sizeof(*dev));
+	kfree(dev);
+	dev = NULL;
+}
+
+EXPORT_SYMBOL(cn_queue_add_callback);
+EXPORT_SYMBOL(cn_queue_del_callback);
+EXPORT_SYMBOL(cn_queue_alloc_dev);
+EXPORT_SYMBOL(cn_queue_free_dev);
diff -Nru /tmp/empty/cn_queue.h linux-2.6/drivers/connector/cn_queue.h
--- /tmp/empty/cn_queue.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/cn_queue.h	2004-09-21 13:38:57.000000000 +0400
@@ -0,0 +1,90 @@
+/*
+ * 	cn_queue.h
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __CN_QUEUE_H
+#define __CN_QUEUE_H
+
+#include <asm/types.h>
+
+struct cb_id
+{
+	__u32			idx;
+	__u32			val;
+};
+
+#ifdef __KERNEL__
+
+#include <asm/atomic.h>
+
+#include <linux/list.h>
+#include <linux/workqueue.h>
+
+#define CN_CBQ_NAMELEN		32
+
+struct cn_queue_dev
+{
+	atomic_t		refcnt;
+	unsigned char		name[CN_CBQ_NAMELEN];
+
+	struct workqueue_struct	*cn_queue;
+	
+	struct list_head 	queue_list;
+	spinlock_t 		queue_lock;
+
+	int			netlink_groups;
+	struct sock		*nls;
+};
+
+struct cn_callback
+{
+	unsigned char		name[CN_CBQ_NAMELEN];
+	
+	struct cb_id		id;
+	void			(* callback)(void *);
+	void			*priv;
+	
+	atomic_t		refcnt;
+};
+
+struct cn_callback_entry
+{
+	struct list_head	callback_entry;
+	struct cn_callback	*cb;
+	struct work_struct	work;
+	struct cn_queue_dev	*pdev;
+	
+	void			(* destruct_data)(void *);
+	void			*ddata;
+
+	int			seq, group;
+	struct sock		*nls;
+};
+
+int cn_queue_add_callback(struct cn_queue_dev *dev, struct cn_callback *cb);
+void cn_queue_del_callback(struct cn_queue_dev *dev, struct cn_callback *cb);
+
+struct cn_queue_dev *cn_queue_alloc_dev(char *name, struct sock *);
+void cn_queue_free_dev(struct cn_queue_dev *dev);
+
+int cn_cb_equal(struct cb_id *, struct cb_id *);
+
+#endif /* __KERNEL__ */
+#endif /* __CN_QUEUE_H */
diff -Nru /tmp/empty/cn_test.c linux-2.6/drivers/connector/cn_test.c
--- /tmp/empty/cn_test.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/cn_test.c	2004-09-21 13:38:57.000000000 +0400
@@ -0,0 +1,160 @@
+/*
+ * 	cn_test.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/skbuff.h>
+
+#include "connector.h"
+
+static struct cb_id cn_test_id = { 0x123, 0x456 };
+static char cn_test_name[] = "cn_test";
+static struct sock *nls;
+
+void cn_test_callback(void *data)
+{
+	struct cn_msg *msg = (struct cn_msg *)data;
+
+	printk("%s: idx=%x, val=%x, len=%d.\n",
+	       __func__, msg->id.idx, msg->id.val, msg->len);
+}
+
+static int cn_test_want_notify(void)
+{
+	struct cn_ctl_msg *ctl;
+	struct cn_notify_req *req;
+	struct cn_msg *msg = NULL;
+	int size, size0;
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+	u32 group = 1;
+
+	size0 = sizeof(*msg) + sizeof(*ctl) + 3*sizeof(*req);
+	
+	size = NLMSG_SPACE(size0);
+
+	skb = alloc_skb(size, GFP_ATOMIC);
+	if (!skb) {
+		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);
+
+		return -ENOMEM;
+	}
+
+	nlh = NLMSG_PUT(skb, 0, 0x123, NLMSG_DONE, size - sizeof(*nlh));
+
+	msg = (struct cn_msg *)NLMSG_DATA(nlh);
+
+	memset(msg, 0, size0);
+
+	msg->id.idx 	= -1;
+	msg->id.val 	= -1;
+	msg->seq 	= 0x123;
+	msg->ack 	= 0x345;
+	msg->len 	= size0 - sizeof(*msg);
+
+	ctl = (struct cn_ctl_msg *)(msg + 1);
+
+	ctl->idx_notify_num 	= 1;
+	ctl->val_notify_num 	= 2;
+	ctl->group		= group;
+	ctl->len		= msg->len - sizeof(*ctl);
+
+	req = (struct cn_notify_req *)(ctl + 1);
+
+	/*
+	 * Idx.
+	 */
+	req->first = cn_test_id.idx;
+	req->range = 10;
+
+	/*
+	 * Val 0.
+	 */
+	req++;
+	req->first = cn_test_id.val;
+	req->range = 10;
+	
+	/*
+	 * Val 1.
+	 */
+	req++;
+	req->first = cn_test_id.val + 20;
+	req->range = 10;
+	
+	NETLINK_CB(skb).dst_groups = ctl->group;
+	//netlink_broadcast(nls, skb, 0, ctl->group, GFP_ATOMIC);
+	netlink_unicast(nls, skb, 0, 0);
+
+	printk(KERN_INFO "Request was sent. Group=0x%x.\n", group);
+		
+	return 0;
+
+nlmsg_failure:
+	printk(KERN_ERR "Failed to send %u.%u\n", msg->seq, msg->ack);
+	kfree_skb(skb);
+	return -EINVAL;
+}
+
+static int cn_test_init(void)
+{
+	int err;
+	
+	nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
+	if (!nls) {
+		printk(KERN_ERR "Failed to create new netlink socket(%u).\n", NETLINK_NFLOG);
+		return -EIO;
+	}
+
+	err = cn_test_want_notify();
+	if (err)
+		goto err_out;
+
+	err = cn_add_callback(&cn_test_id, cn_test_name, cn_test_callback);
+	if (err)
+		goto err_out;
+	cn_test_id.val++;
+	err = cn_add_callback(&cn_test_id, cn_test_name, cn_test_callback);
+	if (err) {
+		cn_del_callback(&cn_test_id);
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	if (nls->sk_socket)
+		sock_release(nls->sk_socket);
+
+	return err;
+}
+
+static void cn_test_fini(void)
+{
+	cn_del_callback(&cn_test_id);
+	cn_test_id.val--;
+	cn_del_callback(&cn_test_id);
+	if (nls->sk_socket)
+		sock_release(nls->sk_socket);
+}
+
+module_init(cn_test_init);
+module_exit(cn_test_fini);
diff -Nru /tmp/empty/connector.c linux-2.6/drivers/connector/connector.c
--- /tmp/empty/connector.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/connector.c	2004-09-21 13:38:57.000000000 +0400
@@ -0,0 +1,496 @@
+/*
+ * 	connector.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/moduleparam.h>
+
+#include <net/sock.h>
+
+#include "../connector/connector.h"
+#include "../connector/cn_queue.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Generic userspace <-> kernelspace connector.");
+
+static int unit = NETLINK_NFLOG;
+static u32 cn_idx = -1;
+static u32 cn_val = -1;
+
+module_param(unit, int, 0);
+module_param(cn_idx, uint, 0);
+module_param(cn_val, uint, 0);
+
+spinlock_t notify_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(notify_list);
+
+static struct cn_dev cdev;
+
+/*
+ * msg->seq and msg->ack are used to determine message genealogy.
+ * When someone sends message it puts there locally unique sequence 
+ * and random acknowledge numbers.
+ * Sequence number may be copied into nlmsghdr->nlmsg_seq too.
+ *
+ * Sequence number is incremented with each message to be sent.
+ *
+ * If we expect reply to our message, 
+ * then sequence number in received message MUST be the same as in original message,
+ * and acknowledge number MUST be the same + 1.
+ *
+ * If we receive message and it's sequence number is not equal to one we are expecting, 
+ * then it is new message.
+ * If we receive message and it's sequence number is the same as one we are expecting,
+ * but it's acknowledge is not equal acknowledge number in original message + 1,
+ * then it is new message.
+ *
+ */
+void cn_netlink_send(struct cn_msg *msg, u32 __groups)
+{
+	struct cn_callback_entry *n, *__cbq;
+	unsigned int size;
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+	struct cn_msg *data;
+	struct cn_dev *dev = &cdev;
+	u32 groups = 0;
+	int found = 0;
+
+	if (!__groups)
+	{
+		spin_lock(&dev->cbdev->queue_lock);
+		list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_entry) {
+			if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
+				found = 1;
+				groups = __cbq->group;
+			}
+		}
+		spin_unlock(&dev->cbdev->queue_lock);
+
+		if (!found) {
+			printk(KERN_ERR "Failed to find multicast netlink group for callback[0x%x.0x%x]. seq=%u\n",
+			       msg->id.idx, msg->id.val, msg->seq);
+			return;
+		}
+	}
+	else
+		groups = __groups;
+
+	size = NLMSG_SPACE(sizeof(*msg) + msg->len);
+
+	skb = alloc_skb(size, GFP_ATOMIC);
+	if (!skb) {
+		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);
+		return;
+	}
+
+	nlh = NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size - sizeof(*nlh));
+
+	data = (struct cn_msg *)NLMSG_DATA(nlh);
+
+	memcpy(data, msg, sizeof(*data) + msg->len);
+#if 0
+	printk("%s: len=%u, seq=%u, ack=%u, group=%u.\n",
+	       __func__, msg->len, msg->seq, msg->ack, groups);
+#endif
+	NETLINK_CB(skb).dst_groups = groups;
+	netlink_broadcast(dev->nls, skb, 0, groups, GFP_ATOMIC);
+
+	return;
+
+      nlmsg_failure:
+	printk(KERN_ERR "Failed to send %u.%u\n", msg->seq, msg->ack);
+	kfree_skb(skb);
+	return;
+}
+
+static int cn_call_callback(struct cn_msg *msg, void (*destruct_data) (void *), void *data)
+{
+	struct cn_callback_entry *n, *__cbq;
+	struct cn_dev *dev = &cdev;
+	int found = 0;
+
+	spin_lock(&dev->cbdev->queue_lock);
+	list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_entry) {
+		if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
+			__cbq->cb->priv = msg;
+
+			__cbq->ddata = data;
+			__cbq->destruct_data = destruct_data;
+
+			queue_work(dev->cbdev->cn_queue, &__cbq->work);
+			found = 1;
+			break;
+		}
+	}
+	spin_unlock(&dev->cbdev->queue_lock);
+
+	return found;
+}
+
+static int __cn_rx_skb(struct sk_buff *skb, struct nlmsghdr *nlh)
+{
+	u32 pid, uid, seq, group;
+	struct cn_msg *msg;
+
+	pid = NETLINK_CREDS(skb)->pid;
+	uid = NETLINK_CREDS(skb)->uid;
+	seq = nlh->nlmsg_seq;
+	group = NETLINK_CB((skb)).groups;
+	msg = (struct cn_msg *)NLMSG_DATA(nlh);
+
+	if (msg->len != nlh->nlmsg_len - sizeof(*msg) - sizeof(*nlh)) {
+		printk(KERN_ERR "skb does not have enough length: "
+				"requested msg->len=%u[%u], nlh->nlmsg_len=%u[%u], skb->len=%u[must be %u].\n", 
+				msg->len, NLMSG_SPACE(msg->len), 
+				nlh->nlmsg_len, nlh->nlmsg_len - sizeof(*nlh),
+				skb->len, msg->len + sizeof(*msg));
+		return -EINVAL;
+	}
+#if 0
+	printk(KERN_INFO "pid=%u, uid=%u, seq=%u, group=%u.\n",
+	       pid, uid, seq, group);
+#endif
+	return cn_call_callback(msg, (void (*)(void *))kfree_skb, skb);
+}
+
+static void cn_rx_skb(struct sk_buff *__skb)
+{
+	struct nlmsghdr *nlh;
+	u32 len;
+	int err;
+	struct sk_buff *skb;
+
+	skb = skb_get(__skb);
+	if (!skb) {
+		printk(KERN_ERR "Failed to reference an skb.\n");
+		return;
+	}
+#if 0
+	printk(KERN_INFO
+	       "skb: len=%u, data_len=%u, truesize=%u, proto=%u, cloned=%d, shared=%d.\n",
+	       skb->len, skb->data_len, skb->truesize, skb->protocol,
+	       skb_cloned(skb), skb_shared(skb));
+#endif
+	while (skb->len >= NLMSG_SPACE(0)) {
+		nlh = (struct nlmsghdr *)skb->data;
+		if (nlh->nlmsg_len < sizeof(struct cn_msg) ||
+		    skb->len < nlh->nlmsg_len ||
+		    nlh->nlmsg_len > CONNECTOR_MAX_MSG_SIZE) {
+			printk(KERN_INFO "nlmsg_len=%u, sizeof(*nlh)=%u\n",
+			       nlh->nlmsg_len, sizeof(*nlh));
+			break;
+		}
+
+		len = NLMSG_ALIGN(nlh->nlmsg_len);
+		if (len > skb->len)
+			len = skb->len;
+
+		err = __cn_rx_skb(skb, nlh);
+		if (err) {
+			if (err < 0 && (nlh->nlmsg_flags & NLM_F_ACK))
+				netlink_ack(skb, nlh, -err);
+			kfree_skb(skb);
+			break;
+		} else {
+			if (nlh->nlmsg_flags & NLM_F_ACK)
+				netlink_ack(skb, nlh, 0);
+			kfree_skb(skb);
+			break;
+		}
+		skb_pull(skb, len);
+	}
+}
+
+static void cn_input(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL)
+		cn_rx_skb(skb);
+}
+
+static void cn_notify(struct cb_id *id, u32 notify_event)
+{
+	struct cn_ctl_entry *ent;
+
+	spin_lock(&notify_lock);
+	list_for_each_entry(ent, &notify_list, notify_entry) {
+		int i;
+		struct cn_notify_req *req;
+		struct cn_ctl_msg *ctl = ent->msg;
+		int a, b;
+
+		a = b = 0;
+		
+		req = (struct cn_notify_req *)ctl->data;
+		for (i=0; i<ctl->idx_notify_num; ++i, ++req) {
+			if (id->idx >= req->first && id->idx < req->first + req->range) {
+				a = 1;
+				break;
+			}
+		}
+		
+		for (i=0; i<ctl->val_notify_num; ++i, ++req) {
+			if (id->val >= req->first && id->val < req->first + req->range) {
+				b = 1;
+				break;
+			}
+		}
+
+		if (a && b) {
+			struct cn_msg m;
+			
+			printk(KERN_INFO "Notifying group %x with event %u about %x.%x.\n", 
+					ctl->group, notify_event, 
+					id->idx, id->val);
+
+			memset(&m, 0, sizeof(m));
+			m.ack = notify_event;
+
+			memcpy(&m.id, id, sizeof(m.id));
+			cn_netlink_send(&m, ctl->group);
+		}
+	}
+	spin_unlock(&notify_lock);
+}
+
+int cn_add_callback(struct cb_id *id, char *name, void (*callback) (void *))
+{
+	int err;
+	struct cn_dev *dev = &cdev;
+	struct cn_callback *cb;
+
+	cb = kmalloc(sizeof(*cb), GFP_KERNEL);
+	if (!cb) {
+		printk(KERN_INFO "%s: Failed to allocate new struct cn_callback.\n",
+		       dev->cbdev->name);
+		return -ENOMEM;
+	}
+
+	memset(cb, 0, sizeof(*cb));
+
+	snprintf(cb->name, sizeof(cb->name), "%s", name);
+
+	memcpy(&cb->id, id, sizeof(cb->id));
+	cb->callback = callback;
+
+	atomic_set(&cb->refcnt, 0);
+
+	err = cn_queue_add_callback(dev->cbdev, cb);
+	if (err) {
+		kfree(cb);
+		return err;
+	}
+			
+	cn_notify(id, 0);
+
+	return 0;
+}
+
+void cn_del_callback(struct cb_id *id)
+{
+	struct cn_dev *dev = &cdev;
+	struct cn_callback_entry *n, *__cbq;
+
+	list_for_each_entry_safe(__cbq, n, &dev->cbdev->queue_list, callback_entry) {
+		if (cn_cb_equal(&__cbq->cb->id, id)) {
+			cn_queue_del_callback(dev->cbdev, __cbq->cb);
+			cn_notify(id, 1);
+			break;
+		}
+	}
+}
+
+static int cn_ctl_msg_equals(struct cn_ctl_msg *m1, struct cn_ctl_msg *m2)
+{
+	int i;
+	struct cn_notify_req *req1, *req2;
+
+	if (m1->idx_notify_num != m2->idx_notify_num)
+		return 0;
+	
+	if (m1->val_notify_num != m2->val_notify_num)
+		return 0;
+	
+	if (m1->len != m2->len)
+		return 0;
+
+	if ((m1->idx_notify_num + m1->val_notify_num)*sizeof(*req1) != m1->len) {
+		printk(KERN_ERR "Notify entry[idx_num=%x, val_num=%x, len=%u] contains garbage. Removing.\n", 
+				m1->idx_notify_num, m1->val_notify_num, m1->len);
+		return 1;
+	}
+
+	req1 = (struct cn_notify_req *)m1->data;
+	req2 = (struct cn_notify_req *)m2->data;
+	
+	for (i=0; i<m1->idx_notify_num; ++i) {
+		if (memcmp(req1, req2, sizeof(*req1)))
+			return 0;
+
+		req1++;
+		req2++;
+	}
+
+	for (i=0; i<m1->val_notify_num; ++i) {
+		if (memcmp(req1, req2, sizeof(*req1)))
+			return 0;
+
+		req1++;
+		req2++;
+	}
+
+	return 1;
+}
+
+static void cn_callback(void * data)
+{
+	struct cn_msg *msg = (struct cn_msg *)data;
+	struct cn_ctl_msg *ctl;
+	struct cn_ctl_entry *ent;
+	u32 size;
+ 
+	if (msg->len < sizeof(*ctl)) {
+		printk(KERN_ERR "Wrong connector request size %u, must be >= %u.\n", 
+				msg->len, sizeof(*ctl));
+		return;
+	}
+	
+	ctl = (struct cn_ctl_msg *)msg->data;
+
+	size = sizeof(*ctl) + (ctl->idx_notify_num + ctl->val_notify_num)*sizeof(struct cn_notify_req);
+
+	if (msg->len != size) {
+		printk(KERN_ERR "Wrong connector request size %u, must be = %u.\n", 
+				msg->len, size);
+		return;
+	}
+
+	if (ctl->len + sizeof(*ctl) != msg->len) {
+		printk(KERN_ERR "Wrong message: msg->len=%u must be equal to inner_len=%u [+%u].\n", 
+				msg->len, ctl->len, sizeof(*ctl));
+		return;
+	}
+
+	/*
+	 * Remove notification.
+	 */
+	if (ctl->group = 0) {
+		struct cn_ctl_entry *n;
+		
+		spin_lock(&notify_lock);
+		list_for_each_entry_safe(ent, n, &notify_list, notify_entry) {
+			if (cn_ctl_msg_equals(ent->msg, ctl)) {
+				list_del(&ent->notify_entry);
+				kfree(ent);
+			}
+		}
+		spin_unlock(&notify_lock);
+
+		return;
+	}
+
+	size += sizeof(*ent);
+
+	ent = kmalloc(size, GFP_ATOMIC);
+	if (!ent) {
+		printk(KERN_ERR "Failed to allocate %d bytes for new notify entry.\n", size);
+		return;
+	}
+
+	memset(ent, 0, size);
+
+	ent->msg = (struct cn_ctl_msg *)(ent + 1);
+
+	memcpy(ent->msg, ctl, size - sizeof(*ent));
+
+	spin_lock(&notify_lock);
+	list_add(&ent->notify_entry, &notify_list);
+	spin_unlock(&notify_lock);
+
+	{
+		int i;
+		struct cn_notify_req *req;
+	
+		printk("Notify group %x for idx: ", ctl->group);
+
+		req = (struct cn_notify_req *)ctl->data;
+		for (i=0; i<ctl->idx_notify_num; ++i, ++req)
+		{
+			printk("%u-%u ", req->first, req->first+req->range-1);
+		}
+		
+		printk("\nNotify group %x for val: ", ctl->group);
+
+		for (i=0; i<ctl->val_notify_num; ++i, ++req)
+		{
+			printk("%u-%u ", req->first, req->first+req->range-1);
+		}
+		printk("\n");
+	}
+}
+
+static int cn_init(void)
+{
+	struct cn_dev *dev = &cdev;
+
+	dev->input = cn_input;
+	dev->id.idx = cn_idx;
+	dev->id.val = cn_val;
+
+	dev->nls = netlink_kernel_create(unit, dev->input);
+	if (!dev->nls) {
+		printk(KERN_ERR "Failed to create new netlink socket(%u).\n",
+		       unit);
+		return -EIO;
+	}
+
+	dev->cbdev = cn_queue_alloc_dev("cqueue", dev->nls);
+	if (!dev->cbdev) {
+		if (dev->nls->sk_socket)
+			sock_release(dev->nls->sk_socket);
+		return -EINVAL;
+	}
+
+	return cn_add_callback(&dev->id, "connector", &cn_callback);
+}
+
+static void cn_fini(void)
+{
+	struct cn_dev *dev = &cdev;
+
+	cn_del_callback(&dev->id);
+	cn_queue_free_dev(dev->cbdev);
+	if (dev->nls->sk_socket)
+		sock_release(dev->nls->sk_socket);
+}
+
+module_init(cn_init);
+module_exit(cn_fini);
+
+EXPORT_SYMBOL(cn_add_callback);
+EXPORT_SYMBOL(cn_del_callback);
+EXPORT_SYMBOL(cn_netlink_send);
diff -Nru /tmp/empty/connector.h linux-2.6/drivers/connector/connector.h
--- /tmp/empty/connector.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/connector/connector.h	2004-09-21 13:38:57.000000000 +0400
@@ -0,0 +1,81 @@
+/*
+ * 	connector.h
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __CONNECTOR_H
+#define __CONNECTOR_H
+
+#include "../connector/cn_queue.h"
+
+#define CONNECTOR_MAX_MSG_SIZE 	1024
+
+struct cn_msg
+{
+	struct cb_id 		id;
+
+	__u32			seq;
+	__u32			ack;
+
+	__u32			len;		/* Length of the following data */
+	__u8			data[0];
+};
+
+struct cn_notify_req
+{
+	__u32			first;
+	__u32			range;
+};
+
+struct cn_ctl_msg
+{
+	__u32			idx_notify_num;
+	__u32			val_notify_num;
+	__u32			group;
+	__u32			len;
+	__u8			data[0];
+};
+
+#ifdef __KERNEL__
+
+#include <net/sock.h>
+
+struct cn_ctl_entry
+{
+	struct list_head	notify_entry;
+	struct cn_ctl_msg	*msg;
+};
+
+struct cn_dev
+{
+	struct cb_id 		id;
+
+	u32			seq, groups;
+	struct sock 		*nls;
+	void 			(*input)(struct sock *sk, int len);
+
+	struct cn_queue_dev	*cbdev;
+};
+
+int cn_add_callback(struct cb_id *, char *, void (* callback)(void *));
+void cn_del_callback(struct cb_id *);
+void cn_netlink_send(struct cn_msg *, u32);
+
+#endif /* __KERNEL__ */
+#endif /* __CONNECTOR_H */


diff -Nru /tmp/empty/Kconfig linux-2.6/drivers/superio/Kconfig
--- /tmp/empty/Kconfig	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/Kconfig	2004-09-10 08:52:40.000000000 +0400
@@ -0,0 +1,56 @@
+menu "SuperIO subsystem support"
+
+config SC_SUPERIO
+	tristate "SuperIO subsystem support"
+	depends on CONNECTOR
+	help
+	  SuperIO subsystem support.
+	
+	  This support is also available as a module.  If so, the module
+          will be called superio.ko.
+
+config SC_PC8736X
+	tristate "PC8736x SuperIO"
+	depends on SC_SUPERIO
+	help
+	  Say Y here if you want to use PC8736x controller.
+	  It is LPC SuperIO with hardware monitoring chip from National Semiconductor.
+	
+	  This support is also available as a module.  If so, the module
+          will be called pc8736x.ko.
+
+config SC_SCX200
+	tristate "SCx200/SC1100 SuperIO"
+	depends on SC_SUPERIO
+	help
+	  Say Y here if you want to use SCx200/SC1100 controller.
+	  It is Geode system-on-chip processor from AMD(formerly National Semiconductor).
+	
+	  This support is also available as a module.  If so, the module
+          will be called scx200.ko.
+
+
+config SC_GPIO
+	tristate "SuperIO - GPIO"
+	depends on SC_SUPERIO
+	help
+	  Say Y here if you want to use General-Purpose Input/Output (GPIO) pins.
+	
+	  This support is also available as a module.  If so, the module
+          will be called sc_gpio.ko.
+
+config SC_ACB
+	tristate "SuperIO - Access Bus"
+	depends on SC_SUPERIO
+	help
+	  Say Y here if you want to use Access Bus.
+	  The ACB is a two-wire synchronous serial interface compatible with the ACCESS.bus physical layer. 
+	  The ACB is also compatible with Intel's SMBus and Philips' I2C. 
+	  The ACB allows easy interfacing to a wide range of low-cost memories and I/O devices, 
+	  including EEPROMs, SRAMs, timers, ADC, DAC, clock chips and peripheral drivers.
+	
+	  This support is also available as a module.  If so, the module
+          will be called sc_acb.ko.
+
+
+endmenu
diff -Nru /tmp/empty/Makefile linux-2.6/drivers/superio/Makefile
--- /tmp/empty/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/Makefile	2004-09-09 11:57:00.000000000 +0400
@@ -0,0 +1,11 @@
+#
+# Makefile for the SuperIO subsystem.
+#
+
+obj-$(CONFIG_SC_SUPERIO)	+= superio.o
+obj-$(CONFIG_SC_GPIO)		+= sc_gpio.o
+obj-$(CONFIG_SC_ACB)		+= sc_acb.o
+obj-$(CONFIG_SC_PC8736X)	+= pc8736x.o
+obj-$(CONFIG_SC_SCX200)		+= scx200.o
+
+superio-objs		:= sc.o chain.o sc_conn.o
diff -Nru /tmp/empty/chain.c linux-2.6/drivers/superio/chain.c
--- /tmp/empty/chain.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/chain.c	2004-09-12 00:42:01.000000000 +0400
@@ -0,0 +1,52 @@
+/*
+ * 	chain.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <asm/atomic.h>
+#include <asm/types.h>
+
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include "chain.h"
+
+struct dev_chain *chain_alloc(void *ptr)
+{
+	struct dev_chain *ch;
+
+	ch = kmalloc(sizeof(struct dev_chain), GFP_ATOMIC);
+	if (!ch) {
+		printk(KERN_ERR "Failed to allocate new chain for %p.\n", ptr);
+		return NULL;
+	}
+
+	memset(ch, 0, sizeof(struct dev_chain));
+
+	ch->ptr = ptr;
+
+	return ch;
+}
+
+void chain_free(struct dev_chain *ch)
+{
+	memset(ch, 0, sizeof(struct dev_chain));
+	kfree(ch);
+}
diff -Nru /tmp/empty/chain.h linux-2.6/drivers/superio/chain.h
--- /tmp/empty/chain.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/chain.h	2004-09-12 00:42:01.000000000 +0400
@@ -0,0 +1,37 @@
+/*
+ * 	chain.h
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __CHAIN_H
+#define __CHAIN_H
+
+#include <linux/list.h>
+
+struct dev_chain
+{
+	struct list_head	chain_entry;
+	void			*ptr;
+};
+
+struct dev_chain *chain_alloc(void *ptr);
+void chain_free(struct dev_chain *ch);
+
+#endif /* __CHAIN_H */
diff -Nru /tmp/empty/pc8736x.c linux-2.6/drivers/superio/pc8736x.c
--- /tmp/empty/pc8736x.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/pc8736x.c	2004-09-19 23:28:06.000000000 +0400
@@ -0,0 +1,280 @@
+/*
+ * 	pc8736x.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <asm/atomic.h>
+#include <asm/types.h>
+#include <asm/io.h>
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/suspend.h>
+
+#include "sc.h"
+#include "pc8736x.h"
+#include "sc_gpio.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for PC87366 SuperIO chip.");
+
+static int pc8736x_probe(void *, unsigned long base);
+static int pc8736x_activate_one_logical(struct logical_dev *ldev);
+static int pc8736x_deactivate_one_logical(struct logical_dev *ldev);
+
+static struct sc_dev pc8736x_dev = {
+	.name 			"PC8736X",
+	.probe 			pc8736x_probe,
+	.activate_one 		pc8736x_activate_one_logical,
+	.deactivate_one 	pc8736x_deactivate_one_logical,
+	//.read         pc8736x_read,
+	//.write        pc8736x_write,
+};
+
+static struct sc_chip_id pc8736x_sio_ids[] = {
+	{"PC87360", 0xe1},
+	{"PC87363", 0xe8},
+	{"PC87364", 0xe4},
+	{"PC87365", 0xe5},
+	{"PC87366", 0xe9},
+};
+
+void pc8736x_write_reg(struct sc_dev *dev, u8 reg, u8 val)
+{
+	outb(reg, dev->base_index);
+	outb(val, dev->base_data);
+}
+
+u8 pc8736x_read_reg(struct sc_dev *dev, u8 reg)
+{
+	u8 val;
+
+	outb(reg, dev->base_index);
+	val = inb(dev->base_data);
+
+	return val;
+}
+
+static int pc8736x_chip_index(u8 id)
+{
+	int i;
+
+	for (i = 0; i < sizeof(pc8736x_sio_ids) / sizeof(pc8736x_sio_ids[0]); ++i)
+		if (pc8736x_sio_ids[i].id = id)
+			return i;
+
+	return -ENODEV;
+}
+
+static int pc8736x_probe(void *data, unsigned long base)
+{
+	unsigned long size = 2;
+	u8 id;
+	int chip_num;
+	struct sc_dev *dev = (struct sc_dev *)data;
+
+	/*
+	 * Special address to handle.
+	 */
+	if (base = 0)
+		return -ENODEV;
+
+	dev->base_index = base;
+	dev->base_data = base + 1;
+
+	id = pc8736x_read_reg(dev, SIO_REG_SID);
+	chip_num = pc8736x_chip_index(id);
+
+	if (chip_num >= 0) {
+		printk(KERN_INFO "Found %s [0x%x] at 0x%04lx-0x%04lx.\n",
+		       pc8736x_sio_ids[chip_num].name,
+		       pc8736x_sio_ids[chip_num].id, 
+		       base, base + size - 1);
+		return 0;
+	}
+
+	printk(KERN_INFO "Found nothing at 0x%04lx-0x%04lx.\n", 
+			base, base + size - 1);
+
+	return -ENODEV;
+}
+		
+static irqreturn_t pc8736x_interrupt(int irq, void *data, struct pt_regs * regs)
+{
+	int i;
+	struct logical_dev *ldev = (struct logical_dev *)data;
+
+	if (strcmp(ldev->name, "GPIO"))
+	{
+		printk(KERN_ERR "IRQ %d registered or logical device %s [irq=%d].\n", 
+				irq, ldev->name, ldev->irq);
+		return IRQ_HANDLED;
+	}
+
+	printk(KERN_INFO "%s: irq=%d.\n", __func__, irq);
+
+	for (i=0; i<SIO_GPIO_NPINS; ++i)
+		ldev->read(ldev, i);
+		
+	return IRQ_HANDLED;
+}
+
+static int pc8736x_deactivate_one_logical(struct logical_dev *ldev)
+{
+	if (ldev->irq)
+	{
+		free_irq(ldev->irq, ldev);
+		ldev->irq = 0;
+	}
+
+	return 0;
+}
+
+static int pc8736x_activate_one_logical(struct logical_dev *ldev)
+{
+	int err;
+	struct sc_dev *dev = ldev->pdev;
+	u8 active;
+
+	pc8736x_write_reg(dev, SIO_REG_LDN, ldev->index);
+	active = pc8736x_read_reg(dev, SIO_REG_ACTIVE);
+	if ((active & SIO_ACTIVE_EN) = 0) {
+		printk(KERN_INFO "\t%16s - not activated at %x: activating... ",
+		       ldev->name, ldev->index);
+
+		pc8736x_write_reg(dev, SIO_REG_ACTIVE, active | SIO_ACTIVE_EN);
+		active = pc8736x_read_reg(dev, SIO_REG_ACTIVE);
+		if ((active & SIO_ACTIVE_EN) = 0) {
+			printk("failed.\n");
+			return -ENODEV;
+		}
+		printk("done\n");
+		/*printk("done. Resetting... ");
+
+		   pc8736x_write_reg(dev, SIO_REG_ACTIVE, active | SIO_RESET);
+		   active = pc8736x_read_reg(dev, SIO_REG_ACTIVE);
+		   printk("done [sio_cfg1=%x].\n", active);
+		 */
+	}
+
+	if (!strcmp(ldev->name, "GPIO"))
+	{
+		pc8736x_write_reg(dev, SIO_REG_IRQ, 3);
+		ldev->irq = pc8736x_read_reg(dev, SIO_REG_IRQ);
+		if (ldev->irq = 0)
+		{
+			pc8736x_write_reg(dev, SIO_REG_IRQ, 3);
+			ldev->irq = pc8736x_read_reg(dev, SIO_REG_IRQ);
+		}
+	}
+	else
+		ldev->irq = 0;
+
+	ldev->irq_type = pc8736x_read_reg(dev, SIO_REG_IRQ_TYPE);
+	ldev->base_addr = pc8736x_read_reg(dev, SIO_REG_IO_LSB);
+	ldev->base_addr |= (pc8736x_read_reg(dev, SIO_REG_IO_MSB) << 8);
+
+	err = ldev->activate(ldev);
+	if (err < 0) {
+		printk(KERN_INFO "\t%16s - not activated: ->activate() failed with error code %d.\n",
+		       ldev->name, err);
+		return -ENODEV;
+	}
+	
+	if (ldev->irq)
+	{
+#if 0
+		int err;
+		
+		err = ldev->irq_type = 0;
+		pc8736x_write_reg(dev, SIO_REG_IRQ_TYPE, ldev->irq_type);
+		ldev->irq_type = pc8736x_read_reg(dev, SIO_REG_IRQ_TYPE);
+
+		if (ldev->irq_type != err)
+		{
+			printk(KERN_INFO "Logical device %s doest not support irq type %x.\n", 
+					ldev->name, err);
+			ldev->irq = 0;
+		}
+		else
+#endif
+		{
+			err = request_irq(ldev->irq, pc8736x_interrupt, SA_SHIRQ | SA_INTERRUPT, ldev->name, ldev);
+			if (err)
+			{
+				printk(KERN_ERR "Failed to request irq %d: err=%d. Disabling interrupt.\n", 
+						ldev->irq, err);
+				ldev->irq = 0;
+			}
+		}
+	}
+		
+
+	printk(KERN_INFO "\t%16s - activated: 0x%04lx-0x%04lx, irq=%02x [type=%02x]\n",
+	       ldev->name, ldev->base_addr, ldev->base_addr + ldev->range,
+	       ldev->irq, ldev->irq_type);
+
+	return 0;
+}
+
+static int pc8736x_init(void)
+{
+	int err;
+
+	err = sc_add_sc_dev(&pc8736x_dev);
+	if (err)
+		return err;
+
+	printk(KERN_INFO "Driver for %s SuperIO chip.\n", pc8736x_dev.name);
+	return 0;
+}
+
+static void pc8736x_fini(void)
+{
+	sc_del_sc_dev(&pc8736x_dev);
+
+	while (atomic_read(&pc8736x_dev.refcnt)) {
+		printk(KERN_INFO "Waiting for %s to became free: refcnt=%d.\n",
+				pc8736x_dev.name, atomic_read(&pc8736x_dev.refcnt));
+		
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+			
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
+}
+
+module_init(pc8736x_init);
+module_exit(pc8736x_fini);
+
+EXPORT_SYMBOL(pc8736x_write_reg);
+EXPORT_SYMBOL(pc8736x_read_reg);
diff -Nru /tmp/empty/pc8736x.h linux-2.6/drivers/superio/pc8736x.h
--- /tmp/empty/pc8736x.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/pc8736x.h	2004-09-12 00:42:01.000000000 +0400
@@ -0,0 +1,39 @@
+/*
+ * 	pc8736x.h
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __PC8736X_H
+#define __PC8736X_H
+
+#define SIO_GPDO0		0x00
+#define SIO_GPDI0 		0x01
+#define SIO_GPEVEN0		0x02 
+#define SIO_GPEVST0		0x03 
+#define SIO_GPDO1 		0x04
+#define SIO_GPDI1 		0x05
+#define SIO_GPEVEN1		0x06 
+#define SIO_GPEVST1		0x07 
+#define SIO_GPDO2 		0x08
+#define SIO_GPDI2 		0x09
+#define SIO_GPDO3 		0x0A
+#define SIO_GPDI3 		0x0B
+
+#endif /* __PC8736X_H */
diff -Nru /tmp/empty/pin_test.c linux-2.6/drivers/superio/pin_test.c
--- /tmp/empty/pin_test.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/pin_test.c	2004-09-12 00:42:02.000000000 +0400
@@ -0,0 +1,93 @@
+/*
+ * 	pin_test.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <asm/atomic.h>
+#include <asm/types.h>
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+
+#include "sc.h"
+#include "sc_gpio.h"
+
+MODULE_LICENSE ("GPL");
+
+static int test_pin = 21;
+module_param(test_pin, int, 0);
+
+static struct timer_list tm;
+static struct logical_dev *ldev;
+
+static void tm_func(unsigned long data)
+{
+	int i;
+	int val;
+
+	for (i=0; i<SIO_GPIO_NPINS; ++i)
+	{
+		val = ldev->read(ldev, i);
+		printk("%02d.%d ", i, val);
+		if (i % 8 = 7)
+			printk("\n");
+
+		if (i = test_pin)
+			ldev->write(ldev, i, (val)?0:1);
+	}
+	printk("\n");
+
+	mod_timer(&tm, jiffies + HZ);
+}
+
+int __devinit tm_init (void)
+{
+	int i;
+	
+	ldev = sc_get_ldev("GPIO");
+	if (!ldev)
+	{
+		printk(KERN_ERR "Logical device GPIO is not registered.\n");
+		return -ENODEV;
+	}
+	for (i=0; i<SIO_GPIO_NPINS; ++i)
+		ldev->control(ldev, i, ~0, SIO_GPIO_CONF_PUSHPULL);
+
+	init_timer(&tm);
+	tm.expires = jiffies + HZ;
+	tm.function = tm_func;
+	tm.data = 0;
+	add_timer(&tm);
+
+	return 0;
+}
+
+void __devexit tm_fini(void)
+{
+	del_timer_sync(&tm);
+	sc_put_ldev(ldev);
+}
+
+module_init(tm_init);
+module_exit(tm_fini);
diff -Nru /tmp/empty/sc.c linux-2.6/drivers/superio/sc.c
--- /tmp/empty/sc.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/sc.c	2004-09-12 00:42:02.000000000 +0400
@@ -0,0 +1,754 @@
+/*
+ * 	sc.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <asm/atomic.h>
+#include <asm/types.h>
+#include <asm/io.h>
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+
+#include "sc.h"
+#include "sc_conn.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Generic SuperIO driver.");
+
+static unsigned long base_addr[] = { 0x2e, 0x4e };
+
+static spinlock_t sdev_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(sdev_list);
+
+static spinlock_t ldev_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(ldev_list);
+
+static int sc_activate_logical(struct sc_dev *, struct logical_dev *);
+static void sc_deactivate_logical(struct sc_dev *, struct logical_dev *);
+
+static int __devinit sc_init(void);
+static void __devexit sc_fini(void);
+
+static inline int sc_ldev_equal(struct logical_dev *l1, struct logical_dev *l2)
+{
+	int a, b;
+
+	a = b = 1;
+
+	a = (!strncmp(l1->name, l2->name, SC_NAME_LEN) && l1->index = l2->index);
+
+	if (sc_ldev_is_clone(l1) && sc_ldev_is_clone(l2))
+		b = (l1->base_addr = l2->base_addr);
+
+	return (a && b);
+}
+
+static inline int sc_ldev_equal_name(struct logical_dev *l1,
+				     struct logical_dev *l2)
+{
+	return (!strncmp(l1->name, l2->name, SC_NAME_LEN));
+}
+
+static inline int sc_sdev_equal(struct sc_dev *s1, struct sc_dev *s2)
+{
+	return (!strncmp(s1->name, s2->name, SC_NAME_LEN));
+}
+
+static void sc_del_sdev_from_ldev(struct sc_dev *sdev, struct logical_dev *ldev)
+{
+	struct sc_dev *__sdev;
+	struct dev_chain *ch, *n;
+
+	spin_lock(&ldev->chain_lock);
+
+	list_for_each_entry_safe(ch, n, &ldev->chain_list, chain_entry) {
+		__sdev = ch->ptr;
+
+		if (sc_sdev_equal(__sdev, sdev)) {
+			list_del(&ch->chain_entry);
+			chain_free(ch);
+			atomic_dec(&__sdev->refcnt);
+			break;
+		}
+	}
+
+	spin_unlock(&ldev->chain_lock);
+}
+
+static int __sc_add_logical_dev(struct sc_dev *dev, struct logical_dev *__ldev)
+{
+	int err;
+	struct logical_dev *ldev;
+	struct dev_chain *ch, *lch, *_ch;
+	int __found = 0;
+
+	err = 0;
+
+	list_for_each_entry(_ch, &dev->chain_list, chain_entry) {
+		ldev = _ch->ptr;
+
+		if (sc_ldev_equal(ldev, __ldev)) {
+			printk(KERN_INFO "Logical device %s already registered in SuperIO chip %s.\n",
+			       ldev->name, dev->name);
+			err++;
+			break;
+		}
+	}
+
+	if (err) {
+		err = -ENODEV;
+		goto err_out;
+	}
+
+	if (!sc_ldev_is_clone(__ldev)) {
+		struct sc_chip_id *cid;
+
+		/*
+		 * SuperIO core is registering logical device. 
+		 * SuperIO chip knows where it must live.
+		 * If logical device being registered lives at the different location
+		 * (for example when it was registered for all devices, 
+		 * but has address(index) corresponding to only one SuperIO chip) 
+		 * then we will register new logical device with the same name 
+		 * but with the different location(index).
+		 *
+		 * It is called clone.
+		 */
+
+		for (cid = dev->ldevs; cid && strlen(cid->name); ++cid) {
+			if (!strncmp(cid->name, __ldev->name, SC_NAME_LEN)
+			    && cid->id != __ldev->index) {
+				struct logical_dev *clone;
+
+				__found = 1;
+
+				printk(KERN_INFO "Logical device %s in chip %s lives at %x, but provided address %x.\n"
+				       "Registering new logical device %s in chip %s with address %x.\n",
+				       __ldev->name, dev->name, cid->id,
+				       __ldev->index, __ldev->name, dev->name,
+				       cid->id);
+
+				clone = sc_ldev_clone(__ldev);
+				if (!clone) {
+					err = -ENOMEM;
+					continue;
+				}
+
+				/*
+				 * If logical device provided 0xFF index, than it is mean that
+				 * SuperIO chip driver must handle this situation.
+				 * It is similar to the zero base address in SuperIO ->probe() function.
+				 */
+
+				clone->index = cid->id;
+
+				err = __sc_add_logical_dev(dev, clone);
+				if (err)
+					sc_ldev_unclone(clone);
+			}
+		}
+
+		if (__found)
+			return 0;
+	}
+
+	__ldev->pdev = dev;
+	err = sc_activate_logical(dev, __ldev);
+	if (err) {
+		printk(KERN_INFO "Logical device %s is not found in SuperIO chip %s.\n",
+		       __ldev->name, dev->name);
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	ch = chain_alloc(dev);
+	if (!ch) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	lch = chain_alloc(__ldev);
+	if (!lch) {
+		err = -ENOMEM;
+		goto err_out_free_chain;
+	}
+
+	ch->ptr = dev;
+
+	spin_lock(&__ldev->chain_lock);
+	atomic_inc(&__ldev->refcnt);
+	list_add_tail(&ch->chain_entry, &__ldev->chain_list);
+	spin_unlock(&__ldev->chain_lock);
+
+	atomic_inc(&dev->refcnt);
+	list_add_tail(&lch->chain_entry, &dev->chain_list);
+
+	__found = 0;
+	spin_lock(&ldev_lock);
+	list_for_each_entry(ldev, &ldev_list, ldev_entry) {
+		if (sc_ldev_equal(ldev, __ldev)) {
+			__found = 1;
+			break;
+		}
+	}
+
+	if (!__found) {
+		list_add(&__ldev->ldev_entry, &ldev_list);
+	}
+
+	spin_unlock(&ldev_lock);
+
+	return 0;
+
+	chain_free(lch);
+err_out_free_chain:
+	chain_free(ch);
+err_out:
+
+	return err;
+}
+
+int sc_add_logical_dev(struct sc_dev *sdev, struct logical_dev *__ldev)
+{
+	struct sc_dev *dev;
+	int err, found = 0;
+
+	printk(KERN_INFO "Adding logical device %s [%x] [%s].\n",
+	       __ldev->name, __ldev->index,
+	       (sc_ldev_is_clone(__ldev)) ? "clone" : "not clone");
+
+	spin_lock_init(&__ldev->chain_lock);
+	INIT_LIST_HEAD(&__ldev->chain_list);
+
+	spin_lock_init(&__ldev->lock);
+
+	atomic_set(&__ldev->refcnt, 0);
+
+	if (sdev) {
+		spin_lock(&sdev->lock);
+		spin_lock(&sdev->chain_lock);
+		err = __sc_add_logical_dev(sdev, __ldev);
+		spin_unlock(&sdev->chain_lock);
+		spin_unlock(&sdev->lock);
+
+		if (!err)
+			found = 1;
+
+		goto finish;
+	}
+
+	spin_lock(&sdev_lock);
+	list_for_each_entry(dev, &sdev_list, sdev_entry) {
+		spin_lock(&dev->lock);
+		spin_lock(&dev->chain_lock);
+		err = __sc_add_logical_dev(dev, __ldev);
+		spin_unlock(&dev->chain_lock);
+		spin_unlock(&dev->lock);
+		if (!err)
+			found = 1;
+	}
+	spin_unlock(&sdev_lock);
+
+finish:
+
+	return (found) ? 0 : -ENODEV;
+}
+
+/*
+ * Must be called under ldev->chain_lock and ldev_lock held.
+ */
+static void __sc_del_logical_dev(struct sc_dev *dev, struct logical_dev *__ldev)
+{
+	struct dev_chain *ch, *n;
+	struct logical_dev *ldev;
+
+	spin_lock(&dev->chain_lock);
+	list_for_each_entry_safe(ch, n, &dev->chain_list, chain_entry) {
+		ldev = ch->ptr;
+
+		if (sc_ldev_equal(ldev, __ldev)) {
+			list_del(&ch->chain_entry);
+			atomic_dec(&ldev->refcnt);
+			chain_free(ch);
+
+			sc_deactivate_logical(dev, ldev);
+
+			break;
+		}
+	}
+	spin_unlock(&dev->chain_lock);
+}
+
+void sc_del_logical_dev(struct logical_dev *ldev)
+{
+	struct sc_dev *dev;
+	struct dev_chain *ch, *n;
+	struct logical_dev *ld, *ln;
+
+	spin_lock(&ldev->lock);
+
+	spin_lock(&ldev->chain_lock);
+	list_for_each_entry_safe(ch, n, &ldev->chain_list, chain_entry) {
+		dev = ch->ptr;
+
+		spin_lock(&dev->lock);
+		printk(KERN_INFO "Deactivating %s [%s/%s] from %s\n",
+		       ldev->name,
+		       (sc_ldev_is_clone(ldev)) ? "clone" : "not clone",
+		       (sc_ldev_cloned(ldev)) ? "cloned" : "not cloned",
+		       dev->name);
+		__sc_del_logical_dev(dev, ldev);
+
+		list_del(&ch->chain_entry);
+		atomic_dec(&dev->refcnt);
+		chain_free(ch);
+		spin_unlock(&dev->lock);
+	}
+	spin_unlock(&ldev->chain_lock);
+
+	if (sc_ldev_is_clone(ldev)) {
+		spin_unlock(&ldev->lock);
+		return;
+	}
+
+	spin_lock(&ldev_lock);
+	list_for_each_entry_safe(ld, ln, &ldev_list, ldev_entry) {
+		printk(KERN_INFO "Processing ldev %s [%s/%s] [%x]\n",
+		       ld->name,
+		       (sc_ldev_is_clone(ld)) ? "clone" : "not clone",
+		       (sc_ldev_cloned(ld)) ? "cloned" : "not cloned",
+		       ld->index);
+		if (sc_ldev_equal(ld, ldev)) {
+			list_del(&ld->ldev_entry);
+		} else if (sc_ldev_cloned(ldev)) {
+			/*
+			 * When logical device is clonned 
+			 * clone's chunks can point to the diferent device 
+			 * than origianl logical device's chunks.
+			 * Since we do not have backlink from the original device
+			 * to it's clones we must run through the whole ldev_list.
+			 */
+
+			if (sc_ldev_is_clone(ld) && sc_ldev_equal_name(ld, ldev)) {
+				list_del(&ld->ldev_entry);
+				sc_del_logical_dev(ld);
+				sc_ldev_unclone(ld);
+			}
+		}
+	}
+	spin_unlock(&ldev_lock);
+
+	spin_unlock(&ldev->lock);
+
+	while (atomic_read(&ldev->refcnt)) {
+		printk(KERN_INFO "Waiting logical device %s [%x] [%s] to become free: refcnt=%d.\n",
+		       ldev->name, ldev->index,
+		       (sc_ldev_is_clone(ldev)) ? "clone" : "not clone",
+		       atomic_read(&ldev->refcnt));
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+			
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
+
+}
+
+static int sc_check_sc_dev(struct sc_dev *dev)
+{
+	if (!dev->activate_one) {
+		printk(KERN_ERR "SuperIO device %s does not have ->activate_one() method.\n",
+		       dev->name);
+		return -EINVAL;
+	}
+
+	if (!dev->probe) {
+		printk(KERN_ERR "SuperIO device %s does not have ->probe() method.\n",
+		       dev->name);
+		return -EINVAL;
+	}
+
+	if (!dev->ldevs)
+		printk(KERN_INFO "SuperIO device %s does not have logical device table.\n",
+		       dev->name);
+
+	return 0;
+}
+
+int sc_add_sc_dev(struct sc_dev *__sdev)
+{
+	int i, err;
+	struct sc_dev *sdev;
+
+	if (sc_check_sc_dev(__sdev))
+		return -EINVAL;
+
+	spin_lock_init(&__sdev->chain_lock);
+	INIT_LIST_HEAD(&__sdev->chain_list);
+
+	spin_lock_init(&__sdev->lock);
+
+	spin_lock(&sdev_lock);
+	list_for_each_entry(sdev, &sdev_list, sdev_entry) {
+		if (sc_sdev_equal(sdev, __sdev)) {
+			printk(KERN_INFO "Super IO chip %s already registered.\n",
+			       sdev->name);
+			spin_unlock(&sdev_lock);
+			return -EINVAL;
+		}
+	}
+
+	err = -ENODEV;
+	for (i = 0; i < sizeof(base_addr) / sizeof(base_addr[0]); ++i) {
+		err = __sdev->probe(__sdev, base_addr[i]);
+		if (!err)
+			break;
+	}
+
+	/*
+	 * Special case for non standard base location.
+	 */
+	if (i = sizeof(base_addr) / sizeof(base_addr[0]))
+		err = __sdev->probe(__sdev, 0);
+
+	if (!err) {
+		atomic_set(&__sdev->refcnt, 0);
+		list_add_tail(&__sdev->sdev_entry, &sdev_list);
+	}
+
+	spin_unlock(&sdev_lock);
+
+	return err;
+}
+
+void sc_del_sc_dev(struct sc_dev *__sdev)
+{
+	struct dev_chain *ch, *n;
+	struct logical_dev *ldev;
+	struct sc_dev *sdev, *sn;
+
+	spin_lock(&__sdev->lock);
+	spin_lock(&sdev_lock);
+	list_for_each_entry_safe(sdev, sn, &sdev_list, sdev_entry) {
+		if (sc_sdev_equal(sdev, __sdev)) {
+			list_del(&sdev->sdev_entry);
+			break;
+		}
+	}
+	spin_unlock(&sdev_lock);
+
+	spin_lock(&__sdev->chain_lock);
+	list_for_each_entry_safe(ch, n, &__sdev->chain_list, chain_entry) {
+		ldev = ch->ptr;
+
+		list_del(&ch->chain_entry);
+		atomic_dec(&ldev->refcnt);
+		chain_free(ch);
+
+		sc_deactivate_logical(__sdev, ldev);
+		sc_del_sdev_from_ldev(__sdev, ldev);
+	}
+	spin_unlock(&__sdev->chain_lock);
+	spin_unlock(&__sdev->lock);
+
+	while (atomic_read(&__sdev->refcnt)) {
+		printk(KERN_INFO "Waiting SuperIO chip %s to become free: refcnt=%d.\n",
+		       __sdev->name, atomic_read(&__sdev->refcnt));
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ);
+			
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
+}
+
+static void sc_deactivate_logical(struct sc_dev *dev, struct logical_dev *ldev)
+{
+	printk(KERN_INFO "Deactivating logical device %s in SuperIO chip %s... ",
+	       ldev->name, dev->name);
+
+	if (dev->deactivate_one)
+		dev->deactivate_one(ldev);
+
+	printk("done.\n");
+}
+
+/*
+ * Must be called under sdev_lock held.
+ */
+static int sc_activate_logical(struct sc_dev *dev, struct logical_dev *ldev)
+{
+	int err;
+
+	printk(KERN_INFO "Activating logical device %s [%x].\n", ldev->name,
+	       ldev->index);
+
+	ldev->pdev = dev;
+	err = dev->activate_one(ldev);
+	return err;
+}
+
+struct sc_dev *sc_get_sdev(char *name)
+{
+	struct sc_dev *sdev;
+
+	spin_lock(&sdev_lock);
+	list_for_each_entry(sdev, &sdev_list, sdev_entry) {
+		if (!strcmp(name, sdev->name)) {
+			atomic_inc(&sdev->refcnt);
+			spin_unlock(&sdev_lock);
+			return sdev;
+		}
+	}
+	spin_unlock(&sdev_lock);
+
+	return NULL;
+}
+
+void sc_put_sdev(struct sc_dev *sdev)
+{
+	atomic_dec(&sdev->refcnt);
+}
+
+/*
+ * Get logical device which has given name and index.
+ */
+struct logical_dev *sc_get_ldev_index(char *name, u8 index)
+{
+	struct logical_dev *ldev;
+
+	spin_lock(&ldev_lock);
+	list_for_each_entry(ldev, &ldev_list, ldev_entry) {
+		if (!strcmp(name, ldev->name) && ldev->index = index) {
+			atomic_inc(&ldev->refcnt);
+			spin_unlock(&ldev_lock);
+			return ldev;
+		}
+	}
+	spin_unlock(&ldev_lock);
+
+	return NULL;
+}
+
+/*
+ * Get the first logical device with the given name.
+ */
+struct logical_dev *sc_get_ldev(char *name)
+{
+	struct logical_dev *ldev;
+
+	spin_lock(&ldev_lock);
+	list_for_each_entry(ldev, &ldev_list, ldev_entry) {
+		if (!strcmp(name, ldev->name)) {
+			atomic_inc(&ldev->refcnt);
+			spin_unlock(&ldev_lock);
+			return ldev;
+		}
+	}
+	spin_unlock(&ldev_lock);
+
+	return NULL;
+}
+
+/*
+ * Get the first logical device with the given name connected to given SuperIO chip.
+ */
+struct logical_dev *sc_get_ldev_in_sdev(char *name, struct sc_dev *sdev)
+{
+	struct dev_chain *ch;
+	struct logical_dev *ldev;
+
+	spin_lock(&sdev->chain_lock);
+	list_for_each_entry(ch, &sdev->chain_list, chain_entry) {
+		ldev = ch->ptr;
+
+		if (!strcmp(name, ldev->name)) {
+			atomic_inc(&ldev->refcnt);
+			spin_unlock(&sdev->chain_lock);
+			return ldev;
+		}
+	}
+	spin_unlock(&sdev->chain_lock);
+
+	return NULL;
+}
+
+void sc_put_ldev(struct logical_dev *ldev)
+{
+	atomic_dec(&ldev->refcnt);
+}
+
+/*
+ * Cloned logical device has the same structure as original device.
+ * Although cloned and original devices do not cross, they both point
+ * to the same block of the memory(they have pointers to the same functions), 
+ * so we will increment reference counter for original device 
+ * like cloned device has a reference to it.
+ */
+struct logical_dev *sc_ldev_clone(struct logical_dev *ldev)
+{
+	struct logical_dev *__ldev;
+
+	__ldev = sc_ldev_alloc(ldev->name, ldev->index);
+	if (!__ldev)
+		return NULL;
+
+	memcpy(__ldev, ldev, sizeof(*__ldev));
+
+	spin_lock_init(&__ldev->chain_lock);
+	INIT_LIST_HEAD(&__ldev->chain_list);
+	spin_lock_init(&__ldev->lock);
+
+	atomic_inc(&ldev->refcnt);
+	set_bit(LDEV_CLONED, (long *)&ldev->flags);
+
+	atomic_set(&__ldev->refcnt, 0);
+	__ldev->orig_ldev = ldev;
+
+	return __ldev;
+}
+
+inline int sc_ldev_is_clone(struct logical_dev *ldev)
+{
+	return (ldev->orig_ldev) ? 1 : 0;
+}
+
+inline int sc_ldev_cloned(struct logical_dev *ldev)
+{
+	return (test_bit(LDEV_CLONED, (long *)&ldev->flags)
+		&& (atomic_read(&ldev->refcnt) >= 1));
+}
+
+void sc_ldev_unclone(struct logical_dev *clone)
+{
+	struct logical_dev *orig = clone->orig_ldev;
+
+	if (!sc_ldev_is_clone(clone)) {
+		printk(KERN_INFO "Logical device %s is not clone.\n",
+		       clone->name);
+		return;
+	}
+
+	if (atomic_dec_and_test(&orig->refcnt))
+		clear_bit(LDEV_CLONED, (long *)&orig->flags);
+
+	memset(clone, 0, sizeof(*clone));
+	kfree(clone);
+	clone = NULL;
+}
+
+struct logical_dev *sc_ldev_alloc(char *name, u8 index)
+{
+	struct logical_dev *ldev;
+
+	ldev = kmalloc(sizeof(*ldev), GFP_ATOMIC);
+	if (!ldev) {
+		printk(KERN_ERR "Failed to allocate new logical device %s at address %x.\n",
+		       name, index);
+		return NULL;
+	}
+
+	memset(ldev, 0, sizeof(*ldev));
+
+	snprintf(ldev->name, sizeof(ldev->name), "%s", name);
+	ldev->index = index;
+
+	return ldev;
+}
+
+void sc_ldev_free(struct logical_dev *ldev)
+{
+	if (ldev->orig_ldev) {
+		struct logical_dev *orig = ldev->orig_ldev;
+		/*
+		 * It is clone.
+		 */
+		atomic_dec(&ldev->refcnt);
+		if (atomic_read(&ldev->refcnt)) {
+			/*
+			 * It is impossible, clone can not have clones.
+			 */
+			printk(KERN_INFO "Logical device clone %s has refcnt=%d and flags=%x.\n",
+			       ldev->name, atomic_read(&ldev->refcnt),
+			       ldev->flags);
+			BUG();
+		}
+
+		spin_lock(&orig->lock);
+
+		clear_bit(LDEV_CLONED, (long *)&orig->flags);
+		atomic_dec(&orig->refcnt);
+
+		memset(ldev, 0, sizeof(*ldev));
+		kfree(ldev);
+
+		spin_unlock(&orig->lock);
+	} else if (sc_ldev_cloned(ldev)) {
+		/*
+		 * It is cloned.
+		 */
+	}
+}
+
+static int __devinit sc_init(void)
+{
+	printk(KERN_INFO "SuperIO driver is starting...\n");
+
+	return sc_register_callback();
+}
+
+static void __devexit sc_fini(void)
+{
+	sc_unregister_callback();
+	printk(KERN_INFO "SuperIO driver finished.\n");
+}
+
+module_init(sc_init);
+module_exit(sc_fini);
+
+EXPORT_SYMBOL(sc_add_logical_dev);
+EXPORT_SYMBOL(sc_del_logical_dev);
+EXPORT_SYMBOL(sc_get_ldev);
+EXPORT_SYMBOL(sc_get_ldev_in_sdev);
+EXPORT_SYMBOL(sc_put_ldev);
+EXPORT_SYMBOL(sc_add_sc_dev);
+EXPORT_SYMBOL(sc_del_sc_dev);
+EXPORT_SYMBOL(sc_get_sdev);
+EXPORT_SYMBOL(sc_put_sdev);
+EXPORT_SYMBOL(sc_ldev_alloc);
+EXPORT_SYMBOL(sc_ldev_free);
+EXPORT_SYMBOL(sc_ldev_clone);
+EXPORT_SYMBOL(sc_ldev_unclone);
+EXPORT_SYMBOL(sc_ldev_cloned);
+EXPORT_SYMBOL(sc_ldev_is_clone);
diff -Nru /tmp/empty/sc.h linux-2.6/drivers/superio/sc.h
--- /tmp/empty/sc.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/sc.h	2004-09-12 00:42:02.000000000 +0400
@@ -0,0 +1,132 @@
+/*
+ * 	sc.h
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __SC_H
+#define __SC_H
+
+#include <linux/types.h>
+
+#include "chain.h"
+
+#define SC_NAME_LEN		16
+
+#define SIO_REG_SID		0x20	/* Super I/O ID */
+
+#define SIO_REG_SRID		0x27	/* Super I/O Revision */
+#define SIO_REG_IRQ		0x70	/* IRQ number */
+#define SIO_REG_IRQ_TYPE	0x71	/* IRQ type */
+
+#define SIO_REG_LDN		0x07	/* Logical Device Number */
+#define SIO_LDN_GPIO		0x07	/* General-Purpose I/O (GPIO) Ports */
+#define SIO_LDN_ACB		0x08	/* Access bus */
+
+#define SIO_REG_ACTIVE		0x30	/* Logical Device Activate Register */
+#define SIO_ACTIVE_EN		0x01	/* enabled */
+#define SIO_RESET		0x02
+
+#define SIO_REG_IO_MSB		0x60	/* I/O Port Base, bits 15-8 */
+#define SIO_REG_IO_LSB		0x61	/* I/O Port Base, bits 7-0 */
+
+#define LDEV_PRIVATE		0xff	/* Logical device has non standard dynamic address (like PCI space) */
+
+#define LDEV_CLONED		(1<<0)
+
+struct logical_dev
+{
+	struct list_head	ldev_entry;
+
+	atomic_t		refcnt;
+	spinlock_t		lock;
+
+	struct list_head	chain_list;
+	spinlock_t		chain_lock;
+
+	unsigned char		name[SC_NAME_LEN];
+	u8			index;
+	
+	unsigned long		base_addr;
+	unsigned long		range;
+
+	u32			flags;
+
+	void			*pdev;
+	void			*orig_ldev;
+
+	u8			irq;
+	u8			irq_type;
+
+	int			(*activate)(void *);
+	u8			(*read)(void *, int);
+	void			(*write)(void *, int, u8);
+	void			(*control)(void *, int, u8, u8);
+};
+
+struct sc_dev
+{
+	struct list_head	sdev_entry;
+
+	atomic_t		refcnt;
+	spinlock_t		lock;
+	
+	struct list_head	chain_list;
+	spinlock_t		chain_lock;
+
+	unsigned char		name[SC_NAME_LEN];
+
+	void			*pdev;
+	unsigned long		base_index, base_data;
+
+	struct sc_chip_id	*ldevs;
+
+	int			(*probe)(void *, unsigned long);
+	int			(*activate_one)(struct logical_dev *);
+	int			(*deactivate_one)(struct logical_dev *);
+	u8			(*read)(struct logical_dev *, unsigned long);
+	void			(*write)(struct logical_dev *, unsigned long, u8);
+};
+
+struct sc_chip_id
+{
+	unsigned char		name[SC_NAME_LEN];
+	u8			id;
+};
+
+int sc_add_logical_dev(struct sc_dev *, struct logical_dev *);
+void sc_del_logical_dev(struct logical_dev *);
+struct logical_dev *sc_get_ldev(char *);
+struct logical_dev *sc_get_ldev_in_sdev(char *, struct sc_dev *);
+void sc_put_ldev(struct logical_dev *);
+
+int sc_add_sc_dev(struct sc_dev *);
+void sc_del_sc_dev(struct sc_dev *);
+struct sc_dev *sc_get_sdev(char *);
+void sc_put_sdev(struct sc_dev *);
+
+struct logical_dev *sc_ldev_clone(struct logical_dev *ldev);
+void sc_ldev_unclone(struct logical_dev *ldev);
+inline int sc_ldev_cloned(struct logical_dev *ldev);
+inline int sc_ldev_is_clone(struct logical_dev *ldev);
+
+struct logical_dev *sc_ldev_alloc(char *name, u8 index);
+void sc_ldev_free(struct logical_dev *ldev);
+
+#endif /* __SC_H */
diff -Nru /tmp/empty/sc_acb.c linux-2.6/drivers/superio/sc_acb.c
--- /tmp/empty/sc_acb.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/sc_acb.c	2004-09-12 00:42:02.000000000 +0400
@@ -0,0 +1,163 @@
+/*
+ * 	sc_acb.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+
+#include "sc.h"
+#include "sc_acb.h"
+
+int sc_acb_activate(void *data);
+u8 sc_acb_read(void *data, int reg);
+void sc_acb_write(void *data, int reg, u8 byte);
+void sc_acb_control(void *data, int pin, u8 mask, u8 ctl);
+
+static struct logical_dev ldev_acb = {
+	.name = "ACB",
+	.index = 0x08,
+	.range = 16,
+
+	.activate = sc_acb_activate,
+	.read = sc_acb_read,
+	.write = sc_acb_write,
+	.control = sc_acb_control,
+
+	.flags = 0,
+	.orig_ldev = NULL,
+};
+
+void sc_write_reg(struct sc_dev *dev, u8 reg, u8 val)
+{
+	outb(reg, dev->base_index);
+	outb(val, dev->base_data);
+}
+
+u8 sc_read_reg(struct sc_dev *dev, u8 reg)
+{
+	u8 val;
+
+	outb(reg, dev->base_index);
+	val = inb(dev->base_data);
+
+	return val;
+}
+
+int sc_acb_activate(void *data)
+{
+	struct logical_dev *ldev = (struct logical_dev *)data;
+	u8 val;
+
+	sc_write_reg(ldev->pdev, ACBCTL2, 1);
+
+	val = sc_read_reg(ldev->pdev, ACBCTL2);
+	if ((val & 1) != 1) {
+		printk(KERN_ERR "Can not enable %s at %x: ctl2=%x.\n",
+		       ldev->name, ldev->index, val);
+		return -ENODEV;
+	}
+
+	sc_write_reg(ldev->pdev, ACBCTL2, 0x71);
+
+	val = sc_read_reg(ldev->pdev, ACBCTL2);
+	if (val != 0x71) {
+		printk(KERN_ERR "ACBCTL2 readback failed: val=%x.\n", val);
+		return -ENXIO;
+	}
+
+	sc_write_reg(ldev->pdev, ACBCTL1,
+		     sc_read_reg(ldev->pdev, ACBCTL1) | ACBCTL1_NMINTE);
+
+	val = sc_read_reg(ldev->pdev, ACBCTL1);
+	if (val) {
+		printk(KERN_ERR "Disabled, but ACBCTL1=0x%02x\n", val);
+		return -ENXIO;
+	}
+
+	sc_write_reg(ldev->pdev, ACBCTL2,
+		     sc_read_reg(ldev->pdev, ACBCTL2) | ACBCTL2_ENABLE);
+
+	sc_write_reg(ldev->pdev, ACBCTL1,
+		     sc_read_reg(ldev->pdev, ACBCTL1) | ACBCTL1_NMINTE);
+
+	val = sc_read_reg(ldev->pdev, ACBCTL1);
+	if ((val & ACBCTL1_NMINTE) != ACBCTL1_NMINTE) {
+		printk(KERN_ERR "Enabled, but NMINTE won't be set, ACBCTL1=0x%02x\n",
+		       val);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+u8 sc_acb_read(void *data, int reg)
+{
+	struct logical_dev *ldev = (struct logical_dev *)data;
+	u8 val;
+
+	val = inb(ldev->base_addr + reg);
+
+	//printk("R: %02x\n", val);
+
+	return val;
+}
+
+void sc_acb_write(void *data, int reg, u8 byte)
+{
+	struct logical_dev *ldev = (struct logical_dev *)data;
+
+	//printk("W: %02x\n", val);
+
+	outb(byte, ldev->base_addr + reg);
+}
+
+void sc_acb_control(void *data, int pin, u8 mask, u8 ctl)
+{
+}
+
+static int __devinit sc_acb_init(void)
+{
+	printk(KERN_INFO "Access Bus logical device driver is activating now.\n");
+	INIT_LIST_HEAD(&ldev_acb.ldev_entry);
+	spin_lock_init(&ldev_acb.lock);
+	return sc_add_logical_dev(NULL, &ldev_acb);
+}
+
+static void __devexit sc_acb_fini(void)
+{
+	sc_del_logical_dev(&ldev_acb);
+	printk(KERN_INFO "Access Bus logical device driver finished.\n");
+}
+
+module_init(sc_acb_init);
+module_exit(sc_acb_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for Access Bus logical device.");
+
+EXPORT_SYMBOL(sc_acb_activate);
+EXPORT_SYMBOL(sc_acb_read);
+EXPORT_SYMBOL(sc_acb_write);
+EXPORT_SYMBOL(sc_acb_control);
diff -Nru /tmp/empty/sc_acb.h linux-2.6/drivers/superio/sc_acb.h
--- /tmp/empty/sc_acb.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/sc_acb.h	2004-09-12 00:42:02.000000000 +0400
@@ -0,0 +1,45 @@
+/*
+ * 	sc_acb.h
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __SC_ACB_H
+#define __SC_ACB_H
+
+#define ACBSDA			(ldev->base_addr + 0)
+#define ACBST			(ldev->base_addr + 1)
+#define ACBST_SDAST		0x40 /* SDA Status */
+#define ACBST_BER		0x20 
+#define ACBST_NEGACK		0x10 /* Negative Acknowledge */
+#define ACBST_STASTR		0x08 /* Stall After Start */
+#define ACBST_MASTER		0x02
+#define ACBCST			(ldev->base_addr + 2)
+#define ACBCST_BB		0x02
+#define ACBCTL1			(ldev->base_addr + 3)
+#define ACBCTL1_STASTRE		0x80
+#define ACBCTL1_NMINTE		0x40
+#define	ACBCTL1_ACK		0x10
+#define	ACBCTL1_STOP		0x02
+#define	ACBCTL1_START		0x01
+#define ACBADDR			(ldev->base_addr + 4)
+#define ACBCTL2			(ldev->base_addr + 5)
+#define ACBCTL2_ENABLE		0x01
+
+#endif /* __SC_ACB_H */
diff -Nru /tmp/empty/sc_conn.c linux-2.6/drivers/superio/sc_conn.c
--- /tmp/empty/sc_conn.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/sc_conn.c	2004-09-12 00:42:02.000000000 +0400
@@ -0,0 +1,127 @@
+/*
+ * 	sc_conn.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <asm/atomic.h>
+#include <asm/types.h>
+#include <asm/io.h>
+
+#include "sc.h"
+#include "sc_conn.h"
+#include "../connector/connector.h"
+
+#define SC_CONN_IDX		0xaabb
+#define SC_CONN_VAL		0xccdd
+
+static struct cb_id sc_conn_id = { SC_CONN_IDX, SC_CONN_VAL };
+
+static void sc_conn_callback(void *data)
+{
+	struct cn_msg *reply, *msg = (struct cn_msg *)data;
+	struct sc_conn_data *rcmd, *cmd = (struct sc_conn_data *)(msg + 1);
+	struct logical_dev *ldev;
+	struct sc_dev *sdev;
+	u8 ret;
+
+	if (msg->len != sizeof(*cmd)) {
+		printk(KERN_ERR "Wrong additional data size %u, must be %u.\n",
+		       msg->len, sizeof(*cmd));
+		return;
+	}
+#if 0
+	printk
+	    ("%s: len=%u, seq=%u, ack=%u, sname=%s, lname=%s, idx=0x%x, cmd=%02x [%02x.%02x.%02x].\n",
+	     __func__, msg->len, msg->seq, msg->ack, cmd->sname, cmd->lname,
+	     cmd->idx, cmd->cmd, cmd->p0, cmd->p1, cmd->p2);
+#endif
+	sdev = sc_get_sdev(cmd->sname);
+	if (!sdev) {
+		printk(KERN_ERR "%s: sdev %s does not exist.\n", 
+			__func__, cmd->sname);
+		return;
+	}
+
+	ldev = sc_get_ldev_in_sdev(cmd->lname, sdev);
+	if (!ldev) {
+		printk(KERN_ERR "%s: ldev %s does not exist in chip %s.\n",
+		       __func__, cmd->lname, cmd->sname);
+		sc_put_sdev(sdev);
+		return;
+	}
+
+	ret = 0;
+	switch (cmd->cmd) {
+	case SC_CMD_LDEV_READ:
+		ret = ldev->read(ldev, cmd->p0);
+		reply = kmalloc(sizeof(*msg) + sizeof(*cmd), GFP_ATOMIC);
+		if (reply) {
+			memcpy(reply, msg, sizeof(*reply));
+
+			/*
+			 * See protocol description in connector.c
+			 */
+			reply->ack++;
+
+			rcmd = (struct sc_conn_data *)(reply + 1);
+			memcpy(rcmd, cmd, sizeof(*rcmd));
+
+			rcmd->cmd = SC_CMD_LDEV_READ;
+			rcmd->p0 = cmd->p0;
+			rcmd->p1 = ret;
+
+			cn_netlink_send(reply);
+
+			kfree(reply);
+		} else
+			printk(KERN_ERR "Failed to allocate %d bytes in reply to comamnd 0x%x.\n",
+			       sizeof(*msg) + sizeof(*cmd), cmd->cmd);
+		break;
+	case SC_CMD_LDEV_WRITE:
+		ldev->write(ldev, cmd->p0, cmd->p1);
+		break;
+	case SC_CMD_LDEV_CONTROL:
+		ldev->control(ldev, cmd->p0, cmd->p1, cmd->p2);
+		break;
+	case SC_CMD_LDEV_ACTIVATE:
+		ldev->activate(ldev);
+		break;
+	default:
+		printk(KERN_ERR "Unsupported command 0x%x for %s in chip %s.\n",
+		       cmd->cmd, ldev->name, sdev->name);
+		break;
+	}
+
+	sc_put_ldev(ldev);
+	sc_put_sdev(sdev);
+}
+
+int sc_register_callback(void)
+{
+	return cn_add_callback(&sc_conn_id, "sc_callback",
+			       (void (*)(void *))&sc_conn_callback);
+}
+
+void sc_unregister_callback(void)
+{
+	return cn_del_callback(&sc_conn_id);
+}
+
+EXPORT_SYMBOL(sc_register_callback);
+EXPORT_SYMBOL(sc_unregister_callback);
diff -Nru /tmp/empty/sc_conn.h linux-2.6/drivers/superio/sc_conn.h
--- /tmp/empty/sc_conn.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/sc_conn.h	2004-09-12 00:42:02.000000000 +0400
@@ -0,0 +1,50 @@
+/*
+ * 	sc_conn.h
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __SC_CONN_H
+#define __SC_CONN_H
+
+enum sc_conn_cmd
+{
+	SC_CMD_LDEV_READ = 0,
+	SC_CMD_LDEV_WRITE,
+	SC_CMD_LDEV_CONTROL,
+	SC_CMD_LDEV_ACTIVATE,
+
+	__SC_CMD_MAX_CMD_NUMBER
+};
+
+struct sc_conn_data
+{
+	char		sname[16];
+	char		lname[16];
+	__u32		idx;
+	
+	__u8		cmd;
+	__u8		p0, p1, p2;
+
+	__u8		data[0];
+};
+
+int sc_register_callback(void);
+void sc_unregister_callback(void);
+
+#endif /* __SC_CONN_H */
diff -Nru /tmp/empty/sc_gpio.c linux-2.6/drivers/superio/sc_gpio.c
--- /tmp/empty/sc_gpio.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/sc_gpio.c	2004-09-19 23:19:44.000000000 +0400
@@ -0,0 +1,299 @@
+/*
+ * 	sc_gpio.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+
+#include <asm/io.h>
+
+#include "sc.h"
+#include "sc_gpio.h"
+#include "pc8736x.h"
+
+static struct gpio_pin gpin[SIO_GPIO_NPINS];
+
+static struct logical_dev ldev_gpio = {
+	.name = "GPIO",
+	.index = SIO_LDN_GPIO,
+	.range = 16,
+
+	.activate = sc_gpio_activate,
+	.read = sc_gpio_read,
+	.write = sc_gpio_write,
+	.control = sc_gpio_control,
+
+	.flags = 0,
+	.orig_ldev = 0,
+};
+
+static void sc_gpio_write_event(void *data, int pin_number, u8 byte);
+
+void sc_write_reg(struct sc_dev *dev, u8 reg, u8 val)
+{
+	outb(reg, dev->base_index);
+	outb(val, dev->base_data);
+}
+
+u8 sc_read_reg(struct sc_dev *dev, u8 reg)
+{
+	u8 val;
+
+	outb(reg, dev->base_index);
+	val = inb(dev->base_data);
+
+	return val;
+}
+
+void sc_gpio_pin_select(void *data, int pin_number)
+{
+	struct logical_dev *ldev = (struct logical_dev *)data;
+	int port, pin;
+	u8 val;
+
+	port = pin_number >> 3;
+	pin = pin_number - (pin_number & (~7));
+	val = (port << 4) | pin;
+
+	sc_write_reg(ldev->pdev, SIO_REG_LDN, SIO_LDN_GPIO);
+	sc_write_reg(ldev->pdev, SIO_GPIO_PINSEL, val);
+}
+
+int sc_gpio_activate(void *data)
+{
+	struct logical_dev *ldev = (struct logical_dev *)data;
+	int i;
+
+	memset(gpin, 0, sizeof(gpin));
+
+	for (i = 0; i < SIO_GPIO_NPINS; ++i) {
+		gpin[i].flags = SIO_GPIO_CONF_PULLUP | SIO_GPIO_CONF_EVENT_LEVEL;
+		gpin[i].mask &= ~(SIO_GPIO_CONF_DEBOUNCE);
+
+		sc_gpio_control(ldev, i, gpin[i].mask, gpin[i].flags);
+
+		//gpin[i].state = GPIO_PIN_HIGH;
+		//sc_gpio_write(ldev, i, gpin[i].state);
+
+		//sc_gpio_write_event(ldev, i, 1);
+	}
+	
+	outb(0xff, ldev->base_addr + SIO_GPEVEN0);
+	outb(0xff, ldev->base_addr + SIO_GPEVEN1);
+
+	return 0;
+}
+
+u8 sc_gpio_read(void *data, int pin_number)
+{
+	struct logical_dev *ldev = (struct logical_dev *)data;
+	int port, pin;
+	u8 val, reg = SIO_GPDI0;
+
+	port = pin_number >> 3;
+	pin = pin_number - (pin_number & (~7));
+
+	switch (port) {
+	case 0:
+		reg = SIO_GPDI0;
+		break;
+	case 1:
+		reg = SIO_GPDI1;
+		break;
+	case 2:
+		reg = SIO_GPDI2;
+		break;
+	case 3:
+		reg = SIO_GPDI3;
+		break;
+	}
+
+	val = inb(ldev->base_addr + reg);
+
+	{
+		static u8 r[4], e[2], s[2];
+		u8 cr[4], ce[2], cs[2];
+		int i;
+		static int cnt;
+
+		for (i=0; i<2; ++i)
+		{	
+			ce[i] = inb(ldev->base_addr + i*4 + 2);
+			cs[i] = inb(ldev->base_addr + i*4 + 3);
+		}
+		
+		for (i=0; i<4; ++i)
+			cr[i] = inb(ldev->base_addr + i*4 + 1);
+
+		for (i=0; i<4; ++i)
+		{
+			u8 p = cr[i] ^ r[i];
+			u8 f;
+			
+			if (!p)
+				continue;
+			
+			while((f = ffs(p)))
+			{
+				f = ffs(p);
+				printk("%2d: cr=%02x, r=%02x, xor=%02x pin=%d, val=%d\n", 
+						i, cr[i], r[i], 
+						p, f + i*8 - 1, ((cr[i] >> (f-1)) & 1));
+				p &= ~(1<<(f-1));
+			}
+
+			if (i < 2)
+			{
+				printk("%2d: ce=%02x, e=%02x\n", i, ce[i], e[i]);
+				printk("%2d: cs=%02x, s=%02x\n", i, cs[i], s[i]);
+				outb(0xff, ldev->base_addr + i*4 + 3);
+			}
+
+		}
+		
+		memcpy(r, cr, sizeof(r));
+		memcpy(s, cs, sizeof(s));
+		memcpy(e, ce, sizeof(e));
+		
+		cnt++;
+	}
+
+	return ((val >> pin) & 0x01);
+}
+
+static void sc_gpio_write_event(void *data, int pin_number, u8 byte)
+{
+	struct logical_dev *ldev = (struct logical_dev *)data;
+	int port, pin;
+	u8 val, reg = SIO_GPEVEN0;
+
+	port = pin_number >> 3;
+	pin = pin_number - (pin_number & (~7));
+
+	switch (port) {
+		case 0:
+			reg = SIO_GPEVEN0;
+			break;
+		case 1:
+			reg = SIO_GPEVEN1;
+			break;
+		default:
+			return;
+	}
+
+	val = inb(ldev->base_addr + reg);
+
+	if (byte)
+		val |= (1 << pin);
+	else
+		val &= ~(1 << pin);
+
+	outb(val, ldev->base_addr + reg);
+	
+	outb(1<<pin, ldev->base_addr + reg+1);
+}
+
+void sc_gpio_write(void *data, int pin_number, u8 byte)
+{
+	struct logical_dev *ldev = (struct logical_dev *)data;
+	int port, pin;
+	u8 val, reg = SIO_GPDO0, rreg = SIO_GPDI0;
+
+	port = pin_number >> 3;
+	pin = pin_number - (pin_number & (~7));
+
+	switch (port) {
+	case 0:
+		reg = SIO_GPDO0;
+		rreg = SIO_GPDI0;
+		break;
+	case 1:
+		reg = SIO_GPDO1;
+		rreg = SIO_GPDI1;
+		break;
+	case 2:
+		reg = SIO_GPDO2;
+		rreg = SIO_GPDI2;
+		break;
+	case 3:
+		reg = SIO_GPDO3;
+		rreg = SIO_GPDI3;
+		break;
+	}
+
+	//val = inb(ldev->base_addr + reg);
+	val = inb(ldev->base_addr + rreg);
+
+	if (byte)
+		val |= (1 << pin);
+	else
+		val &= ~(1 << pin);
+
+	//printk("W: %02x [%d]\n", val, ((val>>pin)&1));
+
+	outb(val, ldev->base_addr + reg);
+}
+
+void sc_gpio_control(void *data, int pin, u8 mask, u8 ctl)
+{
+	struct logical_dev *ldev = (struct logical_dev *)data;
+	u8 cfg, ev;
+
+	sc_gpio_pin_select(ldev, pin);
+
+	cfg = sc_read_reg(ldev->pdev, SIO_GPIO_PINCFG);
+	ev = sc_read_reg(ldev->pdev, SIO_GPIO_PINEV);
+
+	cfg &= mask;
+	cfg |= ctl;
+
+	printk(KERN_INFO "pin=%2d cfg=%02x, mask=%02x, ctl=%02x, event=%02x\n", 
+			pin, cfg, mask, ctl, ev);
+	
+	sc_write_reg(ldev->pdev, SIO_GPIO_PINCFG, cfg);
+}
+
+static int __devinit sc_gpio_init(void)
+{
+	printk(KERN_INFO "GPIO logical device driver is activating now.\n");
+	INIT_LIST_HEAD(&ldev_gpio.ldev_entry);
+	spin_lock_init(&ldev_gpio.lock);
+	return sc_add_logical_dev(NULL, &ldev_gpio);
+}
+
+static void __devexit sc_gpio_fini(void)
+{
+	sc_del_logical_dev(&ldev_gpio);
+	printk(KERN_INFO "GPIO logical device driver finished.\n");
+}
+
+module_init(sc_gpio_init);
+module_exit(sc_gpio_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for GPIO logical device.");
+
+EXPORT_SYMBOL(sc_gpio_activate);
+EXPORT_SYMBOL(sc_gpio_read);
+EXPORT_SYMBOL(sc_gpio_write);
+EXPORT_SYMBOL(sc_gpio_control);
+EXPORT_SYMBOL(sc_gpio_pin_select);
diff -Nru /tmp/empty/sc_gpio.h linux-2.6/drivers/superio/sc_gpio.h
--- /tmp/empty/sc_gpio.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/sc_gpio.h	2004-09-19 20:09:36.000000000 +0400
@@ -0,0 +1,56 @@
+/*
+ * 	sc_gpio.h
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __SC_GPIO_H
+#define __SC_GPIO_H
+
+#define SIO_GPIO_PINSEL		0xf0
+#define SIO_GPIO_PINCFG		0xf1
+#define SIO_GPIO_PINEV		0xf2
+
+#define GPIO_PIN_LOW		0x00	/* low level (logical 0) */
+#define GPIO_PIN_HIGH		0x01	/* high level (logical 1) */
+
+#define SIO_GPIO_NPINS		29
+
+#define SIO_GPIO_CONF_OUTPUTEN		(1 << 0)
+#define SIO_GPIO_CONF_PUSHPULL		(1 << 1)
+#define SIO_GPIO_CONF_PULLUP		(1 << 2)
+#define SIO_GPIO_CONF_LOCK		(1 << 3)
+#define SIO_GPIO_CONF_EVENT_LEVEL	(1 << 4)
+#define SIO_GPIO_CONF_EVENT_POLAR_RIS	(1 << 5)
+#define SIO_GPIO_CONF_DEBOUNCE		(1 << 6)
+
+int sc_gpio_activate(void *);
+u8 sc_gpio_read(void *, int);
+void sc_gpio_write(void *, int, u8);
+void sc_gpio_control(void *, int, u8, u8);
+void sc_gpio_pin_select(void *, int);
+
+struct gpio_pin
+{
+	u8			state;
+	u8			flags;
+	u8			mask;
+};
+
+#endif /* __SC_GPIO_H */
diff -Nru /tmp/empty/sc_w1.c linux-2.6/drivers/superio/sc_w1.c
--- /tmp/empty/sc_w1.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/sc_w1.c	2004-09-12 00:42:02.000000000 +0400
@@ -0,0 +1,112 @@
+/*
+ * 	sc_w1.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <asm/atomic.h>
+#include <asm/types.h>
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+
+#include "../w1/w1.h"
+#include "../w1/w1_int.h"
+#include "../w1/w1_log.h"
+
+#include "../superio/sc.h"
+#include "../superio/sc_gpio.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for transport(Dallas 1-wire prtocol) over SuperIO GPIO pins.");
+
+static int pin_number = 21;	/* Use pin 21 by default */
+module_param(pin_number, int, 0);
+
+struct sc_w1_device {
+	struct logical_dev *ldev;
+	struct w1_bus_master bus_master;
+} sc_w1;
+
+static u8 sc_w1_read_bit(unsigned long data)
+{
+	struct sc_w1_device *swd = (struct sc_w1_device *)data;
+
+	//swd->ldev->control(swd->ldev, pin_number, ~(SIO_GPIO_CONF_PUSHPULL | SIO_GPIO_CONF_PULLUP), 0);
+
+	return swd->ldev->read(swd->ldev, pin_number);
+}
+
+static void sc_w1_write_bit(unsigned long data, u8 bit)
+{
+	struct sc_w1_device *swd = (struct sc_w1_device *)data;
+	u8 mask = SIO_GPIO_CONF_OUTPUTEN;
+
+	if (bit)
+		bit = 0;
+	else
+		bit = mask;
+
+	swd->ldev->control(swd->ldev, pin_number, ~mask, bit);
+	swd->ldev->write(swd->ldev, pin_number, 0);
+}
+
+int __devinit sc_w1_init(void)
+{
+	int err;
+
+	sc_w1.ldev = sc_get_ldev("GPIO");
+	if (!sc_w1.ldev) {
+		printk(KERN_ERR "Logical device GPIO is not registered.\n");
+		return -ENODEV;
+	}
+
+	sc_w1.bus_master.data = (unsigned long)&sc_w1;
+	sc_w1.bus_master.read_bit = sc_w1_read_bit;
+	sc_w1.bus_master.write_bit = sc_w1_write_bit;
+
+	err = w1_add_master_device(&sc_w1.bus_master);
+	if (err) {
+		printk(KERN_ERR "Failed to register sc_w1 master device: err=%d.\n",
+		       err);
+		sc_put_ldev(sc_w1.ldev);
+		return err;
+	}
+
+	printk(KERN_INFO "sc_w1 transport driver has been loaded. Pin number %d.\n",
+	       pin_number);
+
+	return 0;
+}
+
+void __devexit sc_w1_fini(void)
+{
+	w1_remove_master_device(&sc_w1.bus_master);
+
+	sc_put_ldev(sc_w1.ldev);
+
+	printk(KERN_INFO "sc_w1 transport driver has been unloaded.\n");
+}
+
+module_init(sc_w1_init);
+module_exit(sc_w1_fini);
diff -Nru /tmp/empty/scx200.c linux-2.6/drivers/superio/scx200.c
--- /tmp/empty/scx200.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/scx200.c	2004-09-12 00:42:02.000000000 +0400
@@ -0,0 +1,413 @@
+/*
+ * 	scx200.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <asm/atomic.h>
+#include <asm/types.h>
+#include <asm/io.h>
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pci.h>
+#include <linux/suspend.h>
+
+#include "sc.h"
+#include "scx200.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for SCx200/SC1100 SuperIO chips.");
+
+static int scx200_probe(void *, unsigned long base);
+static int scx200_activate_one_logical(struct logical_dev *ldev);
+static int scx200_deactivate_one_logical(struct logical_dev *ldev);
+
+static struct sc_chip_id scx200_logical_devs[] = {
+	{"RTC", 0x00},
+	{"SWC", 0x01},
+	{"IRCP", 0x02},
+	{"ACB", 0x05},
+	{"ACB", 0x06},
+	{"SPORT", 0x08},
+	{"GPIO", LDEV_PRIVATE},
+	{}
+};
+
+static struct sc_dev scx200_dev = {
+	.name "SCx200",
+	.probe scx200_probe,
+	.ldevs scx200_logical_devs,
+	.activate_one scx200_activate_one_logical,
+	.deactivate_one scx200_deactivate_one_logical,
+};
+
+static struct sc_chip_id scx200_sio_ids[] = {
+	{"SCx200/SC1100", 0xF5},
+};
+
+static unsigned long private_base;
+
+static struct pci_device_id scx200_tbl[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_BRIDGE)},
+	{PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SC1100_BRIDGE)},
+	{},
+};
+
+MODULE_DEVICE_TABLE(pci, scx200_tbl);
+
+static int scx200_pci_probe(struct pci_dev *, const struct pci_device_id *);
+
+static struct pci_driver scx200_pci_driver = {
+	.name = "scx200",
+	.id_table = scx200_tbl,
+	.probe = scx200_pci_probe,
+};
+
+void scx200_write_reg(struct sc_dev *dev, u8 reg, u8 val)
+{
+	outb(reg, dev->base_index);
+	outb(val, dev->base_data);
+}
+
+u8 scx200_read_reg(struct sc_dev *dev, u8 reg)
+{
+	u8 val;
+
+	outb(reg, dev->base_index);
+	val = inb(dev->base_data);
+
+	return val;
+}
+
+static u8 scx200_gpio_read(void *data, int pin_number)
+{
+	u32 val;
+	int bank;
+	unsigned long base;
+	struct logical_dev *ldev = (struct logical_dev *)data;
+
+	if (pin_number > 63 || pin_number < 0)
+		return 0;
+
+	bank = 0;
+	base = ldev->base_addr;
+
+	if (pin_number > 31) {
+		bank = 1;
+		base = ldev->base_addr + 0x10;
+		pin_number -= 32;
+	}
+
+	val = inl(base + 0x04);
+
+	return ((val >> pin_number) & 0x01);
+}
+
+static void scx200_gpio_write(void *data, int pin_number, u8 byte)
+{
+	u32 val;
+	int bank;
+	unsigned long base;
+	struct logical_dev *ldev = (struct logical_dev *)data;
+
+	if (pin_number > 63 || pin_number < 0)
+		return;
+
+	bank = 0;
+	base = ldev->base_addr;
+
+	if (pin_number > 31) {
+		bank = 1;
+		base = ldev->base_addr + 0x10;
+		pin_number -= 32;
+	}
+
+	val = inl(base);
+
+	if (byte)
+		val |= (1 << pin_number);
+	else
+		val &= ~(1 << pin_number);
+
+	outl(val, base);
+}
+
+void scx200_gpio_control(void *data, int pin_number, u8 mask, u8 ctl)
+{
+	u32 val;
+	int bank;
+	unsigned long base;
+	struct logical_dev *ldev = (struct logical_dev *)data;
+
+	if (pin_number > 63 || pin_number < 0)
+		return;
+
+	bank = 0;
+	base = ldev->base_addr;
+
+	if (pin_number > 31) {
+		bank = 1;
+		base = ldev->base_addr + 0x10;
+		pin_number -= 32;
+	}
+
+	/*
+	 * Pin selection.
+	 */
+
+	val = 0;
+	val = ((bank & 0x01) << 5) | pin_number;
+	outl(val, ldev->base_addr + 0x20);
+
+	val = inl(ldev->base_addr + 0x24);
+
+	val &= 0x7f;
+	val &= mask;
+	val |= ctl;
+
+	outl(val, ldev->base_addr + 0x24);
+}
+
+int scx200_gpio_activate(void *data)
+{
+	return 0;
+}
+
+static int scx200_ldev_index_by_name(char *name)
+{
+	int i;
+
+	for (i = 0;
+	     i < sizeof(scx200_logical_devs) / sizeof(scx200_logical_devs[0]); ++i)
+		if (!strncmp(scx200_logical_devs[i].name, name, SC_NAME_LEN))
+			return i;
+
+	return -ENODEV;
+}
+
+static int scx200_chip_index(u8 id)
+{
+	int i;
+
+	for (i = 0; i < sizeof(scx200_sio_ids) / sizeof(scx200_sio_ids[0]); ++i)
+		if (scx200_sio_ids[i].id = id)
+			return i;
+
+	return -ENODEV;
+}
+
+static int scx200_probe(void *data, unsigned long base)
+{
+	unsigned long size = 2;
+	u8 id;
+	int chip_num;
+	struct sc_dev *dev = (struct sc_dev *)data;
+
+	/*
+	 * Special address to handle.
+	 */
+	if (base = 0) {
+		return scx200_probe(data, 0x015C);
+	}
+
+	dev->base_index = base;
+	dev->base_data = base + 1;
+
+	id = scx200_read_reg(dev, SIO_REG_SID);
+	chip_num = scx200_chip_index(id);
+
+	if (chip_num >= 0) {
+		printk(KERN_INFO "Found %s [0x%x] at 0x%04lx-0x%04lx.\n",
+		       scx200_sio_ids[chip_num].name,
+		       scx200_sio_ids[chip_num].id, base, base + size - 1);
+		return 0;
+	}
+
+	printk(KERN_INFO "Found nothing at 0x%04lx-0x%04lx.\n", 
+			base, base + size - 1);
+
+	return -ENODEV;
+}
+
+static int scx200_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *ent)
+{
+	private_base = pci_resource_start(pdev, 0);
+	printk(KERN_INFO "%s: GPIO base 0x%lx.\n", pci_name(pdev), private_base);
+
+	if (!request_region
+	    (private_base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO")) {
+		printk(KERN_ERR "%s: failed to request %d bytes I/O region for GPIOs.\n",
+		       pci_name(pdev), SCx200_GPIO_SIZE);
+		return -EBUSY;
+	}
+
+	pci_set_drvdata(pdev, &private_base);
+	pci_enable_device(pdev);
+
+	return 0;
+}
+
+static int scx200_deactivate_one_logical(struct logical_dev *ldev)
+{
+	if (ldev->index != LDEV_PRIVATE)
+		return -ENODEV;
+
+	private_base -= 0x10;
+
+	return 0;
+}
+
+static int scx200_find_private_device(struct logical_dev *ldev)
+{
+	struct sc_dev *dev = (struct sc_dev *)ldev->pdev;
+
+	/*
+	 * SCx200/SC1100 has only GPIO in it's private space.
+	 */
+
+	if (strncmp(ldev->name, "GPIO", SC_NAME_LEN)) {
+		printk(KERN_ERR "Logical device %s at private space is not supported in chip %s.\n",
+		       ldev->name, dev->name);
+		return -ENODEV;
+	}
+
+	ldev->base_addr = private_base;
+	private_base += 0x10;
+
+	ldev->read = scx200_gpio_read;
+	ldev->write = scx200_gpio_write;
+	ldev->control = scx200_gpio_control;
+	ldev->activate = scx200_gpio_activate;
+
+	return 0;
+}
+
+static int scx200_activate_one_logical(struct logical_dev *ldev)
+{
+	int err, idx;
+	struct sc_dev *dev = ldev->pdev;
+	u8 active;
+
+	idx = scx200_ldev_index_by_name(ldev->name);
+	if (idx < 0) {
+		printk(KERN_INFO "Chip %s does not have logical device %s at %x.\n",
+		       dev->name, ldev->name, ldev->index);
+		return -ENODEV;
+	}
+
+	if (scx200_logical_devs[idx].id = LDEV_PRIVATE) {
+		err = scx200_find_private_device(ldev);
+		if (err)
+			return err;
+
+		printk(KERN_INFO "\t%16s - found at 0x%lx.\n", 
+				ldev->name, ldev->base_addr);
+	} else {
+		scx200_write_reg(dev, SIO_REG_LDN, ldev->index);
+		active = scx200_read_reg(dev, SIO_REG_ACTIVE);
+		if ((active & SIO_ACTIVE_EN) = 0) {
+			printk(KERN_INFO "\t%16s - not activated at %x: activating... ",
+			       ldev->name, ldev->index);
+
+			scx200_write_reg(dev, SIO_REG_ACTIVE,
+					 active | SIO_ACTIVE_EN);
+			active = scx200_read_reg(dev, SIO_REG_ACTIVE);
+			if ((active & SIO_ACTIVE_EN) = 0) {
+				printk("failed.\n");
+				return -ENODEV;
+			}
+			printk("done.\n");
+		}
+
+		ldev->base_addr = scx200_read_reg(dev, SIO_REG_IO_LSB);
+		ldev->base_addr |= (scx200_read_reg(dev, SIO_REG_IO_MSB) << 8);
+	}
+
+	err = ldev->activate(ldev);
+	if (err < 0) {
+		printk(KERN_INFO "\t%16s - not activated: ->activate() failed with error code %d.\n",
+				ldev->name, err);
+		return -ENODEV;
+	}
+
+	printk(KERN_INFO "\t%16s - activated at %x: 0x%04lx-0x%04lx\n",
+	       ldev->name, ldev->index, ldev->base_addr,
+	       ldev->base_addr + ldev->range);
+
+	return 0;
+}
+
+static int scx200_init(void)
+{
+	int err;
+
+	err = pci_module_init(&scx200_pci_driver);
+	if (err) {
+		printk(KERN_ERR "Failed to register PCI driver for device %s : err=%d.\n",
+		       scx200_pci_driver.name, err);
+		return err;
+	}
+
+	err = sc_add_sc_dev(&scx200_dev);
+	if (err)
+		return err;
+
+	printk(KERN_INFO "Driver for %s SuperIO chip.\n", scx200_dev.name);
+	return 0;
+}
+
+static void scx200_fini(void)
+{
+	sc_del_sc_dev(&scx200_dev);
+
+	while (atomic_read(&scx200_dev.refcnt))
+	{
+		printk(KERN_INFO "Waiting for %s to became free: refcnt=%d.\n",
+				scx200_dev.name, atomic_read(&scx200_dev.refcnt));
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+			
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
+
+	pci_unregister_driver(&scx200_pci_driver);
+	if (private_base)
+		release_region(private_base, SCx200_GPIO_SIZE);
+}
+
+module_init(scx200_init);
+module_exit(scx200_fini);
+
+EXPORT_SYMBOL(scx200_write_reg);
+EXPORT_SYMBOL(scx200_read_reg);
diff -Nru /tmp/empty/scx200.h linux-2.6/drivers/superio/scx200.h
--- /tmp/empty/scx200.h	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/scx200.h	2004-09-12 00:42:02.000000000 +0400
@@ -0,0 +1,28 @@
+/*
+ * 	scx200.h
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __SCX200_H
+#define __SCX200_H
+
+#define SCx200_GPIO_SIZE 	0x2c
+
+#endif /* __SCX200_H */


--
	Evgeniy Polyakov

Crash is better than data corruption. -- Artur Grabowski
-------------- next part --------------
/*
 * 	cn_test.c
 * 
 * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 * All rights reserved.
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/skbuff.h>

#include "connector.h"

static struct cb_id cn_test_id = { 0x123, 0x456 };
static char cn_test_name[] = "cn_test";
static struct sock *nls;

void cn_test_callback(void *data)
{
	struct cn_msg *msg = (struct cn_msg *)data;

	printk("%s: idx=%x, val=%x, len=%d.\n",
	       __func__, msg->id.idx, msg->id.val, msg->len);
}

static int cn_test_want_notify(void)
{
	struct cn_ctl_msg *ctl;
	struct cn_notify_req *req;
	struct cn_msg *msg = NULL;
	int size, size0;
	struct sk_buff *skb;
	struct nlmsghdr *nlh;
	u32 group = 1;

	size0 = sizeof(*msg) + sizeof(*ctl) + 3*sizeof(*req);
	
	size = NLMSG_SPACE(size0);

	skb = alloc_skb(size, GFP_ATOMIC);
	if (!skb) {
		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);

		return -ENOMEM;
	}

	nlh = NLMSG_PUT(skb, 0, 0x123, NLMSG_DONE, size - sizeof(*nlh));

	msg = (struct cn_msg *)NLMSG_DATA(nlh);

	memset(msg, 0, size0);

	msg->id.idx 	= -1;
	msg->id.val 	= -1;
	msg->seq 	= 0x123;
	msg->ack 	= 0x345;
	msg->len 	= size0 - sizeof(*msg);

	ctl = (struct cn_ctl_msg *)(msg + 1);

	ctl->idx_notify_num 	= 1;
	ctl->val_notify_num 	= 2;
	ctl->group		= group;
	ctl->len		= msg->len - sizeof(*ctl);

	req = (struct cn_notify_req *)(ctl + 1);

	/*
	 * Idx.
	 */
	req->first = cn_test_id.idx;
	req->range = 10;

	/*
	 * Val 0.
	 */
	req++;
	req->first = cn_test_id.val;
	req->range = 10;
	
	/*
	 * Val 1.
	 */
	req++;
	req->first = cn_test_id.val + 20;
	req->range = 10;
	
	NETLINK_CB(skb).dst_groups = ctl->group;
	//netlink_broadcast(nls, skb, 0, ctl->group, GFP_ATOMIC);
	netlink_unicast(nls, skb, 0, 0);

	printk(KERN_INFO "Request was sent. Group=0x%x.\n", group);
		
	return 0;

nlmsg_failure:
	printk(KERN_ERR "Failed to send %u.%u\n", msg->seq, msg->ack);
	kfree_skb(skb);
	return -EINVAL;
}

static int cn_test_init(void)
{
	int err;
	
	nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
	if (!nls) {
		printk(KERN_ERR "Failed to create new netlink socket(%u).\n", NETLINK_NFLOG);
		return -EIO;
	}

	err = cn_test_want_notify();
	if (err)
		goto err_out;

	err = cn_add_callback(&cn_test_id, cn_test_name, cn_test_callback);
	if (err)
		goto err_out;
	cn_test_id.val++;
	err = cn_add_callback(&cn_test_id, cn_test_name, cn_test_callback);
	if (err) {
		cn_del_callback(&cn_test_id);
		goto err_out;
	}

	return 0;

err_out:
	if (nls->sk_socket)
		sock_release(nls->sk_socket);

	return err;
}

static void cn_test_fini(void)
{
	cn_del_callback(&cn_test_id);
	cn_test_id.val--;
	cn_del_callback(&cn_test_id);
	if (nls->sk_socket)
		sock_release(nls->sk_socket);
}

module_init(cn_test_init);
module_exit(cn_test_fini);
-------------- next part --------------
/*
 * 	ucon.c
 *
 * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 * 
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include <asm/types.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/poll.h>

#include <linux/netlink.h>
#include <linux/rtnetlink.h>

#include <arpa/inet.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <time.h>

#include "connector.h"
#include "../soekris/sc_conn.h"

static int need_exit;
__u32 seq;

static int netlink_send(int s, char *data)
{
	struct nlmsghdr *nlh;
	unsigned int size;
	int err;
	char buf[128];
	struct cn_msg *m, *msg;
	struct sc_conn_data *cmd;

	size = NLMSG_SPACE(sizeof(struct cn_msg) + sizeof(struct sc_conn_data));

	nlh = (struct nlmsghdr *)buf;
	nlh->nlmsg_seq = seq++;
	nlh->nlmsg_pid = getpid();
	nlh->nlmsg_type = NLMSG_DONE;
	nlh->nlmsg_len = NLMSG_LENGTH(size - sizeof(*nlh));
	nlh->nlmsg_flags = 0;

	m = NLMSG_DATA(nlh);
	msg = (struct cn_msg *)data;
	cmd = (struct sc_conn_data *)(msg + 1);

	printf("%s: len=%u, seq=%u, ack=%u, "
	       "sname=%s, lname=%s, idx=0x%x, cmd=%02x [%02x.%02x.%02x].\n",
	       __func__,
	       msg->len, msg->seq, msg->ack,
	       cmd->sname,
	       cmd->lname, cmd->idx, cmd->cmd, cmd->p0, cmd->p1, cmd->p2);

	memcpy(m, data, sizeof(*m) + msg->len);

	err = send(s, nlh, size, 0);
	if (err = -1)
		fprintf(stderr, "Failed to send: %s [%d].\n",
			strerror(errno), errno);

	return err;
}

int main(int argc, char *argv[])
{
	int s;
	char buf[1024];
	int len;
	struct nlmsghdr *reply;
	struct sockaddr_nl l_local;
	struct cn_msg *data;
	struct sc_conn_data *m;
	FILE *out;
	time_t tm;
	struct pollfd pfd;

	if (argc < 2)
		out = stdout;
	else {
		out = fopen(argv[1], "a+");
		if (!out) {
			fprintf(stderr, "Unable to open %s for writing: %s\n",
				argv[1], strerror(errno));
			out = stdout;
		}
	}

	memset(buf, 0, sizeof(buf));

	s = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_NFLOG);
	if (s = -1) {
		perror("socket");
		return -1;
	}

	l_local.nl_family = AF_NETLINK;
	l_local.nl_groups = 1;
	l_local.nl_pid = getpid();

	if (bind(s, (struct sockaddr *)&l_local, sizeof(struct sockaddr_nl)) = -1) {
		perror("bind");
		close(s);
		return -1;
	}

	pfd.fd = s;

	while (!need_exit) {
		pfd.events = POLLIN;
		pfd.revents = 0;
		/*switch (poll(&pfd, 1, -1)) 
		   {
		   case 0:
		   need_exit = 1;
		   break;
		   case -1:
		   if (errno != EINTR) 
		   {
		   need_exit = 1;
		   break;
		   }
		   continue;
		   } */
		if (need_exit)
			break;

		data = (struct cn_msg *)buf;

		data->id.idx = 0xaabb;
		data->id.val = 0xccdd;
		data->seq = seq++;
		data->ack = (seq ^ 0x1234);
		data->len = sizeof(*m);

		m = (struct sc_conn_data *)(data + 1);
		memset(m, 0, sizeof(*m));

		m->cmd = SC_CMD_LDEV_READ;
		m->idx = 0xff;
		sprintf(m->sname, "PC8736X");
		sprintf(m->lname, "GPIO");

		m->p0 = 21;

		len = netlink_send(s, buf);

		len = recv(s, buf, sizeof(buf), 0);
		if (len = -1) {
			perror("recv buf");
			close(s);
			return -1;
		}
		reply = (struct nlmsghdr *)buf;

		switch (reply->nlmsg_type) {
		case NLMSG_ERROR:
			fprintf(out, "Error message received.\n");
			fflush(out);
			break;
		case NLMSG_DONE:
			data = (struct cn_msg *)NLMSG_DATA(reply);
			m = (struct sc_conn_data *)(data + 1);

			time(&tm);
			fprintf(out,
				"%.24s : [%x.%x] [seq=%u, ack=%u], sname=%s, lname=%s, idx=%u, cmd=%#02x [%#02x.%#02x.%#02x]\n",
				ctime(&tm), data->id.idx, data->id.val,
				data->seq, data->ack, m->sname, m->lname,
				m->idx, m->cmd, m->p0, m->p1, m->p2);
			fflush(out);
			break;
		default:
			break;
		}

		sleep(1);
	}

	close(s);
	return 0;
}
