From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Thu, 02 Jun 2005 19:10:59 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] w1 search cleanup
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9076C1EA@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

While writing a driver for the DS2482 (an i2c to w1 bridge),=20
I made a few enhancements to the w1 subsystem.

1.
I added a new I/O function: triplet
A triplet reads two bits and writes a direction bit.  The DS2482
implements this in hardware.
I modified w1_search() to use w1_triplet() at its core.

2.
I cleaned up the I/O functions to separate emulated vs native w1
support.
A w1 bus master must be able to do one of:
  a. Set and sample the line via write_bit() and read_bit()
  b. Support reset_bus() and touch_bit()
Function set (a) is only needed for emulated devices (ie, a parallel
port).
I hid w1_read_bit() and w1_write_bit() behind w1_touch_bit(), and
changed functions to call touch_bit() instead or read/write_bit().
=20
3.=20
Searching is fairly slow - it requires about 200 w1 bit cycles per
device, multiplied by the number of devices on the bus.
I modified the w1_process() to NOT periodically search the bus.
A sysfs entry was added to request a search. (w1_master_search).
To request a search, echo anything into w1_master_search and it'll run
another search.

4.
I added a default family so that a slave device will get reported even
if there isn't a driver for that family.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
-------------- next part --------------
diff -Naur linux-2.6.12-rc5-mm2-clean/drivers/w1/w1.c linux-2.6.12-rc5-mm2/=
drivers/w1/w1.c
--- linux-2.6.12-rc5-mm2-clean/drivers/w1/w1.c	2005-06-01 14:29:28.00000000=
0 -0500
+++ linux-2.6.12-rc5-mm2/drivers/w1/w1.c	2005-06-02 09:59:29.101279854 -0500
@@ -59,6 +59,19 @@
 static int control_needs_exit;
 static DECLARE_COMPLETION(w1_control_complete);
