From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 10 Jun 2010 08:24:12 +0000
Subject: Re: [lm-sensors] Fintek F71889ED is unsupported (hack patch
Message-Id: <4C10A12C.5060701@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTikzgi3flngEea2GeiEtAwdfRDdPaMtDq_zb6jD7@mail.gmail.com>
In-Reply-To: <AANLkTikzgi3flngEea2GeiEtAwdfRDdPaMtDq_zb6jD7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Short self intro: I'm the author and maintainer of the f71882fg driver.

On 05/28/2010 11:25 PM, Maarten Maathuis wrote:
> This appears to be a pretty new Super I/O IC, which i found on my new
> motherboard (MSI 870A-G54).
>
> I couldn't find a datasheet, but this link
> (http://code.google.com/p/open-hardware-monitor/source/detail?r0#)
> suggests that it can be trivially added to the f71882fg driver.
>
> So i tried that, pretending it was a f71889fg.
>
> This is the output i got, i appended what i think about the values:
>
> f71889ed-isa-0600
> Adapter: ISA adapter
> in0:         +1.66 V
> in1:         +0.90 V  (max =  +2.04 V)<-- Vcore, 1.11 V when in high
> power mode, this seems accurate (compared to bios)
> in2:         +1.07 V
> in3:         +0.88 V
> in4:         +0.62 V
> in5:         +1.27 V
> in6:         +1.55 V
> in7:         +1.66 V
> in8:         +1.64 V
> fan1:        785 RPM<-- cpu fan, accurate (compared to bios)
> fan2:          0 RPM  ALARM
> fan3:          0 RPM  ALARM
> temp1:       +24.0 C  (high = +255.0 C, hyst = +251.0 C)  ALARM<--
> cpu temp, probably accurate (compared to bios)
>                        (crit = +255.0 C, hyst = +251.0 C)  ALARM
> sensor = Intel PECI
> temp2:         FAULT  (high = +255.0 C, hyst = +251.0 C)
>                        (crit = +255.0 C, hyst = +251.0 C)  sensor = transistor
> temp3:       +33.0 C  (high = +255.0 C, hyst = +253.0 C)  ALARM<--
> system temp, probably accurate (compared to bios)
>                        (crit = +255.0 C, hyst = +253.0 C)  ALARM
> sensor = transistor
>
> So please tell me what you think, any ideas how this can be improved.
> Especially the system voltages are horribly mis-calibrated it seems.
>

Well first fo all we will need a datasheet, yes really. The fintek
chips are quite complex when it comes to there fan control parts
and there then to be subtile differences between all the different
versions, see all the special handling for various revisions already
present in the driver.

Luckily Fintek usually provides datasheet to the public. But they tend
to lag a bit between devices showing up in the market and actually
publishing a datasheet. They don't want to put the sheet up till it
is "final" (or so I think), where as products are already being sold
in the market with the chip in them (presumably made with the use of
non final datasheets).

So the thing to do is to keep an eye on:
http://www.fintek.com.tw/eng/products.asp?BID=1&SID

And when a datasheet shows up there drop me a mail and I'll extend
the driver and then ask you to test it.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
