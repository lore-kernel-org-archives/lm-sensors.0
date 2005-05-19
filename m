From: ladis@linux-mips.org (Ladislav Michl)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] ds1337 3/3
Message-Id: <20050504061438.GD1439@orphique>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050407231848.GD27226@orphique> <u5mZNEX1.1112954918.3200720.khali@localhost> <20050408130639.GC7054@orphique> <20050502204136.GE32713@kroah.com>
In-Reply-To: <20050502204136.GE32713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>

Chip is searched by bus number rather than its own proprietary id.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: James Chapman <jchapman@katalix.com>

--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-04-20 20:34:31.622721568 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-04-20 20:50:05.043819992 +0200
@@ -69,13 +69,11 @@
 struct ds1337_data {
 	struct i2c_client client;
 	struct list_head list;
-	int id;
 };
 
 /*
  * Internal variables
  */
-static int ds1337_id;
 static LIST_HEAD(ds1337_clients);
 
 static inline int ds1337_read(struct i2c_client *client, u8 reg, u8 *value)
@@ -213,7 +211,7 @@
  * Public API for access to specific device. Useful for low-level
  * RTC access from kernel code.
  */
-int ds1337_do_command(int id, int cmd, void *arg)
+int ds1337_do_command(int bus, int cmd, void *arg)
 {
 	struct list_head *walk;
 	struct list_head *tmp;
@@ -221,7 +219,7 @@
 
 	list_for_each_safe(walk, tmp, &ds1337_clients) {
 		data = list_entry(walk, struct ds1337_data, list);
-		if (data->id = id)
+		if (data->client.adapter->nr = bus)
 			return ds1337_command(&data->client, cmd, arg);
 	}
 
@@ -331,7 +329,6 @@
 	ds1337_init_client(new_client);
 
 	/* Add client to local list */
-	data->id = ds1337_id++;
 	list_add(&data->list, &ds1337_clients);
 
 	return 0;
