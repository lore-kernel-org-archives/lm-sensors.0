From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 09 Mar 2014 09:13:41 +0000
Subject: Re: [lm-sensors] Sensors configuration for ASRock G41C-GS
Message-Id: <20140309101341.6aa7e056@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392823661.17478.YahooMailNeo@web160502.mail.bf1.yahoo.com>
In-Reply-To: <1392823661.17478.YahooMailNeo@web160502.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 24 Feb 2014 14:13:58 -0800 (PST), ianp wrote:
> Hi Jean,
>=20
>=20
> I wish to submit some corrections regarding this configuration.
>=20
>=20
> ### Fans
>=20
> =A0=A0 ### Ignore fan4 and fan5. There are
> =A0=A0 ### only 3 fan connectors on this board.
>=20
> =A0=A0 label=A0 fan1=A0 "POW Fan"=A0=A0=A0=A0=A0=A0 # was incorrectly lab=
eled "CHA Fan"
> =A0=A0 label=A0 fan2=A0 "CPU Fan"
> =A0=A0 label=A0 fan3=A0 "CHA Fan"=A0=A0=A0=A0=A0=A0 # was incorrectly lab=
eled "PSU Fan"
> =A0=A0 ignore fan4
> =A0=A0 ignore fan5
>=20
>=20
> I was able to verify this after having acquired a fan that provided speed=
 monitoring. I have changed "PSU Fan" to "POW Fan" so that it matches the l=
abeling on the motherboard as well, which is POWER_FAN.

Sorry for the delay. Your reply landed in my spam box, which for some
reason was no longer subscribed so I didn't see it.

I just updated the wiki with the change above, thanks.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
