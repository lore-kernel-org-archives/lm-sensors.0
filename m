From: sjobin@gniinc.net (Samuel Jobin)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Chipset VIA686b and SYSFAN (PART 2)
Message-Id: <3F2973E9.50304@gniinc.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I totally forget:

I used lm_sensor-2.8.0 with i2c-2.8.0.  I did the step on the QUICKSTART
from the lm_sensors directory.  I'm on Slackre 8.1 (kern 2.4.18) and the
I2C are compiled in module on the kernel

Thanks again,

Sam

Samuel Jobin wrote:

 > Hi!
 >
 > I installed lm_sensor on a MSI MS-6368 board with the VIA686B chipset.
 > LM_Sensors workk great (but he detected a via686a chipset.  I don't
 > know why).  But, the P/S Fan doesn't work.  I checked and I have the
 > right value in my bios.  But, with lm_sensors...  He display 9000RM
 > the first time i type "sensors".  After, only 0.  I need to reboot the
 > pc to get 9000 again.  So, do you have any idea (because the true
 > value cannot be 9000 rpm and it's always at 0 anyway).  The SYSFAN is
 > in fact the fan of my power supply (enermax).
 >
 > Thanks,
 >
 > Sam


-- 
Samuel Jobin
sjobin@gniinc.net
Software Development
_____________________
--= GNI inc.=--
5075 Wilfrid-Hamel O.
Suite 220
Qu?bec (QC), G2E 5G3
Phone: (418) 864-7721
Fax:   (418) 263-3150
