From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <402143C9.20100@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>Well, none of the two file types (pwm/fan_min) is perfekt for that
>>case. It would be necessary to have something like 'pwm_min'!
> 
> If we have to choose, this is more like pwm, at least because of the
> unit. What made me think wrong was the fact that it was named fan_min in
> the 2.4 driver, and that code in sensors/chips.c:
> 
>       && !sensors_get_feature(*name,SENSORS_FSCHER_FAN1,&fan)
>       && !sensors_get_feature(*name,SENSORS_FSCHER_FAN1_MIN,&min_rpm)
> (...)
>       else if (fan < min_rpm)
>         printf("\t%6.0f RPM (not present or faulty)\n",fan);
>       else
>         printf("\t%6.0f RPM \n",fan);
> 
> I just can't make any sense out of this comparison. Units don't even
> match. Am I missing something or is it plain wrong?

Silly me. I've just copied it from FSCPOS, but didn't check it. I had a look
into Poseidon's data sheet and cannot find a difference to Hermes'. You are
right, that this code doesn't make sense and is wrong.

> I read in the Hermes data sheet that FSC doesn't recommend to set the
> pwm value lower than what it was set to by the BIOS. Since I don't think
> anyone would want to set it higher (what would be the point? it is
> supposed to go higher by itself on high load) I wonder if it is even
> worth handling it in the driver. If we do, one possible safety would be
> to store the registers value as the driver is loaded and not to allow
> subsequent sets to set it lower than that.

Well, the BIOS sets reasonable values at boot time, but I wouldn't have the
driver block writing lower values to the registers. If FSC had concerns about
the values written to the registers, they simply wouldn't have documented them
(see my last email about the sensor-fan-matrix).

> Here is the plan I propose:
> 
> 1* Clean up sensors code so that it doesn't reference fan_min. For one
> thing, it'll let us get rid of the errors you had when running
> "sensors". Or at least use the value the way it should be (doesn't seem
> to be the case as of now).
>
> 2* Either rename fan_min in libsensors to pwm, or even remove it
> completely. Depends if you want to keep it or not. If it is removed,
> update sensors.conf accordingly.

I would like to keep it as pwm.

> 3* If you want to keep the pwm stuff, rename it in the 2.4 driver as
> well.

This means renaming the procfs files to pwm, doesn't it?

I don't think, that it would be good idea to rename every fan_min to pwm, as 
there would then no longer be a relationship to the documenation.

> 4* If you don't want to keep the pwm stuff, remove it from the 2.6
> driver.

So, this one is already up to date.

> Usually, fan speeds are controled by scripts, not sensors. In this case
> it is a bit different since the system can make fans go higher by
> itself, so no closed-loop script is needed.

That's fine with me. Usually, a script should be enough to set reasonable pwm
values depending to the sensor values.

> Basically everything is possible, keeping it in the driver only,
> driver+library, driver+library+sensors.conf or
> driver+library+sensors.conf+sensors. Depends on how useful the feature
> is to you.

It is imported to me. I've choosen this board, because of its possiblity to
control all fans very precisely. I use it in my video disk recorder, to have a
silent PC for watching TV. But it can also be powerful (and loud), e. g. for
converting recordings. When watching TV, the system still stays cool enough to 
have all fans run at minimum speed, where the used VERAX fans are almost not 
noticeable.

> I can handle points 1 and 2, while I would let you handle points 3 and
> 4. Just tell me what you think should be done so that I can fix things
> in the correct way.

Thank you very much for your assistance. If Hermes is ported properly, it can
be the base for porting Poseidon's driver. I already have contact to a person,
that is willing to port it.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de


