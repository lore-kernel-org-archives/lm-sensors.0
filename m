From: Sasikanth babu <sasikanth.v19@gmail.com>
Date: Wed, 13 Jun 2012 03:58:08 +0000
Subject: Re: [lm-sensors] lm75_remove: LM75 Device remove using sysfs delete_device
Message-Id: <CAOJFanUqEPUGm-7M2HEP8U+uwhg4zQS5ww5dFu0gYAU-exs_Sg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3624348710319718668=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
	<20120610173640.3b21759c@endymion.delvare>
In-Reply-To: <20120610173640.3b21759c@endymion.delvare>
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>
Cc: linux-i2c@vger.kernel.org, lm-sensors@lm-sensors.org

--===============3624348710319718668==
Content-Type: multipart/alternative; boundary=047d7b33c710d9144704c2528014

--047d7b33c710d9144704c2528014
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Jun 10, 2012 at 9:06 PM, Jean Delvare <khali@linux-fr.org> wrote:

> (Note: Frodo is out of the lm-sensors project for years, no need to Cc
> him.)
>
> On Sun, 10 Jun 2012 07:41:03 -0700, Sasikanth babu wrote:
> >   when I'm trying to delete lm75 device using sysfs delete_device
> attribute
> > (echo 0x4e >/sys/bus/i2c/devices/i2c-3/delete_device)
> >   It hangs at lm75_remove function. I started the device using sysfs
> > attribute new_device.
> >
> >
> >   Kernel verion : 2.6.34.12
>
> I can't reproduce this with kernel 3.4.2.
>
> Did you try reproducing this with a more recent kernel? 2.6.34 is
> getting old.
>
> Is there anything you can think of which makes your system special? I2C
> bus multiplexing ? Some unusual kernel option maybe?
>

      Yes, I have PCA9545 Mux device. LM75 device was connected to PCA9545
Mux devices (Mux device
      is connected to SMBUS). At first I unloaded PCA954x module, It hanged
at lm75_remove. Later I had
      to tried remove the lm75 device using sysfs, again it hanged at same
location. Both PCA Mux device and
      lm75 devvice instantiated using sysfs new_device.

>
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > i2cinit       D ffffffff814a04e0     0  2064   2059 0x00000004
> >  ffff880271928a70 0000000000000086 0000000000000096 ffff880273215b48
> >  ffff8802ffffffff ffff880477306a70 0000000000010140 ffff880273215fd8
> >  0000000000010140 ffff880271928a70 ffff880273215fd8 ffff880273215fd8
> > Call Trace:
> >  [<ffffffff8103ecd0>] ? default_wake_function+0x0/0x20
> >  [<ffffffff8148765f>] ? __rt_mutex_slowlock+0x4f/0x110
> >  [<ffffffff814879e3>] ? rt_mutex_slowlock+0x93/0x190
> >  [<ffffffff813278d9>] ? i2c_smbus_xfer+0x49/0x110
> >  [<ffffffff814e1de0>] ? dev_sysfs_ops+0x0/0x10
> >  [<ffffffff81327c40>] ? i2c_smbus_write_byte_data+0x30/0x40
>
> This looks odd, sysfs_remove_group() doesn't call
> i2c_smbus_write_byte_data(), and i2c_smbus_write_byte_data() doesn't
> touch dev_sysfs_ops... So this stack trace is approximate.
>
> >  [<ffffffff811361f9>] ? sysfs_remove_group+0x59/0x100
> >  [<ffffffff8132ec2d>] ? lm75_remove+0x4d/0x80
> >  [<ffffffff81326ef9>] ? i2c_device_remove+0xa9/0xc0
> >  [<ffffffff8129ffb6>] ? __device_release_driver+0x56/0xc0
> >  [<ffffffff812a00f5>] ? device_release_driver+0x25/0x40
> >  [<ffffffff8129f481>] ? bus_remove_device+0x91/0xc0
> >  [<ffffffff8129d7a8>] ? device_del+0x118/0x190
> >  [<ffffffff8129d829>] ? device_unregister+0x9/0x20
> >  [<ffffffff813281bc>] ? i2c_sysfs_delete_device+0x17c/0x200
> >  [<ffffffff81133046>] ? sysfs_write_file+0x1c6/0x260
> >  [<ffffffff810d5323>] ? vfs_write+0x103/0x200
> >  [<ffffffff810d550e>] ? sys_write+0x4e/0x90
> >  [<ffffffff814884e4>] ? page_fault+0x24/0x30
> >  [<ffffffff810024ab>] ? system_call_done+0x0/0x5
>
> --
> Jean Delvare
>

