From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <Pine.LNX.4.53.0312231246500.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Patch -km-3 :

Replace use of ADAP_LOCK and DRV_LOCK with down(&core_lists).
In many cases we need both, some return path forgot UNLOCK, and locks
were claimed in varying order and sometimes not at all.

Replace use of I2C_LOCK with down(&adapter->bus).

Remove unused adapter, driver and client counts.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
-------------- next part --------------
diff -ur lk-i2c-km-2/drivers/i2c/i2c-core.c lk-i2c-km-3/drivers/i2c/i2c-core.c
--- lk-i2c-km-2/drivers/i2c/i2c-core.c	2003-12-22 23:43:33.000000000 +0200
+++ lk-i2c-km-3/drivers/i2c/i2c-core.c	2003-12-23 12:36:43.000000000 +0200
@@ -34,32 +34,14 @@
 
 /* ----- global defines ---------------------------------------------------- */
 
-/* exclusive access to the bus */
-#define I2C_LOCK(adap) down(&adap->lock)
-#define I2C_UNLOCK(adap) up(&adap->lock) 
-
-#define ADAP_LOCK()	down(&adap_lock)
-#define ADAP_UNLOCK()	up(&adap_lock)
-
-#define DRV_LOCK()	down(&driver_lock)
-#define DRV_UNLOCK()	up(&driver_lock)
-
 #define DEB(x) if (i2c_debug>=1) x;
 #define DEB2(x) if (i2c_debug>=2) x;
 
 /* ----- global variables -------------------------------------------------- */
 
-/**** lock for writing to global variables: the adapter & driver list */
-struct semaphore adap_lock;
-struct semaphore driver_lock;
-
-/**** adapter list */
+DECLARE_MUTEX(core_lists);
 static struct i2c_adapter *adapters[I2C_ADAP_MAX];
-static int adap_count;
-
-/**** drivers list */
 static struct i2c_driver *drivers[I2C_DRIVER_MAX];
-static int driver_count;
 
 /**** debug level */
 static int i2c_debug=1;
@@ -111,7 +93,7 @@
 {
 	int i,j,res;
 
-	ADAP_LOCK();
+	down(&core_lists);
 	for (i = 0; i < I2C_ADAP_MAX; i++)
 		if (NULL = adapters[i])
 			break;
@@ -124,12 +106,10 @@
 	}
 
 	adapters[i] = adap;
-	adap_count++;
-	ADAP_UNLOCK();
 	
 	/* init data types */
