From: Sasikanth babu <sasikanth.v19@gmail.com>
Date: Wed, 13 Jun 2012 13:53:38 +0000
Subject: Re: [lm-sensors] lm75_remove: LM75 Device remove using sysfs delete_device
Message-Id: <CAOJFanUR8gh0NQ6KNgCLX1jZhvS+7rX2EYnnTsJ76zK-SWi+3w@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1155661016405623244=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
In-Reply-To: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============1155661016405623244==
Content-Type: multipart/alternative; boundary=e89a8ff1c8b80b255a04c25abece

--e89a8ff1c8b80b255a04c25abece
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jun 13, 2012 at 9:53 AM, Guenter Roeck
<guenter.roeck@ericsson.com>wrote:

> On Tue, Jun 12, 2012 at 11:51:51PM -0400, Sasikanth babu wrote:
> >
> > On Sun, Jun 10, 2012 at 9:06 PM, Jean Delvare <khali@linux-fr.org>
> wrote:
> >
> >     (Note: Frodo is out of the lm-sensors project for years, no need to
> Cc
> >     him.)
> >
> >     On Sun, 10 Jun 2012 07:41:03 -0700, Sasikanth babu wrote:
> >     >   when I'm trying to delete lm75 device using sysfs delete_device
> >     attribute
> >     > (echo 0x4e >/sys/bus/i2c/devices/i2c-3/delete_device)
> >     >   It hangs at lm75_remove function. I started the device using
> sysfs
> >     > attribute new_device.
> >     >
> >     >
> >     >   Kernel verion : 2.6.34.12
> >
> >     I can't reproduce this with kernel 3.4.2.
> >
> >     Did you try reproducing this with a more recent kernel? 2.6.34 is
> >     getting old.
> >
> >     Is there anything you can think of which makes your system special?
> I2C
> >     bus multiplexing ? Some unusual kernel option maybe?
> >
> >
> >       Yes, I have PCA9545 Mux device. LM75 device was connected to
> PCA9545 Mux
> > devices (Mux device
> >       is connected to SMBUS). At first I unloaded PCA954x module, It
> hanged at
> > lm75_remove. Later I had
> >       to tried remove the lm75 device using sysfs, again it hanged at
> same
> > location. Both PCA Mux device and
> >       lm75 devvice instantiated using sysfs new_device.
> >
> >
> >     > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
> >     > i2cinit       D ffffffff814a04e0     0  2064   2059 0x00000004
> >     >  ffff880271928a70 0000000000000086 0000000000000096
> ffff880273215b48
> >     >  ffff8802ffffffff ffff880477306a70 0000000000010140
> ffff880273215fd8
> >     >  0000000000010140 ffff880271928a70 ffff880273215fd8
> ffff880273215fd8
> >     > Call Trace:
> >     >  [<ffffffff8103ecd0>] ? default_wake_function+0x0/0x20
> >     >  [<ffffffff8148765f>] ? __rt_mutex_slowlock+0x4f/0x110
> >     >  [<ffffffff814879e3>] ? rt_mutex_slowlock+0x93/0x190
> >     >  [<ffffffff813278d9>] ? i2c_smbus_xfer+0x49/0x110
> >     >  [<ffffffff814e1de0>] ? dev_sysfs_ops+0x0/0x10
> >     >  [<ffffffff81327c40>] ? i2c_smbus_write_byte_data+0x30/0x40
> >
> >     This looks odd, sysfs_remove_group() doesn't call
> >     i2c_smbus_write_byte_data(), and i2c_smbus_write_byte_data() doesn't
> >     touch dev_sysfs_ops... So this stack trace is approximate.
> >
> >     >  [<ffffffff811361f9>] ? sysfs_remove_group+0x59/0x100
> >     >  [<ffffffff8132ec2d>] ? lm75_remove+0x4d/0x80
> >     >  [<ffffffff81326ef9>] ? i2c_device_remove+0xa9/0xc0
> >     >  [<ffffffff8129ffb6>] ? __device_release_driver+0x56/0xc0
> >     >  [<ffffffff812a00f5>] ? device_release_driver+0x25/0x40
> >     >  [<ffffffff8129f481>] ? bus_remove_device+0x91/0xc0
> >     >  [<ffffffff8129d7a8>] ? device_del+0x118/0x190
> >     >  [<ffffffff8129d829>] ? device_unregister+0x9/0x20
> >     >  [<ffffffff813281bc>] ? i2c_sysfs_delete_device+0x17c/0x200
> >     >  [<ffffffff81133046>] ? sysfs_write_file+0x1c6/0x260
> >     >  [<ffffffff810d5323>] ? vfs_write+0x103/0x200
> >     >  [<ffffffff810d550e>] ? sys_write+0x4e/0x90
> >     >  [<ffffffff814884e4>] ? page_fault+0x24/0x30
> >     >  [<ffffffff810024ab>] ? system_call_done+0x0/0x5
> >
> Jean,
>
> in 2.6.34, i2c_sysfs_delete_device calls i2c_lock_adapter, then
> i2c_unregister_device.
> This in turn calls lm75_remove which through i2c_smbus_xfer tries to
> acquire the lock again.
>
> The current code is different - i2c_sysfs_delete_device no longer calls
> i2c_lock_adapter.
> Commit ID is dafc50d141c27959dbd3a1cfe9857a86d23402a7, which specifically
> mentions deadlock
> issues with multiplexed busses.
>
> Guenter
>


