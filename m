From: ALLEN.C.DOUGLASS@saic.com (Chris Douglass)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: adm1021 + kernel 2.6.3 kills machine
Message-Id: <1077918018.21481.21.camel@nomad.ad.eecg.saic.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello-
sensors-detect tells me I have and adm1021 sensor. When I try to load
this module, my monitor turns off, and the hard drive light stays on
until I shut down and unplug the machine from the wall for several
seconds. Merely powering off does not help. I don't know if this is a
bad detection or a hardware issue. I also have a W83682HF chip on the
mobo which works fine, as well as the eeprom driver.
It may be of interest to note that the new radeonfb driver includes an
i2c interface which is detected by sensors-detect and the i2c interface
itself is detected by the radeonfb driver. If there is any output you
would like, or investigation I can do to help, let me know. Please
respond to:
douglassac@earthlink.net
Thanks
-Chris 


My hardware is:
ABIT NF7-S 2.0 BIOS 21
Radeon 9700 Pro

Software:
Slackware 9.1
kernel 2.6.3
lm_sensors2 CVS checked out on 2/25/04

-- 
-- 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040227/640b42f5/attachment.html