-	init_MUTEX(&adap->lock);
-
+	init_MUTEX(&adap->bus);
+	init_MUTEX(&adap->list);
 #ifdef CONFIG_PROC_FS
 
 	if (i2cproc_initialized) {
@@ -154,36 +134,25 @@
 #endif /* def CONFIG_PROC_FS */
 
 	/* inform drivers of new adapters */
-	DRV_LOCK();	
 	for (j=0;j<I2C_DRIVER_MAX;j++)
 		if (drivers[j]!=NULL && 
 		    (drivers[j]->flags&(I2C_DF_NOTIFY|I2C_DF_DUMMY)))
 			/* We ignore the return code; if it fails, too bad */
 			drivers[j]->attach_adapter(adap);
-	DRV_UNLOCK();
 	
 	DEB(printk(KERN_DEBUG "i2c-core.o: adapter %s registered as adapter %d.\n",
 	           adap->name,i));
-
-	return 0;	
-
-
-ERROR1:
-	ADAP_LOCK();
-	adapters[i] = NULL;
-	adap_count--;
-ERROR0:
-	ADAP_UNLOCK();
+ ERROR0:
+	up(&core_lists);
 	return res;
 }
 
 
 int i2c_del_adapter(struct i2c_adapter *adap)
 {
-	int i,j,res;
-
-	ADAP_LOCK();
+	int i,j, res=0;
 
+	down(&core_lists);
 	for (i = 0; i < I2C_ADAP_MAX; i++)
 		if (adap = adapters[i])
 			break;
@@ -199,17 +168,14 @@
 	 * *detach* it! Of course, each dummy driver should know about
 	 * this or hell will break loose...
 	 */
-	DRV_LOCK();
 	for (j = 0; j < I2C_DRIVER_MAX; j++) 
 		if (drivers[j] && (drivers[j]->flags & I2C_DF_DUMMY))
 			if ((res = drivers[j]->attach_adapter(adap))) {
 				printk(KERN_WARNING "i2c-core.o: can't detach adapter %s "
 				       "while detaching driver %s: driver not "
 				       "detached!",adap->name,drivers[j]->name);
-				goto ERROR1;	
+				goto ERROR0;
 			}
-	DRV_UNLOCK();
-
 
 	/* detach any active clients. This must be done first, because
 	 * it can fail; in which case we give upp. */
@@ -237,17 +203,9 @@
 #endif /* def CONFIG_PROC_FS */
 
 	adapters[i] = NULL;
-	adap_count--;
-	
-	ADAP_UNLOCK();	
-	DEB(printk(KERN_DEBUG "i2c-core.o: adapter unregistered: %s\n",adap->name));
-	return 0;
-
-ERROR0:
-	ADAP_UNLOCK();
-	return res;
-ERROR1:
-	DRV_UNLOCK();
+       	DEB(printk(KERN_DEBUG "i2c-core.o: adapter unregistered: %s\n",adap->name));
+ ERROR0:
+	up(&core_lists);
 	return res;
 }
 
@@ -261,7 +219,8 @@
 int i2c_add_driver(struct i2c_driver *driver)
 {
 	int i;
-	DRV_LOCK();
+
+	down(&core_lists);
 	for (i = 0; i < I2C_DRIVER_MAX; i++)
 		if (NULL = drivers[i])
 			break;
@@ -270,19 +229,12 @@
 		       " i2c-core.o: register_driver(%s) "
 		       "- enlarge I2C_DRIVER_MAX.\n",
 			driver->name);
-		DRV_UNLOCK();
+		up(&core_lists);
 		return -ENOMEM;
 	}
-
-	drivers[i] = driver;
-	driver_count++;
-	
-	DRV_UNLOCK();	/* driver was successfully added */
-	
+	drivers[i] = driver;	
 	DEB(printk(KERN_DEBUG "i2c-core.o: driver %s registered.\n",driver->name));
 	
-	ADAP_LOCK();
-
 	/* now look for instances of driver on our adapters
 	 */
 	if (driver->flags& (I2C_DF_NOTIFY|I2C_DF_DUMMY)) {
@@ -291,15 +243,15 @@
 				/* Ignore errors */
 				driver->attach_adapter(adapters[i]);
 	}
-	ADAP_UNLOCK();
+	up(&core_lists);
 	return 0;
 }
 
 int i2c_del_driver(struct i2c_driver *driver)
 {
-	int i,j,k,res;
+	int i,j,k,res = 0;
 
-	DRV_LOCK();
+	down(&core_lists);
 	for (i = 0; i < I2C_DRIVER_MAX; i++)
 		if (driver = drivers[i])
 			break;
@@ -307,7 +259,7 @@
 		printk(KERN_WARNING " i2c-core.o: unregister_driver: "
 				    "[%s] not found\n",
 			driver->name);
-		DRV_UNLOCK();
+		up(&core_lists);
 		return -ENODEV;
 	}
 	/* Have a look at each adapter, if clients of this driver are still
@@ -319,7 +271,6 @@
 	 * invalid operation might (will!) result, when using stale client
 	 * pointers.
 	 */
-	ADAP_LOCK(); /* should be moved inside the if statement... */
 	for (k=0;k<I2C_ADAP_MAX;k++) {
 		struct i2c_adapter *adap = adapters[k];
 		if (adap = NULL) /* skip empty entries. */
@@ -338,8 +289,7 @@
 				       "not be detached properly; driver "
 				       "not unloaded!",driver->name,
 				       adap->name);
