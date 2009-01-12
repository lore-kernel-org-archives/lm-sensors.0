From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 12 Jan 2009 18:49:04 +0000
Subject: Re: [lm-sensors] Supporting ADT7481 temperature sensor
Message-Id: <496B90A0.3070801@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
In-Reply-To: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Crossley, Malcolm (GE EntSol, Intelligent Platforms) wrote:
> Hello,
> 
> I am tasked with writing linux kernel support for the ADT7481 sensor. 
> This sensor is a dual remote, single local, sensor with an extended
> temperature 
> range capability on the remote sensors. 
> 
> Most of the register layout of the device is compliant with the LM90
> driver but unfortunately the official manufacturer ID and device ID
> registers are not in 
> a LM90 compliant location. 
> 
> The LM90 driver supports the ADT7481 extended temperature range
> registers through it's
> ADT7461 support. 
> 
> The ADT7481 does have register values at 0xfe and 0xff but they are not
> documented in 
> the datasheet.
> 
> Here is an i2cdump output:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 67 6b 00 24 08 9a 13 a9 13 24 08 9a 13 a9 13 00    gk.$?????$?????.
> 10: 40 00 00 00 00 00 00 00 00 a4 00 00 00 00 00 00    @........?......
> 20: 98 05 07 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
> 30: 6d ae 13 c0 00 00 00 00 00 a9 00 00 00 81 41 02    m???.....?...?A?
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 08 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00    ?..?............
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 41 62    ..............Ab
> 
> The official manufacturer ID register is at 0x3e and the official device
> ID register is at
> 0x3d.
> 
> My question is whether it would be better to?
> 1. Modify the lm90 driver, using undocumented registers for detection
> and adding second 
>    remote channel support
> Or 
> 2. Write a new driver from scratch but borrow code from the existing
> LM90 driver
> 
> I would like to get this driver included into the kernel.
> 

I think one would be the best, if the changes are not to invasive (which they 
probably are not).

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
