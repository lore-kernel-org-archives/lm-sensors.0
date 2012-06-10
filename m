From: Sasikanth babu <sasikanth.v19@gmail.com>
Date: Sun, 10 Jun 2012 14:41:03 +0000
Subject: [lm-sensors] lm75_remove: LM75 Device remove using sysfs delete_device
Message-Id: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6812214873850911177=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org
Cc: frodol@dds.nl

--===============6812214873850911177==
Content-Type: multipart/alternative; boundary=047d7b10cc9b11de0304c21f39b1

--047d7b10cc9b11de0304c21f39b1
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

  when I'm trying to delete lm75 device using sysfs delete_device attribute
(echo 0x4e >/sys/bus/i2c/devices/i2c-3/delete_device)
  It hangs at lm75_remove function. I started the device using sysfs
attribute new_device.


  Kernel verion : 2.6.34.12

"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
i2cinit       D ffffffff814a04e0     0  2064   2059 0x00000004
 ffff880271928a70 0000000000000086 0000000000000096 ffff880273215b48
 ffff8802ffffffff ffff880477306a70 0000000000010140 ffff880273215fd8
 0000000000010140 ffff880271928a70 ffff880273215fd8 ffff880273215fd8
Call Trace:
 [<ffffffff8103ecd0>] ? default_wake_function+0x0/0x20
 [<ffffffff8148765f>] ? __rt_mutex_slowlock+0x4f/0x110
 [<ffffffff814879e3>] ? rt_mutex_slowlock+0x93/0x190
 [<ffffffff813278d9>] ? i2c_smbus_xfer+0x49/0x110
 [<ffffffff814e1de0>] ? dev_sysfs_ops+0x0/0x10
 [<ffffffff81327c40>] ? i2c_smbus_write_byte_data+0x30/0x40
 [<ffffffff811361f9>] ? sysfs_remove_group+0x59/0x100
 [<ffffffff8132ec2d>] ? lm75_remove+0x4d/0x80
 [<ffffffff81326ef9>] ? i2c_device_remove+0xa9/0xc0
 [<ffffffff8129ffb6>] ? __device_release_driver+0x56/0xc0
 [<ffffffff812a00f5>] ? device_release_driver+0x25/0x40
 [<ffffffff8129f481>] ? bus_remove_device+0x91/0xc0
 [<ffffffff8129d7a8>] ? device_del+0x118/0x190
 [<ffffffff8129d829>] ? device_unregister+0x9/0x20
 [<ffffffff813281bc>] ? i2c_sysfs_delete_device+0x17c/0x200
 [<ffffffff81133046>] ? sysfs_write_file+0x1c6/0x260
 [<ffffffff810d5323>] ? vfs_write+0x103/0x200
 [<ffffffff810d550e>] ? sys_write+0x4e/0x90
 [<ffffffff814884e4>] ? page_fault+0x24/0x30
 [<ffffffff810024ab>] ? system_call_done+0x0/0x5

Thanks in advance for your help.

Thanks
Sasi

--047d7b10cc9b11de0304c21f39b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>=A0 when I&#39;m trying to delete lm75 devi=
ce using sysfs delete_device attribute (echo 0x4e &gt;/sys/bus/i2c/devices/=
i2c-3/delete_device)<br>=A0 It hangs at lm75_remove function. I started the=
 device using sysfs attribute new_device.<br>
<br><br>=A0 Kernel verion : 2.6.34.12<br><br>&quot;echo 0 &gt; /proc/sys/ke=
rnel/hung_task_timeout_secs&quot; disables this message.<br>i2cinit=A0=A0=
=A0=A0=A0=A0 D ffffffff814a04e0=A0=A0=A0=A0 0=A0 2064=A0=A0 2059 0x00000004=
<br>=A0ffff880271928a70 0000000000000086 0000000000000096 ffff880273215b48<=
br>
=A0ffff8802ffffffff ffff880477306a70 0000000000010140 ffff880273215fd8<br>=
=A00000000000010140 ffff880271928a70 ffff880273215fd8 ffff880273215fd8<br>C=
all Trace:<br>=A0[&lt;ffffffff8103ecd0&gt;] ? default_wake_function+0x0/0x2=
0<br>
=A0[&lt;ffffffff8148765f&gt;] ? __rt_mutex_slowlock+0x4f/0x110<br>=A0[&lt;f=
fffffff814879e3&gt;] ? rt_mutex_slowlock+0x93/0x190<br>=A0[&lt;ffffffff8132=
78d9&gt;] ? i2c_smbus_xfer+0x49/0x110<br>=A0[&lt;ffffffff814e1de0&gt;] ? de=
v_sysfs_ops+0x0/0x10<br>
=A0[&lt;ffffffff81327c40&gt;] ? i2c_smbus_write_byte_data+0x30/0x40<br>=A0[=
&lt;ffffffff811361f9&gt;] ? sysfs_remove_group+0x59/0x100<br>=A0[&lt;ffffff=
ff8132ec2d&gt;] ? lm75_remove+0x4d/0x80<br>=A0[&lt;ffffffff81326ef9&gt;] ? =
i2c_device_remove+0xa9/0xc0<br>
=A0[&lt;ffffffff8129ffb6&gt;] ? __device_release_driver+0x56/0xc0<br>=A0[&l=
t;ffffffff812a00f5&gt;] ? device_release_driver+0x25/0x40<br>=A0[&lt;ffffff=
ff8129f481&gt;] ? bus_remove_device+0x91/0xc0<br>=A0[&lt;ffffffff8129d7a8&g=
t;] ? device_del+0x118/0x190<br>
=A0[&lt;ffffffff8129d829&gt;] ? device_unregister+0x9/0x20<br>=A0[&lt;fffff=
fff813281bc&gt;] ? i2c_sysfs_delete_device+0x17c/0x200<br>=A0[&lt;ffffffff8=
1133046&gt;] ? sysfs_write_file+0x1c6/0x260<br>=A0[&lt;ffffffff810d5323&gt;=
] ? vfs_write+0x103/0x200<br>
=A0[&lt;ffffffff810d550e&gt;] ? sys_write+0x4e/0x90<br>=A0[&lt;ffffffff8148=
84e4&gt;] ? page_fault+0x24/0x30<br>=A0[&lt;ffffffff810024ab&gt;] ? system_=
call_done+0x0/0x5<br><br>Thanks in advance for your help.<br><br>Thanks<br>=
Sasi<br>
</div>

--047d7b10cc9b11de0304c21f39b1--


--===============6812214873850911177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6812214873850911177==--
