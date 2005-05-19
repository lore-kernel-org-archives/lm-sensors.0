From: abraham@2d3d.co.za (Abraham vd Merwe)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Adapter driver
Message-Id: <20020520172349.A7186@crystal.2d3d.co.za>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

I've written an adapter driver an I'd like to have an ID assigned to me.
This is what I'm using at the moment:

------------< snip <------< snip <------< snip <------------
root@crystal:~/lart/c++/src/i2c# grep FRODO
/usr/arm-linux/linux/include/linux/i2c-id.h
#define I2C_HW_B_FRODO  0x13    /* 2d3D, Inc. SA-1110 Development Board */
------------< snip <------< snip <------< snip <------------

I've also got a couple of questions for you:

1) Is there a developer mailinglist where I can discuss I2C related stuff?

2) There is 3 fields in the i2c_algo_bit_data structure for timing: udelay,
mdelay, timeout. What should I make this? I've made them 80, 80, 100
respectively (stolen from Russell King's acorn RTC driver), but I'm not sure
if this is the best selection...

3) Where do I send i2c patches to / can I get CVS access?

-- 

Regards
 Abraham

If at first you don't succeed, redefine success.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 232 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020520/27f88777/attachment.bin
