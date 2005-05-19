From: rtjohnso@eecs.berkeley.edu (Robert T. Johnson)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
Message-Id: <1060886657.1006.7121.camel@dooby.cs.berkeley.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806100702.78298ffe.khali@linux-fr.org>
In-Reply-To: <20030806100702.78298ffe.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you for looking at my bug report and proposed patch with such
careful scrutiny!  I think the mem leak fix you propose is fine, but I
had an ulterior motive for writing the user/kernel fix as I did. 

The user/kernel bug was discovered by our automatic bug-finding tool,
cqual, and my patch allowed i2c-dev.c to pass through cqual with no
warnings.  The new patch does not, because rdwr_pa[i].buf is sometimes a
a user pointer and sometimes a kernel pointer, e.g. on i2c-dev.c, line
248:


data_ptrs[i] = rdwr_pa[i].buf; // rdwr_pa[i].buf is user pointer
rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL); // now it's kernel


Cqual is not just a bug finder, it can verify the _absence_ of bugs.  I
think this is pretty cool.  Imagine a kernel that can be automatically
verified to have no user/kernel bugs.  You'd never have to worry about
user/kernel bugs again!

But like all automatic code verification tools, cqual imposes certain
limits on the types of code you can write.  For example, cqual doesn't
allow a variable to sometimes hold a user pointer and sometimes hold a
kernel pointer, like rdwr_pa[i].buf now does.  The original patch avoids
this, but the new patch doesn't for performance reasons.  FWIW, I think
Linus' checker will also fail to check the new patch. 

So there's a trade-off here between performance and automatic code
auditing.  Considering that 

1. The performance cost of the original patch is minor. 
2. i2c-dev.c has had user/kernel bugs in the past. 
3. This user/kernel bug was tricky and time consuming to understand. 

I propose that having code which can be automatically verified may be
more important than squeezing out every last cycle.  In other words,
user/kernel bugs have proven so tricky to detect and fix that it's worth
writing _slightly_ less efficient code in order to have code which can
be automatically verified. 

After looking at your rewritten patch, I thought of a possibly cleaner
way to make i2c-dev.c pass cqual without warnings.  I've included it
below.  I'd like to work with the i2c developers to find a solution
which can be automatically audited and that you like. 

Thanks for giving this so much thought. 

Best, 
Rob 

This patch is against i2c cvs.  The basic idea is this:

- move all the fields, except buf, of i2c_msg into a substructure, md
(i.e. metadata).
- lots of 1 line changes based on this
- Now the i2cdev_ioctl I2C_RDWR works as follows:

copy all the i2_msg structures from userspace onto tmp_pa
for i = 1 to number of messages
   rdwr_pa[i].md = tmp_pa[i].md;
   rdwr_pa[i].buf = kmalloc(...);
   copy_from_user (rdwr_pa[i].buf, tmp_pa[i].buf);

instead of

copy all the i2_msg structures from userspace onto rdwr_pa
for i = 1 to number of messages
   data_ptr[i] = rdwr_pa[i].buf;
   rdwr_pa[i].buf = kmalloc(...);
   copy_from_user (rdwr_pa[i].buf, data_ptr[i]);

The overhead versus the current version of the ioctl is
- the extra memory consumed by tmp_pa (versus data_ptr)
- the copy of the md field (versus the copy of rdwr_pa[i].buf).
The benefit is
- never have to worry about user/kernel bugs again.

diff -urN --exclude=CVS i2c.orig/kernel/i2c-algo-bit.c i2c.md/kernel/i2c-algo-bit.c
--- i2c.orig/kernel/i2c-algo-bit.c	Fri Jul 25 00:56:42 2003
+++ i2c.md/kernel/i2c-algo-bit.c	Wed Aug 13 16:02:16 2003
@@ -336,8 +336,8 @@
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 	char c;
 	const char *temp = msg->buf;
-	int count = msg->len;
-	unsigned short nak_ok = msg->flags & I2C_M_IGNORE_NAK; 
+	int count = msg->md.len;
+	unsigned short nak_ok = msg->md.flags & I2C_M_IGNORE_NAK; 
 	int retval;
 	int wrcount=0;
 
