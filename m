From: hgchew@gunnet.org (Chew Hong Gunn)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <20040129044934.GA14941@evilmoon.gunnet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Comments on the code itself:
Thanks for the comments on the code.
Do note that these comments are due to the original code that I was not
involved in.  I simply ported it over to 2.6 kernel accordingly.
Since the chip specification is not available anymore, I can only comment
based on what I think the code is doing and from doc/chips/gl518sm.

> > +static int gl518_update_thread(void *c)
> > +{
> > +	struct i2c_client *client = c;
> > +	struct gl518_data *data = i2c_get_clientdata(client);
> > +
> > +#ifdef __SMP__
> > +	lock_kernel();
> > +#endif
> 
> No.  Again, no #ifdefs are needed.  And what's with the lock_kernel()
> call?  What are you trying to protect here?
I have no experiment as to what is considered SMP unsafe.  I assume the
author wanted to create the thread safely.

> It looks like you only kick off this kernel thread if a user opens a
> specific sysfs file.  Why?  Why not just work like all other sensor
> drivers, and update the chip data when asked for it from the user?
> 
> I really do not see the need for this thread here.
This code is only relevant for the rev0 chip and only for iterate=2

There are 3 operation modes for the rev0 chip:
	iterate=0:	in[1-2] are not read
	iterate=1:	in[1-2] are read when sysfs is read
	iterate=2:	in[1-2] are read every 1.5s

The reason for iterate=1 and 2 is that the read operation requires about
10s to complete for this rev0 chip hardware, so iterate=2 is used if it
is preferable for sysfs not to block for 10s while the read is performed, 
and instead returns the value obtain in the previous iterative read.

> > +	exit_mm(current);
> > +	current->session = 1;
> > +	sigfillset(&current->blocked);
> > +	current->fs->umask = 0;
> > +	strcpy(current->comm, "gl518sm");
> > +
> > +	init_waitqueue_head(&(data->wq));
> > +	data->thread = current;
> > +
> > +#ifdef __SMP__
> > +	unlock_kernel();
> > +#endif
> 
> I think there's easier, and more proper ways to create a kernel thread
> in 2.6 now.  If you really want to do this (and you can convince me of
> it), please look into this (hint, search for daemonize()).
I will have a look into it and see if I change it.
More hints would be helpful.

> > +	for (j = 0; j < 10 && loop_more; j++) {
> > +		for (i = 0; i < 3; i++)
> > +			gl518_write_value(client, VIN_REG(i),
> > +					  max[i] << 8 | min[i]);
> > +
> > +		if ((data->thread) &&
> > +		    ((data->quit_thread) || signal_pending(current)))
> > +			goto finish;
> > +
> > +		/* we wait now 1.5 seconds before comparing */
> > +		current->state = TASK_INTERRUPTIBLE;
> > +		schedule_timeout(HZ + HZ / 2);
> > +
> > +		alarm = gl518_read_value(client, GL518_REG_INT);
> 
> So you sleep for 1.5 seconds 10 times?  Why?  That seems very slow...
Rev0 chip does not allow for direct reading of in[1-2].
Somehow, the author has found a comparison method of deriving those
values indirectly.  As I stated above, it will take ~10s to complete.


As for the threaded method of reading the values, it would be up to team
to decide whether to remove or keep it.  I will update the code accordingly.

Hong-Gunn
