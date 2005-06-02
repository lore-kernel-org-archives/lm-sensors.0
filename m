From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Thu, 02 Jun 2005 19:58:35 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] ds2482: new driver - i2c to
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9076C237@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Attached is a new driver for the DS2482, a i2c to 1-wire bridge.

This patch depends on my "w1 search cleanup" patch posted earlier.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
-------------- next part --------------
diff -Naur linux-2.6.12-rc5-mm2-clean/drivers/i2c/chips/ds2482.c linux-2.6.=
12-rc5-mm2-ds2482/drivers/i2c/chips/ds2482.c
--- linux-2.6.12-rc5-mm2-clean/drivers/i2c/chips/ds2482.c	1969-12-31 18:00:=
00.000000000 -0600
+++ linux-2.6.12-rc5-mm2-ds2482/drivers/i2c/chips/ds2482.c	2005-06-02 12:53=
:05.245138844 -0500
@@ -0,0 +1,574 @@
+/**
+ * ds2482.c - provides i2c to w1-master bridge(s)
+ * Copyright (C) 2005  Ben Gardner <bgardner@wabtec.com>
+ *
+ * Inspired by the lm83 and ds_w1_bridge drivers.=20
+ *=20
+ * The DS2482 is a sensor chip made by Dallis Semiconductor (MAXIM).=20
+ * It is a I2C to 1-wire bridge.
+ * There are two variations: -100 and -800, which have 1 or 8 1-wire ports.
+ * The complete datasheet can be obtained from MAXIM's website at:
+ *   http://www.maxim-ic.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <asm/delay.h>
+
+#include "../../w1/w1.h"
+#include "../../w1/w1_int.h"
+
+/*
+ * Addresses to scan
+ * Address is selected using 2 pins, resulting in 4 possible addresses.
+ */
+static unsigned short normal_i2c[] =3D { 0x18, 0x19, 0x1a, 0x1b, I2C_CLIEN=
T_END};
+static unsigned int normal_isa[] =3D { I2C_CLIENT_ISA_END};
+
+/*
+ * Insmod parameters
+ */
+SENSORS_INSMOD_1(ds2482);
+
+/**
+ * The DS2482 registers - there are 3 registers that are addressed by a re=
ad
+ * pointer. The read pointer is set by the last command executed.
+ *=20
+ * To read the data, issue a register read for any address
+ */
+#define DS2482_CMD_RESET               0xF0	/* No param */
+#define DS2482_CMD_SET_READ_PTR        0xE1	/* Param: DS2482_PTR_CODE_xxx =
*/
+#define   DS2482_PTR_CODE_STATUS         0xF0
+#define   DS2482_PTR_CODE_DATA           0xE1
+#define   DS2482_PTR_CODE_CHANNEL        0xD2	/* DS2482-800 only */
+#define   DS2482_PTR_CODE_CONFIG         0xC3
+#define DS2482_CMD_CHANNEL_SELECT      0xC3	/* Param: Channel byte - DS248=
2-800 only */
+#define DS2482_CMD_WRITE_CONFIG        0xD2	/* Param: Config byte */
+#define DS2482_CMD_1WIRE_RESET         0xB4	/* Param: None */
+#define DS2482_CMD_1WIRE_SINGLE_BIT    0x87	/* Param: Bit byte (bit7) */
+#define DS2482_CMD_1WIRE_WRITE_BYTE    0xA5	/* Param: Data byte */
+#define DS2482_CMD_1WIRE_READ_BYTE     0x96	/* Param: None */
+/* Note to read the byte, Set the ReadPtr to Data then read (any addr) */
+#define DS2482_CMD_1WIRE_TRIPLET       0x78	/* Param: Dir byte (bit7) */
+
+/**
+ * Configure Register bit definitions=20
+ * The top 4 bits always read 0.
+ * To write, the top nibble must be the 1's compl. of the low nibble.
+ */
+#define DS2482_REG_CFG_1WS             0x08
+#define DS2482_REG_CFG_SPU             0x04
+#define DS2482_REG_CFG_PPM             0x02
+#define DS2482_REG_CFG_APU             0x01
+
+/* Write and verify codes for the CHANNEL_SELECT command (DS2482-800 only)=
 */
