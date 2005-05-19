From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040204212630.2b542c1a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Silly me. I've just copied it from FSCPOS, but didn't check it. I had
> a look into Poseidon's data sheet and cannot find a difference to
> Hermes'. You are right, that this code doesn't make sense and is
> wrong.

Indeed, Poseidon and Scylla do the same, meaningless comparison. I
wonder how this could survive unseen until today. I will clean it up
right now.

> Well, the BIOS sets reasonable values at boot time, but I wouldn't
> have the driver block writing lower values to the registers. If FSC
> had concerns about the values written to the registers, they simply
> wouldn't have documented them(see my last email about the
> sensor-fan-matrix).

I don't quite agree with you. They documented the limitation, this
sounds like a piece of advice to driver programers.

> > 1* Clean up sensors code so that it doesn't reference fan_min. For
> > one thing, it'll let us get rid of the errors you had when running
> > "sensors". (...)

I'll do this, as mentioned above.

> > 2* Either rename fan_min in libsensors to pwm, or even remove it
> > completely. Depends if you want to keep it or not. If it is removed,
> > update sensors.conf accordingly.
> 
> I would like to keep it as pwm.

OK, let's go this way. I'll do that as soon as you have submitted a
change to the 2.4 driver.

> > 3* If you want to keep the pwm stuff, rename it in the 2.4 driver as
> > well.
> 
> This means renaming the procfs files to pwm, doesn't it?
> 
> I don't think, that it would be good idea to rename every fan_min to
> pwm, as there would then no longer be a relationship to the
> documenation.

Well, in this case, rewrite the documentation as well. Doesn't sound
very difficult. My reason for suggesting that change is that tweaking
libsensors is much easier if the 2.4 and 2.6 driver are similar. And
anyway, I don't much like calling fan_min something that is not in RPM
unit. See the confusion it has caused to me already ;') and in sensors
as well.

> > 4* If you don't want to keep the pwm stuff, remove it from the 2.6
> > driver.
> 
> So, this one is already up to date.

Yes, shouldn't need to be changed.

> > Basically everything is possible, keeping it in the driver only,
> > driver+library, driver+library+sensors.conf or
> > driver+library+sensors.conf+sensors. Depends on how useful the
> > feature is to you.
> 
> It is imported to me. I've choosen this board, because of its
> possiblity to control all fans very precisely. I use it in my video
> disk recorder, to have a silent PC for watching TV. But it can also be
> powerful (and loud), e. g. for converting recordings. When watching
> TV, the system still stays cool enough to have all fans run at minimum
> speed, where the used VERAX fans are almost not noticeable.

Nice :) So let's keep that functionality in the 2.6 driver, and fix it
everywhere else it is needed.

> Thank you very much for your assistance. If Hermes is ported properly,
> it can be the base for porting Poseidon's driver. I already have
> contact to a person, that is willing to port it.

Interesting how users of old rare chips are surfacing these days, first
with the gl518sm, now with fscpos... Indeed Poseidon seems to be very
similar to Hermes (while Scylla seems more complex, or at least bigger,
to me).

Thanks for helping in the porting process. This is much work and we
couldn't do it without the help of people who actually have the chip and
can test the new driver.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
