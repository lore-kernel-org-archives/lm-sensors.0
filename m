From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <Pine.LNX.4.53.0312271638180.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Forget about -km-2 and -km-6. I will post them in smaller parts.

Patch -km-7 : Drop 2.2 code.
Patch -km-8 : User progs don't include kernel files.
Patch -km-9 : Message block size.
Patch -km-10 : Remove SLO_IO in algo-bit.
Patch -km-11 : Bus scan removal, bit & pcf.
Patch -km-12 : Add new IDs.
Patch -km-13 : Unused code, whitespace.

Yes, christmas got cancelled ;)

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
-------------- next part --------------
Only in lk-i2c-km-7/drivers/i2c: i2c-dev.c.orig
diff -ur lk-i2c-km-6/drivers/i2c/i2c-proc.c lk-i2c-km-7/drivers/i2c/i2c-proc.c
--- lk-i2c-km-6/drivers/i2c/i2c-proc.c	2003-12-22 21:09:37.000000000 +0200
+++ lk-i2c-km-7/drivers/i2c/i2c-proc.c	2003-12-25 11:38:16.000000000 +0200
@@ -209,48 +209,6 @@
 	}
 }
 
-/* Monitor access for /proc/sys/dev/sensors; make unloading i2c-proc.o 
-   impossible if some process still uses it or some file in it */
-void i2c_fill_inode(struct inode *inode, int fill)
-{
-	if (fill)
-		MOD_INC_USE_COUNT;
-	else
-		MOD_DEC_USE_COUNT;
-}
-
-/* Monitor access for /proc/sys/dev/sensors/ directories; make unloading
-   the corresponding module impossible if some process still uses it or
-   some file in it */
-void i2c_dir_fill_inode(struct inode *inode, int fill)
-{
-	int i;
-	struct i2c_client *client;
-
-#ifdef DEBUG
-	if (!inode) {
-		printk("i2c-proc.o: Warning: inode NULL in fill_inode()\n");
-		return;
-	}
-#endif				/* def DEBUG */
-
-	for (i = 0; i < SENSORS_ENTRY_MAX; i++)
-		if (i2c_clients[i]
-		    && (i2c_inodes[i] = inode->i_ino)) break;
-#ifdef DEBUG
-	if (i = SENSORS_ENTRY_MAX) {
-		printk
-		    ("i2c-proc.o: Warning: inode (%ld) not found in fill_inode()\n",
-		     inode->i_ino);
-		return;
-	}
-#endif				/* def DEBUG */
-	client = i2c_clients[i];
-	if (fill)
-		client->driver->inc_use(client);
-	else
-		client->driver->dec_use(client);
-}
 
 int i2c_proc_chips(ctl_table * ctl, int write, struct file *filp,
 		       void *buffer, size_t * lenp)
Only in lk-i2c-km-7/drivers/i2c: i2c-proc.c~
-------------- next part --------------
Only in lk-i2c-km-7/drivers/i2c: i2c-dev.c.orig
Only in lk-i2c-km-7/drivers/i2c: i2c-proc.c~
diff -ur lk-i2c-km-7/include/linux/i2c-dev.h lk-i2c-km-8/include/linux/i2c-dev.h
--- lk-i2c-km-7/include/linux/i2c-dev.h	2003-12-23 00:41:47.000000000 +0200
+++ lk-i2c-km-8/include/linux/i2c-dev.h	2003-12-25 12:19:20.000000000 +0200
@@ -43,137 +43,4 @@
 	__u32 nmsgs;		/* number of i2c_msgs */
 };
 
