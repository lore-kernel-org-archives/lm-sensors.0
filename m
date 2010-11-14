From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 14 Nov 2010 15:38:55 +0000
Subject: Re: [lm-sensors] Discrepancy between reported readings from
Message-Id: <20101114163855.0c3cc96c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
In-Reply-To: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Arun,

Please keep the list Cc'd.

On Sat, 13 Nov 2010 18:45:16 -0500, Arun Raghavan wrote:
> I recompiled with HZ/10 and I still can't see any resolution when the
> temperature begins to rise - here are two consecutive readings 100ms
> apart:
>=20
> 0: +29.0=B0C 1: +24.0=B0C 2: +24.0=B0C 8: +27.0=B0C 9: +19.0=B0C 10: +26.=
0=B0C
> <Begin execution>
> 0: +35.0=B0C 1: +29.0=B0C 2: +27.0=B0C 8: +35.0=B0C 9: +30.0=B0C 10: +36.=
0=B0C
>=20
> Any further suggestions?

You could try HZ/100, just for testing. What's your test protocol, BTW?
I'll try doing my own tests.

Now it is entirely possible that the sensor itself (or the MSR
interface thereto) has latency/caching. Maybe the information is
available in Intel's documents (but I really don't have the time to
look for it) or maybe you have to ask Intel about the technical details
- not sure if they want to share on this though.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