+static u8 ds2482_chan_wr[8] =3D { 0xF0, 0xE1, 0xD2, 0xC3, 0xB4, 0xA5, 0x96=
, 0x87};
+static u8 ds2482_chan_rd[8] =3D { 0xB8, 0xB1, 0xAA, 0xA3, 0x9C, 0x95, 0x8E=
, 0x87};
+
+
+/**
+ * Status Register bit definitions (read only)
+ */
+#define DS2482_REG_STS_DIR             0x80
+#define DS2482_REG_STS_TSB             0x40
+#define DS2482_REG_STS_SBR             0x20
+#define DS2482_REG_STS_RST             0x10
+#define DS2482_REG_STS_LL              0x08
+#define DS2482_REG_STS_SD              0x04
+#define DS2482_REG_STS_PPD             0x02
+#define DS2482_REG_STS_1WB             0x01
+
+
+
+/*
+ * Functions declaration
+ */
+
+static int ds2482_attach_adapter(struct i2c_adapter *adapter);
+static int ds2482_detect(struct i2c_adapter *adapter, int address, int kin=
d);
+static int ds2482_detach_client(struct i2c_client *client);
+
+
+/*
+ * Driver data (common to all clients)
+ */
+
+static struct i2c_driver ds2482_driver =3D {
+	.owner          =3D THIS_MODULE,
+	.name           =3D "ds2482",
+	.flags          =3D I2C_DF_NOTIFY,
+	.attach_adapter =3D ds2482_attach_adapter,
+	.detach_client  =3D ds2482_detach_client,
+};
+
+/*
+ * Client data (each client gets its own)
+ */
+
+struct ds2482_data;
+
+struct ds2482_w1_chan {
+	struct ds2482_data   *pdev;
+	u8                   channel;
+	struct w1_bus_master w1_bus_master;
+};
+
+struct ds2482_data {
+	struct i2c_client client;
+	struct semaphore  access_lock;
+
+	/* 1-wire interface(s) */
+	int                   w1_count;	/* 1 or 8 */
+	struct ds2482_w1_chan w1_ch[8];
+
+	/* per-device values */
+	u8    channel;
+	u8    read_prt;	  /* see DS2482_PTR_CODE_xxx */
+	u8    reg_config;
+};
+
+
+
+/*
+ * Internal variables
+ */
+
+/**
+ * Sets the read pointer.
+ * @param pdev       The ds2482 client pointer
+ * @param read_ptr   see DS2482_PTR_CODE_xxx above
+ */
+static inline int ds2482_select_register(struct ds2482_data *pdev, u8 read=
_ptr)
+{
+	if ( pdev->read_prt !=3D read_ptr ) {
+		if ( i2c_smbus_write_byte_data(&pdev->client,=20
+					       DS2482_CMD_SET_READ_PTR,=20
+					       read_ptr) < 0 ) {
+			return(-1);
+		}
+		pdev->read_prt =3D read_ptr;
+	}
+	return(0);
+}
+
+/**
+ * Sends a command without a parameter
+ * @param pdev       The ds2482 client pointer
+ * @param cmd        DS2482_CMD_RESET,=20
+ *                   DS2482_CMD_1WIRE_RESET,=20
+ *                   DS2482_CMD_1WIRE_READ_BYTE
+ */
+static inline int ds2482_send_cmd(struct ds2482_data *pdev, u8 cmd)
+{
+	if ( i2c_smbus_write_byte(&pdev->client, cmd) < 0 ) {
+		return(-1);
+	}
+	pdev->read_prt =3D DS2482_PTR_CODE_STATUS;
+	return(0);
+}
+
+/**
+ * Sends a command with a parameter
+ * @param pdev       The ds2482 client pointer
+ * @param cmd        DS2482_CMD_WRITE_CONFIG,=20
+ *                   DS2482_CMD_1WIRE_SINGLE_BIT,=20
+ *                   DS2482_CMD_1WIRE_WRITE_BYTE,
+ *                   DS2482_CMD_1WIRE_TRIPLET
+ * @param byte       The data to send
+ */
+static inline int ds2482_send_cmd_data(struct ds2482_data *pdev, u8 cmd, u=
8 byte)
+{
+	if ( i2c_smbus_write_byte_data(&pdev->client, cmd, byte) < 0 ) {
+		return(-1);
+	}
+	/* all cmds leave in STATUS, except CONFIG */
+	pdev->read_prt =3D (cmd !=3D DS2482_CMD_WRITE_CONFIG) ?=20
+			 DS2482_PTR_CODE_STATUS : DS2482_PTR_CODE_CONFIG;
+	return(0);
+}
+
+
+/*
+ * 1-Wire interface code=20
+ */
+
+
+/**=20
+ * Waits until the 1-wire interface is idle (not busy)
+ *=20
+ * @param pdev Pointer to the device structure
+ * @return the last value read from status or -1 (failure)
+ */
+static inline int ds2482_wait_1wire_idle(struct ds2482_data *pdev)
+{
+	int temp =3D -1;
+	if ( !ds2482_select_register(pdev, DS2482_PTR_CODE_STATUS) ) {
+		do {
+			temp =3D i2c_smbus_read_byte(&pdev->client);
+		} while ( (temp >=3D 0) && (temp & DS2482_REG_STS_1WB) );
+	}
+	return(temp);
+}
+
+/**
+ * Selects a w1 channel.=20
+ * The 1-wire interface must be idle before calling this function.
+ *=20
+ * @param pdev       The ds2482 client pointer
+ * @param channel    0-7
+ * @return           -1 (failure) or 0 (success)
+ */
+static inline int ds2482_set_channel(struct ds2482_data *pdev, u8 channel)
+{
+	if (channel >=3D 8)
+		return -1;
+
+	if ( i2c_smbus_write_byte_data(&pdev->client, DS2482_CMD_CHANNEL_SELECT, =

+				       ds2482_chan_wr[channel]) < 0 )
+		return -1;
+
+	pdev->read_prt =3D DS2482_PTR_CODE_CHANNEL;
+	pdev->channel =3D -1;
+	if (i2c_smbus_read_byte(&pdev->client) =3D ds2482_chan_rd[channel]) {
+		pdev->channel =3D channel;
+		return 0;
+	}
+	return -1;
+}
+
+
+/**
+ * Performs the touch-bit function, which writes a 0 or 1 and reads the le=
vel.
+ *=20
+ * @param data       The ds2482 channel pointer
+ * @param bit        The level to write: 0 or non-zero
+ * @return           The level read: 0 or 1
+ */
+static u8 ds2482_w1_touch_bit(unsigned long data, u8 bit)
+{
+	struct ds2482_w1_chan *pchan =3D (struct ds2482_w1_chan *)data;
+	struct ds2482_data    *pdev =3D pchan->pdev;
+	int status =3D -1;
+
+	down(&pdev->access_lock);
+
+	/* Select the channel */
+	ds2482_wait_1wire_idle(pdev);
+	if (pdev->w1_count > 1) {
+		ds2482_set_channel(pdev, pchan->channel);
+	}
+
+	if (!ds2482_send_cmd_data(pdev, DS2482_CMD_1WIRE_SINGLE_BIT, bit ? 0xFF :=
 0)) {
+		/* Wait until 1WB =3D 0, return the status */
+		status =3D ds2482_wait_1wire_idle(pdev);
+	}
+	up(&pdev->access_lock);
+
+	return((status & DS2482_REG_STS_SBR) ? 1 : 0);
+}
+
+/**
+ * Performs the triplet function, which reads two bits and writes a bit.
+ * The bit written is determined by the two reads:=20
+ *   00 =3D> dbit, 01 =3D> 0, 10 =3D> 1
+ *=20
+ * @param data       The ds2482 channel pointer
+ * @param dbit       The direction to choose if both branches are valid
+ * @return           b0=3Dread1 b1=3Dread2 b3=3Dbit written
+ */
+static u8 ds2482_w1_triplet(unsigned long data, u8 dbit)
+{
+	struct ds2482_w1_chan *pchan =3D (struct ds2482_w1_chan *)data;
+	struct ds2482_data    *pdev =3D pchan->pdev;
+	int status=3D3, result;
+
+	down(&pdev->access_lock);
+
+	/* Select the channel */
+	ds2482_wait_1wire_idle(pdev);
+	if (pdev->w1_count > 1) {
+		ds2482_set_channel(pdev, pchan->channel);
+	}
+
+	/* Send the triplet command */
+	if (!ds2482_send_cmd_data(pdev, DS2482_CMD_1WIRE_TRIPLET, dbit ? 0xFF : 0=
)) {
+		/* Wait until 1WB =3D 0, grab the status */
+		status =3D ds2482_wait_1wire_idle(pdev);
+	}
+	up(&pdev->access_lock);
+
+	/* Decode the status */
+	result =3D (status >> 5);
+	return(result);
+}
+
+/**
+ * Performs the write byte function.
+ *=20
+ * @param data       The ds2482 channel pointer
+ * @param byte       The value to write
+ */
+static void ds2482_w1_write_byte(unsigned long data, u8 byte)
+{
+	struct ds2482_w1_chan *pchan =3D (struct ds2482_w1_chan *)data;
+	struct ds2482_data    *pdev =3D pchan->pdev;
+
+	down(&pdev->access_lock);
+
+	/* Select the channel */
+	ds2482_wait_1wire_idle(pdev);
+	if (pdev->w1_count > 1) {
+		ds2482_set_channel(pdev, pchan->channel);
+	}
+
+	/* Send the write byte command */
+	ds2482_send_cmd_data(pdev, DS2482_CMD_1WIRE_WRITE_BYTE, byte);
+
+	up(&pdev->access_lock);
+}
+
+/**
+ * Performs the read byte function.
+ *=20
+ * @param data       The ds2482 channel pointer
+ * @return           The value read
+ */
+static u8 ds2482_w1_read_byte(unsigned long data)
+{
+	struct ds2482_w1_chan *pchan =3D (struct ds2482_w1_chan *)data;
+	struct ds2482_data    *pdev =3D pchan->pdev;
+	int result;
+
+	down(&pdev->access_lock);
+
+	/* Select the channel */
+	ds2482_wait_1wire_idle(pdev);
+	if (pdev->w1_count > 1) {
+		ds2482_set_channel(pdev, pchan->channel);
+	}
+
+	/* Send the read byte command */
+	ds2482_send_cmd(pdev, DS2482_CMD_1WIRE_READ_BYTE);
+
+	/* Wait until 1WB =3D 0 */
+	ds2482_wait_1wire_idle(pdev);
+
+	/* Select the data register */
+	ds2482_select_register(pdev, DS2482_PTR_CODE_DATA);
+
+	/* Read the data byte */
+	result =3D i2c_smbus_read_byte(&pdev->client);
+
+	up(&pdev->access_lock);
+
+	return((u8)result);
+}
+
+
+/**
+ * Sends a reset on the 1-wire interface
+ *=20
+ * @param data    The ds2482 channel pointer
+ * @return        0=DEvice present, 1=3DNo device present or error
+ */
+static u8 ds2482_w1_reset_bus(unsigned long data)
+{
+	struct ds2482_w1_chan *pchan =3D (struct ds2482_w1_chan *)data;
+	struct ds2482_data    *pdev =3D pchan->pdev;
+	int err;
+	u8 retval =3D 1;
+
+	down(&pdev->access_lock);
+
+	/* Select the channel */
+	ds2482_wait_1wire_idle(pdev);
+	if (pdev->w1_count > 1) {
+		ds2482_set_channel(pdev, pchan->channel);
+	}
+
+	/* Send the reset command */
+	err =3D ds2482_send_cmd(pdev, DS2482_CMD_1WIRE_RESET);
+	if (err >=3D 0) {
+		/* Wait until the reset is complete */
+		err =3D ds2482_wait_1wire_idle(pdev);
+		retval =3D (err & DS2482_REG_STS_PPD) ? 0 : 1;
+
+		/* If the chip did reset since detect, re-config it */
+		if (err & DS2482_REG_STS_RST) {
+			ds2482_send_cmd_data(pdev, DS2482_CMD_WRITE_CONFIG, 0xF0);
+		}
+	}
+
+	up(&pdev->access_lock);
+
+	return(retval);
+}
+
+
+/**
+ * Called to see if the device exists on an i2c bus.
+ */
+static int ds2482_attach_adapter(struct i2c_adapter *adapter)
+{
+	if ( !(adapter->class & I2C_CLASS_HWMON) )
+		return(0);
+
+	return(i2c_detect(adapter, &addr_data, ds2482_detect));
+}
+
+
+/*
+ * The following function does more than just detection. If detection
+ * succeeds, it also registers the new chip.
+ */
+static int ds2482_detect(struct i2c_adapter *adapter, int address, int kin=
d)
+{
+	struct ds2482_data *data;
+	struct i2c_client  *new_client;
+	int err =3D 0;
+	int temp1;
+	int idx;
+
+	if ( !i2c_check_functionality(adapter,=20
+				      I2C_FUNC_SMBUS_BYTE_DATA |=20
+				      I2C_FUNC_SMBUS_BYTE) ) {
+		goto exit;
+	}
+
+	if ( !(data =3D kmalloc(sizeof(struct ds2482_data), GFP_KERNEL)) ) {
+		err =3D -ENOMEM;
+		goto exit;
+	}
+	memset(data, 0, sizeof(struct ds2482_data));
+
+	new_client =3D &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr =3D address;
+	new_client->adapter =3D adapter;
+	new_client->driver =3D &ds2482_driver;
+	new_client->flags =3D 0;
+
+	/* Make sure the device exists */
+
+	/* Reset the device (sets the read_ptr to status) */
+	if ( ds2482_send_cmd(data, DS2482_CMD_RESET) < 0 ) {
+		dev_dbg(&adapter->dev, "DS2482 reset failed at 0x%02x.\n", address);
+		goto exit_free;
+	}
+
+	/* Sleep at least 525ns to allow the reset to complete */
+	ndelay(525);
+
+	/* Read the status byte - expect reset bit and line to be set */
+	temp1 =3D i2c_smbus_read_byte(new_client);
+	if (temp1 !=3D (DS2482_REG_STS_LL | DS2482_REG_STS_RST)) {
+		dev_dbg(&adapter->dev, "DS2482 (0x%02x) reset status 0x%02X - not a DS24=
82\n", address, temp1);
+		goto exit_free;
+	}
+
+	/* Set all config items to 0 (off) */
+	ds2482_send_cmd_data(data, DS2482_CMD_WRITE_CONFIG, 0xF0);
+
+	/* Set the read pointer to config */
+	if ( ds2482_select_register(data, DS2482_PTR_CODE_CONFIG) < 0 ) {
+		dev_dbg(&adapter->dev, "DS2482 write failed at 0x%02x.\n", address);
+		goto exit_free;
+	}
+
+	/* Detect the 8-port version */
+	data->w1_count =3D 1;
+	if (ds2482_set_channel(data, 7) =3D 0) {
+		data->w1_count =3D 8;
+	}
+
+	/* We can fill in the remaining client fields */
+	sprintf(new_client->name, "ds2482-%d00", data->w1_count);
+
+	init_MUTEX(&data->access_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ( (err =3D i2c_attach_client(new_client)) )
+		goto exit_free;
+
+	/* Register 1-wire interface(s) */
+	for (idx =3D 0; idx < data->w1_count; idx++) {
+		data->w1_ch[idx].pdev =3D data;
+		data->w1_ch[idx].channel =3D idx;
+
+		/* Populate all the w1 bus master stuff */
+		data->w1_ch[idx].w1_bus_master.data =3D (unsigned long)&data->w1_ch[idx];
+		data->w1_ch[idx].w1_bus_master.read_byte  =3D ds2482_w1_read_byte;
+		data->w1_ch[idx].w1_bus_master.write_byte =3D ds2482_w1_write_byte;
+		data->w1_ch[idx].w1_bus_master.touch_bit  =3D ds2482_w1_touch_bit;
+		data->w1_ch[idx].w1_bus_master.triplet    =3D ds2482_w1_triplet;
+		data->w1_ch[idx].w1_bus_master.reset_bus  =3D ds2482_w1_reset_bus;
+
+		err =3D w1_add_master_device(&data->w1_ch[idx].w1_bus_master);
+		if ( err ) {
+			data->w1_ch[idx].pdev =3D NULL;
+			goto exit_w1_remove;
+		}
+	}
+
+	return(0);
+
+exit_w1_remove:
+	for (idx =3D 0; idx < data->w1_count; idx++) {
+		if (data->w1_ch[idx].pdev !=3D NULL) {
+			w1_remove_master_device(&data->w1_ch[idx].w1_bus_master);
+		}
+	}
+exit_free:
+	kfree(data);
+exit:
+	return(err);
+}
+
+static int ds2482_detach_client(struct i2c_client *client)
+{
+	struct ds2482_data   *data =3D i2c_get_clientdata(client);
+	int err, idx;
+
+	/* Unregister the 1-wire bridge(s) */
+	for (idx =3D 0; idx < data->w1_count; idx++) {
+		if (data->w1_ch[idx].pdev !=3D NULL) {
+			w1_remove_master_device(&data->w1_ch[idx].w1_bus_master);
+		}
+	}
+
+	/* Detach the i2c device */
+	if ( (err =3D i2c_detach_client(client)) ) {
+		dev_err(&client->dev,
+			"Client deregistration failed, client not detached.\n");
+		return(err);
+	}
+
+	/* Free the memory */
+	kfree(data);
+	return(0);
+}
+
+static int __init sensors_ds2482_init(void)
+{
+	return(i2c_add_driver(&ds2482_driver));
+}
+
+static void __exit sensors_ds2482_exit(void)
+{
+	i2c_del_driver(&ds2482_driver);
+}
+
+MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
+MODULE_DESCRIPTION("DS2482 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_ds2482_init);
+module_exit(sensors_ds2482_exit);
+
diff -Naur linux-2.6.12-rc5-mm2-clean/drivers/i2c/chips/Kconfig linux-2.6.1=
2-rc5-mm2-ds2482/drivers/i2c/chips/Kconfig
--- linux-2.6.12-rc5-mm2-clean/drivers/i2c/chips/Kconfig	2005-06-01 14:29:1=
7.000000000 -0500
+++ linux-2.6.12-rc5-mm2-ds2482/drivers/i2c/chips/Kconfig	2005-06-02 12:46:=
00.501253723 -0500
@@ -488,6 +488,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps65010.
=20
+config SENSORS_DS2482
+	tristate "MAXIM DS2482 I2C to 1-Wire bridge"
+	depends on I2C && EXPERIMENTAL
+	select W1
+	help
+	  If you say yes here you get support for the MAXIM DS2482
+	  I2C to 1-Wire bridge.
+	  This, obviously, requires the 1-Wire subsystem (W1)
+	 =20
+	  This driver can also be built as a module.  If so, the module
+	  will be called ds2482.
=20
 config SENSORS_M41T00
 	tristate "ST M41T00 RTC chip"
@@ -498,4 +509,5 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called m41t00.
=20
+
 endmenu
diff -Naur linux-2.6.12-rc5-mm2-clean/drivers/i2c/chips/Makefile linux-2.6.=
12-rc5-mm2-ds2482/drivers/i2c/chips/Makefile
--- linux-2.6.12-rc5-mm2-clean/drivers/i2c/chips/Makefile	2005-06-01 14:29:=
17.000000000 -0500
+++ linux-2.6.12-rc5-mm2-ds2482/drivers/i2c/chips/Makefile	2005-06-02 12:42=
:59.510290478 -0500
@@ -45,6 +45,7 @@
 obj-$(CONFIG_SENSORS_W83L785TS)	+=3D w83l785ts.o
=20
 obj-$(CONFIG_ISP1301_OMAP)	+=3D isp1301_omap.o
+obj-$(CONFIG_SENSORS_DS2482)	+=3D ds2482.o
 obj-$(CONFIG_TPS65010)		+=3D tps65010.o
=20
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
