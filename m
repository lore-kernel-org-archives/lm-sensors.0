From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 28 Oct 2007 12:55:45 +0000
Subject: Re: [lm-sensors] What to use as prefix for TI TMP401 IC,
Message-Id: <472486D1.9010107@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4722FB3C.9010402@hhs.nl>
In-Reply-To: <4722FB3C.9010402@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Sat, 27 Oct 2007 10:47:56 +0200, Hans de Goede wrote:
>> As part of the linuxdriverproject:
>> http://linuxdriverproject.org
>>
>> I'm working on a TI TMP401 driver, but what should I use as prefix:
>> ti_tmp401 or just tmp401?
> 
> Just tmp401, please.
> 

I already figured as much in the mean time (after looking at the devices page 
of the wiki), still thanks for the answer!

> Did you check first if the TMP401 was compatible with another device we
> already support? After a quick look, the register map reminds me those
> of the LM90/ADM1032 a lot. It would be worth checking that the TMP401
> device couldn't be supported by the lm90 driver by just adding the
> device and manufacturer ID...
> 

I did, its indeed like the lm90, except that the local (on chip) temp sensor 
registers all are 16 bits (split in a low and high reg) insetad of the 8 bits 
of the lm90, which esp with all the special cases already in lm90.c seems like 
enough of a divergence to me to warrant a new driver.

> Also, I suggest that you add detection for the TMP401 to sensors-detect
> right away. That's the best way to find early testers for your work.
> 

Will do.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
