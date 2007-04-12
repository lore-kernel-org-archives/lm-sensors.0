From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
Date: Thu, 12 Apr 2007 12:26:55 +0000
Subject: Re: [lm-sensors] w83627hf hardware sharing
Message-Id: <461E258F.2080409@draigBrady.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070412121527.GA3132@sirena.org.uk>
In-Reply-To: <20070412121527.GA3132@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Mark Brown wrote:
> While looking at the w83627hf driver I noticed that there are currently
> two drivers in the kernel controlling these devices: w83627hf providing
> lm_sensors support and the w83627hf_wdt driver providing watchdog
> support.  Due to the hardware interface provided by the chip with many
> functions multiplexed via two registers this can't be done safely:
> concurrent access.  This is unlikely to happen at present but it is
> possible and I'm currently looking at an application which uses some
> additional functionality on the chip and would run into trouble much
> more readily.
>=20
> The most straightforward fix appears to be to provide a multiplexing
> driver for the chip.  Does this sound like a reasonable approach to
> take?  I'm particularly worried about the possible effects of changing
> the lm_sensors driver, causing the device to move in sysfs, though as
> far as I can tell current versions of lm-sensors should not be affected
> due to the sysfs class.
>=20

You're right.
Some work has been done wrt this, but I've not tried it:
http://marc.info/?l=3Dlinux-kernel&m=115821759424601&w=3D2

cheers,
P=E1draig.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
