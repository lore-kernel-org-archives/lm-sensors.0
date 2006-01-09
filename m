From: dhylands@gmail.com (Dave Hylands)
Date: Mon, 09 Jan 2006 07:14:50 +0000
Subject: [lm-sensors] Bug in i2c-pxa.c?
Message-Id: <c32efac40601082314i4f2db6c5j64dc2fd2c6270a7e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I believe that I've found a bug in i2c-pxa.c

Q1: Does anybody know where the PXA 250 i2c code is maintained?

There is a global variable called irq which never seems to be assigned
any value other than zero.

This routine:

static void i2c_pxa_wait_for_ite(void)
{
	unsigned long flags;
	if (irq > 0) {
	    spin_lock_irqsave(&i2c_pxa_irqlock, flags);
		if (i2c_pending = 0) {
			interruptible_sleep_on_timeout(&i2c_wait, I2C_SLEEP_TIMEOUT );
		}
		i2c_pending = 0;
		spin_unlock_irqrestore(&i2c_pxa_irqlock, flags);
	} else {
		udelay(100);
	}
}

will always call udelay(100). Since i2c_pxa_wait_for_ite is only
called 3 times, this means that it will only wait about 300 usec for a
response, whereas if irq were defined, it will wait for 6 jiffies (or
60 msec since HZ is 100 for me).

From looking at the code, I think that the correct fix is to modify:

static int i2c_pxa_resource_init(void)
{
	init_waitqueue_head(&i2c_wait);

	if (request_irq(IRQ_I2C, &i2c_pxa_handler, 0, "I2C", 0) < 0) {
		irq = 0;
		if (i2c_debug)
			printk(KERN_INFO "I2C: Failed to register I2C irq %i\n", IRQ_I2C);
		return -ENODEV;
	}
	return 0;
}

to assign irq to be I2C_IRQ just before the return 0;

--
Dave Hylands
Vancouver, BC, Canada
http://www.DaveHylands.com/

