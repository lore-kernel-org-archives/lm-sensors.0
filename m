From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 21 Jul 2010 01:40:17 +0000
Subject: Re: [lm-sensors] W83667HG-B testing
Message-Id: <20100721014017.GA29955@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C42ED6C.9030903@preclik.de>
In-Reply-To: <4C42ED6C.9030903@preclik.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Jul 20, 2010 at 04:51:04PM -0400, Jean Delvare wrote:
> On Tue, 20 Jul 2010 13:41:42 -0700, Guenter Roeck wrote:
> > On Tue, 2010-07-20 at 02:54 -0400, Jean Delvare wrote:
> > > On Mon, 19 Jul 2010 18:24:16 -0700, Guenter Roeck wrote:
> > > > On Sun, Jul 18, 2010 at 08:02:52AM -0400, Tobias Preclik wrote:
> > > > > Hi,
> > > > >=20
> > > > > my Zotac board H55-ITX features the W83667HG-B chip. I downloaded=
 and
> > > > > compiled the standalone kernel module today. Here's the sensors o=
utput:
> > > > >=20
> > > > > The module loads fine:
> > > > >=20
> > > > > # modprobe w83627ehf
> > > > > # tail -n 1 /var/log/messages
> > > > > Jul 18 13:42:58 leela kernel: [50378.028634] w83627ehf: Found W83=
667HG-B
> > > > > chip at 0xa10
> > > > > # sensors
> > > > > w83667hg-isa-0a10
> > > > > Adapter: ISA adapter
> > > > > in0:         +0.98 V  (min =3D  +0.00 V, max =3D  +1.74 V) =20
> > > > > in1:         +1.11 V  (min =3D  +0.10 V, max =3D  +0.20 V)   ALARM
> > > > > in2:         +3.36 V  (min =3D  +3.95 V, max =3D  +3.28 V)   ALARM
> > > > > in3:         +3.36 V  (min =3D  +1.57 V, max =3D  +2.10 V)   ALARM
> > > > > in4:         +1.10 V  (min =3D  +1.74 V, max =3D  +1.87 V)   ALARM
> > > > > in5:         +1.18 V  (min =3D  +1.02 V, max =3D  +1.30 V) =20
> > > > > in7:         +3.28 V  (min =3D  +3.23 V, max =3D  +2.62 V)   ALARM
> > > > > in8:         +3.34 V  (min =3D  +3.18 V, max =3D  +0.05 V)   ALARM
> > > > > fan1:          0 RPM  (min =3D 3515 RPM, div =3D 128)  ALARM
> > > > > fan2:       1022 RPM  (min =3D 1638 RPM, div =3D 8)  ALARM
> > > > > fan3:          0 RPM  (min =3D  958 RPM, div =3D 128)  ALARM
> > > > > fan4:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> > > > > fan5:          0 RPM  (min =3D 3515 RPM, div =3D 128)  ALARM
> > > > > temp1:       +30.0=B0C  (high =3D -56.0=B0C, hyst =3D -17.0=B0C) =
 ALARM  sensor > > > > > thermistor
> > > > > temp2:       +41.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =
 sensor =3D thermistor
> > > > > temp3:        -3.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =
 sensor =3D thermistor
> > > > > cpu0_vid:   +0.000 V
> > > > >=20
> > > > Actual values look mostly good, but the limits are really off.
> > > > Difficult to say, though, if those are wrong readings or just badly=
 configured.
> > > >=20
> > > > Jean, any idea/thoughts ?
> > >=20
> > > Only a register dump would say from sure. But given that the alarm
> > > flags all match out-of-limit readings, I would be inclined to say the=
se
> > > are only misonconfigured limits. Tobias could set proper limits and
> > > check that all the alarms go away.
> > >=20
> > > The only inconsistency is with temp3... the reading is out of limit b=
ut
> > > there is no alarm flag. You may want to double check the datasheet to
> > > ensure that the driver reads both the temp3 value and its alarm flag
> > > from the right register/bit.
> > >=20
> > I checked the specification. Registers are the same for both chips,
> > unless I am missing something. No idea what is going on.
>=20
> I seem to remember that on some of these chips, in6 and temp3 are
> mutually exclusive? So you may have to check all the configuration
> registers which determine which of in6 or temp3 is enabled. Maybe in6
> is enabled and the driver wrongfully think temp3 is instead?
>=20
> Just a random idea, I may be completely off the track.
>=20
I did some research on the web. Looks like temp3 almost always shows
very low temperatures for the W83667, and also for w83627ehf. Also, since
the reading is low, but there is no low limit, there isn't really a reason
for raising an alarm.=20

Also, min/max values for voltages seem to be off almost everywhere.
And values for temp1_max and temp1_hyst are often negative or very low.

So, in summry, looks like -B support is just as good or as bad as support
for the other chips. Not sure if that is good or bad, though, since the=20
off-track readings are so common.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