After patching dafc50d141c27959dbd3a1cfe9857a86d23402a7 lm75_probe is
getting crashed.

i2c i2c-1: adapter [i2c-0-mux (chan_id 0)] registered
i2c-dev: adapter [i2c-0-mux (chan_id 0)] registered as minor 1
i2c i2c-0: Added multiplexed i2c bus 1
i2c i2c-2: adapter [i2c-0-mux (chan_id 1)] registered
i2c-dev: adapter [i2c-0-mux (chan_id 1)] registered as minor 2
i2c i2c-0: Added multiplexed i2c bus 2
i2c i2c-3: adapter [i2c-0-mux (chan_id 2)] registered
i2c-dev: adapter [i2c-0-mux (chan_id 2)] registered as minor 3
i2c i2c-0: Added multiplexed i2c bus 3
i2c i2c-4: adapter [i2c-0-mux (chan_id 3)] registered
i2c-dev: adapter [i2c-0-mux (chan_id 3)] registered as minor 4
i2c i2c-0: Added multiplexed i2c bus 4
pca954x 0-0073: registered 4 multiplexed busses for I2C switch pca9545
i2c i2c-0: client [pca9545] registered with bus id 0-0073
i2c i2c-0: new_device: Instantiated device pca9545 at 0x73
i2c i2c-3: The new_device interface is still experimental and may change in
a near future
i2c 3-004c: uevent
lm75 3-004c: probe
kernel tried to execute NX-protected page - exploit attempt? (uid: 0, task:
S0i2cinit, pid: 1774)
lm75 3-004c: uevent
lm75 3-004c: uevent
BUG: unable to handle kernel paging request at ffff880272ab0200
IP: [<ffff880272ab0200>] 0xffff880272ab0200
PGD 8000000001768063 PUD 80000002400001e3
Oops: 0011 [#1] SMP
last sysfs file:
/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/i2c-3/3-004c/uevent
CPU 8
Modules linked in: igb ixgbe pmbus_core ltc2978 i2c_mux pca954x [last
unloaded: scsi_wait_scan]

Pid: 1774, comm: S0i2cinit Not tainted 2.6.34.10-grsec-WR4.3.0.0_cgl #1 To
be filled by O.E.M./To be filled by O.E.M.
RIP: 0010:[<ffff880272ab0200>]  [<ffff880272ab0200>] 0xffff880272ab0200
RSP: 0018:ffff8804734d5c70  EFLAGS: 00010296
RAX: ffff880272ab01f0 RBX: ffff880473f18c28 RCX: 0000000000000dcd
RDX: 0000000000000000 RSI: ffffffff814f0620 RDI: ffff880272ab0000
RBP: ffff880473f18c00 R08: 00000000000165c8 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff880473f18c04
R13: ffff880473f18c00 R14: ffffffff8132ec80 R15: 0000000000000000
FS:  00007f894f16e700(0000) GS:ffff880287200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff880272ab0200 CR3: 000000027495c000 CR4: 00000000000406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process S0i2cinit (pid: 1774, threadinfo ffff8804734d4000, task
ffff8804734eabb0)
Stack:
 ffffffff8132ecaa ffff880473f18c28 ffffffff814f0620 ffff880473f18c04
<0> ffff880473f18c00 ffffffff8132ec80 ffffffff81327014 0000000000000000
<0> ffffffff812a018a ffffffff84a8c350 ffff880473f18c28 00000000ffffffed
Call Trace:
 [<ffffffff8132ecaa>] ? lm75_probe+0x2a/0x1b0
 [<ffffffff814f0620>] ? lm75_ids+0x40/0x1e0
 [<ffffffff8132ec80>] ? lm75_probe+0x0/0x1b0
 [<ffffffff81327014>] ? i2c_device_probe+0x104/0x130
 [<ffffffff812a018a>] ? driver_sysfs_add+0x5a/0x80
 [<ffffffff812a02a8>] ? driver_probe_device+0x88/0x180
 [<ffffffff812a0440>] ? __device_attach+0x0/0x60
 [<ffffffff8129f6bc>] ? bus_for_each_drv+0x5c/0x90
 [<ffffffff812a0555>] ? device_attach+0x85/0x90
 [<ffffffff8129f4d5>] ? bus_probe_device+0x25/0x40
 [<ffffffff8129ddd5>] ? device_add+0x4f5/0x5c0
 [<ffffffff812287ed>] ? kobject_init+0x2d/0xb0
 [<ffffffff813287e8>] ? i2c_new_device+0x118/0x1b0
 [<ffffffff81328b50>] ? i2c_sysfs_new_device+0xe0/0x2a0
 [<ffffffff814e1de0>] ? dev_sysfs_ops+0x0/0x10
 [<ffffffff81133046>] ? sysfs_write_file+0x1c6/0x260
 [<ffffffff810d5323>] ? vfs_write+0x103/0x200
 [<ffffffff810d550e>] ? sys_write+0x4e/0x90
 [<ffffffff81488524>] ? page_fault+0x24/0x30
 [<ffffffff810024ab>] ? system_call_done+0x0/0x5

--e89a8ff1c8b80b255a04c25abece
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">On Wed, Jun 13, 2012 at=
 9:53 AM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:guenter.roe=
ck@ericsson.com" target=3D"_blank">guenter.roeck@ericsson.com</a>&gt;</span=
> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
ue, Jun 12, 2012 at 11:51:51PM -0400, Sasikanth babu wrote:<br>
&gt;<br>
&gt; On Sun, Jun 10, 2012 at 9:06 PM, Jean Delvare &lt;<a href=3D"mailto:kh=
ali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 (Note: Frodo is out of the lm-sensors project for years, no ne=
ed to Cc<br>
&gt; =A0 =A0 him.)<br>
&gt;<br>
&gt; =A0 =A0 On Sun, 10 Jun 2012 07:41:03 -0700, Sasikanth babu wrote:<br>
&gt; =A0 =A0 &gt; =A0 when I&#39;m trying to delete lm75 device using sysfs=
 delete_device<br>
&gt; =A0 =A0 attribute<br>
&gt; =A0 =A0 &gt; (echo 0x4e &gt;/sys/bus/i2c/devices/i2c-3/delete_device)<=
br>
&gt; =A0 =A0 &gt; =A0 It hangs at lm75_remove function. I started the devic=
e using sysfs<br>
&gt; =A0 =A0 &gt; attribute new_device.<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt;<br>
&gt; =A0 =A0 &gt; =A0 Kernel verion : 2.6.34.12<br>
&gt;<br>
&gt; =A0 =A0 I can&#39;t reproduce this with kernel 3.4.2.<br>
&gt;<br>
&gt; =A0 =A0 Did you try reproducing this with a more recent kernel? 2.6.34=
 is<br>
&gt; =A0 =A0 getting old.<br>
&gt;<br>
&gt; =A0 =A0 Is there anything you can think of which makes your system spe=
cial? I2C<br>
&gt; =A0 =A0 bus multiplexing ? Some unusual kernel option maybe?<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 Yes, I have PCA9545 Mux device. LM75 device was connected =
to PCA9545 Mux<br>
&gt; devices (Mux device<br>
&gt; =A0 =A0 =A0 is connected to SMBUS). At first I unloaded PCA954x module=
, It hanged at<br>
&gt; lm75_remove. Later I had<br>
&gt; =A0 =A0 =A0 to tried remove the lm75 device using sysfs, again it hang=
ed at same<br>
&gt; location. Both PCA Mux device and<br>
&gt; =A0 =A0 =A0 lm75 devvice instantiated using sysfs new_device.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 &gt; &quot;echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs=
&quot; disables this message.<br>
&gt; =A0 =A0 &gt; i2cinit =A0 =A0 =A0 D ffffffff814a04e0 =A0 =A0 0 =A02064 =
=A0 2059 0x00000004<br>
&gt; =A0 =A0 &gt; =A0ffff880271928a70 0000000000000086 0000000000000096 fff=
f880273215b48<br>
&gt; =A0 =A0 &gt; =A0ffff8802ffffffff ffff880477306a70 0000000000010140 fff=
f880273215fd8<br>
&gt; =A0 =A0 &gt; =A00000000000010140 ffff880271928a70 ffff880273215fd8 fff=
f880273215fd8<br>
&gt; =A0 =A0 &gt; Call Trace:<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff8103ecd0&gt;] ? default_wake_function+0x0=
/0x20<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff8148765f&gt;] ? __rt_mutex_slowlock+0x4f/=
0x110<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff814879e3&gt;] ? rt_mutex_slowlock+0x93/0x=
190<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff813278d9&gt;] ? i2c_smbus_xfer+0x49/0x110=
<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff814e1de0&gt;] ? dev_sysfs_ops+0x0/0x10<br=
>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff81327c40&gt;] ? i2c_smbus_write_byte_data=
+0x30/0x40<br>
&gt;<br>
&gt; =A0 =A0 This looks odd, sysfs_remove_group() doesn&#39;t call<br>
&gt; =A0 =A0 i2c_smbus_write_byte_data(), and i2c_smbus_write_byte_data() d=
oesn&#39;t<br>
&gt; =A0 =A0 touch dev_sysfs_ops... So this stack trace is approximate.<br>
&gt;<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff811361f9&gt;] ? sysfs_remove_group+0x59/0=
x100<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff8132ec2d&gt;] ? lm75_remove+0x4d/0x80<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff81326ef9&gt;] ? i2c_device_remove+0xa9/0x=
c0<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff8129ffb6&gt;] ? __device_release_driver+0=
x56/0xc0<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff812a00f5&gt;] ? device_release_driver+0x2=
5/0x40<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff8129f481&gt;] ? bus_remove_device+0x91/0x=
c0<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff8129d7a8&gt;] ? device_del+0x118/0x190<br=
>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff8129d829&gt;] ? device_unregister+0x9/0x2=
0<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff813281bc&gt;] ? i2c_sysfs_delete_device+0=
x17c/0x200<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff81133046&gt;] ? sysfs_write_file+0x1c6/0x=
260<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff810d5323&gt;] ? vfs_write+0x103/0x200<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff810d550e&gt;] ? sys_write+0x4e/0x90<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff814884e4&gt;] ? page_fault+0x24/0x30<br>
&gt; =A0 =A0 &gt; =A0[&lt;ffffffff810024ab&gt;] ? system_call_done+0x0/0x5<=
br>
&gt;<br>
</div></div>Jean,<br>
<br>
in 2.6.34, i2c_sysfs_delete_device calls i2c_lock_adapter, then i2c_unregis=
ter_device.<br>
This in turn calls lm75_remove which through i2c_smbus_xfer tries to acquir=
e the lock again.<br>
<br>
The current code is different - i2c_sysfs_delete_device no longer calls i2c=
_lock_adapter.<br>
Commit ID is dafc50d141c27959dbd3a1cfe9857a86d23402a7, which specifically m=
entions deadlock<br>
issues with multiplexed busses.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br></font></span></blockquote><div><br>=A0<br>After patching dafc50=
d141c27959dbd3a1cfe9857a86d23402a7 lm75_probe is getting crashed.<br><br>i2=
c i2c-1: adapter [i2c-0-mux (chan_id 0)] registered<br>i2c-dev: adapter [i2=
c-0-mux (chan_id 0)] registered as minor 1<br>
i2c i2c-0: Added multiplexed i2c bus 1<br>i2c i2c-2: adapter [i2c-0-mux (ch=
an_id 1)] registered<br>i2c-dev: adapter [i2c-0-mux (chan_id 1)] registered=
 as minor 2<br>i2c i2c-0: Added multiplexed i2c bus 2<br>i2c i2c-3: adapter=
 [i2c-0-mux (chan_id 2)] registered<br>
