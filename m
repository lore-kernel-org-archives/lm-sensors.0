From: empx@gmx.de (=?ISO-8859-1?Q?Michael_Pfl=FCger?=)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: ASUS P4P800/W83627THF Fan Problems
Message-Id: <40001A2D.5030007@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
I'm using Kernel 2.6.1-rc2(2.6.0 gave the same results..) and the 
included i2c modules etc (w83781d driver).
The Temperature and Voltage Readings work, yet i cant read nor set the 
Fan speed of my CPUFan.
 cat /sys/bus/i2c/devices/0-0290/fan_input[123] shows always 0, and 
changing pwm[12] doesn't chnage the fan speed, pwm_enable2 is set to 1 
(there is no other pwm_enable).
I have disabled Asus QFan in the BIOS so it shouldn't interfere with this..
Is this a known problem and will/can it be solved somehow?

regards,
Michael
