From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: Sensor support for IBM PC300PL
Message-Id: <o8UBTcKo.1098429663.0436360.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041021215131.26660.qmail@web50210.mail.yahoo.com>
In-Reply-To: <20041021215131.26660.qmail@web50210.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I have a number of IBM 300PL's currently running SuSE 9.0 (2.4.21) on
>which I'd dearly love to use lmsensors.  If I understand Jean's reply
>correctly, the recommendation is to obtain the latest msensors/i2c
>(v2.8.8), remove the two traps for IBM hardware, compile & install the
>packages.

You can alternatively pick lm_sensors CVS, in which I already removed the
IBM detection code from sensors-detect, so this is one less change left
to you. The IBM detection code in te i2c-piix4 driver is still there
though, and will never be removed.

Note that the whole thing should be completely cleaned in the 2.6 kernel
in some time though. I'm too busy with other things these days but I
definitely plan to do the required changes there so that no corruption
can ever happen and no additional constraint is left for the user. I
can't tell when this will happen though.

>Then, it sounds like lmsensors will either work, or not...  in the latter
>case possibly causing damage to the notorious Atmel eeprom.
>
>My questions:
>
>(1) Is this a correct synopsis of Jean's instructions?

Yes it is.

>(2) Will the absense or presence of the Atmel issue be completely obvious?
>    In other words, is there any possibility of lmsensors appearing to
>    work, while actually malfunctioning in some manner?

The Atmel EEPROM appears at addresses 0x54-0x57 and 0x5C on the SMBus. If
nothing shows there, there is no EEPROM. i2cdetect in lm_sensors 2.8.7
and later are supposedly safe to use even with broken Atmel EEPROMs on
the bus.

EEPROM corruption will result in the system not even booting, so you
would notice that. It will not prevent lm_sensors from working though
(that it, not until the next boot ;)). There is no unnoticeable effect
with long run effects as far as we know.

At any rate, do NOT load the eeprom or ddcmon modules on your IBM
systems, EVER. This is the only potential corruption cause left in
lm_sensors 2.8.7+ as far as I can see.

>(3) My understanding is that the new I2C subsystem is required on a
>v2.4.21
>    kernel.  Once this new I2C subsystem is installed, however, I'm
>    gathering that there is a possibility that other applications which
>    require the old I2C subsystem may break.  Is that correct?

True, except that we have an extended i2c patch here:
  http://khali.linux-fr.org/devel/i2c/
which supposedly addresses the issue.

As a side note, I am currently working on reverting our i2c stack to the
old model so as to bring compatibility back without any additional
changes to the kernel tree. This should be i2c-2.9.0, and should be
ready within a month (or so I hope).

>Once I am clear on these points, my intent is to attempt this test and
>I would be happy to report back to the list if it would be of any use.
>
>I very much appreciate your time, and any insight or advice you can offer.

Keep in mind that you are a pioneer, be VERY careful. I invite you to
test a SINGLE machine at first, and make sure it works well for a month
or so before even considering installing a second one. Wait another
month at this point, and install on the rest of the machines if nothing
bad happened after that.

Jean
