From: primm@netbotz.com (Mike Primm)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Fw: Question on I2C driver development for Motorola chips
Message-Id: <3F96DD51.1060108@netbotz.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB30349BF3FE18418DC420BDDCAE22AF0144AC06@az33exm54.corp.mot.com>
In-Reply-To: <BB30349BF3FE18418DC420BDDCAE22AF0144AC06@az33exm54.corp.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'd be happy to share our driver.....it has some "proprietary" adders 
(as we need to be able to use it kernel mode, as well as through the 
standard ioctl-style interfaces), but should be fine for incorporation 
into a shared codebase.  Here are the driver files:

--Mike

Jean Delvare wrote:

>Hi Michael,
>
>Xianghua is trying to reach you to share your works on Motorola MPC
>drivers, so I am forwarding his message to you so that you can get in
>touch.
>
>Begin forwarded message:
>
>Date: Tue, 21 Oct 2003 13:10:26 -0700
>From: Xiao Xianghua-r6aads <X.Xiao@motorola.com>
>To: "'sensors@stimpy.netroedge.com'" <sensors@Stimpy.netroedge.com>
>Cc: Xiao Xianghua-r6aads <X.Xiao@motorola.com>
>Subject: Question on I2C driver development for Motorola chips
>
>
>Hello,
>
>I'm an engineer working in Motorola. I have a 'working' I2C driver for
>the new chip MPC8540/MPC8560 and I'm eager to add this driver to your
>CVS, and I hope it can be pushed to the linux kernel in the near future.
>
>I noticed a MPC8245 I2C driver is under development by Mike Primm from
>your newdriver
>webpage(http://secure.netroedge.com/%7Elm78/newdrivers.html), and I'm
>very interested in his progress, however there is no way for me to reach
>him(there is no email address :( ). Additionally, there is another Linux
>I2C driver for MPC824x(http://www.humboldt.co.uk/mpc10xi2c.html).
>Include my driver, all of us are trying to do the same thing because
>MPC8540/MPC8560/MPC824x/MPC107 are having the similar I2C design. I
>would like to find a way to provide a generic I2C for all these Motorola
>chips.
>
>I'm also interested in getting the current Motorola 8xx I2C driver a new
>name if possible, because that driver can also be shared by
>8xx/82xx/83xx(forthcoming new chip), i.e. any Motorola chip with a
>CPM(Communication Process Module) part on it.
>
>Thanks a lot for your helps.
>
>Xianghua
>
>
>
>  
>

-- 
--Mike
--

-------------- next part --------------
/* ------------------------------------------------------------------------- */
/* i2c-algo-mpc824x.c i2c driver algorithms for mpc824x i2c interfaces	     */
/* ------------------------------------------------------------------------- */
/*   Copyright (C) 2002 NetBotz Inc <primm@netbotz.com>			     */
/* Derived from i2c-algo-bit.c						     */
/*   Copyright (C) 1995-2000 Simon G. Vogl

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
/* ------------------------------------------------------------------------- */

/* $Id: i2c-algo-mpc824x.c,v 1.11 2003/05/27 16:11:46 primm Exp $ */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/delay.h>
#include <linux/slab.h>
#include <linux/version.h>
#include <linux/init.h>
#include <asm/uaccess.h>
#include <asm/io.h>
#include <linux/pci.h>
#include <linux/ioport.h>
#include <linux/errno.h>
#include <linux/sched.h>
#include <linux/i2c.h>
#include <linux/i2c-algo-mpc824x.h>
#include <linux/smp_lock.h>

#define DRV_VERSION "0.1"

/* PCI device */
#define PCI_DEVICE_ID_BRIDGE_MPC8240	0x0003
#define PCI_DEVICE_ID_BRIDGE_MPC8245	0x0006

#define PCI_CONFIG_EUMB_BASE_ADDR	0x78
#define I2C_REGISTER_BASE_OFFSET	0x03000

#define USE_ASYNC_FOR_XFER
#define USE_HW_INT_FOR_XFER

#ifdef USE_HW_INT_FOR_XFER
#define	TIMER_PERIOD	(HZ/50)
#else
#define TIMER_PERIOD	(1)
#endif

#define HW_INT 129

enum i2c_mpc824x_regs {
	I2CADR, I2CFDR, I2CCR, I2CSR, I2CDR
};

typedef enum _i2c_mpc824x_status {
	ERROR = -1,
	NO_EVENT = -2,
	XMIT_ERROR = -3,
	RCV_ERROR = -4,
	BUS_BUSY = -5,
	ARB_LOST = -6,
	/* Pur errors before SUCCESS					*/
	SUCCESS = 0,
	ADDRESS_SENT,
	RECV_BUF_FULL,
	XMIT_BUF_EMPTY,
} i2c_mpc824x_status;

struct i2c_mpc824x_xfer_req {
	struct i2c_mpc824x_xfer_req *next;

	struct i2c_adapter *i2c_adap;
	struct i2c_msg *msgs;
	int num;
	void *usr_data;
	void (*callback)(struct i2c_adapter *, struct i2c_msg *,
		int num, int rc, void *usr_data);
	/* State variables						*/
	int cur_buf_num;	/* Current buffer index			*/
	int cur_do_xmit;	/* Current buffer is a transmit		*/
	unsigned long cur_wait_time;	/* Next timeout time (jiffies)	*/
};

static int	did_init = 0;
static spinlock_t	lock;
static struct i2c_mpc824x_xfer_req *req_head = NULL;
static struct i2c_mpc824x_xfer_req *req_tail = NULL;
static struct timer_list our_timer;
static int timer_added = 0;
static struct i2c_adapter *mpc_adap;

/* Default divisor of 1536 : gives us < 100KHz for 133MHz or less 	*/
#define DEFAULT_FDR	(0x0A)
/* Defines for i2c_mpc824x_get/setbits					*/
#define I2C_BITS(reg, off, mask) ((((reg) & 0xFF) << 24) | \
	(((off) & 0xFF) << 16) | ((mask) & 0xFFFF))
#define I2C_GETOFF(v) 		(((v) >> 16) & 0xFF)
#define I2C_GETMASK(v)		((v) & 0xFFFF)
#define I2C_GETREG(v) 		(((v) >> 24) & 0xFF)

#define I2C_MPC824X_ADR_ADDR	I2C_BITS(I2CADR, 1, 0x7F)
#define I2C_MPC824X_FDR_DFFAR	I2C_BITS(I2CFDR, 8, 0x3F)
#define I2C_MPC824X_FDR_FDR	I2C_BITS(I2CFDR, 0, 0x3F)
#define I2C_MPC824X_FDR		I2C_BITS(I2CFDR, 0, 0x3F3F)
#define I2C_MPC824X_CR_MEN	I2C_BITS(I2CCR, 7, 0x01)
#define I2C_MPC824X_CR_MIEN	I2C_BITS(I2CCR, 6, 0x01)
#define I2C_MPC824X_CR_MSTA	I2C_BITS(I2CCR, 5, 0x01)
#define I2C_MPC824X_CR_MTX	I2C_BITS(I2CCR, 4, 0x01)
#define I2C_MPC824X_CR_TXAK	I2C_BITS(I2CCR, 3, 0x01)
#define I2C_MPC824X_CR_RSTA	I2C_BITS(I2CCR, 2, 0x01)
#define I2C_MPC824X_CR_PCII	I2C_BITS(I2CCR, 1, 0x01)
#define I2C_MPC824X_CR_BCST	I2C_BITS(I2CCR, 0, 0x01)
#define I2C_MPC824X_CR		I2C_BITS(I2CCR, 0, 0xFF)
#define I2C_MPC824X_SR_MCF	I2C_BITS(I2CSR, 7, 0x01)
#define I2C_MPC824X_SR_MAAS	I2C_BITS(I2CSR, 6, 0x01)
#define I2C_MPC824X_SR_MBB	I2C_BITS(I2CSR, 5, 0x01)
#define I2C_MPC824X_SR_MAL	I2C_BITS(I2CSR, 4, 0x01)
#define I2C_MPC824X_SR_BCA	I2C_BITS(I2CSR, 3, 0x01)
#define I2C_MPC824X_SR_SRW	I2C_BITS(I2CSR, 2, 0x01)
#define I2C_MPC824X_SR_MIF	I2C_BITS(I2CSR, 1, 0x01)
#define I2C_MPC824X_SR_RXAK	I2C_BITS(I2CSR, 0, 0x01)
#define I2C_MPC824X_SR		I2C_BITS(I2CSR, 0, 0xFF)
#define I2C_MPC824X_DR_DATA	I2C_BITS(I2CDR, 0, 0xFF)

/* ----- global variables ---------------------------------------------	*/
static int debug_level = 1;

static u32 *eumb_base = NULL;

#define DEB(x, arg...) if((x) <= debug_level) { printk(arg); }

/* --- other auxiliary functions --------------------------------------	*/
static u32 i2c_mpc824x_getbits(u32 field)
{
	u32 val;
	val = in_le32(eumb_base + I2C_GETREG(field));
	val >>= I2C_GETOFF(field);	/* Shift field into place	*/
	val &= I2C_GETMASK(field);	/* And mask off other data	*/
	DEB(3, "i2c_mpc824x_getbits(0x%.8x)=0x%.8x\n",
		field, val);
	return val;
}

static void i2c_mpc824x_setbits(u32 field, u32 val)
{
	u32 oldval;
	u32 mask;
	u32 newval;

	DEB(3, "i2c_mpc824x_setbits(0x%.8x, 0x%.8x)\n",
		field, val);
	/* Get current value						*/
	oldval = in_le32(eumb_base + I2C_GETREG(field));
	mask = I2C_GETMASK(field);	/* Get mask			*/
	/* Mask off old values to keep					*/
	newval = oldval & (~(mask << I2C_GETOFF(field)));
	/* Now, add in the new value					*/
	newval |= (val & mask) << I2C_GETOFF(field);
	/* Now write out the modified register				*/
	out_le32(eumb_base + I2C_GETREG(field), newval);
}

static void i2c_init(void)
{
	DEB(2, "i2c_init()\n");
	/* Clear control register, for starters				*/
	i2c_mpc824x_setbits(I2C_MPC824X_CR, 0);
	/* Set FDR to a reasonable value (assume SDRAM clk <= 133MHz)	*/
	i2c_mpc824x_setbits(I2C_MPC824X_FDR_FDR,
		DEFAULT_FDR);
	/* Set slave address to invalid address (we don't do slave)     */
	i2c_mpc824x_setbits(I2C_MPC824X_ADR_ADDR, 0x7F);
#ifdef USE_HW_INT_FOR_XFER
	/* Initialize to interrupts enabled				*/
	i2c_mpc824x_setbits(I2C_MPC824X_CR_MIEN, 1);
#else
	/* Initialize to interrupts disabled (for now)			*/
	i2c_mpc824x_setbits(I2C_MPC824X_CR_MIEN, 0);
#endif
	/* We're all set : enable module				*/
	i2c_mpc824x_setbits(I2C_MPC824X_CR_MEN, 1);
}

static void i2c_term(void)
{
	DEB(2, "i2c_term()\n");
	/* Clear control register					*/
	i2c_mpc824x_setbits(I2C_MPC824X_CR, 0);
}

static i2c_mpc824x_status i2c_start(struct i2c_algo_mpc824x_data *adap)
{
	DEB(2, "i2c_start()\n");
	/* Complain if not initialized					*/
	if(i2c_mpc824x_getbits(I2C_MPC824X_CR_MEN) = 0) {
		DEB(1, "i2c-algo-mpc824x: not initialized\n");
		return ERROR;
	}
	/* Check to see if bus is free (only if we're not restarting)	*/
	if(i2c_mpc824x_getbits(I2C_MPC824X_SR_MBB) &&
		(adap->is_restart = 0)) {
		DEB(2, "i2c-algo-mpc824x: bus busy - resetting\n");
		i2c_init();	/* Reinitialize				*/
		return BUS_BUSY;
	}
	/* Set master mode						*/
	i2c_mpc824x_setbits(I2C_MPC824X_CR_MSTA, 1);
	/* Set MTC to indicate transmit					*/
	i2c_mpc824x_setbits(I2C_MPC824X_CR_MTX, 1);
	/* Clear txak							*/
	i2c_mpc824x_setbits(I2C_MPC824X_CR_TXAK, 0);
	/* Set restart appropriately					*/
	i2c_mpc824x_setbits(I2C_MPC824X_CR_RSTA,
		adap->is_restart?1:0);
	/* Write slave address being called into the data register	*/
	i2c_mpc824x_setbits(I2C_MPC824X_DR_DATA,
		(((u32)adap->slaveaddr & 0x7F) << 1) |
		(adap->is_xmit?0x00:0x01));
	/* If receive, then we're in the address phase			*/
	if(adap->is_xmit) {
		adap->is_rcv_addr = 0;
	} else {
		adap->is_rcv_addr = 1;
	}
	return SUCCESS;
}

static void i2c_stop(void)
{
	DEB(2, "i2c_stop()\n");
	/* Clear the master mode bit					*/
	i2c_mpc824x_setbits(I2C_MPC824X_CR_MSTA, 0);
}

/* Transmit next pending byte : return 1 if no more bytes, 0 if sent,
 * -1 if error								*/
static i2c_mpc824x_status i2c_xmit_next_byte(struct
	i2c_algo_mpc824x_data *adap)
{
	DEB(2, "i2c_xmit_next_byte()\n");
	/* If any bytes to send						*/
	if(adap->bufindex >= 0) {
		/* If we've sent the last byte				*/
		if(adap->bufindex = adap->buflen) {
			adap->bufindex = -1;	/* Mark we're done	*/
			/* If we want to stop, do it			*/
			if(adap->stop_when_done) {
				i2c_stop();
			}
			return XMIT_BUF_EMPTY;
		}
		/* Send next byte					*/
		i2c_mpc824x_setbits(I2C_MPC824X_DR_DATA,
			adap->buffer[adap->bufindex]);
		/* Increment index					*/
		adap->bufindex++;
		return SUCCESS;
	}
	return XMIT_BUF_EMPTY;
}

/* Receive next byte into buffer : return 1 if full, 0 if byte read,
 * -1 if error								*/
 static i2c_mpc824x_status i2c_recv_next_byte(struct
 	i2c_algo_mpc824x_data *adap)
 {
 	DEB(2, "i2c_recv_next_byte()\n");
 	/* If we're still receiving bytes				*/
	if(adap->bufindex >= 0) {
		/* If we're up to the next to last byte, we need to
		 * set the TXAK bit to tell the sender to stop		*/
		if((adap->buflen - adap->bufindex) = 2) {
			i2c_mpc824x_setbits(I2C_MPC824X_CR_TXAK, 1);
		}
		/* If we're about to receive the last one, and we want
		 * to stop after it, do so				*/
		if(((adap->buflen - adap->bufindex) = 1) &&
			adap->stop_when_done) {
			i2c_stop();
		}
		/* Now, read the data register				*/
		adap->buffer[adap->bufindex] = (u8)i2c_mpc824x_getbits(
			I2C_MPC824X_DR_DATA);
		adap->bufindex++;
		/* If that was the last one, return appropriately	*/
		if(adap->bufindex = adap->buflen) {
			adap->bufindex = -1;
			return RECV_BUF_FULL;
		}
		return SUCCESS;
	}
	return RECV_BUF_FULL;
}

/* Master ISR for I2C state machine					*/
static i2c_mpc824x_status i2c_isr(struct i2c_algo_mpc824x_data *adap)
{
	DEB(3, "i2c_isr: i2ccr=0x%.4x, i2csr=0x%.4x\n",
		i2c_mpc824x_getbits(I2C_MPC824X_CR),
		i2c_mpc824x_getbits(I2C_MPC824X_SR));
	/* Fist, clear the MIF flag					*/
	i2c_mpc824x_setbits(I2C_MPC824X_SR_MIF, 0);
	/* If we've completed a byte transfer				*/
	if(i2c_mpc824x_getbits(I2C_MPC824X_SR_MCF)) {
		/* If we're in master mode				*/
		if(i2c_mpc824x_getbits(I2C_MPC824X_CR_MSTA)) {
			/* If transmit mode				*/
			if(i2c_mpc824x_getbits(I2C_MPC824X_CR_MTX)) {
				/* If receive address mode		*/
				if(adap->is_rcv_addr) {
					/* Switch to receiving		*/
					i2c_mpc824x_setbits(
						I2C_MPC824X_CR_MTX, 0);
					/* If only getting 1 byte, and
					 * want to stop after: set ak	*/
					if((adap->buflen = 1) &&
						(adap->stop_when_done)) {
						i2c_mpc824x_setbits(
							I2C_MPC824X_CR_TXAK, 1);
					}
					/* Do fake read first		*/
					i2c_mpc824x_getbits(
						I2C_MPC824X_DR_DATA);
					adap->is_rcv_addr = 0;
					/* Return (in address state)	*/
					return ADDRESS_SENT;
				}
				/* Master xmit : has slave acknowledged */
				if(i2c_mpc824x_getbits(
					I2C_MPC824X_SR_RXAK) = 0) {
					/* If so, send next byte	*/
					return i2c_xmit_next_byte(adap);
				}
				/* Else, no ACK : do stop if needed	*/
				if(adap->stop_when_done) {
					i2c_stop();
				}
				return SUCCESS;
			}
			else {	/* Else, we're receiving		*/
				return i2c_recv_next_byte(adap);
			}
		}
		else {	/* Else, slave mode				*/
			/* We don't do this....shouldn't happen		*/
			DEB(1, "i2c-algo-mpc824x: slave mode - not supported!!!\n");
			return ERROR;
		}
	}
	/* Else if received call from master - not supported		*/
	else if(i2c_mpc824x_getbits(I2C_MPC824X_SR_MAAS)) {
		DEB(1, "i2c-algo-mpc824x: received call from master - "
			"slave mode not supported!!!\n");
		return ERROR;
	}
	/* Else, has to be arbitration lost				*/
	else {
		/* Clear MAL flag					*/
		i2c_mpc824x_setbits(I2C_MPC824X_SR_MAL, 0);
		/* Return to receive mode				*/
		i2c_stop();
	}
	return SUCCESS;
}

/* I2C timer function : used if periodic polling is used instead if ints*/
static i2c_mpc824x_status i2c_timer_event(struct
	i2c_algo_mpc824x_data *adap)
{
	/* If interrupt flag set, call ISR				*/
	if(i2c_mpc824x_getbits(I2C_MPC824X_SR_MIF)) {
		//printk("MIF\n");
		return i2c_isr(adap);
	}
	else {	/* Else, no event					*/
		//printk("NO_EVENT\n");
		return NO_EVENT;
	}
}

/* Function to initialize a xmit/recv operation				*/
static i2c_mpc824x_status i2c_init_xmit_recv(struct
	i2c_algo_mpc824x_data *adap, int address, u8 *buffer,
	int buflen, int stop_when_done, int is_restart, int is_xmit)
{
	if((is_xmit = 0) && ((buffer = NULL) || (buflen = 0))) {
		DEB(1, "i2c-algo-mpc824x: zero length recv unsupported!\n");
		return ERROR;
	}
	/* Initialize all state variables for transfer			*/
	adap->buffer = buffer;
	adap->buflen = buflen;
	adap->bufindex = 0;
	adap->slaveaddr = address;
	adap->is_xmit = is_xmit;
	adap->stop_when_done = stop_when_done;
	adap->is_restart = is_restart;
	adap->is_rcv_addr = 0;
	/* Now, start the transfer					*/
	return i2c_start(adap);
}

/* Function to do polling mode processing of one buffer			*/
static i2c_mpc824x_status i2c_do_buffer(struct i2c_algo_mpc824x_data *
	adap, int do_xmit, int address, u8 *buffer, int buflen,
	int stop_when_done, int do_restart)
{
	i2c_mpc824x_status rc;
	u8 minbuf[1];
	/* Initialize the transfer itself				*/
	if((do_xmit = 0) && (buflen = 0)) {
		buffer = minbuf;
		buflen = 1;
	}
	rc = i2c_init_xmit_recv(adap, address, buffer, buflen,
		stop_when_done, do_restart, do_xmit);
	/* If not started successfully, we're done			*/
	if(rc != SUCCESS) {
		DEB(1, "i2c-algo-mpc824x: start failed: i2ccr=0x%.4x, "
			"i2csr=0%.4x\n", i2c_mpc824x_getbits(
			I2C_MPC824X_CR), i2c_mpc824x_getbits(
			I2C_MPC824X_SR));
		i2c_stop();
		return ERROR;
	}
	/* Now, wait for it to get done					*/
	while((rc = SUCCESS) || (rc = ADDRESS_SENT)) {
		unsigned long wait_time = jiffies + 2*HZ;
		unsigned long wait_cnt = 0;

		/* Poll the device until something happens		*/
		do {
			rc = i2c_timer_event(adap);
			wait_cnt++;
		} while ((rc = NO_EVENT) && (jiffies < wait_time) &&
			(wait_cnt < 1000000));
		/* If error, quit					*/
		if(rc < SUCCESS) {
			DEB(1, "i2c-algo-mpc824x: do_buffer failed(%d) - "
				"i2ccr=0x%.4x, i2csr=0x%.4x\n", rc,
				i2c_mpc824x_getbits(
				I2C_MPC824X_CR), i2c_mpc824x_getbits(
				I2C_MPC824X_SR));
			return ERROR;
		}
	}
	return SUCCESS;
}

/* IRQ function : used for timer and for hw irq				*/
static void i2c_mpc824x_irq_func(unsigned long data)
{
	int rc = 0;
	int cur_cmd_done = 0;
	int cur_req_done = 0;
	unsigned long flags;
	struct i2c_msg *pmsg;
	static u8 minbuf[1];
	int len;
	u8 *buf;
	struct i2c_mpc824x_xfer_req *req;

	req = req_head;
	/* If active request, process it			*/
	if(req) {
		/* If buffer is in progress			*/
		if(req->cur_buf_num >= 0) {
			/* Process tick to advance it		*/
			rc = i2c_timer_event(
				req->i2c_adap->algo_data);
			/* If nothing happened, consider timeout*/
			if(rc = NO_EVENT) {
				/* If we're out of time		*/
				if(jiffies >
					req->cur_wait_time) {
					rc = -EREMOTEIO;
					cur_req_done = 1;
				}
			}
			/* If error, we're done			*/
			else if(rc < SUCCESS) {
				rc = -EREMOTEIO;
				cur_req_done = 1;
			}
			/* Else, reset wait timer		*/
			else if((rc = SUCCESS) || (rc = ADDRESS_SENT)) {
				req->cur_wait_time 					jiffies + 2*HZ;
			}
			/* Else, we're done!			*/
			else {
				rc = 0;
				cur_cmd_done = 1;
			}
		}
		else {	/* If not running yet, we need to start */
			cur_cmd_done = 1;
		}
		/* If we finished one (or need to start)	*/
		if(cur_cmd_done) {
			req->cur_buf_num++;
			/* See if there are more buffers	*/
			if(req->cur_buf_num >= req->num) {
				/* If not, we're done		*/
				cur_req_done = 1;
				/* Set return code		*/
				rc = req->num;
			}
			/* Else, start next one			*/
			else {
				pmsg = &(req->msgs[
					req->cur_buf_num]);

				if(pmsg->flags & I2C_M_RD)
					req->cur_do_xmit = 0;
				else
					req->cur_do_xmit = 1;
				len = pmsg->len;
				buf = pmsg->buf;
				/* Make sure its minimum read   */
				if((req->cur_do_xmit = 0) &&
					(len = 0)) {
					buf = minbuf;
					len = 1;
				}
				/* Start the new request	*/
				rc = i2c_init_xmit_recv(
					req->i2c_adap->algo_data,
					pmsg->addr, buf, len,
					(req->cur_buf_num =
					 (req->num - 1)),
					req->cur_buf_num > 0,
					req->cur_do_xmit);
				if(rc != SUCCESS) {
					rc = -EREMOTEIO;
					cur_req_done = 1;
					DEB(2,
						"i2c-algo-mpc824x: xfer init failed\n");
				}
			}
		}
		/* If the request is complete			*/
		if(cur_req_done) {
			/* If not, request is complete		*/
			if(req->callback) {
				/* Do callback			*/
				req->callback(req->i2c_adap,
					req->msgs, req->num,
					rc, req->usr_data);
			}
			/* Dequueue from list		        */
			spin_lock_irqsave(&lock, flags);
			req_head = req->next;
			if(req_head = NULL) req_tail = NULL;
			spin_unlock_irqrestore(&lock, flags);
			/* Free the record			*/
			kfree(req);
		}
	}
}

/* Timer function : called every tick when active	 	    */
static void i2c_mpc824x_timer_func(unsigned long data)
{
	unsigned long flags;

	spin_lock_irqsave(&lock, flags);
	timer_added = 0;
	spin_unlock_irqrestore(&lock, flags);

	//printk("timer\n");

	i2c_mpc824x_irq_func(data);

	spin_lock_irqsave(&lock, flags);
	/* Requeue the timer function IF a request is active    */
	if(req_head && (!timer_added)) {
		our_timer.expires = jiffies + TIMER_PERIOD;
		our_timer.function = i2c_mpc824x_timer_func;
		add_timer(&our_timer);
		timer_added = 1;
	}
	spin_unlock_irqrestore(&lock, flags);
}

static void i2c_mpc824x_interrupt_func(int this_irq, void *dev_id,
	struct pt_regs *regs)
{
	if(i2c_mpc824x_getbits(I2C_MPC824X_SR_MIF)) {
		//printk("irq:MIF\n");
		i2c_mpc824x_irq_func(NULL);
		i2c_mpc824x_setbits(I2C_MPC824X_SR_MIF, 0);
	}
	else {
		//printk("irq:!MIF\n");
	}
}

/* Submit a non-blocking request to issue I2C commands			*/
int i2c_mpc824x_xfer_async(struct i2c_adapter *i2c_adap,
	struct i2c_msg *msgs, int num, void (*callback)
	(struct i2c_adapter *, struct i2c_msg *, int num, int rc,
	void *usr_data), void *usr_data)
{
	unsigned long flags;
	struct i2c_mpc824x_xfer_req *req;
	int did_first_add = 0;

	/* Allocate request block					*/
	req = kmalloc(sizeof(*req), GFP_ATOMIC);
	if(!req) {
		DEB(1, "i2c_algo_mpc824x: kmalloc failed!\n");
		return -ENOMEM;
	}
	req->i2c_adap = i2c_adap;
	req->msgs = &msgs[0];
	req->num = num;
	req->usr_data = usr_data;
	req->callback = callback;
	req->cur_buf_num = -1;
	req->cur_do_xmit = 0;
	req->next = NULL;
	req->cur_wait_time = 0;
	/* Add to list							*/
	spin_lock_irqsave(&lock, flags);
	if(req_tail = NULL) {	/* Empty list				*/
		req_tail = req_head = req;
		did_first_add = 1;
	}
	else {
		req_tail->next = req;
		req_tail = req;
	}
	/* If first on list, start timer back up			*/
	if(did_first_add && (!timer_added)) {
		our_timer.expires = jiffies;
		our_timer.function = i2c_mpc824x_timer_func;
		timer_added = 1;
		add_timer(&our_timer);
	}
	spin_unlock_irqrestore(&lock, flags);

	return 0;
}

/* Find the I2C registers					*/
static __init u32 *find_mpc824x_i2c(void)
{
	struct pci_dev *s_bridge;
	u32 eumb_base;

	if (!pci_present())
		return NULL;

	s_bridge = pci_find_device(PCI_VENDOR_ID_MOTOROLA,
		PCI_DEVICE_ID_BRIDGE_MPC8240, NULL);

	if (!s_bridge) {
		s_bridge = pci_find_device(PCI_VENDOR_ID_MOTOROLA,
			PCI_DEVICE_ID_BRIDGE_MPC8245, NULL);
		if(!s_bridge) {
			DEB(1, "i2c-algo-mpc824x.o: mpc824x not found\n");
			return NULL;
		}
	}
	/* Read EUMB base address				    */
	if(pci_read_config_dword(s_bridge, PCI_CONFIG_EUMB_BASE_ADDR,
		&eumb_base) != PCIBIOS_SUCCESSFUL) {
		return NULL;
	}

	return (u32 *)(eumb_base + I2C_REGISTER_BASE_OFFSET);
}

static int i2c_mpc824x_xfer_sync(struct i2c_adapter *i2c_adap,
	struct i2c_msg *msgs, int num)
{
	struct i2c_msg *pmsg;
	struct i2c_algo_mpc824x_data *adap = i2c_adap->algo_data;
	int i;

	for (i=0;i<num;i++) {
		pmsg = &msgs[i];	/* Get pointer to message	*/
		/* If message is not requesting a no-start		*/
		if (!(pmsg->flags & I2C_M_NOSTART)) {
			i2c_mpc824x_status rc;
			int do_xmit = 1;

			if(pmsg->flags & I2C_M_RD)
				do_xmit = 0;

			rc = i2c_do_buffer(adap, do_xmit,
				pmsg->addr, pmsg->buf ,pmsg->len,
				(i = (num-1)),
				(i > 0));
			if (rc < SUCCESS) {
				DEB(1, "i2c-algo-mpc824x.o:"
					"error(%d) from device adr %#2x "
					"msg #%d\n", rc, msgs[i].addr,
					i);
				return -EREMOTEIO;
			}
		}
	}
	return num;
}

#ifdef USE_ASYNC_FOR_XFER
struct i2c_wait_rslt {
	wait_queue_head_t update_wait_q;
	int rc;
};

static void i2c_mpc824x_xfer_callback(struct i2c_adapter *adap,
	struct i2c_msg *msgs, int num, int rc, void *usr_data)
{
	struct i2c_wait_rslt *rslt = (struct i2c_wait_rslt *)usr_data;
	rslt->rc = rc;
	wake_up_interruptible(&(rslt->update_wait_q));
}
#endif


static int i2c_mpc824x_xfer(struct i2c_adapter *i2c_adap,
	struct i2c_msg msgs[], int num)
{
	int rc;
#ifdef USE_ASYNC_FOR_XFER
	struct i2c_wait_rslt rslt;

	init_waitqueue_head(&(rslt.update_wait_q));
	rslt.rc = -EREMOTEIO;
	rc = i2c_mpc824x_xfer_async(i2c_adap, msgs, num,
		i2c_mpc824x_xfer_callback, &rslt);
	if(rc = 0) {
		interruptible_sleep_on(&(rslt.update_wait_q));
		rc = rslt.rc;
	}
#else
	rc = i2c_mpc824x_xfer_sync(i2c_adap, &msgs[0], num);
#endif
	//printk("i2c_mpc824x_xfer() - rc=%d\n", rc);
	return rc;
}

static int algo_control(struct i2c_adapter *adapter,
	unsigned int cmd, unsigned long arg)
{
	return 0;
}

static u32 i2c_mpc824x_func(struct i2c_adapter *adap)
{
	return I2C_FUNC_SMBUS_EMUL |
	       I2C_FUNC_PROTOCOL_MANGLING;
}

#ifdef CONFIG_RAPTOR
/* Special entry point used for I2C commands issued for system hard reset
 * from raptor_setup.c - needs to be interrupt time callable		*/
void i2c_mpc824x_do_cmds(void *eumb_addr, struct i2c_msg msgs[],
	int num)
{
	struct i2c_algo_mpc824x_data algo;
	struct i2c_adapter adap;
	unsigned long flags;
	int was_up = 0;

	/* Make bogus adapter structure ... enough to work with calls	*/
	memset(&adap, 0, sizeof(adap));
	adap.algo_data = &algo;
	memset(&algo, 0, sizeof(algo));

	eumb_base = (u32 *)((unsigned long)eumb_addr +
		I2C_REGISTER_BASE_OFFSET);

	if(!did_init)	/* If not initialized, init the lock		*/
		lock = (spinlock_t)SPIN_LOCK_UNLOCKED;

	/* Disable interrupts if we're initialized			*/
	spin_lock_irqsave(&lock, flags);

	/* Now do a stop (if we were already active)			*/
	if(i2c_mpc824x_getbits(I2C_MPC824X_CR_MEN)) {
		i2c_stop();
		i2c_term();
		was_up = 1;
	}
	/* Reinitialize if needed					*/
	i2c_init();
	/* Now send the messages					*/
	i2c_mpc824x_xfer_sync(&adap, msgs, num);
	/* Now terminate if we weren't active before			*/
	if(was_up = 0) {
		i2c_term();
	}
	/* Drop lock							*/
	spin_unlock_irqrestore(&lock, flags);
}

/* Special entry point used for I2C commands issued for modules		*/
void i2c_mpc824x_do_cmds_async(struct i2c_msg *msgs,
	int num, void (*callback)(struct i2c_adapter *, struct i2c_msg *, 
	int num, int rc, void *usr_data), void *usr_data)
{
	if(mpc_adap) {
		i2c_mpc824x_xfer_async(mpc_adap, msgs, num,
			callback, usr_data);
	}
	else {
		callback(NULL, msgs, num, -1, usr_data);
	}
}

#endif
/* -----exported algorithm data: -------------------------------------	*/

static struct i2c_algorithm i2c_bit_algo = {
	"Motorola mpc824x algorithm",
	I2C_ALGO_MPC824X,
	i2c_mpc824x_xfer,
	NULL,
	NULL,				/* slave_xmit		*/
	NULL,				/* slave_recv		*/
	algo_control,			/* ioctl		*/
	i2c_mpc824x_func,		/* functionality	*/
};

/*
 * registering functions to load algorithms at runtime
 */
int i2c_mpc824x_add_bus(struct i2c_adapter *i2c_adap)
{
	DEB(2, "i2c-algo-mpc824x.o: hw routines for %s registered.\n",
	            i2c_adap->name);

	/* Initialize the hardware				*/
	i2c_init();

	/* register new adapter to i2c module... */
	i2c_adap->id |= i2c_bit_algo.id;
	i2c_adap->algo = &i2c_bit_algo;

	i2c_adap->timeout = 100;/* default values, should	*/
	i2c_adap->retries = 3;	/* be replaced by defines	*/

#ifdef MODULE
	MOD_INC_USE_COUNT;
#endif
	i2c_add_adapter(i2c_adap);

	mpc_adap = i2c_adap;

	return 0;
}

int i2c_mpc824x_del_bus(struct i2c_adapter *adap)
{
	int res;

	if ((res = i2c_del_adapter(adap)) < 0) {
		return res;
	}

	DEB(2, "i2c-algo-mpc824x.o: adapter unregistered: %s\n",adap->name);

	i2c_term();		/* Shutdown hardware		 */

	mpc_adap = NULL;
 
#ifdef MODULE
	MOD_DEC_USE_COUNT;
#endif
	return 0;
}

int __init i2c_algo_mpc824x_init (void)
{
	DEB(1, "i2c-algo-mpc824x.o: i2c mpc824x algorithm module version %s\n", DRV_VERSION);

	did_init = 1;

	lock = (spinlock_t)SPIN_LOCK_UNLOCKED;

	eumb_base = find_mpc824x_i2c();
	if(eumb_base = NULL) {
		DEB(1, "i2c-algo-mpc824x.o: no mpc824x found!\n");
		return -ENODEV;
	}
#ifdef USE_HW_INT_FOR_XFER
	if (request_irq(HW_INT, i2c_mpc824x_interrupt_func, 0, "i2c mpc824x", NULL) < 0) {
		DEB(1, "i2c-algo-mpc824x.o: error registering irq\n");
		return -ENODEV;
	}
#endif
	return 0;
}

EXPORT_SYMBOL(i2c_mpc824x_add_bus);
EXPORT_SYMBOL(i2c_mpc824x_del_bus);
#ifdef CONFIG_RAPTOR
EXPORT_SYMBOL(i2c_mpc824x_do_cmds);
EXPORT_SYMBOL(i2c_mpc824x_do_cmds_async);
#endif

#ifdef MODULE

MODULE_AUTHOR("Michael Primm <primm@netbotz.com>");
MODULE_DESCRIPTION("I2C-Bus mpc824x algorithm");
#ifdef MODULE_LICENSE
MODULE_LICENSE("GPL");
#endif

MODULE_PARM(debug_level,"i");
MODULE_PARM_DESC(debug_level,
            "debug level - 0 off; 1 normal; 2,3 more verbose");

int init_module(void)
{
	return i2c_algo_mpc824x_init();
}

void cleanup_module(void)
{
#ifdef USE_HW_INT_FOR_XFER
	free_irq(HW_INT, NULL);
#endif
}
#endif
-------------- next part --------------
/*
    i2c-mpc824x.c - Adapter driver for I2C support on Motorola MPC824x

    Copyright (c) 2002 NetBotz Inc <primm@netbotz.com>

    Derived from i2c-via.c

    Copyright (c) 1998, 1999 Kysti M???kki <kmalkki@cc.hut.fi>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/ioport.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <asm/io.h>
#include <linux/types.h>
#include <linux/i2c.h>
#include <linux/i2c-algo-mpc824x.h>
#include <linux/init.h>

#define DRV_VERSION	"0.1"

#ifdef MODULE_LICENSE
MODULE_LICENSE("GPL");
#endif

/* ----- local functions ----------------------------------------------	*/
static void i2c_mpc824x_inc(struct i2c_adapter *adapter)
{
	MOD_INC_USE_COUNT;
}

static void i2c_mpc824x_dec(struct i2c_adapter *adapter)
{
	MOD_DEC_USE_COUNT;
}

/* ------------------------------------------------------------------------ */

static struct i2c_algo_mpc824x_data i2c_mpc824x_data = { 0 };

static struct i2c_adapter i2c_mpc824x_ops = {
	"Motorola mpc824X i2c",
	I2C_HW_MPC824X,
	NULL,
	&i2c_mpc824x_data,
	i2c_mpc824x_inc,
	i2c_mpc824x_dec,
	NULL,
	NULL,
};

#ifdef MODULE
static
#else
extern
#endif
int __init i2c_mpc824x_init(void)
{
	printk("i2c-mpc824x.o version %s\n", DRV_VERSION);
	if (i2c_mpc824x_add_bus(&i2c_mpc824x_ops) = 0) {
		printk("i2c-mpc824x.o: Module succesfully loaded\n");
		return 0;
	} else {
		printk("i2c-mpc824x.o: Algo-mpc824x error, couldn't register bus\n");
		return -ENODEV;
	}
}

EXPORT_NO_SYMBOLS;

#ifdef MODULE
MODULE_AUTHOR("Michael Primm <primm@netbotz.com>");
MODULE_DESCRIPTION("i2c for Motorola mpc824x");

int init_module(void)
{
	return i2c_mpc824x_init();
}

void cleanup_module(void)
{
	i2c_mpc824x_del_bus(&i2c_mpc824x_ops);
}
#endif
-------------- next part --------------
/* ------------------------------------------------------------------------- */
/* i2c-algo-mpc824x.h i2c driver algorithms for Motorola mpc824x processors  */
/* ------------------------------------------------------------------------- */
/*   Copyright (C) 2002 NetBotz Inc <primm@netbotz.com>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.                */
/* ------------------------------------------------------------------------- */

/* $Id: i2c-algo-mpc824x.h,v 1.5 2003/02/10 06:08:11 primm Exp $ */

#ifndef I2C_ALGO_MPC824X_H
#define I2C_ALGO_MPC824X_H 1

#include <linux/i2c.h>

/* --- Defines for mpc824x-adapters ----------------------------------	*/

/* Structures for I2C registers					        */

/* I2C Address Register							*/
union i2c_mpc824x_i2cadr {
	struct {
		u32	reserved : 24;
		/* Slave address					*/
		u32	addr : 7;
		u32	reserved2 : 1;
	} bits;
	u32	reg;
};

/* I2C Frequency Divider Register					*/
union i2c_mpc824x_i2cfdr {
	struct {
		u32	reserved : 18;
		/* Digital filter frequency sampling rate		*/
		u32	dffsr : 6;
		u32	reserved2 : 2;
		/* Frequency divider ratio				*/
		u32	fdr : 6;
	} bits;
	u32	reg;
};

/* I2C Control Register							*/
union i2c_mpc824x_i2ccr {
	struct {
		u32	reserved : 24;
		/* Module enable					*/
		u32	men : 1;
		/* Module interrupt enable				*/
		u32	mien : 1;
		/* Master/slave mode START				*/
		u32	msta : 1;
		/* Transmit/receive mode select				*/
		u32	mtx : 1;
		/* Transfer acknowledge					*/
		u32	txak : 1;
		/* Repeat START						*/
		u32	rsta : 1;
		/* PCI interrupt enable					*/
		u32	pcii : 1;
		/* Broadcast enable					*/
		u32	bcst : 1;
	} bits;
	u32 reg;
};
	
/* I2C Status Register							*/
union i2c_mpc824x_i2csr {
	struct {
		u32	reserved : 24;
		/* Data transferring					*/
		u32	mcf : 1;
		/* Addressed as a slave					*/
		u32	maas : 1;
		/* Bus busy						*/
		u32	mbb : 1;
		/* Arbitration lost					*/
		u32	mal : 1;
		/* Broadcast address detection				*/
		u32	bca : 1;
		/* Slave read/write					*/
		u32	srw : 1;
		/* Module interrupt					*/
		u32	mif : 1;
		/* Received acknowledge					*/
		u32	rxak : 1;
	} bits;
	u32	reg;
};

/* I2C Data Register							*/
union i2c_mpc824x_i2cdr {
	struct {
		u32	reserved : 24;
		/* Data register					*/
		u32	data : 8;
	} bits;
	u32	reg;
};

/*
 * This struct contains the hardware specific information for the port.
 */
struct i2c_algo_mpc824x_data {
	/* State of current transfer					*/
	int	is_xmit;	/* 1 = XMIT, 0 = RECV			*/
	u8 *	buffer;		/* xmit/recv buffer for data		*/
	int	buflen;		/* Length of buffer recv/xmit		*/
	int	bufindex;	/* Current index into buffer		*/
	u8	slaveaddr;	/* Current slave address		*/
	u8	stop_when_done;	/* 1=do STOP when completed		*/
	u8	is_restart;	/* Are we doing a repeat start		*/
	u8	is_rcv_addr;	/* Is receive address phase		*/
};

#define I2C_BIT_ADAP_MAX	16

int i2c_mpc824x_add_bus(struct i2c_adapter *);
int i2c_mpc824x_del_bus(struct i2c_adapter *);

#ifdef CONFIG_RAPTOR
void i2c_mpc824x_do_cmds(void *eumb_addr, struct i2c_msg msgs[],
	int num);
/* Special entry point used for I2C commands issued for modules		*/
void i2c_mpc824x_do_cmds_async(struct i2c_msg *msgs,
	int num, void (*callback)(struct i2c_adapter *, struct i2c_msg *, 
	int num, int rc, void *usr_data), void *usr_data);
#endif

#endif /* I2C_ALGO_MPC824X_H */
-------------- next part --------------
/* ------------------------------------------------------------------------- */
/* 									     */
/* i2c.h - definitions for the i2c-bus interface			     */
/* 									     */
/* ------------------------------------------------------------------------- */
/*   Copyright (C) 1995-1999 Simon G. Vogl

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
/* ------------------------------------------------------------------------- */

/* $Id: i2c-id.h,v 1.3 2003/02/21 23:35:04 primm Exp $ */

#ifndef I2C_ID_H
#define I2C_ID_H
/*
 * This file is part of the i2c-bus package and contains the identifier
 * values for drivers, adapters and other folk populating these serial
 * worlds. 
 *
 * These will change often (i.e. additions) , therefore this has been 
 * separated from the functional interface definitions of the i2c api.
 *
 */

/*
 * ---- Driver types -----------------------------------------------------
 *       device id name + number        function description, i2c address(es)
 *
 *  Range 1000-1999 range is defined in sensors/sensors.h 
 *  Range 0x100 - 0x1ff is for V4L2 Common Components 
 *  Range 0xf000 - 0xffff is reserved for local experimentation, and should
 *        never be used in official drivers 
 */

#define I2C_DRIVERID_MSP3400	 1
#define I2C_DRIVERID_TUNER	 2
#define I2C_DRIVERID_VIDEOTEX	 3	/* please rename		*/
#define I2C_DRIVERID_TDA8425	 4	/* stereo sound processor	*/
#define I2C_DRIVERID_TEA6420	 5	/* audio matrix switch		*/
#define I2C_DRIVERID_TEA6415C	 6	/* video matrix switch		*/
#define I2C_DRIVERID_TDA9840	 7	/* stereo sound processor	*/
#define I2C_DRIVERID_SAA7111A	 8	/* video input processor	*/
#define I2C_DRIVERID_SAA5281	 9	/* videotext decoder		*/
#define I2C_DRIVERID_SAA7112	10	/* video decoder, image scaler	*/
#define I2C_DRIVERID_SAA7120	11	/* video encoder		*/
#define I2C_DRIVERID_SAA7121	12	/* video encoder		*/
#define I2C_DRIVERID_SAA7185B	13	/* video encoder		*/
#define I2C_DRIVERID_CH7003	14	/* digital pc to tv encoder 	*/
#define I2C_DRIVERID_PCF8574A	15	/* i2c expander - 8 bit in/out	*/
#define I2C_DRIVERID_PCF8582C	16	/* eeprom			*/
#define I2C_DRIVERID_AT24Cxx	17	/* eeprom 1/2/4/8/16 K 		*/
#define I2C_DRIVERID_TEA6300	18	/* audio mixer			*/
#define I2C_DRIVERID_BT829	19	/* pc to tv encoder		*/
#define I2C_DRIVERID_TDA9850	20	/* audio mixer			*/
#define I2C_DRIVERID_TDA9855	21	/* audio mixer			*/
#define I2C_DRIVERID_SAA7110	22	/* video decoder		*/
#define I2C_DRIVERID_MGATVO	23	/* Matrox TVOut			*/
#define I2C_DRIVERID_SAA5249	24	/* SAA5249 and compatibles	*/
#define I2C_DRIVERID_PCF8583	25	/* real time clock		*/
#define I2C_DRIVERID_SAB3036	26	/* SAB3036 tuner		*/
#define I2C_DRIVERID_TDA7432	27	/* Stereo sound processor	*/
#define I2C_DRIVERID_TVMIXER    28      /* Mixer driver for tv cards    */
#define I2C_DRIVERID_TVAUDIO    29      /* Generic TV sound driver      */
#define I2C_DRIVERID_DPL3518    30      /* Dolby decoder chip           */
#define I2C_DRIVERID_TDA9873    31      /* TV sound decoder chip        */
#define I2C_DRIVERID_TDA9875    32      /* TV sound decoder chip        */
#define I2C_DRIVERID_PIC16C54_PV9 33    /* Audio mux/ir receiver        */

#define I2C_DRIVERID_SBATT      34     /* Smart Battery Device		*/
#define I2C_DRIVERID_SBS        35     /* SB System Manager		*/
#define I2C_DRIVERID_VES1893	36     /* VLSI DVB-S decoder		*/
#define I2C_DRIVERID_VES1820	37     /* VLSI DVB-C decoder		*/
#define I2C_DRIVERID_SAA7113	38     /* video decoder			*/
#define I2C_DRIVERID_TDA8444	39     /* octuple 6-bit DAC             */
#define I2C_DRIVERID_BT819	40     /* video decoder			*/
#define I2C_DRIVERID_BT856	41     /* video encoder			*/
#define I2C_DRIVERID_VPX32XX	42     /* video decoder+vbi/vtxt	*/
#define I2C_DRIVERID_DRP3510	43     /* ADR decoder (Astra Radio)	*/
#define I2C_DRIVERID_SP5055	44     /* Satellite tuner		*/
#define I2C_DRIVERID_STV0030	45     /* Multipurpose switch		*/

#define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/
#define I2C_DRIVERID_EXP1	0xF1
#define I2C_DRIVERID_EXP2	0xF2
#define I2C_DRIVERID_EXP3	0xF3

#define I2C_DRIVERID_I2CDEV	900
#define I2C_DRIVERID_I2CPROC	901

/* IDs --   Use DRIVERIDs 1000-1999 for sensors. 
   These were originally in sensors.h in the lm_sensors package */
#define I2C_DRIVERID_LM78 1002
#define I2C_DRIVERID_LM75 1003
#define I2C_DRIVERID_GL518 1004
#define I2C_DRIVERID_EEPROM 1005
#define I2C_DRIVERID_W83781D 1006
#define I2C_DRIVERID_LM80 1007
#define I2C_DRIVERID_ADM1021 1008
#define I2C_DRIVERID_ADM9240 1009
#define I2C_DRIVERID_LTC1710 1010
#define I2C_DRIVERID_SIS5595 1011
#define I2C_DRIVERID_ICSPLL 1012
#define I2C_DRIVERID_BT869 1013
#define I2C_DRIVERID_MAXILIFE 1014
#define I2C_DRIVERID_MATORB 1015
#define I2C_DRIVERID_GL520 1016
#define I2C_DRIVERID_THMC50 1017
#define I2C_DRIVERID_DDCMON 1018
#define I2C_DRIVERID_VIA686A 1019
#define I2C_DRIVERID_ADM1025 1020
#define I2C_DRIVERID_LM87 1021
#define I2C_DRIVERID_PCF8574 1022
#define I2C_DRIVERID_MTP008 1023
#define I2C_DRIVERID_DS1621 1024
#define I2C_DRIVERID_ADM1024 1025
#define I2C_DRIVERID_IT87 1026
#define I2C_DRIVERID_CH700X 1027 /* single driver for CH7003-7009 digital pc to tv encoders */

/*
 * ---- Adapter types ----------------------------------------------------
 *
 * First, we distinguish between several algorithms to access the hardware
 * interface types, as a PCF 8584 needs other care than a bit adapter.
 */

#define I2C_ALGO_NONE	0x000000
#define I2C_ALGO_BIT	0x010000	/* bit style adapters		*/
#define I2C_ALGO_PCF	0x020000	/* PCF 8584 style adapters	*/
#define I2C_ALGO_ATI	0x030000	/* ATI video card		*/
#define I2C_ALGO_SMBUS	0x040000
#define I2C_ALGO_ISA 	0x050000	/* lm_sensors ISA pseudo-adapter */
#define I2C_ALGO_SAA7146 0x060000	/* SAA 7146 video decoder bus	*/
#define I2C_ALGO_ACB 	0x070000	/* ACCESS.bus algorithm         */
#define I2C_ALGO_MPC824X 0x0a0000       /* Motorola MPC824x             */
#define I2C_ALGO_EC     0x100000        /* ACPI embedded controller     */

#define I2C_ALGO_MPC8XX 0x110000	/* MPC8xx PowerPC I2C algorithm */
#define I2C_HW_MPC824X  0x00            /* Motorola 8240/8245           */
#define I2C_ALGO_EXP	0x800000	/* experimental			*/

#define I2C_ALGO_MASK	0xff0000	/* Mask for algorithms		*/
#define I2C_ALGO_SHIFT	0x10	/* right shift to get index values 	*/

#define I2C_HW_ADAPS	0x10000		/* # adapter types		*/
#define I2C_HW_MASK	0xffff		


/* hw specific modules that are defined per algorithm layer
 */

/* --- Bit algorithm adapters 						*/
#define I2C_HW_B_LP	0x00	/* Parallel port Philips style adapter	*/
#define I2C_HW_B_LPC	0x01	/* Parallel port, over control reg.	*/
#define I2C_HW_B_SER	0x02	/* Serial line interface		*/
#define I2C_HW_B_ELV	0x03	/* ELV Card				*/
#define I2C_HW_B_VELLE	0x04	/* Vellemann K8000			*/
#define I2C_HW_B_BT848	0x05	/* BT848 video boards			*/
#define I2C_HW_B_WNV	0x06	/* Winnov Videums			*/
#define I2C_HW_B_VIA	0x07	/* Via vt82c586b			*/
#define I2C_HW_B_HYDRA	0x08	/* Apple Hydra Mac I/O			*/
#define I2C_HW_B_G400	0x09	/* Matrox G400				*/
#define I2C_HW_B_I810	0x0a	/* Intel I810 				*/
#define I2C_HW_B_VOO	0x0b	/* 3dfx Voodoo 3 / Banshee      	*/
#define I2C_HW_B_PPORT  0x0c	/* Primitive parallel port adapter	*/
#define I2C_HW_B_RIVA	0x10	/* Riva based graphics cards		*/
#define I2C_HW_B_IOC	0x11	/* IOC bit-wiggling			*/
#define I2C_HW_B_TSUNA  0x12	/* DEC Tsunami chipset			*/

/* --- PCF 8584 based algorithms					*/
#define I2C_HW_P_LP	0x00	/* Parallel port interface		*/
#define I2C_HW_P_ISA	0x01	/* generic ISA Bus inteface card	*/
#define I2C_HW_P_ELEK	0x02	/* Elektor ISA Bus inteface card	*/

/* --- ACPI Embedded controller algorithms                              */
#define I2C_HW_ACPI_EC          0x00

/* --- MPC8xx PowerPC adapters						*/
#define I2C_HW_MPC8XX_EPON 0x00	/* Eponymous MPC8xx I2C adapter 	*/

/* --- SMBus only adapters						*/
#define I2C_HW_SMBUS_PIIX4	0x00
#define I2C_HW_SMBUS_ALI15X3	0x01
#define I2C_HW_SMBUS_VIA2	0x02
#define I2C_HW_SMBUS_VOODOO3	0x03
#define I2C_HW_SMBUS_I801	0x04
#define I2C_HW_SMBUS_AMD756	0x05
#define I2C_HW_SMBUS_SIS5595	0x06
#define I2C_HW_SMBUS_ALI1535	0x07

/* --- ISA pseudo-adapter						*/
#define I2C_HW_ISA 0x00

#endif /* I2C_ID_H */