-#ifndef __KERNEL__
-
-#include <sys/ioctl.h>
-
-static inline __s32 i2c_smbus_access(int file, char read_write, __u8 command, 
-                                     int size, union i2c_smbus_data *data)
-{
-	struct i2c_smbus_ioctl_data args;
-
-	args.read_write = read_write;
-	args.command = command;
-	args.size = size;
-	args.data = data;
-	return ioctl(file,I2C_SMBUS,&args);
-}
-
-
-static inline __s32 i2c_smbus_write_quick(int file, __u8 value)
-{
-	return i2c_smbus_access(file,value,0,I2C_SMBUS_QUICK,NULL);
-}
-	
-static inline __s32 i2c_smbus_read_byte(int file)
-{
-	union i2c_smbus_data data;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,0,I2C_SMBUS_BYTE,&data))
-		return -1;
-	else
-		return 0x0FF & data.byte;
-}
-
-static inline __s32 i2c_smbus_write_byte(int file, __u8 value)
-{
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,value,
-	                        I2C_SMBUS_BYTE,NULL);
-}
-
-static inline __s32 i2c_smbus_read_byte_data(int file, __u8 command)
-{
-	union i2c_smbus_data data;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
-	                     I2C_SMBUS_BYTE_DATA,&data))
-		return -1;
-	else
-		return 0x0FF & data.byte;
-}
-
-static inline __s32 i2c_smbus_write_byte_data(int file, __u8 command, 
-                                              __u8 value)
-{
-	union i2c_smbus_data data;
-	data.byte = value;
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                        I2C_SMBUS_BYTE_DATA, &data);
-}
-
-static inline __s32 i2c_smbus_read_word_data(int file, __u8 command)
-{
-	union i2c_smbus_data data;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
-	                     I2C_SMBUS_WORD_DATA,&data))
-		return -1;
-	else
-		return 0x0FFFF & data.word;
-}
-
-static inline __s32 i2c_smbus_write_word_data(int file, __u8 command, 
-                                              __u16 value)
-{
-	union i2c_smbus_data data;
-	data.word = value;
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                        I2C_SMBUS_WORD_DATA, &data);
-}
-
-static inline __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value)
-{
-	union i2c_smbus_data data;
-	data.word = value;
-	if (i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                     I2C_SMBUS_PROC_CALL,&data))
-		return -1;
-	else
-		return 0x0FFFF & data.word;
-}
-
-
-/* Returns the number of read bytes */
-static inline __s32 i2c_smbus_read_block_data(int file, __u8 command, 
-                                              __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
-	                     I2C_SMBUS_BLOCK_DATA,&data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-			return data.block[0];
-	}
-}
-
-static inline __s32 i2c_smbus_write_block_data(int file, __u8 command, 
-                                               __u8 length, __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > 32)
-		length = 32;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                        I2C_SMBUS_BLOCK_DATA, &data);
-}
-
-static inline __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command,
-                                               __u8 length, __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > 32)
-		length = 32;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                        I2C_SMBUS_I2C_BLOCK_DATA, &data);
-}
-
-#endif /* ndef __KERNEL__ */
-
-#endif
+#endif /* _LINUX_I2C_DEV_H */
Only in lk-i2c-km-8/include/linux: i2c-dev.h~
-------------- next part --------------
diff -ur lk-i2c-km-8/drivers/i2c/i2c-core.c lk-i2c-km-9/drivers/i2c/i2c-core.c
--- lk-i2c-km-8/drivers/i2c/i2c-core.c	2003-12-25 14:34:50.000000000 +0200
+++ lk-i2c-km-9/drivers/i2c/i2c-core.c	2003-12-25 14:36:41.000000000 +0200
@@ -1029,8 +1029,8 @@
 {
 	union i2c_smbus_data data;
 	int i;
-	if (length > 32)
-		length = 32;
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
 	for (i = 1; i <= length; i++)
 		data.block[i] = values[i-1];
 	data.block[0] = length;
@@ -1044,8 +1044,8 @@
 {
 	union i2c_smbus_data data;
 	int i;
-	if (length > 32)
-		length = 32;
+	if (length > I2C_SMBUS_I2C_BLOCK_MAX)
+		length = I2C_SMBUS_I2C_BLOCK_MAX;
 	for (i = 1; i <= length; i++)
 		data.block[i] = values[i-1];
 	data.block[0] = length;
@@ -1119,7 +1119,7 @@
 			return -1;
 		} else {
 			msg[0].len = data->block[0] + 2;
-			if (msg[0].len > 34) {
+			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
 				printk(KERN_ERR "i2c-core.o: smbus_access called with "
 				       "invalid block write size (%d)\n",
 				       msg[0].len);
Only in lk-i2c-km-9/drivers/i2c: i2c-core.c~
diff -ur lk-i2c-km-8/include/linux/i2c.h lk-i2c-km-9/include/linux/i2c.h
--- lk-i2c-km-8/include/linux/i2c.h	2003-12-25 14:34:50.000000000 +0200
+++ lk-i2c-km-9/include/linux/i2c.h	2003-12-25 14:37:56.000000000 +0200
@@ -405,10 +405,11 @@
 /* 
  * Data for SMBus Messages 
  */
+#define I2C_SMBUS_BLOCK_MAX	32	/* As specified in SMBus standard */	
 union i2c_smbus_data {
 	__u8 byte;
 	__u16 word;
-	__u8 block[33]; /* block[0] is used for length */
+	__u8 block[I2C_SMBUS_BLOCK_MAX + 1]; /* block[0] is used for length */
 };
 
 /* smbus_access read or write markers */
Only in lk-i2c-km-9/include/linux: i2c.h~
-------------- next part --------------
diff -ur lk-i2c-km-9/drivers/i2c/i2c-algo-bit.c lk-i2c-km-10/drivers/i2c/i2c-algo-bit.c
--- lk-i2c-km-9/drivers/i2c/i2c-algo-bit.c	2003-12-25 14:59:06.000000000 +0200
+++ lk-i2c-km-10/drivers/i2c/i2c-algo-bit.c	2003-12-25 14:58:35.000000000 +0200
@@ -41,22 +41,9 @@
 #define DEBPROTO(x) if (i2c_debug>=9) { x; }
  	/* debug the protocol by showing transferred bits */
 
-/* debugging - slow down transfer to have a look at the data .. 	*/
-/* I use this with two leds&resistors, each one connected to sda,scl 	*/
-/* respectively. This makes sure that the algorithm works. Some chips   */
-/* might not like this, as they have an internal timeout of some mils	*/
-/*
-#define SLO_IO      jif=jiffies;while(time_before_eq(jiffies, jif+i2c_table[minor].veryslow))\
-                        if (need_resched) schedule();
-*/
-
 
 /* ----- global variables ---------------------------------------------	*/
 
-#ifdef SLO_IO
-	int jif;
-#endif
-
 /* module parameters:
  */
 static int i2c_debug;
@@ -86,9 +73,6 @@
 {
 	setscl(adap,0);
 	udelay(adap->udelay);
-#ifdef SLO_IO
-	SLO_IO
-#endif
 }
 
 /*
@@ -121,9 +105,6 @@
 			schedule();
 	}
 	DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
-#ifdef SLO_IO
-	SLO_IO
-#endif
 	return 0;
 } 
 
Only in lk-i2c-km-10/drivers/i2c: i2c-algo-bit.c~
-------------- next part --------------
diff -ur lk-i2c-km-10/drivers/i2c/i2c-algo-bit.c lk-i2c-km-11/drivers/i2c/i2c-algo-bit.c
--- lk-i2c-km-10/drivers/i2c/i2c-algo-bit.c	2003-12-25 14:58:35.000000000 +0200
+++ lk-i2c-km-11/drivers/i2c/i2c-algo-bit.c	2003-12-25 15:03:09.000000000 +0200
@@ -48,7 +48,6 @@
  */
 static int i2c_debug;
 static int bit_test;	/* see if the line-setting functions work	*/
-static int bit_scan;	/* have a look at what's hanging 'round		*/
 
 /* --- setting states on the bus with the right timing: ---------------	*/
 
@@ -521,7 +520,6 @@
  */
 int i2c_bit_add_bus(struct i2c_adapter *adap)
 {
-	int i;
 	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
 
 	if (bit_test) {
@@ -541,23 +539,6 @@
 	adap->timeout = 100;	/* default values, should	*/
 	adap->retries = 3;	/* be replaced by defines	*/
 
-	/* scan bus */
-	if (bit_scan) {
-		int ack;
-		printk(KERN_INFO " i2c-algo-bit.o: scanning bus %s.\n",
-		       adap->name);
-		for (i = 0x00; i < 0xff; i+=2) {
-			i2c_start(bit_adap);
-			ack = i2c_outb(adap,i);
-			i2c_stop(bit_adap);
-			if (ack>0) {
-				printk("(%02x)",i>>1); 
-			} else 
-				printk("."); 
-		}
-		printk("\n");
-	}
-
 	i2c_add_adapter(adap);
 	return 0;
 }
@@ -576,10 +557,8 @@
 MODULE_LICENSE("GPL");
 
 MODULE_PARM(bit_test, "i");
-MODULE_PARM(bit_scan, "i");
 MODULE_PARM(i2c_debug,"i");
 
 MODULE_PARM_DESC(bit_test, "Test the lines of the bus to see if it is stuck");
-MODULE_PARM_DESC(bit_scan, "Scan for active chips on the bus");
 MODULE_PARM_DESC(i2c_debug,
 		 "debug level - 0 off; 1 normal; 2,3 more verbose; 9 bit-protocol");
diff -ur lk-i2c-km-10/drivers/i2c/i2c-algo-pcf.c lk-i2c-km-11/drivers/i2c/i2c-algo-pcf.c
--- lk-i2c-km-10/drivers/i2c/i2c-algo-pcf.c	2003-12-22 23:22:21.000000000 +0200
+++ lk-i2c-km-11/drivers/i2c/i2c-algo-pcf.c	2003-12-25 15:03:03.000000000 +0200
@@ -48,7 +48,6 @@
 /* module parameters:
  */
 static int i2c_debug=0;
-static int pcf_scan=0;	/* have a look at what's hanging 'round		*/
 
 /* --- setting states on the bus with the right timing: ---------------	*/
 
@@ -469,30 +468,6 @@
 	}
 
 	i2c_add_adapter(adap);
-
-	/* scan bus */
-	if (pcf_scan) {
-		printk(KERN_INFO " i2c-algo-pcf.o: scanning bus %s.\n",
-		       adap->name);
-		for (i = 0x00; i < 0xff; i+=2) {
-			if (wait_for_bb(pcf_adap)) {
-    			printk(KERN_INFO " i2c-algo-pcf.o: scanning bus %s - TIMEOUTed.\n",
-		           adap->name);
-			    break;
-			}
-			i2c_outb(pcf_adap, i);
-			i2c_start(pcf_adap);
-			if ((wait_for_pin(pcf_adap, &status) >= 0) && 
-			    ((status & I2C_PCF_LRB) = 0)) { 
-				printk("(%02x)",i>>1); 
-			} else {
-				printk("."); 
-			}
-			i2c_stop(pcf_adap);
-			udelay(pcf_adap->udelay);
-		}
-		printk("\n");
-	}
 	return 0;
 }
 
@@ -509,9 +484,6 @@
 MODULE_DESCRIPTION("I2C-Bus PCF8584 algorithm");
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(pcf_scan, "i");
 MODULE_PARM(i2c_debug,"i");
-
-MODULE_PARM_DESC(pcf_scan, "Scan for active chips on the bus");
 MODULE_PARM_DESC(i2c_debug,
         "debug level - 0 off; 1 normal; 2,3 more verbose; 9 pcf-protocol");
-------------- next part --------------
diff -ur lk-i2c-km-11/include/linux/i2c-id.h lk-i2c-km-12/include/linux/i2c-id.h
--- lk-i2c-km-11/include/linux/i2c-id.h	2003-12-22 20:50:13.000000000 +0200
+++ lk-i2c-km-12/include/linux/i2c-id.h	2003-12-25 15:13:18.000000000 +0200
@@ -91,7 +91,23 @@
 #define I2C_DRIVERID_DRP3510	43     /* ADR decoder (Astra Radio)	*/
 #define I2C_DRIVERID_SP5055	44     /* Satellite tuner		*/
 #define I2C_DRIVERID_STV0030	45     /* Multipurpose switch		*/
+#define I2C_DRIVERID_SAA7108	46     /* video decoder, image scaler   */
+#define I2C_DRIVERID_DS1307	47     /* DS1307 real time clock	*/
 #define I2C_DRIVERID_ADV7175	48     /* ADV 7175/7176 video encoder	*/
+#define I2C_DRIVERID_ZR36067	49     /* Zoran 36067 video encoder	*/
+#define I2C_DRIVERID_ZR36120	50     /* Zoran 36120 video encoder	*/
+#define I2C_DRIVERID_24LC32A	51	/* Microchip 24LC32A 32k EEPROM	*/
+#define I2C_DRIVERID_STM41T00	52	/* real time clock		*/
+#define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
+#define I2C_DRIVERID_ADV7170	54	/* video encoder		*/
+#define I2C_DRIVERID_RADEON	55	/* I2C bus on Radeon boards	*/
+#define I2C_DRIVERID_MAX1617	56	/* temp sensor			*/
+#define I2C_DRIVERID_SAA7191	57	/* video encoder		*/
+#define I2C_DRIVERID_INDYCAM	58	/* SGI IndyCam			*/
+#define I2C_DRIVERID_BT832	59	/* CMOS camera video processor  */
+#define I2C_DRIVERID_TDA9887	60	/* TDA988x IF-PLL demodulator	*/
+
+
 
 #define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/
 #define I2C_DRIVERID_EXP1	0xF1
@@ -100,6 +116,8 @@
 
 #define I2C_DRIVERID_I2CDEV	900
 #define I2C_DRIVERID_I2CPROC	901
+#define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */
+#define I2C_DRIVERID_ALERT      903    /* SMBus Alert Responder Client  */
 
 /* IDs --   Use DRIVERIDs 1000-1999 for sensors. 
    These were originally in sensors.h in the lm_sensors package */
@@ -129,6 +147,25 @@
 #define I2C_DRIVERID_ADM1024 1025
 #define I2C_DRIVERID_IT87 1026
 #define I2C_DRIVERID_CH700X 1027 /* single driver for CH7003-7009 digital pc to tv encoders */
+#define I2C_DRIVERID_FSCPOS 1028
+#define I2C_DRIVERID_FSCSCY 1029
+#define I2C_DRIVERID_PCF8591 1030
+#define I2C_DRIVERID_SMSC47M1 1031
+#define I2C_DRIVERID_VT1211 1032
+#define I2C_DRIVERID_LM92 1033
+#define I2C_DRIVERID_VT8231 1034
+#define I2C_DRIVERID_SMARTBATT 1035
+#define I2C_DRIVERID_BMCSENSORS 1036
+#define I2C_DRIVERID_FS451 1037
+#define I2C_DRIVERID_W83627HF 1038
+#define I2C_DRIVERID_LM85 1039
+#define I2C_DRIVERID_LM83 1040
+#define I2C_DRIVERID_SAA1064 1041
+#define I2C_DRIVERID_LM90 1042
+#define I2C_DRIVERID_ASB100 1043
+#define I2C_DRIVERID_MAX6650 1044
+#define I2C_DRIVERID_XEONTEMP 1045
+#define I2C_DRIVERID_FSCHER 1046
 
 /*
  * ---- Adapter types ----------------------------------------------------
@@ -145,10 +182,21 @@
 #define I2C_ALGO_ISA 	0x050000	/* lm_sensors ISA pseudo-adapter */
 #define I2C_ALGO_SAA7146 0x060000	/* SAA 7146 video decoder bus	*/
 #define I2C_ALGO_ACB 	0x070000	/* ACCESS.bus algorithm         */
-
+#define I2C_ALGO_IIC    0x080000 	/* ITE IIC bus */
+#define I2C_ALGO_SAA7134 0x090000
+#define I2C_ALGO_MPC824X 0x0a0000	/* Motorola 8240 / 8245         */
+#define I2C_ALGO_IPMI 	0x0b0000	/* IPMI dummy adapter */
+#define I2C_ALGO_IPMB 	0x0c0000	/* IPMB adapter */
+#define I2C_ALGO_MPC107 0x0d0000
 #define I2C_ALGO_EC     0x100000        /* ACPI embedded controller     */
 
 #define I2C_ALGO_MPC8XX 0x110000	/* MPC8xx PowerPC I2C algorithm */
+#define I2C_ALGO_OCP    0x120000	/* IBM or otherwise On-chip I2C algorithm */
+#define I2C_ALGO_BITHS	0x130000	/* enhanced bit style adapters	*/
+#define I2C_ALGO_OCP_IOP3XX  0x140000	/* XSCALE IOP3XX On-chip I2C alg */
+#define I2C_ALGO_SIBYTE	0x150000	/* Broadcom SiByte SOCs         */
+#define I2C_ALGO_SGI	0x160000	/* SGI algorithm                */
+#define I2C_ALGO_USB	0x170000	/* USB algorithm		*/
 
 #define I2C_ALGO_EXP	0x800000	/* experimental			*/
 
@@ -176,21 +224,46 @@
 #define I2C_HW_B_I810	0x0a	/* Intel I810 				*/
 #define I2C_HW_B_VOO	0x0b	/* 3dfx Voodoo 3 / Banshee      	*/
 #define I2C_HW_B_PPORT  0x0c	/* Primitive parallel port adapter	*/
+#define I2C_HW_B_SAVG	0x0d	/* Savage 4                     	*/
+#define I2C_HW_B_SCX200	0x0e	/* Nat'l Semi SCx200 I2C        	*/
 #define I2C_HW_B_RIVA	0x10	/* Riva based graphics cards		*/
 #define I2C_HW_B_IOC	0x11	/* IOC bit-wiggling			*/
 #define I2C_HW_B_TSUNA  0x12	/* DEC Tsunami chipset			*/
+#define I2C_HW_B_FRODO  0x13    /* 2d3D, Inc. SA-1110 Development Board */
+#define I2C_HW_B_OMAHA  0x14    /* Omaha I2C interface (ARM)		*/
+#define I2C_HW_B_GUIDE  0x15    /* Guide bit-basher			*/
+#define I2C_HW_B_IXP2000 0x16	/* GPIO on IXP2000 systems              */
+#define I2C_HW_B_IXP425 0x17	/* GPIO on IXP425 systems		*/
+#define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
+#define I2C_HW_B_ZR36067 0x19	/* Zoran-36057/36067 based boards	*/
+#define I2C_HW_B_PCILYNX 0x20	/* TI PCILynx I2C adapter		*/
 
 /* --- PCF 8584 based algorithms					*/
 #define I2C_HW_P_LP	0x00	/* Parallel port interface		*/
 #define I2C_HW_P_ISA	0x01	/* generic ISA Bus inteface card	*/
 #define I2C_HW_P_ELEK	0x02	/* Elektor ISA Bus inteface card	*/
 
+/* --- USB based adapters						*/
+#define I2C_HW_USB_USBVISION	0x00
+
 /* --- ACPI Embedded controller algorithms                              */
 #define I2C_HW_ACPI_EC          0x00
 
+/* --- MPC824x PowerPC adapters						*/
+#define I2C_HW_MPC824X 0x00	/* Motorola 8240 / 8245                 */
+
 /* --- MPC8xx PowerPC adapters						*/
 #define I2C_HW_MPC8XX_EPON 0x00	/* Eponymous MPC8xx I2C adapter 	*/
 
+/* --- ITE based algorithms						*/
+#define I2C_HW_I_IIC	0x00	/* controller on the ITE */
+
+/* --- PowerPC on-chip adapters						*/
+#define I2C_HW_OCP 0x00	/* IBM on-chip I2C adapter 	*/
+
+/* --- XSCALE on-chip adapters                          */
+#define I2C_HW_IOP321 0x00
+
 /* --- SMBus only adapters						*/
 #define I2C_HW_SMBUS_PIIX4	0x00
 #define I2C_HW_SMBUS_ALI15X3	0x01
@@ -200,9 +273,23 @@
 #define I2C_HW_SMBUS_AMD756	0x05
 #define I2C_HW_SMBUS_SIS5595	0x06
 #define I2C_HW_SMBUS_ALI1535	0x07
+#define I2C_HW_SMBUS_SIS630	0x08
+#define I2C_HW_SMBUS_SIS645	0x09
+#define I2C_HW_SMBUS_AMD8111	0x0a
+#define I2C_HW_SMBUS_SCX200	0x0b
+#define I2C_HW_SMBUS_NFORCE2	0x0c
 #define I2C_HW_SMBUS_W9968CF	0x0d
 
 /* --- ISA pseudo-adapter						*/
 #define I2C_HW_ISA 0x00
 
-#endif /* I2C_ID_H */
+/* --- IPMI pseudo-adapter						*/
+#define I2C_HW_IPMI 0x00
+
+/* --- IPMB adapter						*/
+#define I2C_HW_IPMB 0x00
+
+/* --- MCP107 adapter */
+#define I2C_HW_MPC107 0x00
+
+#endif /* LINUX_I2C_ID_H */
Only in lk-i2c-km-12/include/linux: i2c-id.h~
-------------- next part --------------
diff -ur lk-i2c-km-12/drivers/i2c/i2c-algo-bit.c lk-i2c-km-13/drivers/i2c/i2c-algo-bit.c
--- lk-i2c-km-12/drivers/i2c/i2c-algo-bit.c	2003-12-25 15:11:02.000000000 +0200
+++ lk-i2c-km-13/drivers/i2c/i2c-algo-bit.c	2003-12-25 15:41:06.000000000 +0200
@@ -492,12 +492,6 @@
 	return num;
 }
 
-static int algo_control(struct i2c_adapter *adapter, 
-	unsigned int cmd, unsigned long arg)
-{
-	return 0;
-}
-
 static u32 bit_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
diff -ur lk-i2c-km-12/drivers/i2c/i2c-algo-pcf.c lk-i2c-km-13/drivers/i2c/i2c-algo-pcf.c
--- lk-i2c-km-12/drivers/i2c/i2c-algo-pcf.c	2003-12-25 15:11:02.000000000 +0200
+++ lk-i2c-km-13/drivers/i2c/i2c-algo-pcf.c	2003-12-25 15:37:56.000000000 +0200
@@ -422,12 +422,6 @@
 	return (i);
 }
 
-static int algo_control(struct i2c_adapter *adapter, 
-	unsigned int cmd, unsigned long arg)
-{
-	return 0;
-}
-
 static u32 pcf_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
@@ -449,7 +443,7 @@
  */
 int i2c_pcf_add_bus(struct i2c_adapter *adap)
 {
-	int i, status;
+	int i;
 	struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
 
 	DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: hw routines for %s registered.\n",
diff -ur lk-i2c-km-12/drivers/i2c/i2c-core.c lk-i2c-km-13/drivers/i2c/i2c-core.c
--- lk-i2c-km-12/drivers/i2c/i2c-core.c	2003-12-25 14:39:23.000000000 +0200
+++ lk-i2c-km-13/drivers/i2c/i2c-core.c	2003-12-25 15:19:51.000000000 +0200
@@ -277,8 +277,8 @@
 						       "unregistering driver "
 						       "`%s', the client at "
 						       "address %02x of "
-						       "adapter `%s' could not"
-						       "be detached; driver"
+						       "adapter `%s' could not "
+						       "be detached; driver "
 						       "not unloaded!",
 						       driver->name,
 						       client->addr,
