From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Sat, 27 Dec 2008 01:05:01 +0000
Subject: [lm-sensors] Sensors 3.0.3 on CentOS 5.2 (kernel 2.6.18) on ASUS
Message-Id: <49557F3D.20700@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4953F5E1.8050906@Winfirst.Com>
In-Reply-To: <4953F5E1.8050906@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With some help from others, I was able to get an upgraded kernel module for
the IT8716F chip found on the ASUS M2NPV-VM motherboard, and running 'sensors'
now shows lots of sensor data. Unfortunately, much of it doesn't make any
sense.

Is it possible that someone has already create a sensors.conf file for this
version of lm_sensors and this ASUS motherboard?

If it helps any, here is the information I see from the BIOS hardware
monitoring page:

  Q-Fan Controller:    Enabled
  VCore Voltage   :    1.23V
  3.3V  Voltage   :    3.18V
  5.0V  Voltage   :    4.95V
 12.0V  Voltage   :   11.60V

  CPU Temp            42C
  M/B Temp            38C
  CPU Fan Speed       2163 RPM
  Chassis 1 Fan Speed    0 RPM
  Chassis 2 Fan Speed 4647 RPM
  Power Fan Speed        0 RPM

Can anyone share their sensors.conf file?

Thanks,



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
