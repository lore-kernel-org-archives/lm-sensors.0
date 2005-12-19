From: gardner.ben@gmail.com (Ben Gardner)
Date: Mon, 19 Dec 2005 21:12:56 +0000
Subject: [lm-sensors] [PATCH 1/7] i2c: scx200_acb - whitespace and
Message-Id: <808c8e9d0512191312r10af83b9tb8db0b6b0694e16b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512191049t5050cd42w82b65f03dd350a7b@mail.gmail.com>
In-Reply-To: <808c8e9d0512191049t5050cd42w82b65f03dd350a7b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

scx200_acb whitespace and comment cleanup.

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
---
Hi Jean,

> Looks like you have been over-zealous here.
> (...)

Here's a less-zealous whitespace patch. =)

Thanks,
Ben
-------------- next part --------------
 drivers/i2c/busses/scx200_acb.c |   77 +++++++++++++++++++---------------------
 1 files changed, 37 insertions(+), 40 deletions(-)

--- linux-2.6.15-rc5-mm1.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2.6.15-rc5-mm1/drivers/i2c/busses/scx200_acb.c
@@ -1,27 +1,25 @@
-/*  linux/drivers/i2c/scx200_acb.c 
-
+/*
     Copyright (c) 2001,2002 Christer Weinigel <wingel at nano-system.com>
 
     National Semiconductor SCx200 ACCESS.bus support
-    
+
     Based on i2c-keywest.c which is:
         Copyright (c) 2001 Benjamin Herrenschmidt <benh at kernel.crashing.org>
         Copyright (c) 2000 Philip Edelbrock <phil at stimpy.netroedge.com>
-    
+
     This program is free software; you can redistribute it and/or
     modify it under the terms of the GNU General Public License as
     published by the Free Software Foundation; either version 2 of the
     License, or (at your option) any later version.
-   
+
     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     General Public License for more details.
-   
+
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
 */
 
 #include <linux/module.h>
@@ -100,7 +98,7 @@ struct scx200_acb_iface
 #define ACBSDA		(iface->base + 0)
 #define ACBST		(iface->base + 1)
 #define    ACBST_SDAST		0x40 /* SDA Status */
-#define    ACBST_BER		0x20 
+#define    ACBST_BER		0x20
 #define    ACBST_NEGACK		0x10 /* Negative Acknowledge */
 #define    ACBST_STASTR		0x08 /* Stall After Start */
 #define    ACBST_MASTER		0x02
@@ -109,9 +107,9 @@ struct scx200_acb_iface
 #define ACBCTL1		(iface->base + 3)
 #define    ACBCTL1_STASTRE	0x80
 #define    ACBCTL1_NMINTE	0x40
-#define	   ACBCTL1_ACK		0x10
-#define	   ACBCTL1_STOP		0x02
-#define	   ACBCTL1_START	0x01
+#define    ACBCTL1_ACK		0x10
+#define    ACBCTL1_STOP		0x02
+#define    ACBCTL1_START	0x01
 #define ACBADDR		(iface->base + 4)
 #define ACBCTL2		(iface->base + 5)
 #define    ACBCTL2_ENABLE	0x01
