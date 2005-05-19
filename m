From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <40229535.9030709@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>Silly me. I've just copied it from FSCPOS, but didn't check it. I had
>>a look into Poseidon's data sheet and cannot find a difference to
>>Hermes'. You are right, that this code doesn't make sense and is
>>wrong.
> 
> Indeed, Poseidon and Scylla do the same, meaningless comparison. I
> wonder how this could survive unseen until today. I will clean it up
> right now.

I can't speak for Scylla, as I don't own it's specs.

>>Well, the BIOS sets reasonable values at boot time, but I wouldn't
>>have the driver block writing lower values to the registers. If FSC
>>had concerns about the values written to the registers, they simply
>>wouldn't have documented them(see my last email about the
>>sensor-fan-matrix).
> 
> I don't quite agree with you. They documented the limitation, this
> sounds like a piece of advice to driver programers.

I don't think so. SystemGuard doesn't even give a warning, when one allows the 
fans to turn off.

>>>1* Clean up sensors code so that it doesn't reference fan_min. For
>>>one thing, it'll let us get rid of the errors you had when running
>>>"sensors". (...)
> 
> I'll do this, as mentioned above.
> 
>>>2* Either rename fan_min in libsensors to pwm, or even remove it
>>>completely. Depends if you want to keep it or not. If it is removed,
>>>update sensors.conf accordingly.
>>
>>I would like to keep it as pwm.
> 
> OK, let's go this way. I'll do that as soon as you have submitted a
> change to the 2.4 driver.
> 
>>>3* If you want to keep the pwm stuff, rename it in the 2.4 driver as
>>>well.
>>
>>This means renaming the procfs files to pwm, doesn't it?

Nonsense! procfs has all information in one file, so there is nothing to rename.

>>I don't think, that it would be good idea to rename every fan_min to
>>pwm, as there would then no longer be a relationship to the
>>documenation.
> 
> Well, in this case, rewrite the documentation as well. Doesn't sound

I ment the specification from FSC. But you are right: I still have to update 
the documentation for sysfs.

> very difficult. My reason for suggesting that change is that tweaking
> libsensors is much easier if the 2.4 and 2.6 driver are similar. And
> anyway, I don't much like calling fan_min something that is not in RPM
> unit. See the confusion it has caused to me already ;') and in sensors
> as well.

If I got anything wrong, please point me to the locations, where I need to 
make changes.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de

