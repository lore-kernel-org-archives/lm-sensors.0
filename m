From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 09 Apr 2007 19:56:31 +0000
Subject: Re: [lm-sensors] dynamic chip support in libsensors + generic chip
Message-Id: <461A9EAE.3010601@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <461A59D4.2050409@hhs.nl>
In-Reply-To: <461A59D4.2050409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Bob Schl=E4rmann wrote:
> On Mon, 09 Apr 2007 17:20:52 +0200
> Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
>=20
>> ...
>> So please test this:
>> 1) checkout the 3.0.0 branch:
>>     svn checkout
>> http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0 2)
>> comment the entries for your chips int he table at the end of
>> lib/chips.c and in the table near the end of progs/sensors/main.c 3)
> Note that this isn't needed if you give sensors the -g argument. This
> forces sensors to use the generic printing routines.
>=20

Yes, the removal from progs/sensors/main.c isn't really necessary to test t=
he=20
generic printing routines, that can be done with -g too. However the remova=
l /=20
commenting from lib/chips.c _really_ is necessary to test the dynamic chip =
support.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
