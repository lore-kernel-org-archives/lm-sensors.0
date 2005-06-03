From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Fri, 03 Jun 2005 23:34:22 +0000
Subject: [lm-sensors] [2/6] w1: Added the triplet w1 master method and
Message-Id: <20050604013043.1f28dbe3@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Adds the triplet w1 master method and changes w1_search() to use it.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

--- linux-2.6.12-rc5-mm2-touchbit/drivers/w1/w1_io.c	2005-06-02 16:29:55.00=
0000000 -0500
+++ linux-2.6.12-rc5-mm2-triplet/drivers/w1/w1_io.c	2005-06-03 08:26:03.083=
429351 -0500
@@ -129,6 +129,47 @@
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
 /**
  * Reads 8 bits.
  *=20
@@ -233,7 +274,7 @@
 	if (dev->bus_master->search)
 		dev->bus_master->search(dev->bus_master->data, cb);
 	else
-		w1_search(dev);
+		w1_search(dev, cb);
 }
=20
 EXPORT_SYMBOL(w1_touch_bit);
--- linux-2.6.12-rc5-mm2-touchbit/drivers/w1/w1_io.h	2005-06-02 16:25:29.00=
0000000 -0500
+++ linux-2.6.12-rc5-mm2-triplet/drivers/w1/w1_io.h	2005-06-03 08:25:36.278=
883938 -0500
@@ -26,6 +26,7 @@
=20
 void w1_delay(unsigned long);
 u8 w1_touch_bit(struct w1_master *, int);
+u8 w1_triplet(struct w1_master *dev, int bdir);
 void w1_write_8(struct w1_master *, u8);
 u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
--- linux-2.6.12-rc5-mm2-clean/drivers/w1/w1.h	2005-06-01 14:29:28.00000000=
0 -0500
+++ linux-2.6.12-rc5-mm2-triplet/drivers/w1/w1.h	2005-06-03 08:34:48.982651=
133 -0500
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
@@ -84,24 +84,71 @@
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
@@ -137,7 +184,7 @@
 };
=20
 int w1_create_master_attributes(struct w1_master *);
-void w1_search(struct w1_master *dev);
+void w1_search(struct w1_master *dev, w1_slave_found_callback cb);
=20
 #endif /* __KERNEL__ */
=20
--- linux-2.6.12-rc5-mm2-clean/drivers/w1/w1.c	2005-06-01 14:29:28.00000000=
0 -0500
+++ linux-2.6.12-rc5-mm2-triplet/drivers/w1/w1.c	2005-06-03 08:33:13.254988=
573 -0500
@@ -135,7 +135,7 @@
=20
 static ssize_t w1_master_attribute_show_name(struct device *dev, struct de=
vice_attribute *attr, char *buf)
 {
-	struct w1_master *md =3D container_of (dev, struct w1_master, dev);
+	struct w1_master *md =3D container_of(dev, struct w1_master, dev);
 	ssize_t count;
=20
 	if (down_interruptible (&md->mutex))
@@ -212,7 +212,6 @@
 }
=20
 static ssize_t w1_master_attribute_show_slaves(struct device *dev, struct =
device_attribute *attr, char *buf)
-
 {
 	struct w1_master *md =3D container_of(dev, struct w1_master, dev);
 	int c =3D PAGE_SIZE;
@@ -286,13 +285,13 @@
 	sl->dev.release =3D &w1_slave_release;
=20
 	snprintf(&sl->dev.bus_id[0], sizeof(sl->dev.bus_id),
-		  "%02x-%012llx",
-		  (unsigned int) sl->reg_num.family,
-		  (unsigned long long) sl->reg_num.id);
-	snprintf (&sl->name[0], sizeof(sl->name),
-		  "%02x-%012llx",
-		  (unsigned int) sl->reg_num.family,
-		  (unsigned long long) sl->reg_num.id);
+		 "%02x-%012llx",
+		 (unsigned int) sl->reg_num.family,
+		 (unsigned long long) sl->reg_num.id);
+	snprintf(&sl->name[0], sizeof(sl->name),
+		 "%02x-%012llx",
+		 (unsigned int) sl->reg_num.family,
+		 (unsigned long long) sl->reg_num.id);
=20
 	dev_dbg(&sl->dev, "%s: registering %s.\n", __func__,
 		&sl->dev.bus_id[0]);
@@ -300,8 +299,8 @@
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
@@ -314,8 +313,8 @@
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
@@ -323,8 +322,8 @@
 	err =3D sysfs_create_bin_file(&sl->dev.kobj, &sl->attr_bin);
 	if (err < 0) {
 		dev_err(&sl->dev,
-			 "sysfs file creation for [%s] failed. err=3D%d\n",
-			 sl->dev.bus_id, err);
+			"sysfs file creation for [%s] failed. err=3D%d\n",
+			sl->dev.bus_id, err);
 		device_remove_file(&sl->dev, &sl->attr_name);
 		device_unregister(&sl->dev);
 		return err;
@@ -483,26 +482,39 @@
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
+ * @cb         Function to call when a device is found
+ */
+void w1_search(struct w1_master *dev, w1_slave_found_callback cb)
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
@@ -514,59 +526,39 @@
 			break;
 		}
=20
-#if 1
+		/* Start the search */
 		w1_write_8(dev, W1_SEARCH);
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


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