@@ -122,7 +120,7 @@ static void scx200_acb_machine(struct sc
 {
 	const char *errmsg;
 
-	DBG("state %s, status = 0x%02x\n", 
+	DBG("state %s, status = 0x%02x\n",
 	    scx200_acb_state_name[iface->state], status);
 
 	if (status & ACBST_BER) {
@@ -163,7 +161,7 @@ static void scx200_acb_machine(struct sc
 		
 	case state_quick:
 		if (iface->address_byte & 1) {
-			if (iface->len = 1) 
+			if (iface->len = 1)
 				outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
 			else
 				outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
@@ -212,7 +210,7 @@ static void scx200_acb_machine(struct sc
 	return;
 
  negack:
-	DBG("negative acknowledge in state %s\n", 
+	DBG("negative acknowledge in state %s\n",
 	    scx200_acb_state_name[iface->state]);
 
 	iface->state = state_idle;
@@ -231,7 +229,7 @@ static void scx200_acb_machine(struct sc
 	iface->needs_reset = 1;
 }
 
-static void scx200_acb_timeout(struct scx200_acb_iface *iface) 
+static void scx200_acb_timeout(struct scx200_acb_iface *iface)
 {
 	dev_err(&iface->adapter.dev, "timeout in state %s\n",
 		scx200_acb_state_name[iface->state]);
@@ -264,7 +262,7 @@ static void scx200_acb_poll(struct scx20
 static void scx200_acb_reset(struct scx200_acb_iface *iface)
 {
 	/* Disable the ACCESS.bus device and Configure the SCL
-           frequency: 16 clock cycles */
+	   frequency: 16 clock cycles */
 	outb(0x70, ACBCTL2);
 	/* Polling mode */
 	outb(0, ACBCTL1);
@@ -284,7 +282,7 @@ static void scx200_acb_reset(struct scx2
 
 static s32 scx200_acb_smbus_xfer(struct i2c_adapter *adapter,
 				u16 address, unsigned short flags,	
-				char rw, u8 command, int size, 
+				char rw, u8 command, int size,
 				union i2c_smbus_data *data)
 {
 	struct scx200_acb_iface *iface = i2c_get_adapdata(adapter);
@@ -295,9 +293,10 @@ static s32 scx200_acb_smbus_xfer(struct 
 
 	switch (size) {
 	case I2C_SMBUS_QUICK:
-	    	len = 0;
-	    	buffer = NULL;
-	    	break;
+		len = 0;
+		buffer = NULL;
+		break;
+
 	case I2C_SMBUS_BYTE:
 		if (rw = I2C_SMBUS_READ) {
 			len = 1;
@@ -306,22 +305,26 @@ static s32 scx200_acb_smbus_xfer(struct 
 			len = 1;
 			buffer = &command;
 		}
-	    	break;
+		break;
+
 	case I2C_SMBUS_BYTE_DATA:
-	    	len = 1;
-	    	buffer = &data->byte;
-	    	break;
+		len = 1;
+		buffer = &data->byte;
+		break;
+
 	case I2C_SMBUS_WORD_DATA:
 		len = 2;
-	    	cur_word = cpu_to_le16(data->word);
-	    	buffer = (u8 *)&cur_word;
+		cur_word = cpu_to_le16(data->word);
+		buffer = (u8 *)&cur_word;
 		break;
+
 	case I2C_SMBUS_BLOCK_DATA:
-	    	len = data->block[0];
-	    	buffer = &data->block[1];
+		len = data->block[0];
+		buffer = &data->block[1];
 		break;
+
 	default:
-	    	return -EINVAL;
+		return -EINVAL;
 	}
 
 	DBG("size=%d, address=0x%x, command=0x%x, len=%d, read=%d\n",
@@ -370,7 +373,7 @@ static s32 scx200_acb_smbus_xfer(struct 
 	up(&iface->sem);
 
 	if (rc = 0 && size = I2C_SMBUS_WORD_DATA && rw = I2C_SMBUS_READ)
-	    	data->word = le16_to_cpu(cur_word);
+		data->word = le16_to_cpu(cur_word);
 
 #ifdef DEBUG
 	DBG(": transfer done, result: %d", rc);
@@ -406,7 +409,7 @@ static int scx200_acb_probe(struct scx20
 	u8 val;
 
 	/* Disable the ACCESS.bus device and Configure the SCL
-           frequency: 16 clock cycles */
+	   frequency: 16 clock cycles */
 	outb(0x70, ACBCTL2);
 
 	if (inb(ACBCTL2) != 0x70) {
@@ -459,7 +462,8 @@ static int  __init scx200_acb_create(int
 
 	init_MUTEX(&iface->sem);
 
-	snprintf(description, sizeof(description), "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
+	snprintf(description, sizeof(description),
+		 "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
 	if (request_region(base, 8, description) = 0) {
 		dev_err(&adapter->dev, "can't allocate io 0x%x-0x%x\n",
 			base, base + 8-1);
@@ -528,6 +532,7 @@ static int __init scx200_acb_init(void)
 static void __exit scx200_acb_cleanup(void)
 {
 	struct scx200_acb_iface *iface;
+
 	lock_kernel();
 	while ((iface = scx200_acb_list) != NULL) {
 		scx200_acb_list = iface->next;
@@ -543,11 +548,3 @@ static void __exit scx200_acb_cleanup(vo
 
 module_init(scx200_acb_init);
 module_exit(scx200_acb_cleanup);
-
-/*
-    Local variables:
-        compile-command: "make -k -C ../.. SUBDIRS=drivers/i2c modules"
-        c-basic-offset: 8
-    End:
-*/
-
