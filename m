From: vojtech@suse.cz (Vojtech Pavlik)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Last call 2.7.0
Message-Id: <20021130181526.A23444@ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DE2BB4D.A6B73F17@paradyne.com>
In-Reply-To: <3DE2BB4D.A6B73F17@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 25, 2002 at 07:07:41PM -0500, Mark D. Studebaker wrote:

> everything should be in by now.

Thanks. In the meantime I obtained a winbond w83791d CNR testing card
and implemented/fixed PEC and process calls, and block reads/writes in
the driver. ARP now works with smbus-arp.c. Patch attached.

> Please review / update documentation for dependencies on i2c, etc.
> I already took a shot at README, INSTALL, QUICKSTART.

Thanks. All looks OK.

> Please test compilation/installation on 2.2/2.4.

2.2 doesn't (cannot) work, the driver uses too much of 2.4
functionality. 2.2 doesn't support the x86_64 (Hammer) architecture
anyway ...

> Would like to give Phil the goahead on Thursday or Friday.
> thanks
> mds
> 
> 
> Jean Delvare wrote:
> > 
> > > i2c-proc.[ch] were moved from lm_sensors to i2c in 2.6.0.
> > > This allowed other drivers (particularly non-sensors drivers)
> > > to easily use our /proc interface.
> > >
> > > One unfortunate consequence was increased dependencies on i2c.
> > > But I don't think we want to take i2c-proc back.
> > 
> > Not i2c-proc in its whole, only the incriminated macros.
> > 
> > Maybe a good solution to prevent us from breaking the dependencies for a
> > single macro would be to define it in both i2c (for the long term) and
> > lm_sensors (in some compatibility header file, for the short term, with
> > the appropriate #ifndef to prevent redundant declarations). The same
> > header file could serve the same puprose if the occasion arise again.
> > 
> > Anyway, I am simply suggesting this in case we *don't* want to break
> > dependencies. If we decide we don't care, all this makes little sense.
> > Personaly I don't care, I'll always have an up-to-date i2c ;)
> > 
> > > 2.1, 2.3, 2.5 were not considered unstable for us.
> > 
> > OK, so the debate is over for this part. Now it's between 2.6.6 and
> > 2.7.0, and I am definitely not the one who can decide. I think we've
> > been discussing enough and it's time to make our mind and prepare for
> > the release.