-				ADAP_UNLOCK();
-				return res;
+				goto ERROR0;
 			}
 		} else {
 			for (j=0;j<I2C_CLIENT_MAX;j++) { 
@@ -362,31 +312,41 @@
 						       driver->name,
 						       client->addr,
 						       adap->name);
-						ADAP_UNLOCK();
-						return res;
+						goto ERROR0;
 					}
 				}
 			}
 		}
 	}
-	ADAP_UNLOCK();
 	drivers[i] = NULL;
-	driver_count--;
-	DRV_UNLOCK();
-	
 	DEB(printk(KERN_DEBUG "i2c-core.o: driver unregistered: %s\n",driver->name));
-	return 0;
+
+ ERROR0:
+	up(&core_lists);
+	return res;
 }
 
-int i2c_check_addr (struct i2c_adapter *adapter, int addr)
+static int __i2c_check_addr (struct i2c_adapter *adapter, int addr)
 {
 	int i;
 	for (i = 0; i < I2C_CLIENT_MAX ; i++) 
 		if (adapter->clients[i] && (adapter->clients[i]->addr = addr))
 			return -EBUSY;
+
 	return 0;
 }
 
+int i2c_check_addr (struct i2c_adapter *adapter, int addr)
+{
+	int rval;
+
+	down(&adapter->list);
+	rval = __i2c_check_addr(adapter, addr);
+	up(&adapter->list);
+
+	return rval;
+}
+
 int i2c_attach_client(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
@@ -395,6 +355,7 @@
 	if (i2c_check_addr(client->adapter,client->addr))
 		return -EBUSY;
 
+	down(&adapter->list);
 	for (i = 0; i < I2C_CLIENT_MAX; i++)
 		if (NULL = adapter->clients[i])
 			break;
@@ -402,11 +363,11 @@
 		printk(KERN_WARNING 
 		       " i2c-core.o: attach_client(%s) - enlarge I2C_CLIENT_MAX.\n",
 			client->name);
+		up(&adapter->list);
 		return -ENOMEM;
 	}
-
 	adapter->clients[i] = client;
-	adapter->client_count++;
+	up(&adapter->list);
 	
 	if (adapter->client_register) 
 		if (adapter->client_register(client)) 
@@ -428,16 +389,6 @@
 	struct i2c_adapter *adapter = client->adapter;
 	int i,res;
 
-	for (i = 0; i < I2C_CLIENT_MAX; i++)
-		if (client = adapter->clients[i])
-			break;
-	if (I2C_CLIENT_MAX = i) {
-		printk(KERN_WARNING " i2c-core.o: unregister_client "
-				    "[%s] not found\n",
-			client->name);
-		return -ENODEV;
-	}
-	
 	if( (client->flags & I2C_CLIENT_ALLOW_USE) && 
 	    (client->usage_count>0))
 		return -EBUSY;
@@ -449,8 +400,19 @@
 			return res;
 		}
 
+	down(&adapter->list);
+	for (i = 0; i < I2C_CLIENT_MAX; i++)
+		if (client = adapter->clients[i])
+			break;
+	if (I2C_CLIENT_MAX = i) {
+		printk(KERN_WARNING " i2c-core.o: unregister_client "
+				    "[%s] not found\n",
+			client->name);
+		up(&adapter->list);
+		return -ENODEV;
+	}
 	adapter->clients[i] = NULL;
-	adapter->client_count--;
+	up(&adapter->list);
 
 	DEB(printk(KERN_DEBUG "i2c-core.o: client [%s] unregistered.\n",client->name));
 	return 0;
@@ -482,6 +444,7 @@
 		client->adapter->dec_use(client->adapter);
 }
 
