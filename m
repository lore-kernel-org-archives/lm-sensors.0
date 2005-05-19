From: wellhard@roxen.com (Marcus Wellhard)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Asus as99127f temp2 compute notice
Message-Id: <4jr8le1ymq.fsf@leguan.idonex.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Thanks for a great package!

I have a ASUS-A7V333 Motherboard with an Athlon xp 1800+ processor. I
am using the i2c-viapro bus driver and the w83781d chip driver forced
to as99127f (modprobe w83781d force_as99127f=0,0x2d). The lm_sensors
package is compiled from cvs. I have compared the cpu-temperature
between the lm75 and the w83781d driver. I have noticed that the
compute line for as99127f/temp2 in /etc/sensors.conf is wrong for my
motherboard. If I change it from:

  compute temp2 (@*30/43)+25, (@-25)*43/30

to:

  compute temp2 @*2, @/2

it matches almoust exactely with the output from lm75. Unfortunately
the half degrees become 0.1 degrees less, for example 62.4 and not 62.5.

-- 
Marcus Wellhardh, Developer             e-mail: wellhardh@roxen.com
Roxen Internet Software AB              Voice: +46 13 376802
