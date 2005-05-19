From: are@tuntre.net (Are Pedersen)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: The LPC47M15x sensor chip, fan control
Message-Id: <419E6C18.4010002@tuntre.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have found out that the SMSC LPC47M15x sensor chip is fan-control
compatible with the smsc47m1 driver.

I added:
---
else if (val = 0x60)
   printk(KERN_INFO "smsc47m1: Found SMSC47M15x");
----
(around line 360)
To the drivers "smsc47m1_find" function.

The bios on the MSI Mega 865 barebone (my system) unfortunately have the
fan polarity inversed, so setting the fan_pwn to 0 will get the fan to
full speed, and 256 stops it (haven't tried that).

I'll probably try to patch some more on the driver to get the
temperature sensors working, but I don't know when.

-- 
You are not Are, I am Are, are you another Are, don't think you are Are!