=20
+/* stuff for the default family */
+static ssize_t w1_famdefault_read_name(struct device *dev, struct device_a=
ttribute *attr, char *buf)
+{
+	struct w1_slave *sl =3D container_of(dev, struct w1_slave, dev);
+	return(sprintf(buf, "%s\n", sl->name));
+}
+static struct w1_family_ops w1_default_fops =3D {
+	.rname =3D &w1_famdefault_read_name,
+};
+static struct w1_family w1_default_family =3D {
+	.fops =3D &w1_default_fops,
+};
+
 static int w1_master_match(struct device *dev, struct device_driver *drv)
 {
 	return 1;
@@ -135,7 +148,7 @@
=20
 static ssize_t w1_master_attribute_show_name(struct device *dev, struct de=
vice_attribute *attr, char *buf)
 {
-	struct w1_master *md =3D container_of (dev, struct w1_master, dev);
+	struct w1_master *md =3D container_of(dev, struct w1_master, dev);
 	ssize_t count;
=20
 	if (down_interruptible (&md->mutex))
@@ -148,6 +161,22 @@
 	return count;
 }
=20
+static ssize_t w1_master_attribute_store_search(struct device * dev,=20
+						struct device_attribute *attr,
+						const char * buf, size_t count)
+{
+	struct w1_master *md =3D container_of(dev, struct w1_master, dev);
+
+	if (down_interruptible (&md->mutex))
+		return -EBUSY;
+
+	md->search_type =3D W1_SEARCH;
+
+	up(&md->mutex);
+
+	return count;
+}
+
 static ssize_t w1_master_attribute_show_pointer(struct device *dev, struct=
 device_attribute *attr, char *buf)
 {
 	struct w1_master *md =3D container_of(dev, struct w1_master, dev);
@@ -212,7 +241,6 @@
 }
=20
 static ssize_t w1_master_attribute_show_slaves(struct device *dev, struct =
device_attribute *attr, char *buf)
-
 {
 	struct w1_master *md =3D container_of(dev, struct w1_master, dev);
 	int c =3D PAGE_SIZE;
@@ -243,6 +271,11 @@
 		__ATTR(w1_master_##_name, _mode,		\
 		       w1_master_attribute_show_##_name, NULL)
=20
+#define W1_MASTER_ATTR_WO(_name, _mode)				\
+	struct device_attribute w1_master_attribute_##_name =3D	\
+		__ATTR(w1_master_##_name, _mode,		\
+		       NULL, w1_master_attribute_store_##_name)
+
 static W1_MASTER_ATTR_RO(name, S_IRUGO);
 static W1_MASTER_ATTR_RO(slaves, S_IRUGO);
 static W1_MASTER_ATTR_RO(slave_count, S_IRUGO);
@@ -251,6 +284,8 @@
 static W1_MASTER_ATTR_RO(timeout, S_IRUGO);
 static W1_MASTER_ATTR_RO(pointer, S_IRUGO);
=20
+static W1_MASTER_ATTR_WO(search, S_IWUGO);
+
 static struct attribute *w1_master_default_attrs[] =3D {
 	&w1_master_attribute_name.attr,
 	&w1_master_attribute_slaves.attr,
@@ -259,6 +294,7 @@
 	&w1_master_attribute_attempts.attr,
 	&w1_master_attribute_timeout.attr,
 	&w1_master_attribute_pointer.attr,
+	&w1_master_attribute_search.attr,
 	NULL
 };
=20
@@ -286,9 +322,9 @@
 	sl->dev.release =3D &w1_slave_release;
=20
 	snprintf(&sl->dev.bus_id[0], sizeof(sl->dev.bus_id),
-		  "%02x-%012llx",
-		  (unsigned int) sl->reg_num.family,
-		  (unsigned long long) sl->reg_num.id);
+		 "%02x-%012llx",
+		 (unsigned int) sl->reg_num.family,
+		 (unsigned long long) sl->reg_num.id);
 	snprintf (&sl->name[0], sizeof(sl->name),
 		  "%02x-%012llx",
 		  (unsigned int) sl->reg_num.family,
@@ -300,8 +336,8 @@
 	err =3D device_register(&sl->dev);
 	if (err < 0) {
 		dev_err(&sl->dev,
-			 "Device registration [%s] failed. err=3D%d\n",
-			 sl->dev.bus_id, err);
+			"Device registration [%s] failed. err=3D%d\n",
+			sl->dev.bus_id, err);
 		return err;
 	}
=20
@@ -314,22 +350,23 @@
 	err =3D device_create_file(&sl->dev, &sl->attr_name);
 	if (err < 0) {
 		dev_err(&sl->dev,
-			 "sysfs file creation for [%s] failed. err=3D%d\n",
-			 sl->dev.bus_id, err);
+			"sysfs file creation for [%s] failed. err=3D%d\n",
+			sl->dev.bus_id, err);
 		device_unregister(&sl->dev);
 		return err;
 	}
=20
-	err =3D sysfs_create_bin_file(&sl->dev.kobj, &sl->attr_bin);
-	if (err < 0) {
-		dev_err(&sl->dev,
-			 "sysfs file creation for [%s] failed. err=3D%d\n",
-			 sl->dev.bus_id, err);
-		device_remove_file(&sl->dev, &sl->attr_name);
-		device_unregister(&sl->dev);
-		return err;
+	if ( sl->attr_bin.read ) {
+		err =3D sysfs_create_bin_file(&sl->dev.kobj, &sl->attr_bin);
+		if (err < 0) {
+			dev_err(&sl->dev,
+				"sysfs file creation for [%s] failed. err=3D%d\n",
+				sl->dev.bus_id, err);
+			device_remove_file(&sl->dev, &sl->attr_name);
+			device_unregister(&sl->dev);
+			return err;
+		}
 	}
-
 	list_add_tail(&sl->w1_slave_entry, &sl->master->slist);
=20
 	return 0;
@@ -363,12 +400,13 @@
 	spin_lock(&w1_flock);
 	f =3D w1_family_registered(rn->family);
 	if (!f) {
-		spin_unlock(&w1_flock);
-		dev_info(&dev->dev, "Family %x for %02x.%012llx.%02x is not registered.\=
n",
+		f=3D &w1_default_family;
+//		spin_unlock(&w1_flock);
+		dev_info(&dev->dev, "Family %x for %02x.%012llx.%02x is not registered, =
using default.\n",
 			  rn->family, rn->family,
 			  (unsigned long long)rn->id, rn->crc);
-		kfree(sl);
-		return -ENODEV;
+//		kfree(sl);
+//		return -ENODEV;
 	}
 	__w1_family_get(f);
 	spin_unlock(&w1_flock);
@@ -409,7 +447,9 @@
 			flush_signals(current);
 	}
=20
-	sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
+	if ( sl->attr_bin.read ) {
+		sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
+	}
 	device_remove_file(&sl->dev, &sl->attr_name);
 	device_unregister(&sl->dev);
 	w1_family_put(sl->family);
@@ -483,26 +523,40 @@
 	atomic_dec(&dev->refcnt);
 }
=20
-void w1_search(struct w1_master *dev)
-{
-	u64 last, rn, tmp;
-	int i, count =3D 0;
-	int last_family_desc, last_zero, last_device;
-	int search_bit, id_bit, comp_bit, desc_bit;
-
-	search_bit =3D id_bit =3D comp_bit =3D 0;
-	rn =3D tmp =3D last =3D 0;
-	last_device =3D last_zero =3D last_family_desc =3D 0;
+/**
+ * Performs a ROM Search & registers any devices found.
+ * The 1-wire search is a simple binary tree search.
+ * For each bit of the address, we read two bits and write one bit.
+ * The bit written will put to sleep all devies that don't match that bit.
+ * When the two reads differ, the direction choice is obvious.
+ * When both bits are 0, we must choose a path to take.
+ * When we can scan all 64 bits without having to choose a path, we are do=
ne.
+ *=20
+ * See "Application note 187 1-wire search algorithm" at www.maxim-ic.com
+ *=20
+ * @dev        The master device to search
+ * @search_cmd W1_SEARCH or W1_CONDITIONAL_SEARCH
+ * @cb         Function to call when a device is found
+ */
+void w1_search(struct w1_master *dev, u8 search_cmd, w1_slave_found_callba=
ck cb)
+{
+	u64 last_rn, rn, tmp64;
+	int i, slave_count =3D 0;
+	int last_zero, last_device;
+	int search_bit, desc_bit;
+	u8  triplet_ret =3D 0;
+
+	search_bit =3D 0;
+	rn =3D last_rn =3D 0;
+	last_device =3D 0;
+	last_zero =3D -1;
=20
 	desc_bit =3D 64;
=20
-	while (!(id_bit && comp_bit) && !last_device &&
-	       count++ < dev->max_slave_count) {
-		last =3D rn;
+	while ( !last_device && (slave_count++ < dev->max_slave_count) ) {
+		last_rn =3D rn;
 		rn =3D 0;
=20
-		last_family_desc =3D 0;
-
 		/*
 		 * Reset bus and all 1-wire device state machines
 		 * so they can respond to our requests.
@@ -514,59 +568,39 @@
 			break;
 		}
=20
-#if 1
-		w1_write_8(dev, W1_SEARCH);
+		/* Start the search */
+		w1_write_8(dev, search_cmd);
 		for (i =3D 0; i < 64; ++i) {
-			/*
-			 * Read 2 bits from bus.
-			 * All who don't sleep must send ID bit and COMPLEMENT ID bit.
-			 * They actually are ANDed between all senders.
-			 */
-			id_bit =3D w1_touch_bit(dev, 1);
-			comp_bit =3D w1_touch_bit(dev, 1);
-
-			if (id_bit && comp_bit)
-				break;
-
-			if (id_bit =3D 0 && comp_bit =3D 0) {
-				if (i =3D desc_bit)
-					search_bit =3D 1;
-				else if (i > desc_bit)
-					search_bit =3D 0;
-				else
-					search_bit =3D ((last >> i) & 0x1);
-
-				if (search_bit =3D 0) {
-					last_zero =3D i;
-					if (last_zero < 9)
-						last_family_desc =3D last_zero;
-				}
-
-			} else
-				search_bit =3D id_bit;
-
-			tmp =3D search_bit;
-			rn |=3D (tmp << i);
-
-			/*
-			 * Write 1 bit to bus
-			 * and make all who don't have "search_bit" in "i"'th position
-			 * in it's registration number sleep.
-			 */
-			if (dev->bus_master->touch_bit)
-				w1_touch_bit(dev, search_bit);
+			/* Determine the direction/search bit */
+			if (i =3D desc_bit)
+				search_bit =3D 1;	  /* took the 0 path last time, so take the 1 path */
+			else if (i > desc_bit)
+				search_bit =3D 0;	  /* take the 0 path on the next branch */
 			else
-				w1_write_bit(dev, search_bit);
+				search_bit =3D ((last_rn >> i) & 0x1);
=20
-		}
-#endif
+			/** Read two bits and write one bit */
+			triplet_ret =3D w1_triplet(dev, search_bit);
=20
-		if (desc_bit =3D last_zero)
-			last_device =3D 1;
+			/* quit if no device responded */
+			if ( (triplet_ret & 0x03) =3D 0x03 )
+				break;
=20
-		desc_bit =3D last_zero;
+			/* If both directions were valid, and we took the 0 path... */
+			if (triplet_ret =3D 0)
+				last_zero =3D i;
+
+			/* extract the direction taken & update the device number */
+			tmp64 =3D (triplet_ret >> 2);
+			rn |=3D (tmp64 << i);
+		}
=20
-		w1_slave_found(dev->bus_master->data, rn);
+		if ( (triplet_ret & 0x03) !=3D 0x03 ) {
+			if ( (desc_bit =3D last_zero) || (last_zero < 0))
+				last_device =3D 1;
+			desc_bit =3D last_zero;
+			cb(dev->bus_master->data, rn);
+		}
 	}
 }
=20
@@ -634,6 +668,7 @@
 {
 	struct w1_master *dev =3D (struct w1_master *) data;
 	struct w1_slave *sl, *sln;
+	unsigned long bit_num;
=20
 	daemonize("%s", dev->name);
 	allow_signal(SIGTERM);
@@ -651,13 +686,18 @@
 		if (!dev->initialized)
 			continue;
=20
+		if (dev->search_type =3D 0)
+			continue;
+
+		bit_num =3D (dev->search_type =3D W1_SEARCH) ? W1_SLAVE_ACTIVE : W1_SLAV=
E_ALARM;
+
 		if (down_interruptible(&dev->mutex))
 			continue;
=20
 		list_for_each_entry(sl, &dev->slist, w1_slave_entry)
-				clear_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
+				clear_bit(bit_num, (long *)&sl->flags);
=20
-		w1_search_devices(dev, w1_slave_found);
+		w1_search_devices(dev, dev->search_type, w1_slave_found);
=20
 		list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
 			if (!test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags) && !--sl->t=
tl) {
@@ -670,6 +710,9 @@
 			} else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
 				sl->ttl =3D dev->slave_ttl;
 		}
+	=09
+		dev->search_type =3D 0;
+
 		up(&dev->mutex);
 	}
=20
@@ -727,6 +770,7 @@
 		__w1_remove_master_device(dev);
=20
 	control_needs_exit =3D 1;
+	kill_proc(control_thread, SIGTERM, 1);
 	wait_for_completion(&w1_control_complete);
=20
 	driver_unregister(&w1_driver);
diff -Naur linux-2.6.12-rc5-mm2-clean/drivers/w1/w1.h linux-2.6.12-rc5-mm2/=
drivers/w1/w1.h
--- linux-2.6.12-rc5-mm2-clean/drivers/w1/w1.h	2005-06-01 14:29:28.00000000=
0 -0500
+++ linux-2.6.12-rc5-mm2/drivers/w1/w1.h	2005-06-02 09:16:38.657970647 -0500
@@ -25,9 +25,9 @@
 struct w1_reg_num
 {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-  	__u64	family:8,
-  		id:48,
-  		crc:8;
+	__u64	family:8,
+		id:48,
+		crc:8;
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	__u64	crc:8,
 		id:48,
@@ -61,6 +61,7 @@
 #define W1_MATCH_ROM		0x55
=20
 #define W1_SLAVE_ACTIVE		(1<<0)
+#define W1_SLAVE_ALARM		(1<<1)
=20
 struct w1_slave
 {
@@ -84,24 +85,71 @@
=20
 typedef void (* w1_slave_found_callback)(unsigned long, u64);
=20
+
+/**
+ * Note: read_bit and write_bit are very low level functions and should on=
ly
+ * be used with hardware that doesn't really support 1-wire operations,
+ * like a parallel/serial port.
+ * Either define read_bit and write_bit OR define, at minimum, touch_bit a=
nd=20
+ * reset_bus.
+ */
 struct w1_bus_master
 {
-	unsigned long		data;
-
-	u8			(*read_bit)(unsigned long);
-	void			(*write_bit)(unsigned long, u8);
-
-	u8			(*read_byte)(unsigned long);
-	void			(*write_byte)(unsigned long, u8);
-
-	u8			(*read_block)(unsigned long, u8 *, int);
-	void			(*write_block)(unsigned long, u8 *, int);
-
-	u8			(*touch_bit)(unsigned long, u8);
+	/** the first parameter in all the functions below */
+	unsigned long	data;
=20
-	u8			(*reset_bus)(unsigned long);
+	/**=20
+	 * Sample the line level=20
+	 * @return the level read (0 or 1)
+	 */
+	u8		(*read_bit)(unsigned long);
+
+	/** Sets the line level */
+	void		(*write_bit)(unsigned long, u8);
+
+	/**
+	 * touch_bit is the lowest-level function for devices that really=20
+	 * support the 1-wire protocol.
+	 * touch_bit(0) =3D write-0 cycle
+	 * touch_bit(1) =3D write-1 / read cycle
+	 * @return the bit read (0 or 1)
+	 */
+	u8		(*touch_bit)(unsigned long, u8);
+
+	/**=20
+	 * Reads a bytes. Same as 8 touch_bit(1) calls.
+	 * @return the byte read
+	 */
+	u8		(*read_byte)(unsigned long);
+
+	/**=20
+	 * Writes a byte. Same as 8 touch_bit(x) calls.
+	 */
+	void		(*write_byte)(unsigned long, u8);
+
+	/**
+	 * Same as a series of read_byte() calls=20
+	 * @return the number of bytes read
+	 */
+	u8		(*read_block)(unsigned long, u8 *, int);
+
+	/** Same as a series of write_byte() calls */
+	void		(*write_block)(unsigned long, const u8 *, int);
+
+	/**=20
+	 * Combines two reads and a smart write for ROM searches=20
+	 * @return bit0=3DId bit1=3Dcomp_id bit2=3Ddir_taken
+	 */
+	u8		(*triplet)(unsigned long, u8);
+
+	/**=20
+	 * long write-0 with a read for the presence pulse detection=20
+	 * @return -1=3DError, 0=DEvice present, 1=3DNo device present
+	 */
+	u8		(*reset_bus)(unsigned long);
=20
-	void			(*search)(unsigned long, w1_slave_found_callback);
+	/** Really nice hardware can handles the ROM searches */
+	void		(*search)(unsigned long, w1_slave_found_callback);
 };
=20
 struct w1_master
@@ -115,6 +163,7 @@
 	int			slave_ttl;
 	int			initialized;
 	u32			id;
+	u8			search_type;
=20
 	atomic_t		refcnt;
=20
@@ -137,7 +186,7 @@
 };
=20
 int w1_create_master_attributes(struct w1_master *);
-void w1_search(struct w1_master *dev);
+void w1_search(struct w1_master *dev, u8 search_cmd, w1_slave_found_callba=
ck cb);
=20
 #endif /* __KERNEL__ */
=20
diff -Naur linux-2.6.12-rc5-mm2-clean/drivers/w1/w1_int.c linux-2.6.12-rc5-=
mm2/drivers/w1/w1_int.c
--- linux-2.6.12-rc5-mm2-clean/drivers/w1/w1_int.c	2005-06-01 14:29:28.0000=
00000 -0500
+++ linux-2.6.12-rc5-mm2/drivers/w1/w1_int.c	2005-06-01 16:36:05.000000000 =
-0500
@@ -69,6 +69,7 @@
 	dev->initialized	=3D 0;
 	dev->id			=3D id;
 	dev->slave_ttl		=3D slave_ttl;
+        dev->search_type        =3D W1_SEARCH;
=20
 	atomic_set(&dev->refcnt, 2);
=20
@@ -121,6 +122,14 @@
 	int retval =3D 0;
 	struct w1_netlink_msg msg;
=20
+        /* validate minimum functionality */
+        if (!(master->touch_bit && master->reset_bus) &&
+            !(master->write_bit && master->read_bit))
+        {
+           printk(KERN_ERR "w1_add_master_device: invalid function set\n");
+           return(-EINVAL);
+        }
+
 	dev =3D w1_alloc_dev(w1_ids++, w1_max_slave_count, w1_max_slave_ttl, &w1_=
driver, &w1_device);
 	if (!dev)
 		return -ENOMEM;
diff -Naur linux-2.6.12-rc5-mm2-clean/drivers/w1/w1_io.c linux-2.6.12-rc5-m=
m2/drivers/w1/w1_io.c
--- linux-2.6.12-rc5-mm2-clean/drivers/w1/w1_io.c	2005-06-01 14:29:28.00000=
0000 -0500
+++ linux-2.6.12-rc5-mm2/drivers/w1/w1_io.c	2005-06-01 16:36:05.000000000 -=
0500
@@ -55,15 +55,29 @@
 	udelay(tm * w1_delay_parm);
 }
=20
+static void w1_write_bit(struct w1_master *dev, int bit);
+static u8 w1_read_bit(struct w1_master *dev);
+
+/**
+ * Generates a write-0 or write-1 cycle and samples the level.
+ */
 u8 w1_touch_bit(struct w1_master *dev, int bit)
 {
 	if (dev->bus_master->touch_bit)
 		return dev->bus_master->touch_bit(dev->bus_master->data, bit);
-	else
+	else if (bit)
 		return w1_read_bit(dev);
+	else {
+		w1_write_bit(dev, 0);
+		return(0);
+	}
 }
=20
-void w1_write_bit(struct w1_master *dev, int bit)
+/**
+ * Generates a write-0 or write-1 cycle.
+ * Only call if dev->bus_master->touch_bit is NULL
+ */
+static void w1_write_bit(struct w1_master *dev, int bit)
 {
 	if (bit) {
 		dev->bus_master->write_bit(dev->bus_master->data, 0);
@@ -78,6 +92,12 @@
 	}
 }
=20
+/**
+ * Writes 8 bits.
+ *=20
+ * @param dev     the master device
+ * @param byte    the byte to write
+ */
 void w1_write_8(struct w1_master *dev, u8 byte)
 {
 	int i;
@@ -86,10 +106,15 @@
 		dev->bus_master->write_byte(dev->bus_master->data, byte);
 	else
 		for (i =3D 0; i < 8; ++i)
-			w1_write_bit(dev, (byte >> i) & 0x1);
+			w1_touch_bit(dev, (byte >> i) & 0x1);
 }
=20
-u8 w1_read_bit(struct w1_master *dev)
+
+/**
+ * Generates a write-1 cycle and samples the level.
+ * Only call if dev->bus_master->touch_bit is NULL
+ */
+static u8 w1_read_bit(struct w1_master *dev)
 {
 	int result;
=20
@@ -104,6 +129,53 @@
 	return result & 0x1;
 }
=20
+/**=20
+ * Does a triplet - used for searching ROM addresses.
+ * Return bits:
+ *  bit 0 =3D id_bit
+ *  bit 1 =3D comp_bit
+ *  bit 2 =3D dir_taken
+ * If both bits 0 & 1 are set, the search should be restarted.
+ *=20
+ * @param dev     the master device
+ * @param bdir    the bit to write if both id_bit and comp_bit are 0=20
+ * @return        bit fields - see above
+ */
+u8 w1_triplet(struct w1_master *dev, int bdir)
+{
+	if ( dev->bus_master->triplet )
+		return(dev->bus_master->triplet(dev->bus_master->data, bdir));
+	else {
+		u8 id_bit   =3D w1_touch_bit(dev, 1);
+		u8 comp_bit =3D w1_touch_bit(dev, 1);
+		u8 retval;
+
+		if ( id_bit && comp_bit )
+			return(0x03);  /* error */
+
+		if ( !id_bit && !comp_bit ) {
+			/* Both bits are valid, take the direction given */
+			retval =3D bdir ? 0x04 : 0;
+		} else {
+			/* Only one bit is valid, take that direction */
+			bdir =3D id_bit;
+			retval =3D id_bit ? 0x05 : 0x02;
+		}
+
+		if ( dev->bus_master->touch_bit )
+			w1_touch_bit(dev, bdir);
+		else
+			w1_write_bit(dev, bdir);
+		return(retval);
+	}
+}
+
+/**
+ * Reads 8 bits.
+ *=20
+ * @param dev     the master device
+ * @return        the byte read
+ */
 u8 w1_read_8(struct w1_master * dev)
 {
 	int i;
@@ -113,12 +185,20 @@
 		res =3D dev->bus_master->read_byte(dev->bus_master->data);
 	else
 		for (i =3D 0; i < 8; ++i)
-			res |=3D (w1_read_bit(dev) << i);
+			res |=3D (w1_touch_bit(dev,1) << i);
=20
 	return res;
 }
=20
-void w1_write_block(struct w1_master *dev, u8 *buf, int len)
+/**
+ * Writes a series of bytes.
+ *=20
+ * @param dev     the master device
+ * @param buf     pointer to the data to write
+ * @param len     the number of bytes to write
+ * @return        the byte read
+ */
+void w1_write_block(struct w1_master *dev, const u8 *buf, int len)
 {
 	int i;
=20
@@ -129,6 +209,14 @@
 			w1_write_8(dev, buf[i]);
 }
=20
+/**
+ * Reads a series of bytes.
+ *=20
+ * @param dev     the master device
+ * @param buf     pointer to the buffer to fill
+ * @param len     the number of bytes to read
+ * @return        the number of bytes read
+ */
 u8 w1_read_block(struct w1_master *dev, u8 *buf, int len)
 {
 	int i;
@@ -145,9 +233,15 @@
 	return ret;
 }
=20
+/**
+ * Issues a reset bus sequence.
+ *=20
+ * @param  dev The bus master pointer
+ * @return     0=DEvice present, 1=3DNo device present or error
+ */
 int w1_reset_bus(struct w1_master *dev)
 {
-	int result =3D 0;
+	int result;
=20
 	if (dev->bus_master->reset_bus)
 		result =3D dev->bus_master->reset_bus(dev->bus_master->data) & 0x1;
@@ -174,18 +268,21 @@
 	return crc;
 }
=20
-void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb)
+/** search_type should be W1_SEARCH or W1_CONDITIONAL_SEARCH */
+void w1_search_devices(struct w1_master *dev, u8 search_type, w1_slave_fou=
nd_callback cb)
 {
+	if (search_type !=3D W1_CONDITIONAL_SEARCH)
+		 search_type =3D W1_SEARCH;
+
 	dev->attempts++;
 	if (dev->bus_master->search)
 		dev->bus_master->search(dev->bus_master->data, cb);
 	else
-		w1_search(dev);
+		w1_search(dev, search_type, cb);
 }
