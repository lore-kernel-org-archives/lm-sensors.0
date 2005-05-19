From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: Maxim MAX6657 Support in lm_sensors
Message-Id: <20040604221927.03c0fd00.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40C04A4A.2010208@brend.org>
In-Reply-To: <40C04A4A.2010208@brend.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> At the moment I am not owning a mainboard with this chip on it (and
> do not even know about one using it by "default"), but because I am
> an overclocker I am doing a little modification on my Abit NF7-S
> which allows me to read the data of the AMD Athlon XP internal
> thermal diode. I am going to solder a self-made circuit using the
> MAX6657 to the back of my CPU socket on the mainboard, but before I
> am going to do this I wanted to know if it is possible to read the
> data of it with linux, which will be the only OS used on my computer.
> (So this is why I want to see this chip supported)

OK. So I confirm that the chip isn't supported at the moment but could
be very easily.

> It would be great if you would agree to add support for the MAX6657. 
> Because I still have my Winbond W83627HF in an full operational state 
> and I am not finished with my work yet, there is no need to have this 
> feature imediately availiable. So take your time to do a good job ;)

OK.

> I do not know any system or motherboard using the MAX6658, so support 
> for this chip is not necessary I think. And I do not know any 
> overclocker using this chip for such work - but I know at least
> around 10 people using the MAX6657. Most of them are not using Linux
> or only use it as a secondary OS...expecting me :)

I just checked and there is no way to differenciate between a MAX6657
and a MAX6658 anyway (nor a MAX6659, BTW), at least not according to the
datasheet. So if we support one we have the others for free.

> If you do NOT want to include support for this chip (maybe because it 
> may cause misdetection problems or something like that) just tell me -

No, there's no problem adding support. The "misdetection problems" are
inherent to I2C and if it justifies (IMHO) that we don't support chips
that are not used, it is definitely not a reason for not supporting a
chip once someone requests such support.

> I did not buy the chip until now. But if you are going to support it,
> I will buy it, because it is said to be very precise.

FWIW, Analog Devices ADM1032 is as precise as the MAX6657, at least from
comparing the datasheets. The National Semiconductor LM90 has a lower
accuracy. So if you can get you hands on an ADM1032, you could go with
that as well. But if you end up with a Maxim chip, I promise I'll add
support for it.

> I wanted to buy the chip yesterday somewhere on the internet, but I
> did not find any site where it is sold...do you know a store on the
> internet where I may buy it? (I just thought so because you are "in
> touch with this scene" ;) )

Usually, either we have the chip in a piece of hardware we happen to
own, or the manufacturers send evaluation boards for free. We do not buy
anything.

If you just need one chip, you can take you chance on the manufacturer's
site itself. They usually send free samples for people to experiment on
(or so I heard). They are used to sell them by 1000 to manufacturers, so
I guess they don't really care about one or two samples.

> Thanks again for your efforts!

You're welcome :)

-- 
Jean Delvare
http://khali.linux-fr.org/
