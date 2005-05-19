From: info@wore.ma.cx (wore)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: SMSC LPC47M192 SMBus question
Message-Id: <87vf6ua498.wl@wore.ma.cx>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Yesterday, I have bought ASUS P4G800-V board for my home linux server.
I installed linux distribution, then I wanted to see and log cpu temp.
So, I installed lm_sensors to my box, but part of SMSC LPC47M192 is supported.
And I began to read datasheet(http://www.smsc.com/main/datasheets/47m192.pdf ).

It seems that I must access via SMBus to fetch temp and voltage.
in datasheet (page 129)
> The Hardware Monitoring Block is a standalone block in the 2.
> It can be accessed using SMBus interface.

Then, I browsed other chips codes and putted some printk debug and 
i2c_smbus_read_byte_data function as follows.

The result is failure.

> smsc47m1.o version 2.9.0 (20041228) compiled Apr 11 2005 02:02:47
> smsc47m1_find devid:0x60
> smsc47m1.o addr: 0x680
> i2c_check_functionality 0
> i2c_get_functionality(adapter):0x0
> i2c-core.o: I2C adapter 50000: I2C level transfers not supported
> 0x3e rets 0xffffffff

Anyone know how to access this chip via SMBus?

Regards,
wore

--

Here's my loaded modules.
$ /sbin/lsmod|grep i2c
i2c-proc                7748   0 [smsc47m1]
i2c-dev                 4576   0
i2c-i801                5884   0
i2c-isa                 1392   0
i2c-core               19588   0 [smsc47m1 i2c-proc i2c-dev i2c-i801 i2c-isa]

-- 

This is my debug test.

diff -aurN lm_sensors-2.9.0/kernel/chips/smsc47m1.c.orig lm_sensors-2.9.0/kernel/chips/smsc47m1.c
--- lm_sensors-2.9.0/kernel/chips/smsc47m1.c.orig	2005-04-10 15:48:04.000000000 +0900
+++ lm_sensors-2.9.0/kernel/chips/smsc47m1.c	2005-04-11 02:02:39.000000000 +0900
@@ -33,7 +33,7 @@
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the sensors");
 
-static unsigned short normal_i2c[] = { SENSORS_I2C_END };
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, SENSORS_I2C_END };
 static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };
 static unsigned int normal_isa[] = { 0x0000, SENSORS_ISA_END };
 static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
@@ -214,6 +214,7 @@
 		superio_exit();
 		return -ENODEV;
 	}
+	printk("smsc47m1_find devid:0x%x\n", val);
 
 	superio_select();
 	val = (superio_inb(SMSC_BASE_REG) << 8) |
@@ -245,6 +246,15 @@
 		return 0;
 	}
 
+	if (i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+	  printk("i2c_check_functionality 1\n");
+	} else {
+	  printk("i2c_check_functionality 0\n");
+	}
+
+	printk("i2c_get_functionality(adapter):0x%x\n",
+	       i2c_get_functionality(adapter));
+
 	if(force_addr)
 		address = force_addr & ~(SMSC_EXTENT - 1);
 	if (check_region(address, SMSC_EXTENT)) {
@@ -344,6 +354,8 @@
 	/* configure pins for tach function */
 	smsc47m1_write_value(client, SMSC47M1_REG_TPIN1, 0x05);
 	smsc47m1_write_value(client, SMSC47M1_REG_TPIN2, 0x05);
+	printk("0x3e (company id) rets 0x%x\n", 
+	       i2c_smbus_read_byte_data(client, 0x3e));
 }
 
 static void smsc47m1_update_client(struct i2c_client *client)
@@ -488,12 +500,14 @@
 {
 	int addr;
 
-	printk("smsc47m1.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	printk("smsc47m1.o version %s (%s) compiled %s %s\n",
+	       LM_VERSION, LM_DATE, __DATE__, __TIME__);
 
 	if (smsc47m1_find(&addr)) {
 		printk("smsc47m1.o: SMSC 47M1xx not detected, module not inserted.\n");
 		return -ENODEV;
 	}
+	printk("smsc47m1.o addr: 0x%x\n", addr);
 	normal_isa[0] = addr;
 
 	return i2c_add_driver(&smsc47m1_driver);