@@ -371,7 +371,7 @@
 	int rdcount=0;   	/* counts bytes read */
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 	char *temp = msg->buf;
-	int count = msg->len;
+	int count = msg->md.len;
 
 	while (count > 0) {
 		inval = i2c_inb(i2c_adap);
@@ -414,8 +414,8 @@
  */
 static inline int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg) 
 {
-	unsigned short flags = msg->flags;
-	unsigned short nak_ok = msg->flags & I2C_M_IGNORE_NAK;
+	unsigned short flags = msg->md.flags;
+	unsigned short nak_ok = msg->md.flags & I2C_M_IGNORE_NAK;
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
 	unsigned char addr;
@@ -425,7 +425,7 @@
 	
 	if ( (flags & I2C_M_TEN)  ) { 
 		/* a ten bit address */
-		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
+		addr = 0xf0 | (( msg->md.addr >> 7) & 0x03);
 		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
 		/* try extended address code...*/
 		ret = try_address(i2c_adap, addr, retries);
@@ -434,7 +434,7 @@
 			return -EREMOTEIO;
 		}
 		/* the remaining 8 bit address */
-		ret = i2c_outb(i2c_adap,msg->addr & 0x7f);
+		ret = i2c_outb(i2c_adap,msg->md.addr & 0x7f);
 		if ((ret != 1) && !nak_ok) {
 			/* the chip did not ack / xmission error occurred */
 			printk(KERN_ERR "died at 2nd address code.\n");
@@ -451,7 +451,7 @@
 			}
 		}
 	} else {		/* normal 7bit address	*/
-		addr = ( msg->addr << 1 );
+		addr = ( msg->md.addr << 1 );
 		if (flags & I2C_M_RD )
 			addr |= 1;
 		if (flags & I2C_M_REV_DIR_ADDR )
@@ -476,30 +476,30 @@
 	i2c_start(adap);
 	for (i=0;i<num;i++) {
 		pmsg = &msgs[i];
-		nak_ok = pmsg->flags & I2C_M_IGNORE_NAK; 
-		if (!(pmsg->flags & I2C_M_NOSTART)) {
+		nak_ok = pmsg->md.flags & I2C_M_IGNORE_NAK; 
+		if (!(pmsg->md.flags & I2C_M_NOSTART)) {
 			if (i) {
 				i2c_repstart(adap);
 			}
 			ret = bit_doAddress(i2c_adap, pmsg);
 			if ((ret != 0) && !nak_ok) {
 			    DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: NAK from device addr %2.2x msg #%d\n"
-					,msgs[i].addr,i));
+					,msgs[i].md.addr,i));
 			    return (ret<0) ? ret : -EREMOTEIO;
 			}
 		}
