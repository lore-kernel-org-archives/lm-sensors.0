From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Thu, 09 Jun 2005 17:52:49 +0000
Subject: [lm-sensors] How can I skip i2c detection?
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I have a custom motherboard with four i2c devices on it.
 - lm83 @ 0x4c
 - max6875 @ 0x50
 - pca9539 @ 0x74
 - ds2484 @ 0x18

Right now it takes 15.5 seconds to load those four modules.
I see the "i2c-adapter i2c-0: timeout is state write" kernel message ten
times.
When I build those modules with only the correct addresses, the load
time is 5.5 seconds.

So, it takes 10 seconds to probe addresses that don't exist.

I'd like to speed up the module loading without modifying the source.

Is there a way to tell an i2c module to load only for a specific
address?
I looked at the i2c_detect() function and did not see a way, but perhaps
I just missed it.

Thanks,
Ben

