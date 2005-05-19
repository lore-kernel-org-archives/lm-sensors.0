From: vsu@altlinux.ru (Sergey Vlasov)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: [RFC 2.6] Rework memory allocation in i2c chip drivers
Message-Id: <20040403202042.GA3898@sirius.home>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20040403191023.08f60ff1.khali@linux-fr.org>
References: <20040403191023.08f60ff1.khali@linux-fr.org>
In-Reply-To: <20040403191023.08f60ff1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>

Hello!

> Some times ago, Ralf Roesch reported that the memory allocation scheme
> used in the i2c eeprom driver was causing trouble on MIPS architecture:
> 
> http://archives.andrew.net.au/lm-sensors/msg07233.html
> 
> The cause of the problems is that we do allocate two structures with a
> single kmalloc, which breaks alignment. This doesn't seem to be a
> problem on x86, but is on mips and probably on other architectures as
> well. It happens that all other chip drivers work the same way too, so
> they all would need to be fixed.

Instead of splitting one kmalloc in two, it would also be possible to
add a "struct i2c_client client" field to each of the *_data
structures - the compiler should align all fields appropriately.
Probably this way will result in less changes to the code (and also
less labels and less error paths).

Example patch for lm75 (untested):

--- linux/drivers/i2c/chips/lm75.c.sensors-kmalloc	2004-02-18 06:57:11 +0300
+++ linux/drivers/i2c/chips/lm75.c	2004-04-04 00:11:41 +0400
@@ -50,6 +50,7 @@
 
 /* Each client has this additional data */
 struct lm75_data {
+	struct i2c_client	client;
 	struct semaphore	update_lock;
 	char			valid;		/* !=0 if following fields are valid */
 	unsigned long		last_updated;	/* In jiffies */
@@ -141,16 +142,13 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm75_{read,write}_value. */
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct lm75_data),
-				   GFP_KERNEL))) {
+	if (!(data = kmalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(new_client, 0x00, sizeof(struct i2c_client) +
-				 sizeof(struct lm75_data));
+	memset(data, 0x00, sizeof(struct lm75_data));
 
-	data = (struct lm75_data *) (new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
@@ -204,7 +202,7 @@
 	return 0;
 
 exit_free:
-	kfree(new_client);
+	kfree(data);
 exit:
 	return err;
 }
@@ -212,7 +210,7 @@
 static int lm75_detach_client(struct i2c_client *client)
 {
 	i2c_detach_client(client);
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 

-- 
Sergey Vlasov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040404/e3cd9e60/attachment.bin
