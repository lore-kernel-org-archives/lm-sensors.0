From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Jun 2012 15:52:37 +0000
Subject: Re: [lm-sensors] lm75_remove: LM75 Device remove using sysfs delete_device
Message-Id: <20120610175237.6356c729@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
	<20120610173640.3b21759c@endymion.delvare>
	<20120610154629.GD10367@ericsson.com>
In-Reply-To: <20120610154629.GD10367-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Sasikanth babu <sasikanth.v19-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Sun, 10 Jun 2012 08:46:29 -0700, Guenter Roeck wrote:
> On Sun, Jun 10, 2012 at 11:36:40AM -0400, Jean Delvare wrote:
> > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > i2cinit       D ffffffff814a04e0     0  2064   2059 0x00000004
> > >  ffff880271928a70 0000000000000086 0000000000000096 ffff880273215b48
> > >  ffff8802ffffffff ffff880477306a70 0000000000010140 ffff880273215fd8
> > >  0000000000010140 ffff880271928a70 ffff880273215fd8 ffff880273215fd8
> > > Call Trace:
> > >  [<ffffffff8103ecd0>] ? default_wake_function+0x0/0x20
> > >  [<ffffffff8148765f>] ? __rt_mutex_slowlock+0x4f/0x110
> > >  [<ffffffff814879e3>] ? rt_mutex_slowlock+0x93/0x190
> > >  [<ffffffff813278d9>] ? i2c_smbus_xfer+0x49/0x110
> > >  [<ffffffff814e1de0>] ? dev_sysfs_ops+0x0/0x10
> > >  [<ffffffff81327c40>] ? i2c_smbus_write_byte_data+0x30/0x40
> > 
> > This looks odd, sysfs_remove_group() doesn't call
> > i2c_smbus_write_byte_data(), and i2c_smbus_write_byte_data() doesn't
> > touch dev_sysfs_ops... So this stack trace is approximate.
> > 
> I thought it was probably the call to lm75_write_value() in lm75_remove()
> after sysfs_remove_group() returned.

Certainly. We see a mix of the function calls in lm75_remove().
lm75_write_value() is definitely the one causing the deadlock. And your
analysis is correct... there's nothing special about this byte write,
so there must be something wrong with the underlying I2C bus even
before that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
