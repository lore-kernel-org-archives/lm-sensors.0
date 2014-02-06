From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Feb 2014 07:04:14 +0000
Subject: Re: [lm-sensors] Missing fan speed readout for ASUS M5A97 EVO R2.0 motherboard
Message-Id: <20140206080414.7f130ceb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
In-Reply-To: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rune,

On Thu, 6 Feb 2014 03:02:00 +0100, Rune Kj=E6r Svendsen wrote:
> I recently purchased an ASUS M5A97 EVO R2.0 motherboard, which has four f=
an
> connectors on it: CPU_FAN, CHA_FAN1, CHA_FAN2 and CHA_FAN3.
>=20
> I can only get the fan speeds of the first three of these fans, however,
> which appear as fan1, fan2 and fan3 in /sys/devices/platform/it87.656
>=20
> Is there any chance I might be able to get the speed of the last, CHA_FAN=
3,
> fan?
>=20
> I'm using fancontrol to control the fans, and this works wonderfully. The
> BIOS can't handle it, but it works perfectly with fancontrol - completely
> silent. The CPU is controlled by pwm1 and the chassis fans by pwm3, pwm2
> seems to do nothing.
>=20
> I'd really like to get a reading on the third fan. Any tips on where I can
> go from here? I'm willing to do some hacking to get it to work.

There can be three reasons:

* The last fan is connected to a different monitoring chip. Run a
  recent version of sensors-detect again:
  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
  and share the results with us.

* One of the fan inputs is multiplexed (two or more fans connected to
  the same input.) We do not currently support this and do not plan to
  support it in a near feature, as we don't have the board-specific
  information needed to do so.

* The monitoring chip driver (it87 in your case) has a bug and it
  should really display 4 fans instead of 3. Tell us which monitoring
  chip was detected, and show us the output of "sensors -u
  -c /dev/null". Also tell us which kernel version you are running.

--=20
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
