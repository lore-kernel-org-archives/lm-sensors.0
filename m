From: Christian Emmerich <christian_emmerich@yahoo.de>
Date: Sat, 07 Jul 2007 17:26:06 +0000
Subject: Re: [lm-sensors] [PATCH] Add f75375s driver
Message-Id: <840302.19665.qm@web25106.mail.ukl.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1084407915345617293=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070628230725.GA29698@kos.to>
In-Reply-To: <20070628230725.GA29698@kos.to>
To: lm-sensors@vger.kernel.org

--===============1084407915345617293==
Content-Type: multipart/alternative; boundary="0-1034732978-1183829166=:19665"
Content-Transfer-Encoding: 8bit

--0-1034732978-1183829166=:19665
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Riku,

> Thanks for your time reviewing and testing the driver.
No problem. Without the driver i would't be able to manage the temperature/fan speed of my pc, so i have to thank you for your work.

> > Another problem is still the value of tempX_max_hyst, the value is always
> > zero. If i read sysfs direct i get following output:
> > root at pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-2/2-002d# cat
> > temp1_max_hyst
> > 0
> > root at pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-2/2-002d# cat
> > temp2_max_hyst
> > 0

> What value are you setting it to?
> thecus-1:/sys/devices/platform/IOP3xx-I2C.0/i2c-0/0-002e# cat temp1_max_hyst
> 55000
> thecus-1:/sys/devices/platform/IOP3xx-I2C.0/i2c-0/0-002e# echo 55 >
> temp1_max_hyst
> thecus-1:/sys/devices/platform/IOP3xx-I2C.0/i2c-0/0-002e# cat temp1_max_hyst
> 0
> ALL6500:/sys/devices/platform/IOP3xx-I2C.0/i2c-0/0-002e# echo 61000 >
> temp1_max_hyst
> ALL6500:/sys/devices/platform/IOP3xx-I2C.0/i2c-0/0-002e# cat temp1_max_hyst
> 61000

> So it appears to work as expected. According to sysfs-interface temp*
> should report and accept millidegrees or millivolts. We are outputting
> millidegrees.

OK, this was my fault if i set the value by hand i could also see the value using 'cat temp1_max_hyst' and sensors, i thought there would be an automatic entry i can read out.
What does this value exactly stand for, is it usefull for sensors or just a value i can read out using sensors?

Another problem i forget in my last mail. I don't know what's the reason, but if i do the following:
root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d# cat fan1_min
i got following output:
<output>
root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d# cat fan1_min
Segmentation fault
root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d#
Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] CPU:    0

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] CPU:    0

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] EIP is at show_fan_min+0x2c/0x50 [f75375s]

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] EIP is at show_fan_min+0x2c/0x50 [f75375s]

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] eax: 0016e360   ebx: 00000000   ecx: 00000000   edx: 00000000

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] eax: 0016e360   ebx: 00000000   ecx: 00000000   edx: 00000000

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] esi: db7b2000   edi: c0367514   ebp: dd948e80   esp: d82b9f38

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] esi: db7b2000   edi: c0367514   ebp: dd948e80   esp: d82b9f38

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] ds: 007b   es: 007b   ss: 0068

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] ds: 007b   es: 007b   ss: 0068

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] Process cat (pid: 11063, threadinfo=d82b8000 task=dba09ad0)

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] Process cat (pid: 11063, threadinfo=d82b8000 task=dba09ad0)

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] Stack: c136f640 0fa5bacc 080550d4 e1381360 dd948e80 c0228e7d ddab7668 d657f7e0

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] Stack: c136f640 0fa5bacc 080550d4 e1381360 dd948e80 c0228e7d ddab7668 d657f7e0

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000]        c0196410 00001000 08054000 d657f7f4 e13841a0 c3cc12c0 cc29eae0 08054000

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000]        c0196410 00001000 08054000 d657f7f4 e13841a0 c3cc12c0 cc29eae0 08054000

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000]        d82b9fa4 00001000 c0158c9c d82b9fa4 c01963a0 cc29eae0 fffffff7 08054000

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000]        d82b9fa4 00001000 c0158c9c d82b9fa4 c01963a0 cc29eae0 fffffff7 08054000

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] Call Trace:

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000] Call Trace:

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000]  <e1381360> show_fan_min+0x0/0x50 [f75375s]  <c0228e7d> dev_attr_show+0x1d/0x30

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000]  <e1381360> show_fan_min+0x0/0x50 [f75375s]  <c0228e7d> dev_attr_show+0x1d/0x30

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000]  <c0196410> sysfs_read_file+0x70/0x154  <c0158c9c> vfs_read+0xbc/0x180

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000]  <c0196410> sysfs_read_file+0x70/0x154  <c0158c9c> vfs_read+0xbc/0x180

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000]  <c01963a0> sysfs_read_file+0x0/0x154  <c0159101> sys_read+0x41/0x70