-- 
Vojtech Pavlik
SuSE Labs
-------------- next part --------------
Index: doc/busses/i2c-amd8111
=================================RCS file: /home/cvs/lm_sensors2/doc/busses/i2c-amd8111,v
retrieving revision 1.1
diff -u -r1.1 i2c-amd8111
--- doc/busses/i2c-amd8111	2002/11/17 19:44:46	1.1
+++ doc/busses/i2c-amd8111	2002/11/30 18:12:20
@@ -1,14 +1,15 @@
 Kernel driver `i2c-adm8111.o'
 
-Status: Untested.
+Status: Slightly tested.
 
 Supported adapters:
     * AMD-8111 SMBus 2.0 PCI interface
-    * Possibly any other interface that implements the ACPI 2.0 EC interface
-    Datasheets: Publicly available at AMD and ACPI websites
 
-Author: Vojtech Pavlik <vojtech@suse.cz>
+Datasheets:
+	AMD datasheet not yet available, but almost everything can be found in
+        publically available ACPI 2.0 specification, which the adapter follows.
 
+Author: Vojtech Pavlik <vojtech@suse.cz>
 
 Module Parameters
 -----------------
@@ -30,14 +31,13 @@
 Process Call Support
 --------------------
 
-The chip supports it, but it's not implemented in the driver at the moment.
+Supported.
 
 SMBus 2.0 Support
 -----------------
-
-The chip supports SMBus 2.0, however the only extension the driver
-supports is PEC. Slave mode or host notification are not implemented.
 
+Supported. Both PEC and block process call support is implemented.
+Slave mode or host notification are not yet implemented.
 
 Note that for the 8111, there are two SMBus adapters. The SMBus 2.0 adapter is
 supported by this driver, and the SMBus 1.0 adapter is supported
Index: kernel/busses/i2c-amd8111.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-amd8111.c,v
retrieving revision 1.3
diff -u -r1.3 i2c-amd8111.c
--- kernel/busses/i2c-amd8111.c	2002/11/28 19:57:23	1.3
+++ kernel/busses/i2c-amd8111.c	2002/11/30 18:12:21
@@ -80,7 +80,7 @@
 		udelay(1);
 
 	if (!timeout) {
-		printk(KERN_WARNING "i2c-amd811.c: Timeout while waiting for IBF to clear\n");
+		printk(KERN_WARNING "i2c-amd8111.c: Timeout while waiting for IBF to clear\n");
 		return -1;
 	}
 
@@ -166,6 +166,8 @@
 #define AMD_SMB_STATUS_BUSY	0x1A
 #define AMD_SMB_STATUS_PEC	0x1F
 
+#define AMD_SMB_PRTCL_WRITE		0x00
+#define AMD_SMB_PRTCL_READ		0x01
 #define AMD_SMB_PRTCL_QUICK		0x02
 #define AMD_SMB_PRTCL_BYTE		0x04
 #define AMD_SMB_PRTCL_BYTE_DATA		0x06
@@ -181,59 +183,89 @@
 		char read_write, u8 command, int size, union i2c_smbus_data * data)
 {
 	struct amd_smbus *smbus = adap->algo_data;
-	unsigned char protocol = read_write;	/* 1 = read, 0 = write */
-	unsigned char temp[2];
-	int i, timeout = 5000;
+	unsigned char protocol, len, pec, temp[2];
+	int i;
 
+	protocol = (read_write = I2C_SMBUS_READ) ? AMD_SMB_PRTCL_READ : AMD_SMB_PRTCL_WRITE;
+	pec = (flags & I2C_CLIENT_PEC) ? AMD_SMB_PRTCL_PEC : 0;
+
 	switch (size) {
 
 		case I2C_SMBUS_QUICK:
 			protocol |= AMD_SMB_PRTCL_QUICK;
+			read_write = I2C_SMBUS_WRITE;
 			break;
 
 		case I2C_SMBUS_BYTE:
-			if (!read_write)
+			if (read_write = I2C_SMBUS_WRITE)
 				amd_ec_write(smbus, AMD_SMB_DATA, data->byte);
 			protocol |= AMD_SMB_PRTCL_BYTE;
 			break;
 
 		case I2C_SMBUS_BYTE_DATA:
 			amd_ec_write(smbus, AMD_SMB_CMD, command);
-			if (!read_write)
+			if (read_write = I2C_SMBUS_WRITE)
 				amd_ec_write(smbus, AMD_SMB_DATA, data->byte);
 			protocol |= AMD_SMB_PRTCL_BYTE_DATA;
 			break;
 
+		case I2C_SMBUS_WORD_DATA_PEC:
+			protocol |= AMD_SMB_PRTCL_PEC;
 		case I2C_SMBUS_WORD_DATA:
 			amd_ec_write(smbus, AMD_SMB_CMD, command);
-			if (!read_write) {
-				amd_ec_write(smbus, AMD_SMB_DATA, data->byte);
-				amd_ec_write(smbus, AMD_SMB_DATA + 1, data->byte >> 8);
+			if (read_write = I2C_SMBUS_WRITE) {
+				amd_ec_write(smbus, AMD_SMB_DATA, data->word);
+				amd_ec_write(smbus, AMD_SMB_DATA + 1, data->word >> 8);
 			}
-			protocol |= AMD_SMB_PRTCL_WORD_DATA;
+			protocol |= AMD_SMB_PRTCL_WORD_DATA | pec;
 			break;
 
-		case I2C_SMBUS_BLOCK_DATA:
 		case I2C_SMBUS_BLOCK_DATA_PEC:
-		case I2C_SMBUS_I2C_BLOCK_DATA:
+			protocol |= AMD_SMB_PRTCL_PEC;
+		case I2C_SMBUS_BLOCK_DATA:
 			amd_ec_write(smbus, AMD_SMB_CMD, command);
-			if (!read_write)
-				for (i = 0; i < data->block[0]; i++)
+			if (read_write = I2C_SMBUS_WRITE) {
+				len = min_t(u8, data->block[0], 32);
+				amd_ec_write(smbus, AMD_SMB_BCNT, len);
+				for (i = 0; i < len; i++)
 					amd_ec_write(smbus, AMD_SMB_DATA + i, data->block[i + 1]);
-			switch (size) {
-				case I2C_SMBUS_BLOCK_DATA:
-					protocol |= AMD_SMB_PRTCL_BLOCK_DATA;
-					break;
-				case I2C_SMBUS_BLOCK_DATA_PEC:
-					protocol |= AMD_SMB_PRTCL_BLOCK_DATA | AMD_SMB_PRTCL_PEC;
-					break;
-				case I2C_SMBUS_I2C_BLOCK_DATA:
-					protocol |= AMD_SMB_PRTCL_I2C_BLOCK_DATA;
-					break;
 			}
+			protocol |= AMD_SMB_PRTCL_BLOCK_DATA | pec;
+			break;
+
+		case I2C_SMBUS_I2C_BLOCK_DATA:
+			len = min_t(u8, data->block[0], 32);
+			amd_ec_write(smbus, AMD_SMB_CMD, command);
+			amd_ec_write(smbus, AMD_SMB_BCNT, len);
+			if (read_write = I2C_SMBUS_WRITE)
+				for (i = 0; i < len; i++)
+					amd_ec_write(smbus, AMD_SMB_DATA + i, data->block[i + 1]);
+			protocol |= AMD_SMB_PRTCL_I2C_BLOCK_DATA;
+			break;
+
+		case I2C_SMBUS_PROC_CALL_PEC:
+			protocol |= AMD_SMB_PRTCL_PEC;
+		case I2C_SMBUS_PROC_CALL:
+			amd_ec_write(smbus, AMD_SMB_CMD, command);
+			amd_ec_write(smbus, AMD_SMB_DATA, data->word);
+			amd_ec_write(smbus, AMD_SMB_DATA + 1, data->word >> 8);
+			protocol = AMD_SMB_PRTCL_PROC_CALL | pec;
+			read_write = I2C_SMBUS_READ;
+			break;
+
+		case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
+			protocol |= AMD_SMB_PRTCL_PEC;
+		case I2C_SMBUS_BLOCK_PROC_CALL:
+			protocol |= pec;
+			len = min_t(u8, data->block[0], 31);
+			amd_ec_write(smbus, AMD_SMB_CMD, command);
+			amd_ec_write(smbus, AMD_SMB_BCNT, len);
+			for (i = 0; i < len; i++)
+				amd_ec_write(smbus, AMD_SMB_DATA + i, data->block[i + 1]);
+			protocol = AMD_SMB_PRTCL_BLOCK_PROC_CALL | pec;
+			read_write = I2C_SMBUS_READ;
 			break;
 
-		case I2C_SMBUS_PROC_CALL: /* We don't support proc_call yet */
 		default:
 			printk(KERN_WARNING "i2c-amd8111.c: Unsupported transaction %d\n", size);
 			return -1;
@@ -244,21 +276,21 @@
 
 	amd_ec_read(smbus, AMD_SMB_STS, temp + 0);
 
-	while (timeout && ~temp[0] & AMD_SMB_STS_DONE) {
+	if (~temp[0] & AMD_SMB_STS_DONE) {
+		udelay(500);
 		amd_ec_read(smbus, AMD_SMB_STS, temp + 0);
-		udelay(10);
-		timeout--;
 	}
 
-	if (!timeout)
-		return -1;
-
 	if (~temp[0] & AMD_SMB_STS_DONE) {
-		printk(KERN_WARNING "i2c-amd8111.c: Transaction completed with error %#x\n", temp[0]);
-		return -1;
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(HZ/100);
+		amd_ec_read(smbus, AMD_SMB_STS, temp + 0);
 	}
 
-	if (!read_write) /* We're done, no values to return; */
+	if ((~temp[0] & AMD_SMB_STS_DONE) || (temp[0] & AMD_SMB_STS_STATUS))
+		return -1;
+
+	if (read_write = I2C_SMBUS_WRITE)
 		return 0;
 
 	switch (size) {
@@ -269,6 +301,9 @@
 			break;
 
 		case I2C_SMBUS_WORD_DATA:
+		case I2C_SMBUS_WORD_DATA_PEC:
+		case I2C_SMBUS_PROC_CALL:
+		case I2C_SMBUS_PROC_CALL_PEC:
 			amd_ec_read(smbus, AMD_SMB_DATA, temp + 0);
 			amd_ec_read(smbus, AMD_SMB_DATA + 1, temp + 1);
 			data->word = (temp[1] << 8) | temp[0];
@@ -276,9 +311,14 @@
 
 		case I2C_SMBUS_BLOCK_DATA:
 		case I2C_SMBUS_BLOCK_DATA_PEC:
+		case I2C_SMBUS_BLOCK_PROC_CALL:
+		case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
+			amd_ec_read(smbus, AMD_SMB_BCNT, &len);
+			len = min_t(u8, len, 32);
 		case I2C_SMBUS_I2C_BLOCK_DATA:
-			for (i = 0; i < data->block[0]; i++)
+			for (i = 0; i < len; i++)
 				amd_ec_read(smbus, AMD_SMB_DATA + i, data->block + i + 1);
+			data->block[0] = len;
 			break;
 	}
 
@@ -297,10 +337,12 @@
 
 u32 amd8111_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
-	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
-	    I2C_FUNC_SMBUS_BLOCK_DATA_PEC | I2C_FUNC_SMBUS_HWPEC_CALC;
+	return	I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA |
+		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_WORD_DATA_PEC |
+		I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_BLOCK_DATA_PEC |
+		I2C_FUNC_SMBUS_PROC_CALL | I2C_FUNC_SMBUS_PROC_CALL_PEC |
+		I2C_FUNC_SMBUS_BLOCK_PROC_CALL | I2C_FUNC_SMBUS_BLOCK_PROC_CALL_PEC |
+		I2C_FUNC_SMBUS_I2C_BLOCK | I2C_FUNC_SMBUS_HWPEC_CALC;
 }
 
 static struct i2c_algorithm smbus_algorithm = {
@@ -326,18 +368,10 @@
 	smbus->base = pci_resource_start(dev, 0);
 	smbus->size = pci_resource_len(dev, 0);
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,14)
 	if (!request_region(smbus->base, smbus->size, "amd8111 SMBus 2.0")) {
 		kfree(smbus);
 		return -1;
 	}
-#else
-	if (check_region(smbus->base, smbus->size) < 0) {
-		kfree(smbus);
-		return -1;
-	}
-	request_region(smbus->base, smbus->size, "amd8111 SMBus 2.0");
-#endif
 
 	sprintf(smbus->adapter.name, "SMBus2 AMD8111 adapter at %04x", smbus->base);
 	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD8111;
@@ -346,14 +380,14 @@
 	smbus->adapter.inc_use = amd8111_inc;
 	smbus->adapter.dec_use = amd8111_dec;
 
-	pci_write_config_dword(dev, AMD_PCI_MISC, 0);
-
 	if (i2c_add_adapter(&smbus->adapter)) {
 		printk(KERN_WARNING "i2c-amd8111.c: Failed to register adapter.\n");
 		release_region(smbus->base, smbus->size);
 		kfree(smbus);
 		return -1;
 	}
+
+	pci_write_config_dword(smbus->dev, AMD_PCI_MISC, 0);
 
 	printk(KERN_INFO "i2c-amd8111.c: AMD8111 SMBus 2.0 adapter at pci%s\n", dev->slot_name);
 	return 0;
