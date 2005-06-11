From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 11 Jun 2005 17:21:28 +0000
Subject: [lm-sensors] Patch to check return values in i2c-algo-bit.c
Message-Id: <20050611172058.785a88b1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050611110823.GA21311@kestrel>
In-Reply-To: <20050611110823.GA21311@kestrel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Karel,

> When you use a parallel port adapter that supports SCL readback and have
> the kernel configured to use it and are using also some additional
> driver on top of it (PCFxxx or whatever) and the adapter is accidentally
> pulled out, you get a big (90 second) delay on system startup.
>
> This is because SCL readback times out, generates -ETIMEDOUT, but the
> caller functions don't check this and continue repeating operations
> again and again.
> 
> I have made a patch to fix this problem.

Although I agree on the problem, I think we can solve it with less
changes than you did. You are basically checking the return value of
sclhi(), direct or indirect, everywhere. However, i2c_repstart() and
i2c_stop() cannot be called before at least 8 bits have been transmitted
by either i2c_inb() or i2c_outb(), which themselves will be called by
try_address() before sendbytes() or readbytes() has a chance to call
them. So your problem can be solved by only the check in try_address()
(and making sure that callers of try_address() transmit the error up the
chain).

Also, please do not include isolated coding style fixes in your patch.
Such fixes are welcome but as a separate patch.

Lastly, the check in test_bus() doesn't seem to be needed. On timeout,
the next test will fail and exit anyway.

> However was unable to check it because don't have suitable hardware.

Unfortunately, my i2c-parport adapter has no SCL readback capabilities,
so my testing won't help much.

So the parts of your patch which I think are useful are:

> --- /usr/src/linux/drivers/i2c/algos/i2c-algo-bit.c	2005-06-10 20:06:26.000000000 +0200
> +++ i2c-algo-bit.c	2005-06-10 20:10:20.000000000 +0200
> (...)
> @@ -310,12 +328,20 @@
>  		       unsigned char addr, int retries)
>  {
>  	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
> -	int i,ret = -1;
> +	int i,ret = -1, retval;

You don't need to introduce retval, you could use ret instead.

>  	for (i=0;i<=retries;i++) {
>  		ret = i2c_outb(i2c_adap,addr);
>  		if (ret=1)
>  			break;	/* success! */
> -		i2c_stop(adap);
> +		if (ret < 0) return ret; /* Error */

This is the important one. Coding style suggests to put return on a
separate line though.

> @@ -430,22 +460,30 @@
>  		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
>  		/* try extended address code...*/
>  		ret = try_address(i2c_adap, addr, retries);
> +		if (ret < 0) return ret;
>  		if ((ret != 1) && !nak_ok)  {
>  			printk(KERN_ERR "died at extended address code.\n");
>  			return -EREMOTEIO;
>  		}
>  		/* the remaining 8 bit address */
>  		ret = i2c_outb(i2c_adap,msg->addr & 0x7f);
> +		if (ret < 0) return ret;
>  		if ((ret != 1) && !nak_ok) {
>  			/* the chip did not ack / xmission error occurred */
>  			printk(KERN_ERR "died at 2nd address code.\n");
>  			return -EREMOTEIO;
>  		}

These ones are fine too, although the coding style still isn't correct.
I also think you should add a printk stating that a timeout occured.
Failures without error messages are always a bit frustrating, and hard
to track down.

>  			/* okay, now switch into reading mode */
>  			addr |= 0x01;
>  			ret = try_address(i2c_adap, addr, retries);
> +			if (ret < 0) return ret;
>  			if ((ret!=1) && !nak_ok) {
>  				printk(KERN_ERR "died at extended address code.\n");
>  				return -EREMOTEIO;

Ditto.

> @@ -458,6 +496,7 @@
>  		if (flags & I2C_M_REV_DIR_ADDR )
>  			addr ^= 1;
>  		ret = try_address(i2c_adap, addr, retries);
> +		if (ret < 0) return ret;
>  		if ((ret!=1) && !nak_ok)
>  			return -EREMOTEIO;
>  	}

And same here too.

All the other changes are not necessary IMHO.

Thanks,
-- 
Jean Delvare
