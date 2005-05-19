From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <20040128224355.GB9519@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Comments on the code itself:

> +#ifdef __SMP__
> +#include <linux/smp_lock.h>
> +#endif

No, just include it, don't #ifdef it, that's not needed at all.

> +/* Defining this will enable debug messages for the voltage iteration
> +   code used with rev 0 ICs */
> +#undef DEBUG_VIN
> +#ifdef DEBUG
> +#define DEBUG_VIN
> +#endif

As you always tie DEBUG_VIN to DEBUG, why even have it at all?  Just get
rid of it, and everywhere it's defined.

> +static int gl518_update_thread(void *c)
> +{
> +	struct i2c_client *client = c;
> +	struct gl518_data *data = i2c_get_clientdata(client);
> +
> +#ifdef __SMP__
> +	lock_kernel();
> +#endif

No.  Again, no #ifdefs are needed.  And what's with the lock_kernel()
call?  What are you trying to protect here?

It looks like you only kick off this kernel thread if a user opens a
specific sysfs file.  Why?  Why not just work like all other sensor
drivers, and update the chip data when asked for it from the user?

I really do not see the need for this thread here.

> +	exit_mm(current);
> +	current->session = 1;
> +	sigfillset(&current->blocked);
> +	current->fs->umask = 0;
> +	strcpy(current->comm, "gl518sm");
> +
> +	init_waitqueue_head(&(data->wq));
> +	data->thread = current;
> +
> +#ifdef __SMP__
> +	unlock_kernel();
> +#endif

I think there's easier, and more proper ways to create a kernel thread
in 2.6 now.  If you really want to do this (and you can convince me of
it), please look into this (hint, search for daemonize()).


> +	for (j = 0; j < 10 && loop_more; j++) {
> +		for (i = 0; i < 3; i++)
> +			gl518_write_value(client, VIN_REG(i),
> +					  max[i] << 8 | min[i]);
> +
> +		if ((data->thread) &&
> +		    ((data->quit_thread) || signal_pending(current)))
> +			goto finish;
> +
> +		/* we wait now 1.5 seconds before comparing */
> +		current->state = TASK_INTERRUPTIBLE;
> +		schedule_timeout(HZ + HZ / 2);
> +
> +		alarm = gl518_read_value(client, GL518_REG_INT);

So you sleep for 1.5 seconds 10 times?  Why?  That seems very slow...


thanks,

greg k-h
