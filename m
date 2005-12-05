From: gardner.ben@gmail.com (Ben Gardner)
Date: Mon, 05 Dec 2005 18:09:50 +0000
Subject: [lm-sensors] [PATCH 1/3] w1 : change bus master data type to void
Message-Id: <808c8e9d0512051009p20520aebnb85cb59e26507c4a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Change the type 'unsigned long' member of 'struct w1_bus_master' to 'void *=
'.

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
-------------- next part --------------
 drivers/w1/ds_w1_bridge.c |   34 +++++++++++++++++-----------------
 drivers/w1/matrox_w1.c    |   14 +++++++-------
 drivers/w1/w1.c           |    8 ++++----
 drivers/w1/w1.h           |   24 ++++++++++++------------
 4 files changed, 40 insertions(+), 40 deletions(-)

Index: linux-2.6.15-rc3-mm1/drivers/w1/ds_w1_bridge.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/ds_w1_brid=
ge.c
+++ linux-2.6.15-rc3-mm1/drivers/w1/ds_w1_bridge.c
@@ -29,10 +29,10 @@
 static struct ds_device *ds_dev;
 static struct w1_bus_master *ds_bus_master;
=20
-static u8 ds9490r_touch_bit(unsigned long data, u8 bit)
+static u8 ds9490r_touch_bit(void *data, u8 bit)
 {
 	u8 ret;
-	struct ds_device *dev =3D (struct ds_device *)data;
+	struct ds_device *dev =3D data;
=20
 	if (ds_touch_bit(dev, bit, &ret))
 		return 0;
@@ -40,23 +40,23 @@ static u8 ds9490r_touch_bit(unsigned lon
 	return ret;
 }
=20
-static void ds9490r_write_bit(unsigned long data, u8 bit)
+static void ds9490r_write_bit(void *data, u8 bit)
 {
-	struct ds_device *dev =3D (struct ds_device *)data;
+	struct ds_device *dev =3D data;
=20
 	ds_write_bit(dev, bit);
 }
=20
-static void ds9490r_write_byte(unsigned long data, u8 byte)
+static void ds9490r_write_byte(void *data, u8 byte)
 {
-	struct ds_device *dev =3D (struct ds_device *)data;
+	struct ds_device *dev =3D data;
=20
 	ds_write_byte(dev, byte);
 }
=20
-static u8 ds9490r_read_bit(unsigned long data)
+static u8 ds9490r_read_bit(void *data)
 {
-	struct ds_device *dev =3D (struct ds_device *)data;
+	struct ds_device *dev =3D data;
 	int err;
 	u8 bit =3D 0;
=20
@@ -70,9 +70,9 @@ static u8 ds9490r_read_bit(unsigned long
 	return bit & 1;
 }
=20
-static u8 ds9490r_read_byte(unsigned long data)
+static u8 ds9490r_read_byte(void *data)
 {
-	struct ds_device *dev =3D (struct ds_device *)data;
+	struct ds_device *dev =3D data;
 	int err;
 	u8 byte =3D 0;
=20
@@ -83,16 +83,16 @@ static u8 ds9490r_read_byte(unsigned lon
 	return byte;
 }
=20
-static void ds9490r_write_block(unsigned long data, const u8 *buf, int len)
+static void ds9490r_write_block(void *data, const u8 *buf, int len)
 {
-	struct ds_device *dev =3D (struct ds_device *)data;
+	struct ds_device *dev =3D data;
=20
 	ds_write_block(dev, (u8 *)buf, len);
 }
=20
-static u8 ds9490r_read_block(unsigned long data, u8 *buf, int len)
+static u8 ds9490r_read_block(void *data, u8 *buf, int len)
 {
-	struct ds_device *dev =3D (struct ds_device *)data;
+	struct ds_device *dev =3D data;
 	int err;
=20
 	err =3D ds_read_block(dev, buf, len);
@@ -102,9 +102,9 @@ static u8 ds9490r_read_block(unsigned lo
 	return len;
 }
=20
-static u8 ds9490r_reset(unsigned long data)
+static u8 ds9490r_reset(void *data)
 {
-	struct ds_device *dev =3D (struct ds_device *)data;
+	struct ds_device *dev =3D data;
 	struct ds_status st;
 	int err;
=20
@@ -136,7 +136,7 @@ static int __devinit ds_w1_init(void)
=20
 	memset(ds_bus_master, 0, sizeof(*ds_bus_master));
=20
-	ds_bus_master->data		=3D (unsigned long)ds_dev;
+	ds_bus_master->data		=3D ds_dev;
 	ds_bus_master->touch_bit	=3D &ds9490r_touch_bit;
 	ds_bus_master->read_bit		=3D &ds9490r_read_bit;
 	ds_bus_master->write_bit	=3D &ds9490r_write_bit;
Index: linux-2.6.15-rc3-mm1/drivers/w1/matrox_w1.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/matrox_w1.c
+++ linux-2.6.15-rc3-mm1/drivers/w1/matrox_w1.c
@@ -90,8 +90,8 @@ struct matrox_device
 	struct w1_bus_master *bus_master;
 };
=20
-static u8 matrox_w1_read_ddc_bit(unsigned long);
-static void matrox_w1_write_ddc_bit(unsigned long, u8);
+static u8 matrox_w1_read_ddc_bit(void *);
+static void matrox_w1_write_ddc_bit(void *, u8);
=20
 /*
  * These functions read and write DDC Data bit.
@@ -122,10 +122,10 @@ static __inline__ void matrox_w1_write_r
 	wmb();
 }
=20
-static void matrox_w1_write_ddc_bit(unsigned long data, u8 bit)
+static void matrox_w1_write_ddc_bit(void *data, u8 bit)
 {
 	u8 ret;
-	struct matrox_device *dev =3D (struct matrox_device *) data;
+	struct matrox_device *dev =3D data;
=20
 	if (bit)
 		bit =3D 0;
@@ -137,10 +137,10 @@ static void matrox_w1_write_ddc_bit(unsi
 	matrox_w1_write_reg(dev, MATROX_GET_DATA, 0x00);
 }
=20
-static u8 matrox_w1_read_ddc_bit(unsigned long data)
+static u8 matrox_w1_read_ddc_bit(void *data)
 {
 	u8 ret;
-	struct matrox_device *dev =3D (struct matrox_device *) data;
+	struct matrox_device *dev =3D data;
=20
 	ret =3D matrox_w1_read_reg(dev, MATROX_GET_DATA);
=20
@@ -198,7 +198,7 @@ static int __devinit matrox_w1_probe(str
=20
 	matrox_w1_hw_init(dev);
=20
-	dev->bus_master->data =3D (unsigned long) dev;
+	dev->bus_master->data =3D dev;
 	dev->bus_master->read_bit =3D &matrox_w1_read_ddc_bit;
 	dev->bus_master->write_bit =3D &matrox_w1_write_ddc_bit;
=20
Index: linux-2.6.15-rc3-mm1/drivers/w1/w1.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/w1.h
+++ linux-2.6.15-rc3-mm1/drivers/w1/w1.h
@@ -80,7 +80,7 @@ struct w1_slave
 	struct completion	released;
 };
=20
-typedef void (* w1_slave_found_callback)(unsigned long, u64);
+typedef void (* w1_slave_found_callback)(void *, u64);
=20
=20
 /**
@@ -93,16 +93,16 @@ typedef void (* w1_slave_found_callback)
 struct w1_bus_master
 {
 	/** the first parameter in all the functions below */
-	unsigned long	data;
+	void		*data;
=20
 	/**
 	 * Sample the line level
 	 * @return the level read (0 or 1)
 	 */
-	u8		(*read_bit)(unsigned long);
+	u8		(*read_bit)(void *);
=20
 	/** Sets the line level */
-	void		(*write_bit)(unsigned long, u8);
+	void		(*write_bit)(void *, u8);
=20
 	/**
 	 * touch_bit is the lowest-level function for devices that really
@@ -111,42 +111,42 @@ struct w1_bus_master
 	 * touch_bit(1) =3D write-1 / read cycle
 	 * @return the bit read (0 or 1)
 	 */
-	u8		(*touch_bit)(unsigned long, u8);
+	u8		(*touch_bit)(void *, u8);
=20
 	/**
 	 * Reads a bytes. Same as 8 touch_bit(1) calls.
 	 * @return the byte read
 	 */
-	u8		(*read_byte)(unsigned long);
+	u8		(*read_byte)(void *);
=20
 	/**
 	 * Writes a byte. Same as 8 touch_bit(x) calls.
 	 */
-	void		(*write_byte)(unsigned long, u8);
+	void		(*write_byte)(void *, u8);
=20
 	/**
 	 * Same as a series of read_byte() calls
 	 * @return the number of bytes read
 	 */
-	u8		(*read_block)(unsigned long, u8 *, int);
+	u8		(*read_block)(void *, u8 *, int);
=20
 	/** Same as a series of write_byte() calls */
-	void		(*write_block)(unsigned long, const u8 *, int);
+	void		(*write_block)(void *, const u8 *, int);
=20
 	/**
 	 * Combines two reads and a smart write for ROM searches
 	 * @return bit0=3DId bit1=3Dcomp_id bit2=3Ddir_taken
 	 */
-	u8		(*triplet)(unsigned long, u8);
+	u8		(*triplet)(void *, u8);
=20
 	/**
 	 * long write-0 with a read for the presence pulse detection
 	 * @return -1=3DError, 0=DEvice present, 1=3DNo device present
 	 */
-	u8		(*reset_bus)(unsigned long);
+	u8		(*reset_bus)(void *);
=20
 	/** Really nice hardware can handles the ROM searches */
-	void		(*search)(unsigned long, w1_slave_found_callback);
+	void		(*search)(void *, w1_slave_found_callback);
 };
=20
 #define W1_MASTER_NEED_EXIT		0
Index: linux-2.6.15-rc3-mm1/drivers/w1/w1.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- linux-2.6.15-rc3-mm1.orig/drivers/w1/w1.c
+++ linux-2.6.15-rc3-mm1/drivers/w1/w1.c
@@ -552,7 +552,7 @@ static void w1_slave_detach(struct w1_sl
 	kfree(sl);
 }
=20
-static struct w1_master *w1_search_master(unsigned long data)
+static struct w1_master *w1_search_master(void *data)
 {
 	struct w1_master *dev;
 	int found =3D 0;
@@ -583,7 +583,7 @@ void w1_reconnect_slaves(struct w1_famil
 	spin_unlock_bh(&w1_mlock);
 }
=20
-static void w1_slave_found(unsigned long data, u64 rn)
+static void w1_slave_found(void *data, u64 rn)
 {
 	int slave_count;
 	struct w1_slave *sl;
@@ -595,8 +595,8 @@ static void w1_slave_found(unsigned long
=20
 	dev =3D w1_search_master(data);
 	if (!dev) {
-		printk(KERN_ERR "Failed to find w1 master device for data %08lx, it is i=
mpossible.\n",
-				data);
+		printk(KERN_ERR "Failed to find w1 master device for data %p, "
+		       "it is impossible.\n", data);
 		return;
 	}
=20
