From: "lists@givemefish.com" <lists@givemefish.com>
Date: Wed, 26 Mar 2008 13:40:05 +0000
Subject: Re: [lm-sensors] Strange temperature values
Message-Id: <47EA5235.7070005@givemefish.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <47DFA4D2.1060009@givemefish.com>
In-Reply-To: <47DFA4D2.1060009@givemefish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Matt Roberds wrote:

> On Tue, 18 Mar 2008, xxx@givemefish.com wrote:
>> However, the sensor values that we see are very strange.  They are
>> all positive values, but they range from 0 to 2500 C.
>=20
> There was some recent discussion about updating some of the drivers to
> deal with hardware that reports values with 0.001 deg C resolution
> rather than the more common 0.1 deg C resolution.  I am not sure but I
> think some Intel boards were affected by this.  In other words, dividing
> your reported temperatures by 100 may give you the actual values.
>=20
>> temp1:     +71.0=B0C  (high =3D   +50=B0C, hyst =3D    +0=B0C)
> 0.71 C (probably not connected)
>=20
>> temp2:      +0.0=B0C  (high =3D   +50=B0C, hyst =3D    +0=B0C)
>> temp3:      +0.0=B0C  (high =3D    +0=B0C, hyst =3D    +2=B0C)
> 0 C (probably not connected)

Matt,

thanks for the idea.  Our server is in an air-conditioned room, so those
values do seem realistic.

Would the 100x difference be scaled in the /etc/sensors.conf file?

Also, why would some of the cores not be connected or registering a
temperature (the temps 1-3 above)?  Is there a way to "turn on" these
readings?

Matthew.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
