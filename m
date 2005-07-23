From: hfvogt@gmx.net (Hans-Frieder Vogt)
Date: Sat, 23 Jul 2005 15:34:25 +0000
Subject: [lm-sensors] [PATCH 2.6] cleanup of i2c-nforce2
Message-Id: <42E24733.7010207@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi list,

attached is a small patch that removes unused code from i2c-nforce2 and 
adds a single debug message. The patch is against 2.6.13-rc3-mm1.
I have tested the patch with 2.6.13-rc3: compiles cleanly and works as 
without the patch (as expected).

Greg,
can you please include the patch into the next kernel release?
Thanks.

Signed-off-by: Hans-Frieder Vogt <hfvogt at arcor.de>

*--- linux-2.6.13-rc3-mm1.orig/drivers/i2c/busses/i2c-nforce2.c	2005-07-18 17:55:06.116509000 +0200*
*+++ linux-2.6.13-rc3-mm1/drivers/i2c/busses/i2c-nforce2.c	2005-07-23 14:37:19.176001249 +0200*
@@ -131,7 +131,6 @@
 	struct nforce2_smbus *smbus = adap->algo_data;
 	unsigned char protocol, pec, temp;
 	unsigned char len = 0; /* to keep the compiler quiet */
-	int timeout = 0;
 	int i;
 
 	protocol = (read_write = I2C_SMBUS_READ) ? NVIDIA_SMB_PRTCL_READ :
@@ -191,29 +190,10 @@
 		case I2C_SMBUS_PROC_CALL:
 			dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
 			return -1;
-			/*
-			outb_p(command, NVIDIA_SMB_CMD);
-			outb_p(data->word, NVIDIA_SMB_DATA);
-			outb_p(data->word >> 8, NVIDIA_SMB_DATA + 1);
-			protocol = NVIDIA_SMB_PRTCL_PROC_CALL | pec;
-			read_write = I2C_SMBUS_READ;
-			break;
-			 */
 
 		case I2C_SMBUS_BLOCK_PROC_CALL:
 			dev_err(&adap->dev, "I2C_SMBUS_BLOCK_PROC_CALL not supported!\n");
 			return -1;
-			/*
-			protocol |= pec;
-			len = min_t(u8, data->block[0], 31);
-			outb_p(command, NVIDIA_SMB_CMD);
-			outb_p(len, NVIDIA_SMB_BCNT);
-			for (i = 0; i < len; i++)
-				outb_p(data->block[i + 1], NVIDIA_SMB_DATA + i);
-			protocol = NVIDIA_SMB_PRTCL_BLOCK_PROC_CALL | pec;
-			read_write = I2C_SMBUS_READ;
-			break;
-			*/
 
 		case I2C_SMBUS_WORD_DATA_PEC:
 		case I2C_SMBUS_BLOCK_DATA_PEC:
@@ -232,12 +212,6 @@
 
 	temp = inb_p(NVIDIA_SMB_STS);
 
-#if 0
-	do {
-		i2c_do_pause(1);
-		temp = inb_p(NVIDIA_SMB_STS);
-	} while (((temp & NVIDIA_SMB_STS_DONE) = 0) && (timeout++ < MAX_TIMEOUT));
-#endif
 	if (~temp & NVIDIA_SMB_STS_DONE) {
 		udelay(500);
 		temp = inb_p(NVIDIA_SMB_STS);
@@ -247,9 +221,10 @@
 		temp = inb_p(NVIDIA_SMB_STS);
 	}
 
-	if ((timeout >= MAX_TIMEOUT) || (~temp & NVIDIA_SMB_STS_DONE)
-		|| (temp & NVIDIA_SMB_STS_STATUS))
+	if ((~temp & NVIDIA_SMB_STS_DONE) || (temp & NVIDIA_SMB_STS_STATUS)) {
+		dev_dbg(&adap->dev, "SMBus Timeout! (0x%02x)\n", temp);
 		return -1;
+	}
 
 	if (read_write = I2C_SMBUS_WRITE)
 		return 0;




--
Hans-Frieder Vogt               e-mail: hfvogt <at> arcor .dot. de
                                        hfvogt <at> gmx .dot. net

