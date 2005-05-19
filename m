From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [od@fet.uni-hannover.de: Trying to find device chrontel 7009 ...]
Message-Id: <20031013205850.GA2164@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Oliver Dawid <od@fet.uni-hannover.de> -----

From: Oliver Dawid <od@fet.uni-hannover.de>
To: frodol@dds.nl
Subject: Trying to find device chrontel 7009 ...
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 

Hi Frodo,

I am writing to you, because I found your E-Mail adress in lm_sensors 
source for i2c-algo-bit.c

I have a Hermes 845GL with chrontel encoder for video output. Problem 
is: although I can set in Bios that it should produce PAL signal, I 
allways get NTSC. I already found register which has to be modified 
only problem is how to find the device.

I hoped that chrontel chip is connected to i2c controller of i845, 
which can be accessed through i810 driver (afaik - or there is another 
chip inside i did not find yet).

Unfortunatelly scan_bit=1 does not find any device only a couple of 
dots or ".S <7>0<7>needed 0 jiffies" id debug=9. I am not very familar 
to i2c code, so my digging in that code ended up in nothing.

Can you give me some hints how to find the device and how to adress? Is 
ther some docu I missed to read about i2c drivers for linux (or 
lm_sensors)?

Hope, you can help me,

thanks,
od

-- 
oliver dawid * od@fli4l.de * http://www.fli4l.de/

----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
