From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Tue, 27 Mar 2012 19:21:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for  IT8781F, IT8782F, IT8783E/F
Message-Id: <296C0394-16BB-426F-B13B-1A924A7BBDE5@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
In-Reply-To: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Am 26.03.2012 um 19:01 schrieb Jean Delvare:
> [..]
>> If actually it is the job of the module to do such calculations, I would=
 offer to create an it87 patch for IT8783 fixing this - analog to an existi=
ng module with a similar behavior (if you know one).
>=20
> You assume that the PECI value always refers to the CPU. I do not think
> this is true, other parts (e.g. north bridge) could report their
> temperature through PECI as well.
>=20
> And if it is the CPU temperature, we already have the coretemp driver
> providing the same information, so there's little point in implementing
> the same in it87. The only benefit of handling PECI sensors in it87 and
> the like would be so that they can be used as sources for automatic fan
> speed control, but if the chip itself has no idea about the absolute
> value of the temperature then I doubt it can use it for automatic fan
> speed control.
>=20
Yes, with the coretemp driver even both core temperatures are displayed cor=
rectly. So I agree, it's nonsense to implement our special design into the =
generic driver  ;-)

Bj=F6rn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