i2c-dev: adapter [i2c-0-mux (chan_id 2)] registered as minor 3<br>i2c i2c-0=
: Added multiplexed i2c bus 3<br>i2c i2c-4: adapter [i2c-0-mux (chan_id 3)]=
 registered<br>i2c-dev: adapter [i2c-0-mux (chan_id 3)] registered as minor=
 4<br>
i2c i2c-0: Added multiplexed i2c bus 4<br>pca954x 0-0073: registered 4 mult=
iplexed busses for I2C switch pca9545<br>i2c i2c-0: client [pca9545] regist=
ered with bus id 0-0073<br>i2c i2c-0: new_device: Instantiated device pca95=
45 at 0x73<br>
i2c i2c-3: The new_device interface is still experimental and may change in=
 a near future<br>i2c 3-004c: uevent<br>lm75 3-004c: probe<br>kernel tried =
to execute NX-protected page - exploit attempt? (uid: 0, task: S0i2cinit, p=
id: 1774)<br>
lm75 3-004c: uevent<br>lm75 3-004c: uevent<br>BUG: unable to handle kernel =
paging request at ffff880272ab0200<br>IP: [&lt;ffff880272ab0200&gt;] 0xffff=
880272ab0200<br>PGD 8000000001768063 PUD 80000002400001e3<br>Oops: 0011 [#1=
] SMP<br>
last sysfs file: /sys/devices/pci0000:00/0000:00:1f.3/i2c-0/i2c-3/3-004c/ue=
vent<br>CPU 8<br>Modules linked in: igb ixgbe pmbus_core ltc2978 i2c_mux pc=
a954x [last unloaded: scsi_wait_scan]<br><br>Pid: 1774, comm: S0i2cinit Not=
 tainted 2.6.34.10-grsec-WR4.3.0.0_cgl #1 To be filled by O.E.M./To be fill=