=20
-EXPORT_SYMBOL(w1_write_bit);
+EXPORT_SYMBOL(w1_touch_bit);
 EXPORT_SYMBOL(w1_write_8);
-EXPORT_SYMBOL(w1_read_bit);
 EXPORT_SYMBOL(w1_read_8);
 EXPORT_SYMBOL(w1_reset_bus);
 EXPORT_SYMBOL(w1_calc_crc8);
diff -Naur linux-2.6.12-rc5-mm2-clean/drivers/w1/w1_io.h linux-2.6.12-rc5-m=
m2/drivers/w1/w1_io.h
--- linux-2.6.12-rc5-mm2-clean/drivers/w1/w1_io.h	2005-06-01 14:29:28.00000=
0000 -0500
+++ linux-2.6.12-rc5-mm2/drivers/w1/w1_io.h	2005-06-01 16:36:05.000000000 -=
0500
@@ -26,14 +26,13 @@
=20
 void w1_delay(unsigned long);
 u8 w1_touch_bit(struct w1_master *, int);
-void w1_write_bit(struct w1_master *, int);
+u8 w1_triplet(struct w1_master *dev, int bdir);
 void w1_write_8(struct w1_master *, u8);
-u8 w1_read_bit(struct w1_master *);
 u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
-void w1_write_block(struct w1_master *, u8 *, int);
+void w1_write_block(struct w1_master *, const u8 *, int);
 u8 w1_read_block(struct w1_master *, u8 *, int);
-void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb);
+void w1_search_devices(struct w1_master *dev, u8 search_type, w1_slave_fou=
nd_callback cb);
=20
 #endif /* __W1_IO_H */
