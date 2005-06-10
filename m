From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Fri, 10 Jun 2005 21:49:16 +0000
Subject: [lm-sensors] How can I skip i2c detection?
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9085570F@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

I am as certain as I can be that I am using a LM82.
The chip is on two different motherboards, one is from Avantech and one
is a custom job.

Our schematic calls out a LM82 and the chip has this text on it: 43AB
82CI MQA
I don't know what "43AB" refers to, but "82CIMQA" is part of the order
number "LM82CIMQA".

The Avantech demo board has the same chip, except that the first number
is "42AB".
The BIOS on the Avantech board calls it a LM82.

It could be that the LM82 and LM83 have an identical uC inside and just
the packaging is different.

Ben

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Friday, June 10, 2005 1:43 PM
To: Gardner, Ben
Cc: lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] How can I skip i2c detection?

Hi Ben,

> ~ # i2cdump 0 0x4c
> (...)
> 30: 7f 7f 7f 7f 7f 24 24 24 7f 7f 7f 7f 7f 7f 7f 7f

Hm, this is becoming even weirder. Same ID as the LM83 (which doesn't
match the datasheet...), and additionally register 0x35 reads 0x24,
which means D1 and D3 open on the LM83, while this register is
supposedly 0 on the LM82. This also corroborates the 127 degrees C you
report for temp2 and temp4, which is the documented LM83's behavior when
no diode is connected, while the LM82 datasheet suggests 0 for these
registers.

So I start wondering... are you *absolutely certain* that what you have
is an LM82 and NOT an LM83?

--
Jean Delvare