ed by O.E.M.<br>
RIP: 0010:[&lt;ffff880272ab0200&gt;]=A0 [&lt;ffff880272ab0200&gt;] 0xffff88=
0272ab0200<br>RSP: 0018:ffff8804734d5c70=A0 EFLAGS: 00010296<br>RAX: ffff88=
0272ab01f0 RBX: ffff880473f18c28 RCX: 0000000000000dcd<br>RDX: 000000000000=
0000 RSI: ffffffff814f0620 RDI: ffff880272ab0000<br>
RBP: ffff880473f18c00 R08: 00000000000165c8 R09: 0000000000000000<br>R10: 0=
000000000000000 R11: 0000000000000001 R12: ffff880473f18c04<br>R13: ffff880=
473f18c00 R14: ffffffff8132ec80 R15: 0000000000000000<br>FS:=A0 00007f894f1=
6e700(0000) GS:ffff880287200000(0000) knlGS:0000000000000000<br>
CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>CR2: ffff880272ab020=
0 CR3: 000000027495c000 CR4: 00000000000406f0<br>DR0: 0000000000000000 DR1:=
 0000000000000000 DR2: 0000000000000000<br>DR3: 0000000000000000 DR6: 00000=
000ffff0ff0 DR7: 0000000000000400<br>
Process S0i2cinit (pid: 1774, threadinfo ffff8804734d4000, task ffff8804734=
eabb0)<br>Stack:<br>=A0ffffffff8132ecaa ffff880473f18c28 ffffffff814f0620 f=
fff880473f18c04<br>&lt;0&gt; ffff880473f18c00 ffffffff8132ec80 ffffffff8132=
7014 0000000000000000<br>
&lt;0&gt; ffffffff812a018a ffffffff84a8c350 ffff880473f18c28 00000000ffffff=
ed<br>Call Trace:<br>=A0[&lt;ffffffff8132ecaa&gt;] ? lm75_probe+0x2a/0x1b0<=
br>=A0[&lt;ffffffff814f0620&gt;] ? lm75_ids+0x40/0x1e0<br>=A0[&lt;ffffffff8=
132ec80&gt;] ? lm75_probe+0x0/0x1b0<br>
=A0[&lt;ffffffff81327014&gt;] ? i2c_device_probe+0x104/0x130<br>=A0[&lt;fff=
fffff812a018a&gt;] ? driver_sysfs_add+0x5a/0x80<br>=A0[&lt;ffffffff812a02a8=
&gt;] ? driver_probe_device+0x88/0x180<br>=A0[&lt;ffffffff812a0440&gt;] ? _=
_device_attach+0x0/0x60<br>
=A0[&lt;ffffffff8129f6bc&gt;] ? bus_for_each_drv+0x5c/0x90<br>=A0[&lt;fffff=
fff812a0555&gt;] ? device_attach+0x85/0x90<br>=A0[&lt;ffffffff8129f4d5&gt;]=
 ? bus_probe_device+0x25/0x40<br>=A0[&lt;ffffffff8129ddd5&gt;] ? device_add=
+0x4f5/0x5c0<br>
=A0[&lt;ffffffff812287ed&gt;] ? kobject_init+0x2d/0xb0<br>=A0[&lt;ffffffff8=
13287e8&gt;] ? i2c_new_device+0x118/0x1b0<br>=A0[&lt;ffffffff81328b50&gt;] =
? i2c_sysfs_new_device+0xe0/0x2a0<br>=A0[&lt;ffffffff814e1de0&gt;] ? dev_sy=
sfs_ops+0x0/0x10<br>
=A0[&lt;ffffffff81133046&gt;] ? sysfs_write_file+0x1c6/0x260<br>=A0[&lt;fff=
fffff810d5323&gt;] ? vfs_write+0x103/0x200<br>=A0[&lt;ffffffff810d550e&gt;]=
 ? sys_write+0x4e/0x90<br>=A0[&lt;ffffffff81488524&gt;] ? page_fault+0x24/0=
x30<br>
=A0[&lt;ffffffff810024ab&gt;] ? system_call_done+0x0/0x5<br>=A0<br></div></=
div><br></div>

--e89a8ff1c8b80b255a04c25abece--


--===============1155661016405623244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1155661016405623244==--
