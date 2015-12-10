From: Andreas Werner <andreas.werner@men.de>
Date: Thu, 10 Dec 2015 17:12:31 +0000
Subject: Re: [lm-sensors] LM90 driver and ti tmp461 detection
Message-Id: <20151210171231.GA28022@awelinux>
List-Id: <lm-sensors.vger.kernel.org>
References: <20151210120856.GA27765@awelinux>
 <5669AB55.5030309@roeck-us.net>
In-Reply-To: <5669AB55.5030309@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andreas Werner <andreas.werner@men.de>, linux-kernel@vger.kernel.org, jdelvare@suse.com, lm-sensors@lm-sensors.org, wni@nvidia.com

On Thu, Dec 10, 2015 at 08:41:57AM -0800, Guenter Roeck wrote:
> On 12/10/2015 04:08 AM, Andreas Werner wrote:
> >Hi,
> >i have a temperature sensor device named "TI TMP461" which is quite the
> >same than the tmp451 which is already included in the lm90 driver.
> >
> >I just want to add the tmp461 to the driver but currently i have no way
> >to differ between the tmp461 and tmp451.
> >
> >The main different is that the tmp461 address can be configured by to Pins
> >whereas the tmp451 has a fixed address.
> >
> >The register layout is quite the same except that the tmp461 has one
> >register more (0x16 Channel Enable Register).
> >
> >Every zero bit is the same for both bits, so we cannot use these bits for
> >identification.
> >
> >Does anybody of you have a tmp451 to read out the register 0x16 (which is
> >not implement but i expect a value). May be we can use this to
> >identify the tmp461.
> >
> 
> Here is a register dump.
> 
> 00: 5d 69 00 04 08 bf 00 ff 53 00 00 00 00 00 00 00    ]i.???..S.......
> 10: a0 00 00 00 00 f0 00 00 00 a9 00 00 00 00 00 00    ?....?...?......
> 20: b8 0a 01 00 00 XX 00 00 00 00 0e 00 00 00 00 00    ???..X....?.....
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 00    ..............U.
> 
> there is nothing to distinguish the two chips as far as I can see.
> Is your system a devicetree system ? If so, you can just
> provide a compatible statement such as
> 	compatible = "ti,tmp461", "ti,tmp451";
> or simply instantiate the chip as tmp451.
> 
> Feel free to provide a patch adding '{ "tmp461", tmp451 },'
> to lm90_id as well as the necessary documentation, but I don't
> think there is anything we can do to detect the chip.
> 
> On the other side, I am a bit concerned that the chip detection doesn't
> work well, since the chip ID register is really unsupported and just happens
> to return 0 for both chips. I wonder if there are other TI chips which may
> be mis-detected as TMP451.
> 
> Thanks,
> Guenter
> 

Hi,
thanks for the register dump :-)

There is one difference. The temperature ranges differ:

TMP451:
Standard Mode: 0 to +127
Extended Mode: -64 to +191

TMP461:
Standard Mode: -40 to +127
Extended Mode: -64 to +191

Therefore the calcualtion is different then the tmp451 one.

I also aggree with you with the magical ID register. I hate such
kind of register with are not documented and may have a value.

I have a DT based board yes, but i have also planed to submit my changes
and also wanted to implement the autodetection of the chip.

I have also planned (or need) to implement the "n-Factor Correction" for the
CPU diodes. There is a register to set this value in the tmp451 and tmp461.
Would that make sense to add a DT property for the driver to be able
to set this value? What do you think?

Regards
Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
