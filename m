From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <Pine.LNX.4.53.0312231507410.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This time, with the message ;)

Patch -km-4:

Clean /proc/bus/i2c initialization.

Patch -km-5:

Forgot one use I2C_LOCK earlier in -km-3.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
-------------- next part --------------
diff -ur lk-i2c-km-4/drivers/i2c/i2c-core.c lk-i2c-km-5/drivers/i2c/i2c-core.c
--- lk-i2c-km-4/drivers/i2c/i2c-core.c	2003-12-23 14:16:38.000000000 +0200
+++ lk-i2c-km-5/drivers/i2c/i2c-core.c	2003-12-23 14:57:49.000000000 +0200
@@ -1155,20 +1155,22 @@
 }
 
 
-s32 i2c_smbus_xfer(struct i2c_adapter * adapter, u16 addr, unsigned short flags,
+s32 i2c_smbus_xfer(struct i2c_adapter * adap, u16 addr, unsigned short flags,
                    char read_write, u8 command, int size, 
                    union i2c_smbus_data * data)
 {
 	s32 res;
-	flags = flags & I2C_M_TEN;
-	if (adapter->algo->smbus_xfer) {
-		I2C_LOCK(adapter);
-		res = adapter->algo->smbus_xfer(adapter,addr,flags,read_write,
+
+	flags &= I2C_M_TEN;
+	if (adap->algo->smbus_xfer) {
+		down(&adap->bus);
+		res = adap->algo->smbus_xfer(adap,addr,flags,read_write,
 		                                command,size,data);
-		I2C_UNLOCK(adapter);
+		up(&adap->bus);
 	} else
-		res = i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
+		res = i2c_smbus_xfer_emulated(adap,addr,flags,read_write,
 	                                      command,size,data);
+
 	return res;
 }
 
-------------- next part --------------
diff -ur lk-i2c-km-3/drivers/i2c/i2c-core.c lk-i2c-km-4/drivers/i2c/i2c-core.c
--- lk-i2c-km-3/drivers/i2c/i2c-core.c	2003-12-23 14:45:22.000000000 +0200
+++ lk-i2c-km-4/drivers/i2c/i2c-core.c	2003-12-23 14:16:38.000000000 +0200
@@ -52,11 +52,6 @@
  */
 
 #ifdef CONFIG_PROC_FS
-
-static int i2cproc_init(void);
-static void i2cproc_cleanup(void);
-
-
 static ssize_t i2cproc_bus_read(struct file * file, char * buf,size_t count, 
                                 loff_t *ppos);
 static int read_bus_i2c(char *buf, char **start, off_t offset, int len,
@@ -65,16 +60,11 @@
 /* To implement the dynamic /proc/bus/i2c-? files, we need our own 
    implementation of the read hook */
 static struct file_operations i2cproc_operations = {
-	read:		i2cproc_bus_read,
+	.read		= i2cproc_bus_read,
 };
 
-
-static int i2cproc_initialized = 0;
-
-#else /* undef CONFIG_PROC_FS */
-
-#define i2cproc_init() 0
-#define i2cproc_cleanup() 0
+static int i2cproc_register(struct i2c_adapter *adap, int bus);
+static void i2cproc_remove(int bus);
 
 #endif /* CONFIG_PROC_FS */
 
@@ -91,7 +81,7 @@
  */
 int i2c_add_adapter(struct i2c_adapter *adap)
 {
-	int i,j,res;
+	int i,j,res = 0;
 
 	down(&core_lists);
 	for (i = 0; i < I2C_ADAP_MAX; i++)
@@ -104,34 +94,18 @@
 		res = -ENOMEM;
 		goto ERROR0;
 	}
+	
+#ifdef CONFIG_PROC_FS
+	res = i2cproc_register(adap, i);
+	if (res<0)
+	    goto ERROR0;
+#endif /* def CONFIG_PROC_FS */
 
 	adapters[i] = adap;
 	
 	/* init data types */
 	init_MUTEX(&adap->bus);
 	init_MUTEX(&adap->list);
-#ifdef CONFIG_PROC_FS
-
-	if (i2cproc_initialized) {
-		char name[8];
-		struct proc_dir_entry *proc_entry;
-
-		sprintf(name,"i2c-%d", i);
-
-		proc_entry = create_proc_entry(name,0,proc_bus);
-		if (! proc_entry) {
-			printk("i2c-core.o: Could not create /proc/bus/%s\n",
-			       name);
-			res = -ENOENT;
-			goto ERROR1;
-		}
-
-		proc_entry->proc_fops = &i2cproc_operations;
-		proc_entry->owner = THIS_MODULE;
-		adap->inode = proc_entry->low_ino;
-	}
-
-#endif /* def CONFIG_PROC_FS */
 
 	/* inform drivers of new adapters */
 	for (j=0;j<I2C_DRIVER_MAX;j++)
@@ -194,16 +168,13 @@
 				goto ERROR0;
 			}
 	}
+
 #ifdef CONFIG_PROC_FS
-	if (i2cproc_initialized) {
-		char name[8];
-		sprintf(name,"i2c-%d", i);
-		remove_proc_entry(name,proc_bus);
-	}
+	i2cproc_remove(i);
 #endif /* def CONFIG_PROC_FS */
 
 	adapters[i] = NULL;
-       	DEB(printk(KERN_DEBUG "i2c-core.o: adapter unregistered: %s\n",adap->name));
+	DEB(printk(KERN_DEBUG "i2c-core.o: adapter unregistered: %s\n",adap->name));
  ERROR0:
 	up(&core_lists);
 	return res;
@@ -663,41 +634,52 @@
 	return len;
 }
 
-static int __init i2cproc_init(void)
+static int i2cproc_register(struct i2c_adapter *adap, int bus)
 {
+	char name[8];
+	struct proc_dir_entry *proc_entry;
 
-	struct proc_dir_entry *proc_bus_i2c;
+	sprintf(name,"i2c-%d", bus);
+	proc_entry = create_proc_entry(name,0,proc_bus);
+	if (! proc_entry) {
+		printk(KERN_ERR "i2c-core.o: Could not create /proc/bus/%s\n",
+		       name);
+		return -ENOENT;
+	}
+	    
+	proc_entry->proc_fops = &i2cproc_operations;
+	proc_entry->owner = adap->owner;
+	adap->inode = proc_entry->low_ino;
+	return 0;
+}
 
-	i2cproc_initialized = 0;
+static void i2cproc_remove(int bus)
+{
+	char name[8];
+	sprintf(name,"i2c-%d", bus);
+	remove_proc_entry(name, proc_bus);
+}
+
+static int __init i2cproc_init(void)
+{
+	struct proc_dir_entry *proc_bus_i2c;
 
-	if (! proc_bus) {
-		printk("i2c-core.o: /proc/bus/ does not exist");
-		i2cproc_cleanup();
-		return -ENOENT;
- 	} 
 	proc_bus_i2c = create_proc_entry("i2c",0,proc_bus);
 	if (!proc_bus_i2c) {
 		printk(KERN_ERR "i2c-core.o: Could not create /proc/bus/i2c");
-		i2cproc_cleanup();
 		return -ENOENT;
  	}
+
 	proc_bus_i2c->read_proc = &read_bus_i2c;
 	proc_bus_i2c->owner = THIS_MODULE;
-	i2cproc_initialized += 2;
 	return 0;
 }
 
 static void __exit i2cproc_cleanup(void)
 {
-
-	if (i2cproc_initialized >= 1) {
-		remove_proc_entry("i2c",proc_bus);
-		i2cproc_initialized -= 2;
-	}
-	return 0;
+	remove_proc_entry("i2c",proc_bus);
 }
 
-
 #endif /* def CONFIG_PROC_FS */
 
 /* ----------------------------------------------------
@@ -1214,9 +1196,12 @@
 	memset(adapters,0,sizeof(adapters));
 	memset(drivers,0,sizeof(drivers));
 
-	i2cproc_init();
-	
+#ifdef CONFIG_PROC_FS
+	return i2cproc_init();
+#else
 	return 0;
+#endif
+
 }
 
 static void __exit i2c_exit(void) 
Only in lk-i2c-km-3/drivers/i2c: i2c-core.c.orig
