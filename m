From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [NEW PATCH] Restore compatibility with 2.4 kernels
Message-Id: <20050309174933.GA9881@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Some news about the patch to restore compatibility with 2.4 kernels. I
have tested it yesterday evening, and it works as expected.

Jean and I, discussed about it on IRC. It is clear that the patch, even
if it is technically correct, is overall unclean (one lock for
two completly different things) and might imply performance loss during 
load/unload of i2c client. On the other side, it is the only way to
bring compatibility back.

We also seen that i2c_client is never initialized to 0, even in the 2.4
kernels, so Jean proposed to only add the variable for compatibility
reasons, without affecting it.

Please find attached my new patch.

Jean also remarked that the client lists is not locked in 2.4 kernels.
So there is more than one solution to address that problem:
1) Ignore the problem
2) Send the same kind of patch to Marcello
3) Lock client list with a another semaphore in the 2.4 kernel. This 
   would break again binary compatibility with i2c, but we can handle 
   that by testing the kernel version, and adding #ifdef to the code.
 
Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: kernel/i2c-core.c
=================================RCS file: /home/cvs/i2c/kernel/i2c-core.c,v
retrieving revision 1.106
diff -u -d -p -r1.106 i2c-core.c
--- kernel/i2c-core.c	22 Jan 2005 09:01:56 -0000	1.106
+++ kernel/i2c-core.c	9 Mar 2005 17:39:13 -0000
@@ -104,8 +104,7 @@ int i2c_add_adapter(struct i2c_adapter *
 	adapters[i] = adap;
 	
 	/* init data types */
-	init_MUTEX(&adap->bus);
-	init_MUTEX(&adap->list);
+	init_MUTEX(&adap->lock);
 
 	/* inform drivers of new adapters */
 	for (j=0;j<I2C_DRIVER_MAX;j++)
@@ -311,9 +310,9 @@ int i2c_check_addr (struct i2c_adapter *
 {
 	int rval;
 
-	down(&adapter->list);
+	down(&adapter->lock);
 	rval = __i2c_check_addr(adapter, addr);
-	up(&adapter->list);
+	up(&adapter->lock);
 
 	return rval;
 }
@@ -326,7 +325,7 @@ int i2c_attach_client(struct i2c_client 
 	if (i2c_check_addr(client->adapter,client->addr))
 		return -EBUSY;
 
-	down(&adapter->list);
+	down(&adapter->lock);
 	for (i = 0; i < I2C_CLIENT_MAX; i++)
 		if (NULL = adapter->clients[i])
 			break;
@@ -334,11 +333,11 @@ int i2c_attach_client(struct i2c_client 
 		printk(KERN_WARNING 
 		       " i2c-core.o: attach_client(%s) - enlarge I2C_CLIENT_MAX.\n",
 			client->name);
-		up(&adapter->list);
+		up(&adapter->lock);
 		return -ENOMEM;
 	}
 	adapter->clients[i] = client;
-	up(&adapter->list);
+	up(&adapter->lock);
 	
 	if (adapter->client_register) 
 		if (adapter->client_register(client)) 
@@ -371,7 +370,7 @@ int i2c_detach_client(struct i2c_client 
 			return res;
 		}
 
-	down(&adapter->list);
+	down(&adapter->lock);
 	for (i = 0; i < I2C_CLIENT_MAX; i++)
 		if (client = adapter->clients[i])
 			break;
@@ -379,11 +378,11 @@ int i2c_detach_client(struct i2c_client 
 		printk(KERN_WARNING " i2c-core.o: unregister_client "
 				    "[%s] not found\n",
 			client->name);
-		up(&adapter->list);
+		up(&adapter->lock);
 		return -ENODEV;
 	}
 	adapter->clients[i] = NULL;
-	up(&adapter->list);
+	up(&adapter->lock);
 
 	DEB(printk(KERN_DEBUG "i2c-core.o: client [%s] unregistered.\n",client->name));
 	return 0;
@@ -580,7 +579,7 @@ ssize_t i2cproc_bus_read(struct file * f
 	/* Order will hold the indexes of the clients
 	   sorted by address */
 	order_nr=0;
-	down(&adap->list);
+	down(&adap->lock);
 	for (j = 0; j < I2C_CLIENT_MAX; j++) {
 	    if ((client = adap->clients[j]) && 
 		(client->driver->id != I2C_DRIVERID_I2CDEV))  {
@@ -603,7 +602,7 @@ ssize_t i2cproc_bus_read(struct file * f
 			   client->name,
 			   client->driver->name);
 	}
-	up(&adap->list);
+	up(&adap->lock);
 	up(&core_lists);
 	
 	len = len - file->f_pos;
@@ -681,9 +680,9 @@ int i2c_transfer(struct i2c_adapter * ad
  	 	DEB2(printk(KERN_DEBUG "i2c-core.o: master_xfer: %s with %d msgs.\n",
 		            adap->name,num));
 
-		down(&adap->bus);
+		down(&adap->lock);
 		ret = adap->algo->master_xfer(adap,msgs,num);
-		up(&adap->bus);
+		up(&adap->lock);
 
 		return ret;
 	} else {
@@ -708,9 +707,9 @@ int i2c_master_send(struct i2c_client *c
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
 			count,client->adapter->name));
 	
-		down(&adap->bus);
+		down(&adap->lock);
 		ret = adap->algo->master_xfer(adap,&msg,1);
-		up(&adap->bus);
+		up(&adap->lock);
 
 		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
 		 * transmitted, else error code.
@@ -738,9 +737,9 @@ int i2c_master_recv(struct i2c_client *c
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: reading %d bytes on %s.\n",
 			count,client->adapter->name));
 	
-		down(&adap->bus);
+		down(&adap->lock);
 		ret = adap->algo->master_xfer(adap,&msg,1);
-		up(&adap->bus);
+		up(&adap->lock);
 	
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
 			ret, count, client->addr));
@@ -1403,10 +1402,10 @@ s32 i2c_smbus_xfer(struct i2c_adapter * 
 	}
 
 	if (adap->algo->smbus_xfer) {
-		down(&adap->bus);
+		down(&adap->lock);
 		res = adap->algo->smbus_xfer(adap,addr,flags,read_write,
 		                                command,size,data);
-		up(&adap->bus);
+		up(&adap->lock);
 	} else
 		res = i2c_smbus_xfer_emulated(adap,addr,flags,read_write,
 	                                      command,size,data);
Index: kernel/i2c.h
=================================RCS file: /home/cvs/i2c/kernel/i2c.h,v
retrieving revision 1.87
diff -u -d -p -r1.87 i2c.h
--- kernel/i2c.h	22 Jan 2005 09:04:13 -0000	1.87
+++ kernel/i2c.h	9 Mar 2005 17:39:13 -0000
@@ -237,11 +237,11 @@ struct i2c_adapter {
 			/* and can be set via the i2c_ioctl call	*/
 
 			/* data fields that are valid for all devices	*/
-	struct semaphore bus;
-	struct semaphore list;  
+	struct semaphore lock;
 	unsigned int flags;/* flags specifying div. data		*/
 
 	struct i2c_client *clients[I2C_CLIENT_MAX];
+	int client_count;
 
 	int timeout;
 	int retries;