-		if (pmsg->flags & I2C_M_RD ) {
+		if (pmsg->md.flags & I2C_M_RD ) {
 			/* read bytes into buffer*/
 			ret = readbytes(i2c_adap, pmsg);
 			DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: read %d bytes.\n",ret));
-			if (ret < pmsg->len ) {
+			if (ret < pmsg->md.len ) {
 				return (ret<0)? ret : -EREMOTEIO;
 			}
 		} else {
 			/* write bytes from buffer */
 			ret = sendbytes(i2c_adap, pmsg);
 			DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: wrote %d bytes.\n",ret));
-			if (ret < pmsg->len ) {
+			if (ret < pmsg->md.len ) {
 				return (ret<0) ? ret : -EREMOTEIO;
 			}
 		}
diff -urN --exclude=CVS i2c.orig/kernel/i2c-algo-biths.c i2c.md/kernel/i2c-algo-biths.c
--- i2c.orig/kernel/i2c-algo-biths.c	Fri Jul 25 00:56:42 2003
+++ i2c.md/kernel/i2c-algo-biths.c	Wed Aug 13 16:04:36 2003
@@ -440,31 +440,31 @@
 	unsigned char addr[2];
 	int count;
 
-	if ( msg->flags & I2C_M_TEN ) { 
+	if ( msg->md.flags & I2C_M_TEN ) { 
 		/* a ten bit address */
 		count = 2;
-		addr[0] = 0xf0 | (( msg->addr >> 7) & 0x03);
-		addr[1] = msg->addr & 0x7f;
+		addr[0] = 0xf0 | (( msg->md.addr >> 7) & 0x03);
+		addr[1] = msg->md.addr & 0x7f;
 
 		/* try extended address code ... and the remaining 8 bit address */
-		TRY(i2c_outb(adap, msg->flags, addr, &count));
+		TRY(i2c_outb(adap, msg->md.flags, addr, &count));
 
-		if ( msg->flags & I2C_M_RD ) {
+		if ( msg->md.flags & I2C_M_RD ) {
 			TRY(i2c_start(adap));
 			
 			/* okay, now switch into reading mode */
 			count = 1;
 			addr[0] |= 0x01;
-			TRY(i2c_outb(adap, msg->flags, addr, &count));
+			TRY(i2c_outb(adap, msg->md.flags, addr, &count));
 		}
 	} else {		/* normal 7bit address	*/
 		count = 1;
-		addr[0] = ( msg->addr << 1 );
-		if (msg->flags & I2C_M_RD )
+		addr[0] = ( msg->md.addr << 1 );
+		if (msg->md.flags & I2C_M_RD )
 			addr[0] |= 1;
-		if (msg->flags & I2C_M_REV_DIR_ADDR )
+		if (msg->md.flags & I2C_M_REV_DIR_ADDR )
 			addr[0] ^= 1;
-		TRY(i2c_outb(adap, msg->flags, addr, &count));
+		TRY(i2c_outb(adap, msg->md.flags, addr, &count));
 	}
 }
 
@@ -498,13 +498,13 @@
 		}
 	}
 
-	for (j=0; j<num; j++) msgs[j].err = 0; // unprocessed
+	for (j=0; j<num; j++) msgs[j].md.err = 0; // unprocessed
 
 	do switch (state) {
 	    
 	    case MSG_INIT:
 		    msg = &msgs[mn];
-		    if ((msg->flags & I2C_M_NOSTART) && (mn)) {
+		    if ((msg->md.flags & I2C_M_NOSTART) && (mn)) {
 			    state = MSG_DATA;
 			    break;
 		    }
@@ -524,13 +524,13 @@
 		    }
 
 	    case MSG_DATA:
-		    j = msg->len;
-		    if ( msg->flags & I2C_M_RD ) {
-			    i2c_inb(adap, msg->flags, msg->buf, &j);
+		    j = msg->md.len;
+		    if ( msg->md.flags & I2C_M_RD ) {
+			    i2c_inb(adap, msg->md.flags, msg->buf, &j);
 		    } else {
-			    i2c_outb(adap, msg->flags, msg->buf, &j);
+			    i2c_outb(adap, msg->md.flags, msg->buf, &j);
 		    }
-		    msg->done = msg->len - j;
+		    msg->md.done = msg->md.len - j;
 		    if (adap->errors) {
 			    state = MSG_STOP;
 			    break;
@@ -539,30 +539,30 @@
 	    case MSG_READY:
 		    mn++;
 		    if (mn<num) {
-			    msg->err = errflag(adap->errors);
-			    debug_protocol(adap, msg->err);
+			    msg->md.err = errflag(adap->errors);
+			    debug_protocol(adap, msg->md.err);
 			    state = MSG_INIT;
 			    break;
 		    }
 
 	    case MSG_STOP:
-		    msg->err = errflag(adap->errors);
+		    msg->md.err = errflag(adap->errors);
 		    i2c_stop(adap);
 		    j = 0;
 		    while (adap->errors) {
 			    if ( ++j > 10) {
-				    msg->err = -ENODEV;
+				    msg->md.err = -ENODEV;
 				    break;
 			    }
 			    i2c_stop(adap);
 		    }
-		    debug_protocol(adap, msg->err);
+		    debug_protocol(adap, msg->md.err);
 		    state = MSG_EXIT;
 		    break;
 
 	    default: /* not reached */
 		    state = MSG_EXIT;
-		    msg->err = -EINVAL;
+		    msg->md.err = -EINVAL;
 		    break;
 		    		  
 	} while (state != MSG_EXIT);
@@ -570,9 +570,9 @@
 	if (adap->dstr) kfree(adap->dstr);
 
 	for (j=0; j<num; j++)
-		debug_printout(i2c_adap, j, msgs[j].err);
+		debug_printout(i2c_adap, j, msgs[j].md.err);
 
-	return (msg->err < 0) ? msg->err : mn;
+	return (msg->md.err < 0) ? msg->md.err : mn;
 }
 
 static u32 bit_func(struct i2c_adapter *i2c_adap)
diff -urN --exclude=CVS i2c.orig/kernel/i2c-algo-pcf.c i2c.md/kernel/i2c-algo-pcf.c
--- i2c.orig/kernel/i2c-algo-pcf.c	Fri Jul 25 00:56:42 2003
+++ i2c.md/kernel/i2c-algo-pcf.c	Wed Aug 13 16:05:59 2003
@@ -299,12 +299,12 @@
 static inline int pcf_doAddress(struct i2c_algo_pcf_data *adap,
                                 struct i2c_msg *msg, int retries) 
 {
-	unsigned short flags = msg->flags;
+	unsigned short flags = msg->md.flags;
 	unsigned char addr;
 	int ret;
 	if ( (flags & I2C_M_TEN)  ) { 
 		/* a ten bit address */
-		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
+		addr = 0xf0 | (( msg->md.addr >> 7) & 0x03);
 		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
 		/* try extended address code...*/
 		ret = try_address(adap, addr, retries);
@@ -313,7 +313,7 @@
 			return -EREMOTEIO;
 		}
 		/* the remaining 8 bit address */
-		i2c_outb(adap,msg->addr & 0x7f);
+		i2c_outb(adap,msg->md.addr & 0x7f);
 /* Status check comes here */
 		if (ret != 1) {
 			printk(KERN_ERR "died at 2nd address code.\n");
@@ -330,7 +330,7 @@
 			}
 		}
 	} else {		/* normal 7bit address	*/
-		addr = ( msg->addr << 1 );
+		addr = ( msg->md.addr << 1 );
 		if (flags & I2C_M_RD )
 			addr |= 1;
 		if (flags & I2C_M_REV_DIR_ADDR )
@@ -362,8 +362,8 @@
 		pmsg = &msgs[i];
 
 		DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
-		     pmsg->flags & I2C_M_RD ? "read" : "write",
-                     pmsg->len, pmsg->addr, i + 1, num);)
+		     pmsg->md.flags & I2C_M_RD ? "read" : "write",
+                     pmsg->md.len, pmsg->md.addr, i + 1, num);)
     
 		ret = pcf_doAddress(adap, pmsg, i2c_adap->retries);
 
