From: David Brownell <david-b@pacbell.net>
Date: Tue, 25 Sep 2007 05:12:32 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc6] lm75: new-style i2c binding,
Message-Id: <20070925051232.9536A2397F1@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070916234519.861D3C24EE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070916234519.861D3C24EE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> This is crying for at least two separate patches, and ideally more like
> 3 or 4.

This will be followed by three patches:

 - Cleanups, minor reorg, Kconfig update ... no functional changes

 - Support for new-style driver binding.

 - Use 12-bit resolution where it's available.


> Additionally, I can't apply your patch to my tree. Presumably you are
> missing recent patches that went into Mark's hwmon-testing tree and
> which affect the lm75 driver:
>
> hwmon: Allow writing of negative trigger temperatures
> http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;a=3Dcommit=
;h=A1efde3fd7b3d94c942b1a675da992c8a2f1f04b
>
> hwmon: Convert from class_device to device
> http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;a=3Dcommit=
;h=F89523a27def89ddc74d094a0910970f6a1c6f43
>
> If you split your patch and make sure that the result applies on top of
> the above patches, I'll be happy to review and test your work.

They're on top of those, as modified to apply against rc8 (various
changes in non-lm75 code prevent those from applying).


> > The way to kick in higher sample resolution on a given board is to
> > use the new style binding to pass in the chip type.
> >=20
> > One temporary omission:  IRQ support, or for the TI chips SMBALERT#
> > notifications.

Turns out that it's not just the TMP75/175/275 chips that understand
SMBALERT# and respond to the alert response address ... TMP101 too,
but not the TMP100.

Of course, from what I see so far, hwmon doesn't have any way to get
async notifications to userspace.  A "temp1_max_alarm" attribute
would need constant polling, and it's not clear quite when it'd clear.
Likewise with "temp1_min_alarm".

- Dave


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
