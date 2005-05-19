From: robots@twincar.sk (Michal Demin)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Problem with SMbus
Message-Id: <1075981068.15216.14.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

So i've been using lm_sensors wihtout any problem (isa)
But i'm having problems with SMBus.
I have MB : qdi SinactiX 5EP (82801EP), this seems to be supported
But i can't make the module working (i2c-i801) 

[root@localhost busses]# /sbin/insmod ./i2c-i801.o
./i2c-i801.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg

Here is also lspci
00:00.0 Class 0600: 8086:1130 (rev 04)
00:01.0 Class 0604: 8086:1131 (rev 04)
00:1e.0 Class 0604: 8086:244e (rev 05)
00:1f.0 Class 0601: 8086:2440 (rev 05)
00:1f.1 Class 0101: 8086:244b (rev 05)
00:1f.2 Class 0c03: 8086:2442 (rev 05)
00:1f.4 Class 0c03: 8086:2444 (rev 05)
00:1f.5 Class 0401: 8086:2445 (rev 05)
01:00.0 Class 0300: 10de:0110 (rev b2)
02:0e.0 Class 0200: 10ec:8139 (rev 10)

There is something missing between 2442 and 2444 ..

I have SpeedFan under W2k and it recognizes my SMBus well ...
Is there way how could i make it working ?? 
Many thanks ..
Michal