@@ -391,25 +391,25 @@
 #endif
     
 		DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
-			    i, msgs[i].addr, msgs[i].flags, msgs[i].len);)
+			    i, msgs[i].md.addr, msgs[i].md.flags, msgs[i].md.len);)
     
 		/* Read */
-		if (pmsg->flags & I2C_M_RD) {
+		if (pmsg->md.flags & I2C_M_RD) {
 			/* read bytes into buffer*/
-			ret = pcf_readbytes(i2c_adap, pmsg->buf, pmsg->len,
+			ret = pcf_readbytes(i2c_adap, pmsg->buf, pmsg->md.len,
                                             (i + 1 = num));
         
-			if (ret != pmsg->len) {
+			if (ret != pmsg->md.len) {
 				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
 					    "only read %d bytes.\n",ret));
 			} else {
 				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: read %d bytes.\n",ret));
 			}
 		} else { /* Write */
-			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
+			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->md.len,
                                             (i + 1 = num));
         
-			if (ret != pmsg->len) {
+			if (ret != pmsg->md.len) {
 				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
 					    "only wrote %d bytes.\n",ret));
 			} else {
diff -urN --exclude=CVS i2c.orig/kernel/i2c-core.c i2c.md/kernel/i2c-core.c
--- i2c.orig/kernel/i2c-core.c	Fri Jul 25 00:56:42 2003
+++ i2c.md/kernel/i2c-core.c	Wed Aug 13 15:59:06 2003
@@ -702,9 +702,9 @@
 	struct i2c_msg msg;
 
 	if (client->adapter->algo->master_xfer) {
-		msg.addr   = client->addr;
-		msg.flags = client->flags & I2C_M_TEN;
-		msg.len = count;
+		msg.md.addr   = client->addr;
+		msg.md.flags = client->flags & I2C_M_TEN;
+		msg.md.len = count;
 		(const char *)msg.buf = buf;
 	
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
@@ -731,10 +731,10 @@
 	struct i2c_msg msg;
 	int ret;
 	if (client->adapter->algo->master_xfer) {
-		msg.addr   = client->addr;
-		msg.flags = client->flags & I2C_M_TEN;
-		msg.flags |= I2C_M_RD;
-		msg.len = count;
+		msg.md.addr   = client->addr;
+		msg.md.flags = client->flags & I2C_M_TEN;
+		msg.md.flags |= I2C_M_RD;
+		msg.md.len = count;
 		msg.buf = buf;
 
 		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: reading %d bytes on %s.\n",
@@ -1211,39 +1211,39 @@
 	unsigned char msgbuf0[34];
 	unsigned char msgbuf1[34];
 	int num = read_write = I2C_SMBUS_READ?2:1;
-	struct i2c_msg msg[2] = { { addr, flags, 1, msgbuf0 }, 
-	                          { addr, flags | I2C_M_RD, 0, msgbuf1 }
+	struct i2c_msg msg[2] = { { { addr, flags, 1 }, msgbuf0 }, 
+	                          { { addr, flags | I2C_M_RD, 0 } , msgbuf1 }
 	                        };
 	int i;
 
 	msgbuf0[0] = command;
 	switch(size) {
 	case I2C_SMBUS_QUICK:
-		msg[0].len = 0;
+		msg[0].md.len = 0;
 		/* Special case: The read/write field is used as data */
-		msg[0].flags = flags | (read_write=I2C_SMBUS_READ)?I2C_M_RD:0;
+		msg[0].md.flags = flags | (read_write=I2C_SMBUS_READ)?I2C_M_RD:0;
 		num = 1;
 		break;
 	case I2C_SMBUS_BYTE:
 		if (read_write = I2C_SMBUS_READ) {
 			/* Special case: only a read! */
-			msg[0].flags = I2C_M_RD | flags;
+			msg[0].md.flags = I2C_M_RD | flags;
 			num = 1;
 		}
 		break;
 	case I2C_SMBUS_BYTE_DATA:
 		if (read_write = I2C_SMBUS_READ)
-			msg[1].len = 1;
+			msg[1].md.len = 1;
 		else {
-			msg[0].len = 2;
+			msg[0].md.len = 2;
 			msgbuf0[1] = data->byte;
 		}
 		break;
 	case I2C_SMBUS_WORD_DATA:
 		if (read_write = I2C_SMBUS_READ)
-			msg[1].len = 2;
+			msg[1].md.len = 2;
 		else {
-			msg[0].len=3;
+			msg[0].md.len=3;
 			msgbuf0[1] = data->word & 0xff;
 			msgbuf0[2] = (data->word >> 8) & 0xff;
 		}
@@ -1251,8 +1251,8 @@
 	case I2C_SMBUS_PROC_CALL:
 		num = 2; /* Special case */
 		read_write = I2C_SMBUS_READ;
-		msg[0].len = 3;
-		msg[1].len = 2;
+		msg[0].md.len = 3;
+		msg[1].md.len = 2;
 		msgbuf0[1] = data->word & 0xff;
 		msgbuf0[2] = (data->word >> 8) & 0xff;
 		break;
@@ -1263,16 +1263,16 @@
 			       "under I2C emulation!\n");
 			return -1;
 		} else {
-			msg[0].len = data->block[0] + 2;
-			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
+			msg[0].md.len = data->block[0] + 2;
+			if (msg[0].md.len > I2C_SMBUS_BLOCK_MAX + 2) {
 				printk(KERN_ERR "i2c-core.o: smbus_access called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
 				return -1;
 			}
 			if(size = I2C_SMBUS_BLOCK_DATA_PEC)
-				(msg[0].len)++;
-			for (i = 1; i <= msg[0].len; i++)
+				(msg[0].md.len)++;
+			for (i = 1; i <= msg[0].md.len; i++)
 				msgbuf0[i] = data->block[i-1];
 		}
 		break;
@@ -1283,10 +1283,10 @@
 		return -1;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
 		if (read_write = I2C_SMBUS_READ) {
-			msg[1].len = I2C_SMBUS_I2C_BLOCK_MAX;
+			msg[1].md.len = I2C_SMBUS_I2C_BLOCK_MAX;
 		} else {
-			msg[0].len = data->block[0] + 1;
-			if (msg[0].len > I2C_SMBUS_I2C_BLOCK_MAX + 1) {
+			msg[0].md.len = data->block[0] + 1;
+			if (msg[0].md.len > I2C_SMBUS_I2C_BLOCK_MAX + 1) {
 				printk("i2c-core.o: i2c_smbus_xfer_emulated called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
diff -urN --exclude=CVS i2c.orig/kernel/i2c-dev.c i2c.md/kernel/i2c-dev.c
--- i2c.orig/kernel/i2c-dev.c	Sat Aug  9 11:59:43 2003
+++ i2c.md/kernel/i2c-dev.c	Thu Aug 14 10:51:49 2003
@@ -170,8 +170,8 @@
 	struct i2c_rdwr_ioctl_data rdwr_arg;
 	struct i2c_smbus_ioctl_data data_arg;
 	union i2c_smbus_data temp;
+	struct i2c_msg *tmp_pa;
 	struct i2c_msg *rdwr_pa;
-	u8 **data_ptrs;
 	int i,datasize,res;
 	unsigned long funcs;
 
@@ -218,43 +218,46 @@
 		if (rdwr_arg.nmsgs > 42)
 			return -EINVAL;
                
-		rdwr_pa = (struct i2c_msg *)
+		tmp_pa = (struct i2c_msg *)
 			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg), 
 			GFP_KERNEL);
 
-		if (rdwr_pa = NULL) return -ENOMEM;
+		if (tmp_pa = NULL) return -ENOMEM;
 
-		if (copy_from_user(rdwr_pa, rdwr_arg.msgs,
+		if (copy_from_user(tmp_pa, rdwr_arg.msgs,
 				   rdwr_arg.nmsgs * sizeof(struct i2c_msg))) {
-			kfree(rdwr_pa);
+			kfree(tmp_pa);
 			return -EFAULT;
 		}
 
-		data_ptrs = (u8 **) kmalloc(rdwr_arg.nmsgs * sizeof(u8 *),
-					    GFP_KERNEL);
-		if (data_ptrs = NULL) {
-			kfree(rdwr_pa);
+		rdwr_pa = (struct i2c_msg *)
+			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg), 
+			GFP_KERNEL);
+
+		if (rdwr_pa = NULL) {
+			kfree(tmp_pa);
 			return -ENOMEM;
 		}
 
 		res = 0;
 		for( i=0; i<rdwr_arg.nmsgs; i++ )
 		{
+			rdwr_pa[i].md = tmp_pa[i].md;
+
 			/* Limit the size of the message to a sane amount */
-			if (rdwr_pa[i].len > 8192) {
+			if (rdwr_pa[i].md.len > 8192) {
 				res = -EINVAL;
 				break;
 			}
-			data_ptrs[i] = rdwr_pa[i].buf;
-			rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
+			rdwr_pa[i].buf = kmalloc(rdwr_pa[i].md.len, GFP_KERNEL);
 			if(rdwr_pa[i].buf = NULL)
 			{
 				res = -ENOMEM;
 				break;
 			}
 			if(copy_from_user(rdwr_pa[i].buf,
-				data_ptrs[i],
-				rdwr_pa[i].len))
+				tmp_pa[i].buf,
+				rdwr_pa[i].md.len))
 			{
 				++i; /* Needs to be kfreed too */
 				res = -EFAULT;
@@ -265,8 +268,8 @@
 			int j;
 			for (j = 0; j < i; ++j)
 				kfree(rdwr_pa[j].buf);
-			kfree(data_ptrs);
 			kfree(rdwr_pa);
+			kfree(tmp_pa);
 			return res;
 		}
 
@@ -275,20 +278,20 @@
 			rdwr_arg.nmsgs);
 		while(i-- > 0)
 		{
-			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD))
+			if( res>=0 && (rdwr_pa[i].md.flags & I2C_M_RD))
 			{
 				if(copy_to_user(
-					data_ptrs[i],
+					tmp_pa[i].buf,
 					rdwr_pa[i].buf,
-					rdwr_pa[i].len))
+					rdwr_pa[i].md.len))
 				{
 					res = -EFAULT;
 				}
 			}
 			kfree(rdwr_pa[i].buf);
 		}
-		kfree(data_ptrs);
 		kfree(rdwr_pa);
+		kfree(tmp_pa);
 		return res;
 
 	case I2C_SMBUS:
diff -urN --exclude=CVS i2c.orig/kernel/i2c.h i2c.md/kernel/i2c.h
--- i2c.orig/kernel/i2c.h	Sat Aug  2 22:07:09 2003
+++ i2c.md/kernel/i2c.h	Wed Aug 13 15:54:49 2003
@@ -355,18 +355,20 @@
  * I2C Message - used for pure i2c transaction, also from /dev interface
  */
 struct i2c_msg {
-	__u16 addr;	/* slave address			*/
-	__u16 flags;		
+	struct {
+		__u16 addr;	/* slave address			*/
+		__u16 flags;		
 #define I2C_M_TEN	0x10	/* we have a ten bit chip address	*/
 #define I2C_M_RD	0x01
 #define I2C_M_NOSTART	0x4000
 #define I2C_M_REV_DIR_ADDR	0x2000
 #define I2C_M_IGNORE_NAK	0x1000
 #define I2C_M_NO_RD_ACK		0x0800
-	__u16 len;		/* msg length				*/
+		__u16 len;		/* msg length				*/
+		int err;
+		short done;
+	} md;
 	__u8 *buf;		/* pointer to msg data			*/
-	int err;
-	short done;
 };
 
 /* To determine what functionality is present */
