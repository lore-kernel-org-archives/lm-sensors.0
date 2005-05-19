From: dtor_core@ameritech.net (Dmitry Torokhov)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: [RFC/PATCH 6/22] W1: drop owner field from master and slave
Message-Id: <200504210213.01427.dtor_core@ameritech.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@Stimpy.netroedge.com
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>

W1: drop owner field from w1_master and w1_slave structures.
    Just having it there does not magically fixes lifetime
    rules.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c     |    1 -
 w1.h     |    2 --
 w1_int.c |    1 -
 3 files changed, 4 deletions(-)

Index: dtor/drivers/w1/w1_int.c
=================================--- dtor.orig/drivers/w1/w1_int.c
+++ dtor/drivers/w1/w1_int.c
@@ -60,7 +60,6 @@ struct w1_master * w1_alloc_dev(u32 id, 
 
 	dev->bus_master = (struct w1_bus_master *)(dev + 1);
 
-	dev->owner		= THIS_MODULE;
 	dev->max_slave_count	= slave_count;
 	dev->slave_count	= 0;
 	dev->attempts		= 0;
Index: dtor/drivers/w1/w1.c
=================================--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -407,7 +407,6 @@ static int w1_attach_slave_device(struct
 
 	memset(sl, 0, sizeof(*sl));
 
-	sl->owner = THIS_MODULE;
 	sl->master = dev;
 	set_bit(W1_SLAVE_ACTIVE, &sl->flags);
 
Index: dtor/drivers/w1/w1.h
=================================--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -64,7 +64,6 @@ struct w1_reg_num
 
 struct w1_slave
 {
-	struct module		*owner;
 	unsigned char		name[W1_MAXNAMELEN];
 	struct list_head	node;
 	struct w1_reg_num	reg_num;
@@ -108,7 +107,6 @@ struct w1_bus_master
 struct w1_master
 {
 	struct list_head	node;
-	struct module		*owner;
 	unsigned char		name[W1_MAXNAMELEN];
 	struct list_head	slist;
 	int			max_slave_count, slave_count;