Message from syslogd@pc at Sat Jul  7 18:56:41 2007 ...
pc kernel: [17200023.168000]  <c01963a0> sysfs_read_file+0x0/0x154  <c0159101> sys_read+0x41/0x70

Message from syslogd@pc at Sat Jul  7 18:56:42 2007 ...
pc kernel: [17200023.168000]  <c0102dbb> sysenter_past_esp+0x54/0x79

Message from syslogd@pc at Sat Jul  7 18:56:42 2007 ...
pc kernel: [17200023.168000]  <c0102dbb> sysenter_past_esp+0x54/0x79

Message from syslogd@pc at Sat Jul  7 18:56:42 2007 ...
pc kernel: [17200023.168000] Code: 89 ce 53 83 ec 0c 8b 5a 14 e8 21 fd ff ff 31 c9 0f b7 84 58 bc 01 00 00 66 83 f8 ff 74 11 ba 60 e3 16 00 0f b7 c8 89 d0 c1 fa 1f <f7> f9 89 c1 89 34 24 89 4c 24 08 c7 44 24 04 15 1e 38 e1 e8 bc

Message from syslogd@pc at Sat Jul  7 18:56:42 2007 ...
pc kernel: [17200023.168000] Code: 89 ce 53 83 ec 0c 8b 5a 14 e8 21 fd ff ff 31 c9 0f b7 84 58 bc 01 00 00 66 83 f8 ff 74 11 ba 60 e3 16 00 0f b7 c8 89 d0 c1 fa 1f <f7> f9 89 c1 89 34 24 89 4c 24 08 c7 44 24 04 15 1e 38 e1 e8 bc

Message from syslogd@pc at Sat Jul  7 18:56:42 2007 ...
pc kernel: [17200023.168000] EIP: [pg0+552657804/1069069312] show_fan_min+0x2c/0x50 [f75375s] SS:ESP 0068:d82b9f38

Message from syslogd@pc at Sat Jul  7 18:56:42 2007 ...
pc kernel: [17200023.168000] EIP: [pg0+552657804/1069069312] show_fan_min+0x2c/0x50 [f75375s] SS:ESP 0068:d82b9f38

root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d#
</output>

Maybe you can try to do the same on your machine, maybe the problem is related to my chip/pc?

best regards
christian.

       
---------------------------------
 BE A BETTER WELTENBUMMLER: Jetzt Frage stellen und einen von 44 iPods gewinnen! 