+#if 0 /* just forget about this for now --km */
 struct i2c_client *i2c_get_client(int driver_id, int adapter_id, 
 					struct i2c_client *prev)
 {
@@ -548,6 +511,7 @@
 
 	return 0;
 }
+#endif
 
 int i2c_use_client(struct i2c_client *client)
 {
@@ -598,6 +562,7 @@
 	int i;
 	int nr = 0;
 	/* Note that it is safe to write a `little' beyond len. Yes, really. */
+	down(&core_lists);
 	for (i = 0; (i < I2C_ADAP_MAX) && (nr < len); i++)
 		if (adapters[i]) {
 			nr += sprintf(buf+nr, "i2c-%d\t", i);
@@ -614,6 +579,7 @@
 			              adapters[i]->name,
 			              adapters[i]->algo->name);
 		}
+	up(&core_lists);
 	return nr;
 }
 
@@ -624,61 +590,77 @@
 	struct inode * inode = file->f_dentry->d_inode;
 	char *kbuf;
 	struct i2c_client *client;
+	struct i2c_adapter *adap;
 	int i,j,k,order_nr,len=0;
 	size_t len_total;
 	int order[I2C_CLIENT_MAX];
+#define OUTPUT_LENGTH_PER_LINE 70
 
-	if (count > 4000)
-		return -EINVAL; 
 	len_total = file->f_pos + count;
-	/* Too bad if this gets longer (unlikely) */
-	if (len_total > 4000)
-		len_total = 4000;
-	for (i = 0; i < I2C_ADAP_MAX; i++)
-		if (adapters[i]->inode = inode->i_ino) {
-		/* We need a bit of slack in the kernel buffer; this makes the
-		   sprintf safe. */
-			if (! (kbuf = kmalloc(count + 80,GFP_KERNEL)))
-				return -ENOMEM;
-			/* Order will hold the indexes of the clients
-			   sorted by address */
-			order_nr=0;
-			for (j = 0; j < I2C_CLIENT_MAX; j++) {
-				if ((client = adapters[i]->clients[j]) && 
-				    (client->driver->id != I2C_DRIVERID_I2CDEV))  {
-					for(k = order_nr; 
-					    (k > 0) && 
-					    adapters[i]->clients[order[k-1]]->
-					             addr > client->addr; 
-					    k--)
-						order[k] = order[k-1];
-					order[k] = j;
-					order_nr++;
-				}
-			}
+	if (len_total > (I2C_CLIENT_MAX * OUTPUT_LENGTH_PER_LINE) )
+		/* adjust to maximum file size */
+		len_total = (I2C_CLIENT_MAX * OUTPUT_LENGTH_PER_LINE);
+
+	down(&core_lists);
+	/* adap = file->private_data; ?? --km */
+	for (i = 0; i < I2C_ADAP_MAX; i++) {
+	    adap = adapters[i];
+	    if (adap && (adap->inode = inode->i_ino))
+		break;
+	}
+	if ( I2C_ADAP_MAX = i ) {
+	    up(&core_lists);
+	    return -ENOENT;
+	}
+
+	/* We need a bit of slack in the kernel buffer; this makes the
+	   sprintf safe. */
+	if (! (kbuf = kmalloc(len_total +
+			      OUTPUT_LENGTH_PER_LINE,
+			      GFP_KERNEL)))
+	    return -ENOMEM;
+
+	/* Order will hold the indexes of the clients
+	   sorted by address */
+	order_nr=0;
+	down(&adap->list);
+	for (j = 0; j < I2C_CLIENT_MAX; j++) {
+	    if ((client = adap->clients[j]) && 
+		(client->driver->id != I2C_DRIVERID_I2CDEV))  {
+		for(k = order_nr; 
+		    (k > 0) && 
+			adap->clients[order[k-1]]->
+			addr > client->addr; 
+		    k--)
+		    order[k] = order[k-1];
+		order[k] = j;
+		order_nr++;
+	    }
+	}
 
 
-			for (j = 0; (j < order_nr) && (len < len_total); j++) {
-				client = adapters[i]->clients[order[j]];
-				len += sprintf(kbuf+len,"%02x\t%-32s\t%-32s\n",
-				              client->addr,
-				              client->name,
-				              client->driver->name);
-			}
-			len = len - file->f_pos;
-			if (len > count)
-				len = count;
-			if (len < 0) 
-				len = 0;
-			if (copy_to_user (buf,kbuf+file->f_pos, len)) {
-				kfree(kbuf);
-				return -EFAULT;
-			}
-			file->f_pos += len;
-			kfree(kbuf);
-			return len;
-		}
-	return -ENOENT;
+	for (j = 0; (j < order_nr) && (len < len_total); j++) {
+	    client = adap->clients[order[j]];
+	    len += sprintf(kbuf+len,"%02x\t%-32s\t%-32s\n",
+			   client->addr,
+			   client->name,
+			   client->driver->name);
+	}
+	up(&adap->list);
+	up(&core_lists);
+	
+	len = len - file->f_pos;
+	if (len > count)
+	    len = count;
+	if (len < 0) 
+	    len = 0;
+	if (copy_to_user (buf,kbuf+file->f_pos, len)) {
+	    kfree(kbuf);
+	    return -EFAULT;
+	}
+	file->f_pos += len;
+	kfree(kbuf);
+	return len;
 }
 
 static int __init i2cproc_init(void)
