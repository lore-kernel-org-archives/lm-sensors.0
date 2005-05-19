From: j.ellerbroek@student.tudelft.nl (Joost Ellerbroek)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: problem with it87.o
Message-Id: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've got a small bugreport for the it87 driver.
The driver loads fine, and i get normal readings afterwards, but as soon as 
the driver loads, my cpu fan gears up to it's maximum rpm, even though the 
temperature is still low enough.

I have a shuttle sn41g2 pc, with the nforce2 chipset. The board supports 
variable fan speeds, it monitors cpu temperature, and sets fan speed 
accordingly. Up to the point where i load the it87 module that is :)

I'm running kernel 2.4.20, i2c and lm-sensors version 2.8.0
bios version fn41s019. Should you need more info just ask.

kind regards,

Joost.
