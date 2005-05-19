From: ben-i2c@fluff.org (Ben Dooks)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: S3C2410 I2C driver
Message-Id: <20041012090050.GA5000@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041008130842.GK12218@home.fluff.org>
In-Reply-To: <20041008130842.GK12218@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 11, 2004 at 06:00:48PM -0700, Greg KH wrote:
> On Tue, Oct 12, 2004 at 01:49:34AM +0100, Ben Dooks wrote:
> > On Mon, Oct 11, 2004 at 05:29:32PM -0700, Greg KH wrote:
> > > On Sun, Oct 10, 2004 at 11:05:50PM +0100, Ben Dooks wrote:
> > > > On Fri, Oct 08, 2004 at 02:08:42PM +0100, Ben Dooks wrote:
> > > > > I have the first version of my Samsung S3C2410 I2C bus driver
> > > > > available at http://www.fluff.org/ben/linux-26/i2c-s3cdrv1.patch
> > > > > 
> > > > > Tested against 2.6.9-rc3.
> > > > > 
> > > > > I would be grateful of any comment, as I would like to get this
> > > > > support into the 2.6 kernel soon.
> > > > 
> > > > Is the correct approach to getting this patch applied to email
> > > > linux-kernel@vger.kerne.org and cc greg@kroah.com and 
> > > 
> > > Yes.
> > > 
> > > > I also need an allocation for I2C_ALGO_S3C2410
> > > 
> > > Hm, I thought we didn't need ids allocated anymore.  Doesn't your driver
> > > work just fine without it?
> > 
> > Ok, I've not seen that information before... what is the correct
> > value to set this to? I assume that the identity of the controller
> > can be ascertained from it's parent device?
> 
> Hm, this is for a bus driver?  I need to see the patch to give you a
> better answer.
> 
> > > Care to send the patch so we can comment on it?
> > 
> > The last version was put on my website for download, as I didn't
> > know wether people would get irritated at having a large-ish patch
> > sent to the list... I can repost the patch inline if people would
> > like to see it in the message.
> 
> Inline lets us comment on it properly.

| i2c-s3cdrv1.patch
|
| Files affected:
|   drivers/i2c/busses/Kconfig       |    7 	7 +	0 -	0 !
|   drivers/i2c/busses/Makefile      |    1 	1 +	0 -	0 !
|   drivers/i2c/busses/i2c-s3c2410.c |  922 	922 +	0 -	0 !
|   3 files changed, 930 insertions(+)
|
| Ben Dooks, Fri, 08 Oct 2004 14:04:49 +0100

diff -urN -X ../dontdiff linux-2.6.9-rc3/drivers/i2c/busses/Kconfig linux-2.6.9-rc3-work2/drivers/i2c/busses/Kconfig
--- linux-2.6.9-rc3/drivers/i2c/busses/Kconfig	2004-10-04 22:57:07.000000000 +0100
+++ linux-2.6.9-rc3-work2/drivers/i2c/busses/Kconfig	2004-10-02 14:26:43.000000000 +0100
@@ -289,6 +289,13 @@
 	depends on (RPXLITE || RPXCLASSIC) && I2C
 	select I2C_ALGO8XX
 
+config I2C_S3C2410
+	tristate "S3C2410 I2C Driver"
+	depends on I2C && ARCH_S3C2410
+	help
+	  Say Y to this to enable the I2C controller inbuilt into the
+	  Samsung S3C2410 based System-on-Chip devices
+
 config I2C_SAVAGE4
 	tristate "S3 Savage 4"
 	depends on I2C && PCI && EXPERIMENTAL
diff -urN -X ../dontdiff linux-2.6.9-rc3/drivers/i2c/busses/Makefile linux-2.6.9-rc3-work2/drivers/i2c/busses/Makefile
--- linux-2.6.9-rc3/drivers/i2c/busses/Makefile	2004-10-04 22:57:07.000000000 +0100
+++ linux-2.6.9-rc3-work2/drivers/i2c/busses/Makefile	2004-10-02 14:27:01.000000000 +0100
@@ -26,6 +26,7 @@
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
 obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
 obj-$(CONFIG_I2C_RPXLITE)	+= i2c-rpx.o
+obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
 obj-$(CONFIG_I2C_SAVAGE4)	+= i2c-savage4.o
 obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
diff -urN -X ../dontdiff linux-2.6.9-rc3/drivers/i2c/busses/i2c-s3c2410.c linux-2.6.9-rc3-work2/drivers/i2c/busses/i2c-s3c2410.c
--- linux-2.6.9-rc3/drivers/i2c/busses/i2c-s3c2410.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc3-work2/drivers/i2c/busses/i2c-s3c2410.c	2004-10-08 14:04:27.000000000 +0100
@@ -0,0 +1,922 @@
+/* linux/drivers/i2c/busses/i2c-s3c2410.c
+ *
+ * Copyright (c) 2004 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C2410 I2C Controller
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Changelog
+ *	29-Sep-2004	BJD	Initial version
+ *	04-Oct-2004	BJD	Fixed ignore ACK on last read
+ *	08-Oct-2004	BJD	Fixed stop if zero length message
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/device.h>
+
+#include <asm/hardware.h>
+#include <asm/irq.h>
+
+#include <asm/hardware/clock.h>
+#include <asm/arch/regs-gpio.h>
+#include <asm/arch/regs-iic.h>
+#include <asm/arch/iic.h>
+
+#define PFX "s3c-i2c: "
+
+#define XFER_RETRY (-2000)
+#define XFER_NAKED (-ECONNREFUSED)
+
+static int debug_info = 0;
+static int debug_norm = 4;
+
+enum s3c24xx_i2c_state {
+	STATE_IDLE,
+	STATE_START,
+	STATE_READ,
+	STATE_WRITE,
+	STATE_STOP
+};
+
+struct s3c24xx_i2c {
+	spinlock_t		lock;
+	wait_queue_head_t	wait;
+
+	struct i2c_msg		*msg;
+	unsigned int		msg_num;
+	unsigned int		msg_idx;
+	unsigned int		msg_ptr;
+
+	enum s3c24xx_i2c_state	state;
+
+	void			*regs;
+	struct clk		*clk;
+	struct resource		*irq;
+	struct resource		*ioarea;
+	struct i2c_adapter	adap;
+};
+
+/* default platform data to use if the user does not supply
+ * any 
+*/
+
+static struct s3c2410_platform_i2c s3c24xx_i2c_default_platform = {
+	.flags		= 0,
+	.slave_addr	= 0x10,
+	.bus_freq	= 100*1000,
+	.max_freq	= 400*1000
+};
+
+/* Debug */
+
+#define DBG(lev, msg...) do {\
+	if (lev < debug_info) \
+		printk(KERN_INFO msg); \
+	if (lev < debug_norm ) \
+		printk(KERN_DEBUG msg); \
+	} while(0)
+
+
+/* */
+static inline struct s3c2410_platform_i2c *s3c24xx_i2c_get_platformdata(struct device *dev)
+{
+	if (dev->platform_data != NULL)
+		return (struct s3c2410_platform_i2c *)dev->platform_data;
+
+	return &s3c24xx_i2c_default_platform;
+}
+
+/* IO read/write functions */
+
+static inline void wr_regb(struct s3c24xx_i2c *i2c, int reg, unsigned int val)
+{
+	writeb(val, i2c->regs + reg);
+}
+
+static inline void wr_regl(struct s3c24xx_i2c *i2c, int reg, unsigned long val)
+{
+	writel(val, i2c->regs + reg);
+}
+
+static inline unsigned long rd_regb(struct s3c24xx_i2c *i2c, int reg)
+{
+	return (unsigned long)readb(i2c->regs + reg);
+}
+
+static inline unsigned long rd_regl(struct s3c24xx_i2c *i2c, int reg)
+{
+	return readl(i2c->regs + reg);
+}
+
+/* s3c24xx_i2c_master_complete - complete the message and wake up.
+*/
+
+static inline void s3c24xx_i2c_master_complete(struct s3c24xx_i2c *i2c, int ret)
+{
+	DBG(2, "s3c24xx_i2c_master_complete, code %d\n", ret);
+
+	i2c->msg_ptr = 0;
+	i2c->msg = NULL;
+	i2c->msg_idx ++;
+	i2c->msg_num = 0;
+	if (ret)
+		i2c->msg_idx = ret;
+
+	wake_up(&i2c->wait);
+}
+
+static inline void s3c24xx_i2c_disable_ack(struct s3c24xx_i2c *i2c)
+{
+	unsigned long tmp;
+	
+	DBG(3, "s3c24xx_i2c_disable_ack:\n");
+
+	tmp = rd_regl(i2c, S3C2410_IICCON);
+	wr_regl(i2c, S3C2410_IICCON, tmp & ~S3C2410_IICCON_ACKEN);
+
+}
+
+static inline void s3c24xx_i2c_enable_ack(struct s3c24xx_i2c *i2c)
+{
+	unsigned long tmp;
+	
+	tmp = rd_regl(i2c, S3C2410_IICCON);
+	wr_regl(i2c, S3C2410_IICCON, tmp | S3C2410_IICCON_ACKEN);
+
+}
+
+/* irq enable/disable functions */
+
+static inline void s3c24xx_i2c_disable_irq(struct s3c24xx_i2c *i2c)
+{
+	unsigned long tmp;
+	
+	tmp = rd_regl(i2c, S3C2410_IICCON);
+	wr_regl(i2c, S3C2410_IICCON, tmp & ~S3C2410_IICCON_IRQEN);
+}
+
+static inline void s3c24xx_i2c_enable_irq(struct s3c24xx_i2c *i2c)
+{
+	unsigned long tmp;
+	
+	tmp = rd_regl(i2c, S3C2410_IICCON);
+	wr_regl(i2c, S3C2410_IICCON, tmp | S3C2410_IICCON_IRQEN);
+}
+
+
+/* s3c24xx_i2c_message_start
+ *
+ * put the start of a message onto the bus 
+*/
+
+static void s3c24xx_i2c_message_start(struct s3c24xx_i2c *i2c, 
+				      struct i2c_msg *msg)
+{
+	unsigned int addr = (msg->addr & 0x7f) << 1;
+	unsigned long stat;
+
+	stat = rd_regl(i2c, S3C2410_IICSTAT);
+	stat &= ~S3C2410_IICSTAT_MODEMASK;
+	stat |=  S3C2410_IICSTAT_START;
+	stat |=  S3C2410_IICSTAT_TXRXEN;
+
+	if (msg->flags & I2C_M_RD) {
+		stat |= S3C2410_IICSTAT_MASTER_RX;
+		addr |= 1;
+	} else
+		stat |= S3C2410_IICSTAT_MASTER_TX;
+
+	// todo - check for wether ack wanted or not
+	s3c24xx_i2c_enable_ack(i2c);
+
+	DBG(3, "START Written %08lx to IICSTAT, %02x to DS\n", stat, addr);
+	wr_regb(i2c, S3C2410_IICDS,   addr);
+	wr_regl(i2c, S3C2410_IICSTAT, stat);
+}
+
+static inline void s3c24xx_i2c_stop(struct s3c24xx_i2c *i2c, int ret)
+{
+	unsigned long iicstat = rd_regl(i2c, S3C2410_IICSTAT);
+
+	DBG(2, "s3c24xx_i2c_msg_stop:\n");
+
+	/* stop the transfer */
+	iicstat &= ~ S3C2410_IICSTAT_START;
+	wr_regl(i2c, S3C2410_IICSTAT, iicstat);
+	
+	i2c->state = STATE_STOP;
+	
+	s3c24xx_i2c_master_complete(i2c, ret);
+	s3c24xx_i2c_disable_irq(i2c);
+}
+
+/* helper functions to determine the current state in the set of
+ * messages we are sending */
+
+/* is_lastmsg()
+ *
+ * returns TRUE if the current message is the last in the set 
+*/
+
+static inline int is_lastmsg(struct s3c24xx_i2c *i2c)
+{
+	return i2c->msg_idx >= (i2c->msg_num - 1);
+}
+
+/* is_msglast
+ *
+ * returns TRUE if we this is the last byte in the current message
+*/
+
+static inline int is_msglast(struct s3c24xx_i2c *i2c)
+{
+	return i2c->msg_ptr = i2c->msg->len-1;
+}
+
+/* is_msgend
+ *
+ * returns TRUE if we reached the end of the current message
+*/
+
+static inline int is_msgend(struct s3c24xx_i2c *i2c)
+{
+	return i2c->msg_ptr >= i2c->msg->len;
+}
+
+static int i2s_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
+{
+	unsigned long tmp;
+	unsigned char byte;
+	int ret = 0;
+
+	DBG(3, "nextbyte: msg %p, num=%d, idx=%d, ptr=%d, state=%d\n",
+	    i2c->msg, i2c->msg_num, i2c->msg_idx, i2c->msg_ptr, i2c->state);
+
+	switch (i2c->state) {
+
+	case STATE_IDLE:
+		printk(KERN_ERR "%s: called in STATE_IDLE\n", __FUNCTION__);
+		goto out;
+		break;
+
+	case STATE_STOP:
+		printk(KERN_ERR "%s: called in STATE_STOP\n", __FUNCTION__);
+		s3c24xx_i2c_disable_irq(i2c);		
+		goto out_ack;
+
+	case STATE_START:
+		/* last thing we did was send a start condition on the
+		 * bus, or started a new i2c message
+		 */
+		
+		DBG(3, "STATE_START: iicstat=%lx\n", iicstat);
+
+		if (iicstat  & S3C2410_IICSTAT_LASTBIT &&
+		    !(i2c->msg->flags & I2C_M_IGNORE_NAK)) {
+			/* ack was not received... */
+			DBG(2, "ACK not received from slave\n");
+
+			if (i2c->msg_idx = 0)
+				ret = XFER_RETRY;
+			else
+				ret = XFER_NAKED;
+
+			s3c24xx_i2c_stop(i2c, ret);
+			goto out_ack;
+		}
+
+		if (i2c->msg->flags & I2C_M_RD)
+			i2c->state = STATE_READ;
+		else
+			i2c->state = STATE_WRITE;
+		
+
+		/* terminate the transfer if there is nothing to do
+		 * (used by the i2c probe to find devices */
+
+		if (is_lastmsg(i2c) && i2c->msg->len = 0) {
+			DBG(3, "START: Looks like probe\n");
+			s3c24xx_i2c_stop(i2c, 0);
+			goto out_ack;
+		}
+
+		if (i2c->state = STATE_READ)
+			goto prepare_read;
+
+		/* fall through to the write state, as we will need to 
+		 * send a byte as well */
+
+	case STATE_WRITE:
+		/* we are writing data to the device... check for the
+		 * end of the message, and if so, work out what to do
+		 */
+
+		if (!is_msgend(i2c)) {
+			byte = i2c->msg->buf[i2c->msg_ptr++];
+
+			DBG(3, "WRITE byte %02x\n", byte);
+			wr_regb(i2c, S3C2410_IICDS, byte);		
+			
+		} else if (!is_lastmsg(i2c)) {
+			/* we need to go to the next i2c message */
+
+			DBG(3, "WRITE: Next Message\n");
+
+			i2c->msg_ptr = 0;
+			i2c->msg_idx ++;
+			i2c->msg++;
+			
+			/* check to see if we need to do another message */
+			if (i2c->msg->flags & I2C_M_NOSTART) {
+				// todo //
+				DBG(1, "WRITE: Error I2C_M_NOSTART\n");
+			}
+			
+			/* send the new start */
+			s3c24xx_i2c_message_start(i2c, i2c->msg);
+			i2c->state = STATE_START;
+		} else {
+			/* send stop */
+			DBG(3, "WRITE: Send Stop\n");
+
+			s3c24xx_i2c_stop(i2c, 0);
+		}
+		break;
+
+	case STATE_READ:
+		/* we have a byte of data in the data register, do 
+		 * something with it, and then work out wether we are
+		 * going to do any more read/write
+		 */
+
+		if (!(i2c->msg->flags & I2C_M_IGNORE_NAK) &&
+		    !(is_msglast(i2c) && is_lastmsg(i2c))) {
+
+			if (iicstat & S3C2410_IICSTAT_LASTBIT) {
+				DBG(2, "READ: No Ack\n");
+
+				s3c24xx_i2c_stop(i2c, XFER_NAKED);
+				goto out_ack;
+			}
+		}
+
+		i2c->msg->buf[i2c->msg_ptr++] = rd_regb(i2c, S3C2410_IICDS);
+
+		DBG(3, "READ: Read %02x\n", i2c->msg->buf[i2c->msg_ptr-1]);
+
+	prepare_read:
+		if (is_msglast(i2c)) {
+			/* last byte of buffer */
+
+			if (is_lastmsg(i2c))
+				s3c24xx_i2c_disable_ack(i2c);
+			
+		} else if (is_msgend(i2c)) {
+			/* ok, we've read the entire buffer, see if there
+			 * is anything else we need to do */
+
+			if (is_lastmsg(i2c)) {
+				/* last message, send stop and complete */
+				DBG(3, "READ: Send Stop\n");
+
+				s3c24xx_i2c_stop(i2c, 0);
+			} else {
+				/* go to the next transfer */
+				DBG(3, "READ: Next Transfer\n");
+
+				i2c->msg_ptr = 0;
+				i2c->msg_idx ++;
+				i2c->msg++;
+			}
+		}
+
+		break;
+	}
+
+	/* acknowlegde the IRQ and get back on with the work */
+
+ out_ack:
+	DBG(3, "out_ack:\n");
+	tmp = rd_regl(i2c, S3C2410_IICCON);	
+	tmp &= ~S3C2410_IICCON_IRQPEND;
+	wr_regl(i2c, S3C2410_IICCON, tmp);
+ out:
+	return ret;
+}
+
+/* s3c24xx_i2c_irq
+ *
+ * top level IRQ servicing routine
+*/
+
+static irqreturn_t s3c24xx_i2c_irq(int irqno, void *dev_id,
+				   struct pt_regs *regs)
+{
+	struct s3c24xx_i2c *i2c = dev_id;
+	unsigned long status;
+	unsigned long tmp;
+
+	status = rd_regl(i2c, S3C2410_IICSTAT);
+
+	DBG(3, "s3c24xx_i2c_irq: status %08lx\n", status);
+
+	if (status & S3C2410_IICSTAT_ARBITR) {
+		// deal with arbitration loss
+	}
+
+	if (i2c->state = STATE_IDLE) {
+		DBG(3, "IRQ: error i2c->state = IDLE\n");
+
+		tmp = rd_regl(i2c, S3C2410_IICCON);	
+		tmp &= ~S3C2410_IICCON_IRQPEND;
+		wr_regl(i2c, S3C2410_IICCON, tmp);
+		goto out;
+	}
+	
+	// pretty much this leaves us with the fact that we've
+	// transmitted or received whatever byte we last sent
+
+	i2s_s3c_irq_nextbyte(i2c, status);
+
+ out:
+	return IRQ_HANDLED;
+}
+
+
+/* s3c24xx_i2c_set_master
+ *
+ * get the i2c bus for a master transaction
+*/
+
+static int s3c24xx_i2c_set_master(struct s3c24xx_i2c *i2c)
+{
+	unsigned long iicstat;
+	int timeout = 400;
+
+	while (timeout-- > 0) {
+		iicstat = rd_regl(i2c, S3C2410_IICSTAT);
+		
+		if (!(iicstat & S3C2410_IICSTAT_BUSBUSY))
+			return 0;
+
+		msleep(1);
+	}
+
+	DBG(3, "timeout: read GPEDAT %08x\n", __raw_readl(S3C2410_GPEDAT));
+	return -ETIMEDOUT;
+}
+
+/* s3c24xx_i2c_showmsgs
+ *
+ * debug aide, shows all the messages pointed to in quick summary
+*/
+
+static void s3c24xx_i2c_showmsg(struct i2c_msg *parent, struct i2c_msg *msg)
+{
+	DBG(0, PFX "%p [%2d: A %04x F 0x%04x L 0x%04x %p ]\n",
+	    parent, parent-msg, msg->addr, msg->flags, msg->len, msg->buf);
+}
+
+static void s3c24xx_i2c_showmsgs(struct i2c_msg *msgs, int num)
+{
+	struct i2c_msg *msgp = msgs;
+	int msg;
+
+	for (msg = 0; msg < num; msg++, msgp++)
+		s3c24xx_i2c_showmsg(msgs, msgp); 
+}
+
+/* s3c24xx_i2c_doxfer
+ *
+ * this starts an i2c transfer
+*/
+
+static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c, struct i2c_msg msgs[], int num)
+{
+	unsigned long timeout;
+	int ret;
+
+	ret = s3c24xx_i2c_set_master(i2c);
+	if (ret != 0) {
+		printk(KERN_INFO PFX "cannot get bus (error %d)\n", ret);
+		ret = XFER_RETRY;
+		goto out;
+	}
+
+	spin_lock_irq(&i2c->lock);
+
+#if 1
+	s3c24xx_i2c_showmsgs(msgs, num);
+#endif
+
+	i2c->msg     = msgs;
+	i2c->msg_num = num;
+	i2c->msg_ptr = 0;
+	i2c->msg_idx = 0;
+	i2c->state   = STATE_START;
+
+	s3c24xx_i2c_enable_irq(i2c);
+	s3c24xx_i2c_message_start(i2c, msgs);
+	spin_unlock_irq(&i2c->lock);
+	
+	timeout = wait_event_timeout(i2c->wait, i2c->msg_num = 0, HZ * 5);
+
+	ret = i2c->msg_idx;
+
+	if (timeout = 0)
+		printk(KERN_DEBUG PFX "i2c err: timeout\n");
+	else if (ret != num)
+		printk(KERN_DEBUG PFX "i2c err: incomplete xfer (%d)\n", ret);
+
+	/* ensure the stop has been through the bus */
+
+	msleep(1);
+
+ out:
+	return ret;
+}
+
+/* s3c24xx_i2c_xfer
+ *
+ * first port of call from the i2c bus code when an message needs
+ * transfering across the i2c bus.
+*/
+
+static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
+			struct i2c_msg msgs[], int num)
+{
+	struct s3c24xx_i2c *i2c = (struct s3c24xx_i2c *)adap->algo_data;
+	int retry;
+	int ret;
+
+	for (retry = 0; retry < adap->retries; retry++) {
+
+		ret = s3c24xx_i2c_doxfer(i2c, msgs, num);
+
+		if (ret != XFER_RETRY)
+			return ret;
+
+		DBG(1, "Retrying transmission (%d)\n", retry);
+
+		udelay(100);
+	}
+
+	return -EREMOTEIO;
+}
+
+/* i2c bus registration info */
+
+static struct i2c_algorithm s3c24xx_i2c_algorithm = {
+	.name			= "S3C2410-I2C-Algorithm",
+	.id			= I2C_ALGO_S3C2410,
+	.master_xfer		= s3c24xx_i2c_xfer,
+};
+
+static struct s3c24xx_i2c s3c24xx_i2c = {
+	.lock	= SPIN_LOCK_UNLOCKED,
+	.wait	= __WAIT_QUEUE_HEAD_INITIALIZER(s3c24xx_i2c.wait),
+	.adap	= {
+		.name			= "s3c2410-i2c",
+		.id			= I2C_ALGO_S3C2410,
+		.algo			= &s3c24xx_i2c_algorithm,
+		.retries		= 2,
+	},
+};
+
+/* s3c24xx_i2c_calcdivisor
+ *
+ * return the divisor settings for a given frequency
+*/
+
+static int s3c24xx_i2c_calcdivisor(unsigned long clkin, unsigned int wanted,
+				   unsigned int *div1, unsigned int *divs)
+{
+	unsigned int calc_divs = clkin / wanted;
+	unsigned int calc_div1;
+
+	DBG(1, PFX "%lu/%u = %d\n", clkin, wanted, calc_divs);
+
+	if (calc_divs > (16*16))
+		calc_div1 = 512;
+	else
+		calc_div1 = 16;
+
+	calc_divs += calc_div1-1;
+	calc_divs /= calc_div1;
+
+	if (calc_divs = 0)
+		calc_divs = 1;
+	if (calc_divs > 17)
+		calc_divs = 17;
+
+	*divs = calc_divs;
+	*div1 = calc_div1;
+
+	DBG(1, "divisors %d, %d, => %ld\n",
+	    calc_divs, calc_div1, clkin / (calc_divs + calc_div1));
+
+	return clkin / (calc_divs + calc_div1);
+}
+
+/* freq_acceptable
+ *
+ * test wether a frequency is within the acceptable range of error
+*/
+
+static inline int freq_acceptable(unsigned int freq, unsigned int wanted)
+{
+	int diff = freq - wanted;
+
+	return (diff >= -2 && diff <= 2);
+}
+
+/* s3c24xx_i2c_getdivisor
+ *
+ * work out a divisor for the user requested frequency setting,
+ * either by the requested frequency, or scanning the acceptable
+ * range of frequencies until something is found
+*/
+
+static int s3c24xx_i2c_getdivisor(struct s3c24xx_i2c *i2c,
+				  unsigned long *iicon,
+				  unsigned int *got)
+{
+	unsigned long clkin = clk_get_rate(i2c->clk);
+	struct s3c2410_platform_i2c *pdata;
+	unsigned int divs, div1;
+	int freq;
+	int start, end;
+
+	clkin /= 1000;		/* clkin now in KHz */
+
+	pdata = s3c24xx_i2c_get_platformdata(i2c->adap.dev.parent);
+
+	DBG(1, "pdata %p, freq %lu %lu..%lu\n", pdata, pdata->bus_freq,
+	    pdata->min_freq, pdata->max_freq);
+
+	if (pdata->bus_freq != 0) {
+		freq = s3c24xx_i2c_calcdivisor(clkin, pdata->bus_freq/1000,
+					   &div1, &divs);
+		if (freq_acceptable(freq, pdata->bus_freq/1000))
+			goto found;
+	}
+
+	/* ok, we may have to search for something suitable... */
+
+	start = (pdata->max_freq = 0) ? pdata->bus_freq : pdata->max_freq;
+	end = pdata->min_freq;
+
+	start /= 1000;
+	end /= 1000;
+
+	for (; start > end; start--) {
+		freq = s3c24xx_i2c_calcdivisor(clkin, start, &div1, &divs);
+		if (freq_acceptable(freq, start))
+			goto found;
+	}
+
+	return -EINVAL;
+
+ found:
+	*got = freq;
+	*iicon |= (divs-1);
+	*iicon |= (div1 = 512) ? S3C2410_IICCON_TXDIV_512 : 0;
+	return 0;
+}
+
+/* s3c24xx_i2c_init
+ *
+ * initialise the controller, set the IO lines and frequency 
+*/
+
+static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
+{
+	unsigned long iicon = S3C2410_IICCON_IRQEN | S3C2410_IICCON_ACKEN;
+	unsigned int freq;
+
+	/* inititalise the gpio */
+
+	s3c2410_gpio_cfgpin(S3C2410_GPE15, S3C2410_GPE15_IICSDA);
+	s3c2410_gpio_cfgpin(S3C2410_GPE14, S3C2410_GPE14_IICSCL);
+
+	/* we need to work out the divisors for the clock... */
+
+	if (s3c24xx_i2c_getdivisor(i2c, &iicon, &freq) != 0) {
+		printk(KERN_INFO PFX "cannot meet bus frequency required\n");
+		return -EINVAL;
+	}
+
+	/* todo - check that the i2c lines aren't being dragged anywhere */
+
+	printk(KERN_INFO PFX "Bus set to %d KHz\n", freq);
+
+	return 0;
+}
+
+static void s3c24xx_i2c_free(struct s3c24xx_i2c *i2c)
+{
+	if (i2c->clk != NULL && !IS_ERR(i2c->clk)) {
+		clk_disable(i2c->clk);
+		clk_unuse(i2c->clk);
+		clk_put(i2c->clk);
+		i2c->clk = NULL;
+	}
+
+	if (i2c->regs != NULL) {
+		iounmap(i2c->regs);
+		i2c->regs = NULL;
+	}
+
+	if (i2c->ioarea != NULL) {
+		release_resource(i2c->ioarea);
+		kfree(i2c->ioarea);
+		i2c->ioarea = NULL;
+	}
+}
+
+/* s3c24xx_i2c_probe
+ *
+ * called by the bus driver when a suitable device is found
+*/
+
+static int s3c24xx_i2c_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct s3c24xx_i2c *i2c = &s3c24xx_i2c;
+	struct resource *res;
+	int ret;
+
+	DBG(0, "%s(%p)\n", __FUNCTION__, dev);
+
+	/* find the clock and enable it */
+
+	i2c->clk = clk_get(dev, "i2c");
+	if (IS_ERR(i2c->clk)) {
+		printk(KERN_ERR PFX "cannot get clock\n");
+		ret = -ENOENT;
+		goto out;
+	}
+
+	DBG(1, PFX "got clock %p\n", i2c->clk);
+
+	clk_use(i2c->clk);
+	clk_enable(i2c->clk);
+
+	/* map the registers */
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res = NULL) {
+		printk(KERN_ERR PFX "cannot find IO\n");
+		ret = -ENOENT;
+		goto out;
+	}
+
+	i2c->ioarea = request_mem_region(res->start, (res->end-res->start)+1,
+					 pdev->name);
+
+	if (i2c->ioarea = NULL) {
+		printk(KERN_ERR PFX "cannot request IO\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	i2c->regs = ioremap(res->start, (res->end-res->start)+1);
+
+	if (i2c->regs = NULL) {
+		printk(KERN_ERR PFX "cannot map IO\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	DBG(1, PFX "got registers %p (%p, %p)\n", i2c->regs, i2c->ioarea, res);
+
+	/* setup info block for the i2c core */
+
+	i2c->adap.algo_data = i2c;
+	i2c->adap.dev.parent = dev;
+
+	/* initialise the i2c controller */
+
+	ret = s3c24xx_i2c_init(i2c);
+	if (ret != 0)
+		goto out;
+
+	/* find the IRQ for this unit (note, this relies on the init call to
+	 * ensure no current IRQs pending 
+	 */
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res = NULL) {
+		printk(KERN_ERR PFX "cannot find IRQ\n");
+		ret = -ENOENT;
+		goto out;
+	}
+
+	ret = request_irq(res->start, s3c24xx_i2c_irq, SA_INTERRUPT,
+			  pdev->name, i2c);
+
+	if (ret != 0) {
+		printk(KERN_ERR PFX "cannot claim IRQ\n");
+		goto out;
+	}
+
+	i2c->irq = res;
+		
+	DBG(0, PFX "got irq %p (%ld)\n", res, res->start);
+
+	ret = i2c_add_adapter(&i2c->adap);
+	if (ret < 0) {
+		printk(KERN_INFO "I2C: Failed to add bus\n");
+		goto out;
+	}
+
+	dev_set_drvdata(dev, i2c);
+
+	printk(KERN_INFO "I2C: %s: S3C I2C adapter\n", i2c->adap.dev.bus_id);
+
+ out:
+	if (ret < 0)
+		s3c24xx_i2c_free(i2c);
+
+	return ret;
+}
+
+/* s3c24xx_i2c_remove
+ *
+ * called when device is removed from the bus
+*/
+
+static int s3c24xx_i2c_remove(struct device *dev)
+{
+	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
+	
+	if (i2c != NULL) {
+		s3c24xx_i2c_free(i2c);
+		dev_set_drvdata(dev, NULL);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int s3c24xx_i2c_resume(struct device *dev, u32 level)
+{
+	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
+	
+	if (i2c != NULL && level = RESUME_ENABLE)
+		s3c24xx_i2c_init(i2c);
+
+	return 0;
+}
+
+#else
+#define s3c24xx_i2c_resume NULL
+#endif
+
+/* device driver for platform bus bits */
+
+static struct device_driver s3c24xx_i2c_driver = {
+	.name		= "s3c2410-i2c",
+	.bus		= &platform_bus_type,
+	.probe		= s3c24xx_i2c_probe,
+	.remove		= s3c24xx_i2c_remove,
+	.resume		= s3c24xx_i2c_resume
+};
+
+static int __init i2c_adap_s3c_init(void)
+{
+	return driver_register(&s3c24xx_i2c_driver);
+}
+
+static void i2c_adap_s3c_exit(void)
+{
+	return driver_unregister(&s3c24xx_i2c_driver);
+}
+
+module_init(i2c_adap_s3c_init);
+module_exit(i2c_adap_s3c_exit);


-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
