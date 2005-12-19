From: gardner.ben@gmail.com (Ben Gardner)
Date: Mon, 19 Dec 2005 18:49:46 +0000
Subject: [lm-sensors] [PATCH 1/7] i2c: scx200_acb - whitespace and comment
Message-Id: <808c8e9d0512191049t5050cd42w82b65f03dd350a7b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

scx200_acb whitespace and comment cleanup.

Signed-off-by: Ben Gardner <bgardner at wabtec.com>
-------------- next part --------------
 drivers/i2c/busses/scx200_acb.c |  169 +++++++++++++++++++---------------------
 1 files changed, 83 insertions(+), 86 deletions(-)

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
@@ -36,13 +34,13 @@
 
 #include <linux/scx200.h>
 
-#define NAME "scx200_acb"
+#define NAME		"scx200_acb"
 
 MODULE_AUTHOR("Christer Weinigel <wingel at nano-system.com>");
 MODULE_DESCRIPTION("NatSemi SCx200 ACCESS.bus Driver");
 MODULE_LICENSE("GPL");
 
-#define MAX_DEVICES 4
+#define MAX_DEVICES	4
 static int base[MAX_DEVICES] = { 0x820, 0x840 };
 module_param_array(base, int, NULL, 0);
 MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
@@ -55,8 +53,8 @@ MODULE_PARM_DESC(base, "Base addresses f
 
 /* The hardware supports interrupt driven mode too, but I haven't
    implemented that. */
-#define POLLED_MODE 1
-#define POLL_TIMEOUT (HZ)
+#define POLLED_MODE	1
+#define POLL_TIMEOUT	(HZ)
 
 enum scx200_acb_state {
 	state_idle,
@@ -81,26 +79,26 @@ static const char *scx200_acb_state_name
 /* Physical interface */
 struct scx200_acb_iface
 {
-	struct scx200_acb_iface *next;
-	struct i2c_adapter adapter;
-	unsigned base;
-	struct semaphore sem;
+	struct scx200_acb_iface	*next;
+	struct i2c_adapter	adapter;
+	unsigned		base;
+	struct semaphore	sem;
 
 	/* State machine data */
-	enum scx200_acb_state state;
-	int result;
-	u8 address_byte;
-	u8 command;
-	u8 *ptr;
-	char needs_reset;
-	unsigned len;
+	enum scx200_acb_state	state;
+	int			result;
+	u8			address_byte;
+	u8			command;
+	u8			*ptr;
+	char			needs_reset;
+	unsigned		len;
 };
 
 /* Register Definitions */
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
@@ -189,7 +187,7 @@ static void scx200_acb_machine(struct sc
 
 		if (iface->len = 0) {
 			iface->result = 0;
-			iface->state = state_idle;
+			iface->state  = state_idle;
 			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
 		}
 
@@ -198,7 +196,7 @@ static void scx200_acb_machine(struct sc
 	case state_write:
 		if (iface->len = 0) {
 			iface->result = 0;
-			iface->state = state_idle;
+			iface->state  = state_idle;
 			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
 			break;
 		}
@@ -212,10 +210,10 @@ static void scx200_acb_machine(struct sc
 	return;
 
  negack:
-	DBG("negative acknowledge in state %s\n", 
+	DBG("negative acknowledge in state %s\n",
 	    scx200_acb_state_name[iface->state]);
 
-	iface->state = state_idle;
+	iface->state  = state_idle;
 	iface->result = -ENXIO;
 
 	outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
@@ -226,26 +224,26 @@ static void scx200_acb_machine(struct sc
 	dev_err(&iface->adapter.dev, "%s in state %s\n", errmsg,
 		scx200_acb_state_name[iface->state]);
 
-	iface->state = state_idle;
-	iface->result = -EIO;
+	iface->state       = state_idle;
+	iface->result      = -EIO;
 	iface->needs_reset = 1;
 }
 
-static void scx200_acb_timeout(struct scx200_acb_iface *iface) 
+static void scx200_acb_timeout(struct scx200_acb_iface *iface)
 {
 	dev_err(&iface->adapter.dev, "timeout in state %s\n",
 		scx200_acb_state_name[iface->state]);
 
-	iface->state = state_idle;
-	iface->result = -EIO;
+	iface->state       = state_idle;
+	iface->result      = -EIO;
 	iface->needs_reset = 1;
 }
 
 #ifdef POLLED_MODE
 static void scx200_acb_poll(struct scx200_acb_iface *iface)
 {
-	u8 status = 0;
-	unsigned long timeout;
+	u8		status = 0;
+	unsigned long	timeout;
 
 	timeout = jiffies + POLL_TIMEOUT;
 	while (time_before(jiffies, timeout)) {
@@ -264,7 +262,7 @@ static void scx200_acb_poll(struct scx20
 static void scx200_acb_reset(struct scx200_acb_iface *iface)
 {
 	/* Disable the ACCESS.bus device and Configure the SCL
-           frequency: 16 clock cycles */
+	   frequency: 16 clock cycles */
 	outb(0x70, ACBCTL2);
 	/* Polling mode */
 	outb(0, ACBCTL1);
@@ -284,44 +282,49 @@ static void scx200_acb_reset(struct scx2
 
 static s32 scx200_acb_smbus_xfer(struct i2c_adapter *adapter,
 				u16 address, unsigned short flags,	
-				char rw, u8 command, int size, 
+				char rw, u8 command, int size,
 				union i2c_smbus_data *data)
 {
-	struct scx200_acb_iface *iface = i2c_get_adapdata(adapter);
-	int len;
-	u8 *buffer;
-	u16 cur_word;
-	int rc;
+	struct scx200_acb_iface	*iface = i2c_get_adapdata(adapter);
+	int			len;
+	u8			*buffer;
+	u16			cur_word;
+	int			rc;
 
 	switch (size) {
 	case I2C_SMBUS_QUICK:
-	    	len = 0;
-	    	buffer = NULL;
-	    	break;
+		len    = 0;
+		buffer = NULL;
+		break;
+
 	case I2C_SMBUS_BYTE:
 		if (rw = I2C_SMBUS_READ) {
-			len = 1;
+			len    = 1;
 			buffer = &data->byte;
 		} else {
-			len = 1;
+			len    = 1;
 			buffer = &command;
 		}
-	    	break;
+		break;
+
 	case I2C_SMBUS_BYTE_DATA:
-	    	len = 1;
-	    	buffer = &data->byte;
-	    	break;
+		len    = 1;
+		buffer = &data->byte;
+		break;
+
 	case I2C_SMBUS_WORD_DATA:
-		len = 2;
-	    	cur_word = cpu_to_le16(data->word);
-	    	buffer = (u8 *)&cur_word;
+		len      = 2;
+		cur_word = cpu_to_le16(data->word);
+		buffer   = (u8 *)&cur_word;
 		break;
+
 	case I2C_SMBUS_BLOCK_DATA:
-	    	len = data->block[0];
-	    	buffer = &data->block[1];
+		len    = data->block[0];
+		buffer = &data->block[1];
 		break;
+
 	default:
-	    	return -EINVAL;
+		return -EINVAL;
 	}
 
 	DBG("size=%d, address=0x%x, command=0x%x, len=%d, read=%d\n",
@@ -342,11 +345,11 @@ static s32 scx200_acb_smbus_xfer(struct 
 	iface->address_byte = address<<1;
 	if (rw = I2C_SMBUS_READ)
 		iface->address_byte |= 1;
-	iface->command = command;
-	iface->ptr = buffer;
-	iface->len = len;
-	iface->result = -EINVAL;
-	iface->needs_reset = 0;
+	iface->command      = command;
+	iface->ptr          = buffer;
+	iface->len          = len;
+	iface->result       = -EINVAL;
+	iface->needs_reset  = 0;
 
 	outb(inb(ACBCTL1) | ACBCTL1_START, ACBCTL1);
 
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
@@ -437,10 +440,10 @@ static int scx200_acb_probe(struct scx20
 
 static int  __init scx200_acb_create(int base, int index)
 {
-	struct scx200_acb_iface *iface;
-	struct i2c_adapter *adapter;
-	int rc = 0;
-	char description[64];
+	struct scx200_acb_iface	*iface;
+	struct i2c_adapter	*adapter;
+	int			rc = 0;
+	char			description[64];
 
 	iface = kzalloc(sizeof(*iface), GFP_KERNEL);
 	if (!iface) {
@@ -453,13 +456,14 @@ static int  __init scx200_acb_create(int
 	i2c_set_adapdata(adapter, iface);
 	snprintf(adapter->name, I2C_NAME_SIZE, "SCx200 ACB%d", index);
 	adapter->owner = THIS_MODULE;
-	adapter->id = I2C_HW_SMBUS_SCX200;
-	adapter->algo = &scx200_acb_algorithm;
+	adapter->id    = I2C_HW_SMBUS_SCX200;
+	adapter->algo  = &scx200_acb_algorithm;
 	adapter->class = I2C_CLASS_HWMON;
 
 	init_MUTEX(&iface->sem);
 
-	snprintf(description, sizeof(description), "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
+	snprintf(description, sizeof(description),
+		 "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
 	if (request_region(base, 8, description) = 0) {
 		dev_err(&adapter->dev, "can't allocate io 0x%x-0x%x\n",
 			base, base + 8-1);
@@ -483,7 +487,7 @@ static int  __init scx200_acb_create(int
 	}
 
 	lock_kernel();
-	iface->next = scx200_acb_list;
+	iface->next     = scx200_acb_list;
 	scx200_acb_list = iface;
 	unlock_kernel();
 
@@ -506,8 +510,8 @@ static struct pci_device_id scx200[] = {
 
 static int __init scx200_acb_init(void)
 {
-	int i;
-	int rc;
+	int	i;
+	int	rc;
 
 	pr_debug(NAME ": NatSemi SCx200 ACCESS.bus Driver\n");
 
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