--047d7b33c710d9144704c2528014
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote">On Sun, Jun 10, 2012 at 9:0=
6 PM, Jean Delvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.o=
rg" target=3D"_blank">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
(Note: Frodo is out of the lm-sensors project for years, no need to Cc<br>
him.)<br>
<div class=3D"im"><br>
On Sun, 10 Jun 2012 07:41:03 -0700, Sasikanth babu wrote:<br>
&gt; =A0 when I&#39;m trying to delete lm75 device using sysfs delete_devic=
e attribute<br>
&gt; (echo 0x4e &gt;/sys/bus/i2c/devices/i2c-3/delete_device)<br>
&gt; =A0 It hangs at lm75_remove function. I started the device using sysfs=
<br>
&gt; attribute new_device.<br>
&gt;<br>
&gt;<br>
&gt; =A0 Kernel verion : 2.6.34.12<br>
<br>
</div>I can&#39;t reproduce this with kernel 3.4.2.<br>
<br>
Did you try reproducing this with a more recent kernel? 2.6.34 is<br>
getting old.<br>
<br>
Is there anything you can think of which makes your system special? I2C<br>
bus multiplexing ? Some unusual kernel option maybe?<br></blockquote><div>=
=A0 =A0 <br>=A0 =A0 =A0 Yes, I have PCA9545 Mux device. LM75 device was con=
nected to PCA9545 Mux devices (Mux device<br>=A0=A0=A0=A0=A0 is connected t=
o SMBUS). At first I unloaded PCA954x module, It hanged at lm75_remove. Lat=
er I had <br>
=A0=A0=A0=A0=A0 to tried remove the lm75 device using sysfs, again it hange=
d at same location. Both PCA Mux device and<br>=A0=A0=A0=A0=A0 lm75 devvice=
 instantiated using sysfs new_device.</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">

<div class=3D"im"><br>
&gt; &quot;echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs&quot; disabl=
es this message.<br>
&gt; i2cinit =A0 =A0 =A0 D ffffffff814a04e0 =A0 =A0 0 =A02064 =A0 2059 0x00=
000004<br>
&gt; =A0ffff880271928a70 0000000000000086 0000000000000096 ffff880273215b48=
<br>
&gt; =A0ffff8802ffffffff ffff880477306a70 0000000000010140 ffff880273215fd8=
<br>
&gt; =A00000000000010140 ffff880271928a70 ffff880273215fd8 ffff880273215fd8=
<br>
&gt; Call Trace:<br>
&gt; =A0[&lt;ffffffff8103ecd0&gt;] ? default_wake_function+0x0/0x20<br>
&gt; =A0[&lt;ffffffff8148765f&gt;] ? __rt_mutex_slowlock+0x4f/0x110<br>
&gt; =A0[&lt;ffffffff814879e3&gt;] ? rt_mutex_slowlock+0x93/0x190<br>
&gt; =A0[&lt;ffffffff813278d9&gt;] ? i2c_smbus_xfer+0x49/0x110<br>
&gt; =A0[&lt;ffffffff814e1de0&gt;] ? dev_sysfs_ops+0x0/0x10<br>
&gt; =A0[&lt;ffffffff81327c40&gt;] ? i2c_smbus_write_byte_data+0x30/0x40<br=
>
<br>
</div>This looks odd, sysfs_remove_group() doesn&#39;t call<br>
i2c_smbus_write_byte_data(), and i2c_smbus_write_byte_data() doesn&#39;t<br=
>
touch dev_sysfs_ops... So this stack trace is approximate.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; =A0[&lt;ffffffff811361f9&gt;] ? sysfs_remove_group+0x59/0x100<br>
&gt; =A0[&lt;ffffffff8132ec2d&gt;] ? lm75_remove+0x4d/0x80<br>
&gt; =A0[&lt;ffffffff81326ef9&gt;] ? i2c_device_remove+0xa9/0xc0<br>
&gt; =A0[&lt;ffffffff8129ffb6&gt;] ? __device_release_driver+0x56/0xc0<br>
&gt; =A0[&lt;ffffffff812a00f5&gt;] ? device_release_driver+0x25/0x40<br>
&gt; =A0[&lt;ffffffff8129f481&gt;] ? bus_remove_device+0x91/0xc0<br>
&gt; =A0[&lt;ffffffff8129d7a8&gt;] ? device_del+0x118/0x190<br>
&gt; =A0[&lt;ffffffff8129d829&gt;] ? device_unregister+0x9/0x20<br>
&gt; =A0[&lt;ffffffff813281bc&gt;] ? i2c_sysfs_delete_device+0x17c/0x200<br=
>
&gt; =A0[&lt;ffffffff81133046&gt;] ? sysfs_write_file+0x1c6/0x260<br>
&gt; =A0[&lt;ffffffff810d5323&gt;] ? vfs_write+0x103/0x200<br>
&gt; =A0[&lt;ffffffff810d550e&gt;] ? sys_write+0x4e/0x90<br>
&gt; =A0[&lt;ffffffff814884e4&gt;] ? page_fault+0x24/0x30<br>
&gt; =A0[&lt;ffffffff810024ab&gt;] ? system_call_done+0x0/0x5<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Jean Delvare<br>
</font></span></blockquote></div><br></div>

--047d7b33c710d9144704c2528014--


--===============3624348710319718668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3624348710319718668==--
