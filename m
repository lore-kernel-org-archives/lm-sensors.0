From: rmk@arm.linux.org.uk (Russell King)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: [patch 1/9]Four new i2c drivers and __init/__exit cleanup toi2c
Message-Id: <20020917150649.A29890@flint.arm.linux.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D872F81.61BC7167@attbi.com>
In-Reply-To: <3D872F81.61BC7167@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 17, 2002 at 09:34:57AM -0400, Albert Cranford wrote:
> Jeff, here was the original code which saved flags and
> interrupted.  The goal was to remove the cli, so the new
> code that Ingo suggested is:local_irq_save(flags);
> Redesigning with semaphores is not possible.
> 
>         /* Chip bug, set enable here */
>         save_flags(flags); cli();
>         i2c->i2c_i2cmr = 0x13;  /* Enable some interupts */
>         i2c->i2c_i2cer = 0xff;
>         i2c->i2c_i2mod = 1;     /* Enable */
>         i2c->i2c_i2com = 0x81;  /* Start master */
> 
>         /* Wait for IIC transfer */
>         interruptible_sleep_on(&iic_wait);
>         restore_flags(flags);

Well, shrug.  In 2.5, tests _are_ being put into the scheduler at
this very moment by Linus to prevent sleeping with interrupts disabled,
so it will have to be fixed properly sooner or later.

You simply aren't allowed to sleep with interrupts disabled anymore.

A possible solution would be _something_ like:

	int ret = 0;

	interrupt_happened = 0;

	i2c->i2c_i2cmr = 0x13;
	i2c->i2c_i2cer = 0xff;
	i2c->i2c_i2mod = 1;
	i2c->i2c_i2com = 0x81;

	wait_event_interruptible(&iic_wait, interrupt_happened = 1, ret);

	if (ret) {
		/* I was interrupted while I was sleeping */
		/* clean up */
	}

and in your interrupt handler:

	interrupt_happened = 1;
	wake_up_interruptible(&iic_wait);

If you can guarantee that this function will only be called by thread at
any one time, you can get the exact same effect with:

	sema_init(&sem, 0);

	i2c->i2c_i2cmr = 0x13;
	i2c->i2c_i2cer = 0xff;
	i2c->i2c_i2mod = 1;
	i2c->i2c_i2com = 0x81;

	ret = down_interruptible(&sem);
	if (ret) {
		/* I was interrupted while I was sleeping */
		/* clean up */
	}

and in your interrupt handler:

	up(&sem);

Since you're frobbing with the hardware, you should be able to make
this guarantee.  If not, the driver is buggy, and would need the
following:

	ret = down_interruptible(&hw_access_sem);
	if (ret)
		return ret;

	sema_init(&sem, 0);

	i2c->i2c_i2cmr = 0x13;
	i2c->i2c_i2cer = 0xff;
	i2c->i2c_i2mod = 1;
	i2c->i2c_i2com = 0x81;

	ret = down_interruptible(&sem);

	up(&hw_access_sem);

	if (ret) {
		/* I was interrupted while I was sleeping */
		/* clean up */
	}

The patch you attach is fine as far as making things better than they
are at present.

> Jeff, the busy-wait works fine, but Russell commented that
> Athlon cpu's would destroy itself, so cpu_relax was added.
> I don't think its needed on this chip myself.

Note that I didn't analyse whether they were always in process context
or not.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
