From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 13 Jun 2012 13:51:32 +0000
Subject: Re: [lm-sensors] lm75_remove: LM75 Device remove using sysfs delete_device
Message-Id: <20120613135132.GA13589@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
In-Reply-To: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 13, 2012 at 09:41:38AM -0400, Sasikanth babu wrote:
> 
> 
> On Wed, Jun 13, 2012 at 9:53 AM, Guenter Roeck <guenter.roeck@ericsson.com>
> wrote:
> 
>     On Tue, Jun 12, 2012 at 11:51:51PM -0400, Sasikanth babu wrote:
>     >
>     > On Sun, Jun 10, 2012 at 9:06 PM, Jean Delvare <khali@linux-fr.org> wrote:
>     >
>     >     (Note: Frodo is out of the lm-sensors project for years, no need to
>     Cc
>     >     him.)
>     >
>     >     On Sun, 10 Jun 2012 07:41:03 -0700, Sasikanth babu wrote:
>     >     >   when I'm trying to delete lm75 device using sysfs delete_device
>     >     attribute
>     >     > (echo 0x4e >/sys/bus/i2c/devices/i2c-3/delete_device)
>     >     >   It hangs at lm75_remove function. I started the device using
>     sysfs
>     >     > attribute new_device.
>     >     >
>     >     >
>     >     >   Kernel verion : 2.6.34.12
>     >
>     >     I can't reproduce this with kernel 3.4.2.
>     >
>     >     Did you try reproducing this with a more recent kernel? 2.6.34 is
>     >     getting old.
>     >
>     >     Is there anything you can think of which makes your system special?
>     I2C
>     >     bus multiplexing ? Some unusual kernel option maybe?
>     >
>     >
>     >       Yes, I have PCA9545 Mux device. LM75 device was connected to
>     PCA9545 Mux
>     > devices (Mux device
>     >       is connected to SMBUS). At first I unloaded PCA954x module, It
>     hanged at
>     > lm75_remove. Later I had
>     >       to tried remove the lm75 device using sysfs, again it hanged at
>     same
>     > location. Both PCA Mux device and
>     >       lm75 devvice instantiated using sysfs new_device.
>     >
>     >
>     >     > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>     message.
>     >     > i2cinit       D ffffffff814a04e0     0  2064   2059 0x00000004
>     >     >  ffff880271928a70 0000000000000086 0000000000000096
>     ffff880273215b48
>     >     >  ffff8802ffffffff ffff880477306a70 0000000000010140
>     ffff880273215fd8
>     >     >  0000000000010140 ffff880271928a70 ffff880273215fd8
>     ffff880273215fd8
>     >     > Call Trace:
>     >     >  [<ffffffff8103ecd0>] ? default_wake_function+0x0/0x20
>     >     >  [<ffffffff8148765f>] ? __rt_mutex_slowlock+0x4f/0x110
>     >     >  [<ffffffff814879e3>] ? rt_mutex_slowlock+0x93/0x190
>     >     >  [<ffffffff813278d9>] ? i2c_smbus_xfer+0x49/0x110
>     >     >  [<ffffffff814e1de0>] ? dev_sysfs_ops+0x0/0x10
>     >     >  [<ffffffff81327c40>] ? i2c_smbus_write_byte_data+0x30/0x40
>     >
>     >     This looks odd, sysfs_remove_group() doesn't call
>     >     i2c_smbus_write_byte_data(), and i2c_smbus_write_byte_data() doesn't
>     >     touch dev_sysfs_ops... So this stack trace is approximate.
>     >
>     >     >  [<ffffffff811361f9>] ? sysfs_remove_group+0x59/0x100
>     >     >  [<ffffffff8132ec2d>] ? lm75_remove+0x4d/0x80
>     >     >  [<ffffffff81326ef9>] ? i2c_device_remove+0xa9/0xc0
>     >     >  [<ffffffff8129ffb6>] ? __device_release_driver+0x56/0xc0
>     >     >  [<ffffffff812a00f5>] ? device_release_driver+0x25/0x40
>     >     >  [<ffffffff8129f481>] ? bus_remove_device+0x91/0xc0
>     >     >  [<ffffffff8129d7a8>] ? device_del+0x118/0x190
>     >     >  [<ffffffff8129d829>] ? device_unregister+0x9/0x20
>     >     >  [<ffffffff813281bc>] ? i2c_sysfs_delete_device+0x17c/0x200
>     >     >  [<ffffffff81133046>] ? sysfs_write_file+0x1c6/0x260
>     >     >  [<ffffffff810d5323>] ? vfs_write+0x103/0x200
>     >     >  [<ffffffff810d550e>] ? sys_write+0x4e/0x90
>     >     >  [<ffffffff814884e4>] ? page_fault+0x24/0x30
>     >     >  [<ffffffff810024ab>] ? system_call_done+0x0/0x5
>     >
>     Jean,
> 
>     in 2.6.34, i2c_sysfs_delete_device calls i2c_lock_adapter, then
>     i2c_unregister_device.
>     This in turn calls lm75_remove which through i2c_smbus_xfer tries to
>     acquire the lock again.
> 
>     The current code is different - i2c_sysfs_delete_device no longer calls
>     i2c_lock_adapter.
>     Commit ID is dafc50d141c27959dbd3a1cfe9857a86d23402a7, which specifically
>     mentions deadlock
>     issues with multiplexed busses.
>    
>     Guenter
> 
> 
>  
> After patching dafc50d141c27959dbd3a1cfe9857a86d23402a7 lm75_probe is getting
> crashed.
> 
> i2c i2c-1: adapter [i2c-0-mux (chan_id 0)] registered
> i2c-dev: adapter [i2c-0-mux (chan_id 0)] registered as minor 1
> i2c i2c-0: Added multiplexed i2c bus 1
> i2c i2c-2: adapter [i2c-0-mux (chan_id 1)] registered
> i2c-dev: adapter [i2c-0-mux (chan_id 1)] registered as minor 2
> i2c i2c-0: Added multiplexed i2c bus 2
> i2c i2c-3: adapter [i2c-0-mux (chan_id 2)] registered
> i2c-dev: adapter [i2c-0-mux (chan_id 2)] registered as minor 3
> i2c i2c-0: Added multiplexed i2c bus 3
> i2c i2c-4: adapter [i2c-0-mux (chan_id 3)] registered
> i2c-dev: adapter [i2c-0-mux (chan_id 3)] registered as minor 4
> i2c i2c-0: Added multiplexed i2c bus 4
> pca954x 0-0073: registered 4 multiplexed busses for I2C switch pca9545
> i2c i2c-0: client [pca9545] registered with bus id 0-0073
> i2c i2c-0: new_device: Instantiated device pca9545 at 0x73
> i2c i2c-3: The new_device interface is still experimental and may change in a
> near future
> i2c 3-004c: uevent
> lm75 3-004c: probe
> kernel tried to execute NX-protected page - exploit attempt? (uid: 0, task:
> S0i2cinit, pid: 1774)
> lm75 3-004c: uevent
> lm75 3-004c: uevent
> BUG: unable to handle kernel paging request at ffff880272ab0200
> IP: [<ffff880272ab0200>] 0xffff880272ab0200
> PGD 8000000001768063 PUD 80000002400001e3
> Oops: 0011 [#1] SMP
> last sysfs file: /sys/devices/pci0000:00/0000:00:1f.3/i2c-0/i2c-3/3-004c/uevent
> CPU 8
> Modules linked in: igb ixgbe pmbus_core ltc2978 i2c_mux pca954x [last unloaded:
> scsi_wait_scan]
> 
> Pid: 1774, comm: S0i2cinit Not tainted 2.6.34.10-grsec-WR4.3.0.0_cgl #1 To be
> filled by O.E.M./To be filled by O.E.M.
> RIP: 0010:[<ffff880272ab0200>]  [<ffff880272ab0200>] 0xffff880272ab0200
> RSP: 0018:ffff8804734d5c70  EFLAGS: 00010296
> RAX: ffff880272ab01f0 RBX: ffff880473f18c28 RCX: 0000000000000dcd
> RDX: 0000000000000000 RSI: ffffffff814f0620 RDI: ffff880272ab0000
> RBP: ffff880473f18c00 R08: 00000000000165c8 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff880473f18c04
> R13: ffff880473f18c00 R14: ffffffff8132ec80 R15: 0000000000000000
> FS:  00007f894f16e700(0000) GS:ffff880287200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff880272ab0200 CR3: 000000027495c000 CR4: 00000000000406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Process S0i2cinit (pid: 1774, threadinfo ffff8804734d4000, task
> ffff8804734eabb0)
> Stack:
>  ffffffff8132ecaa ffff880473f18c28 ffffffff814f0620 ffff880473f18c04
> <0> ffff880473f18c00 ffffffff8132ec80 ffffffff81327014 0000000000000000
> <0> ffffffff812a018a ffffffff84a8c350 ffff880473f18c28 00000000ffffffed
> Call Trace:
>  [<ffffffff8132ecaa>] ? lm75_probe+0x2a/0x1b0
>  [<ffffffff814f0620>] ? lm75_ids+0x40/0x1e0
>  [<ffffffff8132ec80>] ? lm75_probe+0x0/0x1b0
>  [<ffffffff81327014>] ? i2c_device_probe+0x104/0x130
>  [<ffffffff812a018a>] ? driver_sysfs_add+0x5a/0x80
>  [<ffffffff812a02a8>] ? driver_probe_device+0x88/0x180
>  [<ffffffff812a0440>] ? __device_attach+0x0/0x60
>  [<ffffffff8129f6bc>] ? bus_for_each_drv+0x5c/0x90
>  [<ffffffff812a0555>] ? device_attach+0x85/0x90
>  [<ffffffff8129f4d5>] ? bus_probe_device+0x25/0x40
>  [<ffffffff8129ddd5>] ? device_add+0x4f5/0x5c0
>  [<ffffffff812287ed>] ? kobject_init+0x2d/0xb0
>  [<ffffffff813287e8>] ? i2c_new_device+0x118/0x1b0
>  [<ffffffff81328b50>] ? i2c_sysfs_new_device+0xe0/0x2a0
>  [<ffffffff814e1de0>] ? dev_sysfs_ops+0x0/0x10
>  [<ffffffff81133046>] ? sysfs_write_file+0x1c6/0x260
>  [<ffffffff810d5323>] ? vfs_write+0x103/0x200
>  [<ffffffff810d550e>] ? sys_write+0x4e/0x90
>  [<ffffffff81488524>] ? page_fault+0x24/0x30
>  [<ffffffff810024ab>] ? system_call_done+0x0/0x5
>  
I suspect it requires additional patches to work. Jean might know.
fe61e07e9ebc890c70d97a1f72ddaad4bee2d848 seems relevant, and there may be others,
even infrastructure changes.

Can you switch to a more recent kernel ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
