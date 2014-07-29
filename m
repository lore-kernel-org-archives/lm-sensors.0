From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 29 Jul 2014 06:56:35 +0000
Subject: Re: [lm-sensors] Sensors configuration for Intel D201GLY2 motherboard
Message-Id: <20140729085635.3e7807c4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
In-Reply-To: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi =C9ric,

On Mon, 28 Jul 2014 17:30:05 +0200, =C9ric Le Bras wrote:
> BTW, how are the temerature limits determined? What values are acceptable?
>=20
> Sensors reports a Sys temp of 43=B0C or more, which triggers the limit of
> 43=B0C and the sending of alarms to syslog. Should I change the limit, or=
 is
> my server realy getting too hot?

The temp1 limits have no hardware default and are not set by your BIOS
either so you have to set them yourself. You see 43=B0C right now but it
was 95=B0C in the first output you sent and most likely it changes with
every reboot.

The "right value" is difficult to tell. You can check the recommended
maximum operating temperature in the manual as a hint. But it also
depends where the sensors is. If it's monitoring a chipset (south
bridge or north bridge for example) or if it is under the CPU socket,
then it's expected that it will be relatively hot. If it is measuring
the ambient temperature, it should not be so hot.

A practical approach is to consider that your system is doing fine at
the moment and set the temperature limit a little higher than the
current input value. So if temp1 is stable at 43=B0C, you could set
temp1_max to 50 and temp1_max_hyst to 48.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