@@ -731,9 +713,9 @@
  	 	DEB2(printk(KERN_DEBUG "i2c-core.o: master_xfer: %s with %d msgs.\n",
 		            adap->name,num));
 
-		I2C_LOCK(adap);
+		down(&adap->bus);
 		ret = adap->algo->master_xfer(adap,msgs,num);
-		I2C_UNLOCK(adap);
+		up(&adap->bus);
 
 		return ret;
 	} else {
@@ -758,9 +740,9 @@
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
 			count,client->adapter->name));
 	
-		I2C_LOCK(adap);
+		down(&adap->bus);
 		ret = adap->algo->master_xfer(adap,&msg,1);
-		I2C_UNLOCK(adap);
+		up(&adap->bus);
 
 		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
 		 * transmitted, else error code.
@@ -788,9 +770,9 @@
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: reading %d bytes on %s.\n",
 			count,client->adapter->name));
 	
-		I2C_LOCK(adap);
+		down(&adap->bus);
 		ret = adap->algo->master_xfer(adap,&msg,1);
-		I2C_UNLOCK(adap);
+		up(&adap->bus);
 	
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
 			ret, count, client->addr));
@@ -1231,12 +1213,7 @@
 	printk(KERN_INFO "i2c-core.o: i2c core module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	memset(adapters,0,sizeof(adapters));
 	memset(drivers,0,sizeof(drivers));
-	adap_count=0;
-	driver_count=0;
 
-	init_MUTEX(&adap_lock);
-	init_MUTEX(&driver_lock);
-	
 	i2cproc_init();
 	
 	return 0;
Only in lk-i2c-km-3/drivers/i2c: i2c-core.c~
diff -ur lk-i2c-km-2/include/linux/i2c.h lk-i2c-km-3/include/linux/i2c.h
--- lk-i2c-km-2/include/linux/i2c.h	2003-12-23 00:41:41.000000000 +0200
+++ lk-i2c-km-3/include/linux/i2c.h	2003-12-23 12:33:15.000000000 +0200
@@ -235,11 +235,11 @@
 			/* and can be set via the i2c_ioctl call	*/
 
 			/* data fields that are valid for all devices	*/
-	struct semaphore lock;  
+	struct semaphore bus;
+	struct semaphore list;  
 	unsigned int flags;/* flags specifying div. data		*/
 
 	struct i2c_client *clients[I2C_CLIENT_MAX];
-	int client_count;
 
 	int timeout;
 	int retries;
Only in lk-i2c-km-3/include/linux: i2c.h~
