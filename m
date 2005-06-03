From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Fri, 03 Jun 2005 17:59:08 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2 1/5] w1 enhancements
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9076C5E9@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Cleans up usage of touch_bit/w1_read_bit/w1_write_bit.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
-------------- next part --------------
--- linux-2.6.12-rc5-mm2-clean/drivers/w1/w1_io.h	2005-06-01 14:29:28.00000=
0000 -0500
+++ linux-2.6.12-rc5-mm2-touchbit/drivers/w1/w1_io.h	2005-06-02 16:25:29.10=
1021377 -0500
@@ -26,13 +26,11 @@
=20
 void w1_delay(unsigned long);
 u8 w1_touch_bit(struct w1_master *, int);
-void w1_write_bit(struct w1_master *, int);
 void w1_write_8(struct w1_master *, u8);
-u8 w1_read_bit(struct w1_master *);
 u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
-void w1_write_block(struct w1_master *, u8 *, int);
+void w1_write_block(struct w1_master *, const u8 *, int);
 u8 w1_read_block(struct w1_master *, u8 *, int);
 void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb);
=20
--- linux-2.6.12-rc5-mm2-clean/drivers/w1/w1_io.c	2005-06-01 14:29:28.00000=
0000 -0500
+++ linux-2.6.12-rc5-mm2-touchbit/drivers/w1/w1_io.c	2005-06-02 16:29:55.10=
0033591 -0500
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
@@ -104,6 +129,12 @@
 	return result & 0x1;
 }
=20
+/**
+ * Reads 8 bits.
+ *=20
+ * @param dev     the master device
+ * @return        the byte read
+ */
 u8 w1_read_8(struct w1_master * dev)
 {
 	int i;
@@ -113,12 +144,20 @@
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
@@ -129,6 +168,14 @@
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
@@ -145,9 +192,15 @@
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
@@ -183,9 +236,8 @@
 		w1_search(dev);
 }
=20
-EXPORT_SYMBOL(w1_write_bit);
+EXPORT_SYMBOL(w1_touch_bit);
 EXPORT_SYMBOL(w1_write_8);
-EXPORT_SYMBOL(w1_read_bit);
 EXPORT_SYMBOL(w1_read_8);
 EXPORT_SYMBOL(w1_reset_bus);
 EXPORT_SYMBOL(w1_calc_crc8);
--- linux-2.6.12-rc5-mm2-clean/drivers/w1/w1_int.c	2005-06-01 14:29:28.0000=
00000 -0500
+++ linux-2.6.12-rc5-mm2-touchbit/drivers/w1/w1_int.c	2005-06-03 08:37:30.0=
54892042 -0500
@@ -121,6 +121,14 @@
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
