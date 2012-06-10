From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 10 Jun 2012 15:28:54 +0000
Subject: Re: [lm-sensors] lm75_remove: LM75 Device remove using sysfs delete_device
Message-Id: <20120610152854.GA10367@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
In-Reply-To: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sasikanth babu <sasikanth.v19-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "frodol-B0qZmFHriGg@public.gmane.org" <frodol-B0qZmFHriGg@public.gmane.org>

On Sun, Jun 10, 2012 at 10:41:03AM -0400, Sasikanth babu wrote:
> Hi all,
> 
>   when I'm trying to delete lm75 device using sysfs delete_device attribute
> (echo 0x4e >/sys/bus/i2c/devices/i2c-3/delete_device)
>   It hangs at lm75_remove function. I started the device using sysfs attribute
> new_device.
> 
> 
>   Kernel verion : 2.6.34.12
> 
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> i2cinit       D ffffffff814a04e0     0  2064   2059 0x00000004
>  ffff880271928a70 0000000000000086 0000000000000096 ffff880273215b48
>  ffff8802ffffffff ffff880477306a70 0000000000010140 ffff880273215fd8
>  0000000000010140 ffff880271928a70 ffff880273215fd8 ffff880273215fd8
> Call Trace:
>  [<ffffffff8103ecd0>] ? default_wake_function+0x0/0x20
>  [<ffffffff8148765f>] ? __rt_mutex_slowlock+0x4f/0x110
>  [<ffffffff814879e3>] ? rt_mutex_slowlock+0x93/0x190
>  [<ffffffff813278d9>] ? i2c_smbus_xfer+0x49/0x110
>  [<ffffffff814e1de0>] ? dev_sysfs_ops+0x0/0x10
>  [<ffffffff81327c40>] ? i2c_smbus_write_byte_data+0x30/0x40
>  [<ffffffff811361f9>] ? sysfs_remove_group+0x59/0x100
>  [<ffffffff8132ec2d>] ? lm75_remove+0x4d/0x80
>  [<ffffffff81326ef9>] ? i2c_device_remove+0xa9/0xc0
>  [<ffffffff8129ffb6>] ? __device_release_driver+0x56/0xc0
>  [<ffffffff812a00f5>] ? device_release_driver+0x25/0x40
>  [<ffffffff8129f481>] ? bus_remove_device+0x91/0xc0
>  [<ffffffff8129d7a8>] ? device_del+0x118/0x190
>  [<ffffffff8129d829>] ? device_unregister+0x9/0x20
>  [<ffffffff813281bc>] ? i2c_sysfs_delete_device+0x17c/0x200
>  [<ffffffff81133046>] ? sysfs_write_file+0x1c6/0x260
>  [<ffffffff810d5323>] ? vfs_write+0x103/0x200
>  [<ffffffff810d550e>] ? sys_write+0x4e/0x90
>  [<ffffffff814884e4>] ? page_fault+0x24/0x30
>  [<ffffffff810024ab>] ? system_call_done+0x0/0x5
> 

Hi,

I don't see anything wrong in the lm75 driver. The problem seems to be related
to the I2C bus master driver, or possibly to another device access pending on the
same I2C bus which does not complete.

What is the I2C bus master driver, and do you have anything else happening on the same bus ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