--0-1034732978-1183829166=:19665
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<span style="font-family: courier;">Hi Riku,</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">&gt; Thanks for your time reviewing and testing the driver.</span><br style="font-family: courier;"><span style="font-family: courier;">No problem. Without the driver i would't be able to manage the temperature/fan speed of my pc, so i have to thank you for your work.</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">&gt; &gt; Another problem is still the value of tempX_max_hyst, the value is always</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; &gt; zero. If i read sysfs direct i get following output:</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; &gt; root at pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-2/2-002d# cat</span><br style="font-family: courier;"><span style="font-family:
 courier;">&gt; &gt; temp1_max_hyst</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; &gt; 0</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; &gt; root at pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-2/2-002d# cat</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; &gt; temp2_max_hyst</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; &gt; 0</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">&gt; What value are you setting it to?</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; thecus-1:/sys/devices/platform/IOP3xx-I2C.0/i2c-0/0-002e# cat temp1_max_hyst</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; 55000</span><br style="font-family: courier;"><span style="font-family: courier;">&gt;
 thecus-1:/sys/devices/platform/IOP3xx-I2C.0/i2c-0/0-002e# echo 55 &gt;</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; temp1_max_hyst</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; thecus-1:/sys/devices/platform/IOP3xx-I2C.0/i2c-0/0-002e# cat temp1_max_hyst</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; 0</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; ALL6500:/sys/devices/platform/IOP3xx-I2C.0/i2c-0/0-002e# echo 61000 &gt;</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; temp1_max_hyst</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; ALL6500:/sys/devices/platform/IOP3xx-I2C.0/i2c-0/0-002e# cat temp1_max_hyst</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; 61000</span><br style="font-family: courier;"><br style="font-family: courier;"><span
 style="font-family: courier;">&gt; So it appears to work as expected. According to sysfs-interface temp*</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; should report and accept millidegrees or millivolts. We are outputting</span><br style="font-family: courier;"><span style="font-family: courier;">&gt; millidegrees.</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">OK, this was my fault if i set the value by hand i could also see the value using 'cat temp1_max_hyst' and sensors, i thought there would be an automatic entry i can read out.</span><br style="font-family: courier;"><span style="font-family: courier;">What does this value exactly stand for, is it usefull for sensors or just a value i can read out using sensors?</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Another problem i forget in my last mail. I don't
 know what's the reason, but if i do the following:</span><br style="font-family: courier;"><span style="font-family: courier;">root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d# cat fan1_min</span><br style="font-family: courier;"><span style="font-family: courier;">i got following output:</span><br style="font-family: courier;"><span style="font-family: courier;">&lt;output&gt;</span><br style="font-family: courier;"><span style="font-family: courier;">root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d# cat fan1_min</span><br style="font-family: courier;"><span style="font-family: courier;">Segmentation fault</span><br style="font-family: courier;"><span style="font-family: courier;">root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d#</span><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc
 kernel: [17200023.168000] CPU:&nbsp;&nbsp;&nbsp; 0</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] CPU:&nbsp;&nbsp;&nbsp; 0</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] EIP is at show_fan_min+0x2c/0x50 [f75375s]</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] EIP is at show_fan_min+0x2c/0x50
 [f75375s]</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] eax: 0016e360&nbsp;&nbsp; ebx: 00000000&nbsp;&nbsp; ecx: 00000000&nbsp;&nbsp; edx: 00000000</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] eax: 0016e360&nbsp;&nbsp; ebx: 00000000&nbsp;&nbsp; ecx: 00000000&nbsp;&nbsp; edx: 00000000</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family:
 courier;">pc kernel: [17200023.168000] esi: db7b2000&nbsp;&nbsp; edi: c0367514&nbsp;&nbsp; ebp: dd948e80&nbsp;&nbsp; esp: d82b9f38</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] esi: db7b2000&nbsp;&nbsp; edi: c0367514&nbsp;&nbsp; ebp: dd948e80&nbsp;&nbsp; esp: d82b9f38</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] ds: 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; ss: 0068</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41
 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] ds: 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; ss: 0068</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] Process cat (pid: 11063, threadinfo=d82b8000 task=dba09ad0)</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] Process cat (pid: 11063, threadinfo=d82b8000 task=dba09ad0)</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp;
 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] Stack: c136f640 0fa5bacc 080550d4 e1381360 dd948e80 c0228e7d ddab7668 d657f7e0</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] Stack: c136f640 0fa5bacc 080550d4 e1381360 dd948e80 c0228e7d ddab7668 d657f7e0</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c0196410 00001000 08054000 d657f7f4 e13841a0 c3cc12c0 cc29eae0 08054000</span><br style="font-family:
 courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c0196410 00001000 08054000 d657f7f4 e13841a0 c3cc12c0 cc29eae0 08054000</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d82b9fa4 00001000 c0158c9c d82b9fa4 c01963a0 cc29eae0 fffffff7 08054000</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family:
 courier;">pc kernel: [17200023.168000]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d82b9fa4 00001000 c0158c9c d82b9fa4 c01963a0 cc29eae0 fffffff7 08054000</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] Call Trace:</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] Call Trace:</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel:
 [17200023.168000]&nbsp; &lt;e1381360&gt; show_fan_min+0x0/0x50 [f75375s]&nbsp; &lt;c0228e7d&gt; dev_attr_show+0x1d/0x30</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000]&nbsp; &lt;e1381360&gt; show_fan_min+0x0/0x50 [f75375s]&nbsp; &lt;c0228e7d&gt; dev_attr_show+0x1d/0x30</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000]&nbsp; &lt;c0196410&gt; sysfs_read_file+0x70/0x154&nbsp; &lt;c0158c9c&gt; vfs_read+0xbc/0x180</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message
 from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000]&nbsp; &lt;c0196410&gt; sysfs_read_file+0x70/0x154&nbsp; &lt;c0158c9c&gt; vfs_read+0xbc/0x180</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000]&nbsp; &lt;c01963a0&gt; sysfs_read_file+0x0/0x154&nbsp; &lt;c0159101&gt; sys_read+0x41/0x70</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:41 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000]&nbsp; &lt;c01963a0&gt; sysfs_read_file+0x0/0x154&nbsp; &lt;c0159101&gt;
 sys_read+0x41/0x70</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:42 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000]&nbsp; &lt;c0102dbb&gt; sysenter_past_esp+0x54/0x79</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:42 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000]&nbsp; &lt;c0102dbb&gt; sysenter_past_esp+0x54/0x79</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:42 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] Code: 89 ce 53 83 ec 0c 8b 5a 14 e8 21
 fd ff ff 31 c9 0f b7 84 58 bc 01 00 00 66 83 f8 ff 74 11 ba 60 e3 16 00 0f b7 c8 89 d0 c1 fa 1f &lt;f7&gt; f9 89 c1 89 34 24 89 4c 24 08 c7 44 24 04 15 1e 38 e1 e8 bc</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:42 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] Code: 89 ce 53 83 ec 0c 8b 5a 14 e8 21 fd ff ff 31 c9 0f b7 84 58 bc 01 00 00 66 83 f8 ff 74 11 ba 60 e3 16 00 0f b7 c8 89 d0 c1 fa 1f &lt;f7&gt; f9 89 c1 89 34 24 89 4c 24 08 c7 44 24 04 15 1e 38 e1 e8 bc</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:42 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] EIP: [pg0+552657804/1069069312] show_fan_min+0x2c/0x50
 [f75375s] SS:ESP 0068:d82b9f38</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Message from syslogd@pc at Sat Jul&nbsp; 7 18:56:42 2007 ...</span><br style="font-family: courier;"><span style="font-family: courier;">pc kernel: [17200023.168000] EIP: [pg0+552657804/1069069312] show_fan_min+0x2c/0x50 [f75375s] SS:ESP 0068:d82b9f38</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-1/1-002d#</span><br style="font-family: courier;"><span style="font-family: courier;">&lt;/output&gt;</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">Maybe you can try to do the same on your machine, maybe the problem is related to my chip/pc?</span><br style="font-family: courier;"><br style="font-family: courier;"><span style="font-family: courier;">best
 regards</span><br style="font-family: courier;"><span style="font-family: courier;">christian.</span><br style="font-family: courier;"><p>&#32;
      <hr size=1> 
<a href="http://de.rd.yahoo.com/evt=48734/*http://de.promotions.yahoo.com/clever/be-a-better/weltenbummler.html" target=_new
><b>BE A BETTER WELTENBUMMLER:</b> Jetzt Frage stellen und einen von 44 iPods gewinnen!</a> 
--0-1034732978-1183829166=:19665--


--===============1084407915345617293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1084407915345617293==--
