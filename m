From: David Brownell <david-b@pacbell.net>
Date: Mon, 09 Jun 2008 05:07:32 +0000
Subject: Re: [lm-sensors] [patch 2.6.26-rc1] lm75: sensor reading bugfix
Message-Id: <200806082207.32631.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805031919.17110.david-b@pacbell.net>
In-Reply-To: <200805031919.17110.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sunday 08 June 2008, Mark M. Hoffman wrote:
> Applied to hwmon-2.6.git/testing, thanks.
>=20
> Hrm, I missed this one on the first pass through my queue when I picked
> up your other lm75 patches. =A0Looks like it's severe enough to warrant
> sending to Linus before 2.6.26 (along with the prerequisite cleanup patch=
).
>=20
> Any objections?

I'd not object if any of them were sent upstream. :)

FYI my comment about "goes on top of cleanup" was mostly
to reflect the fact that I didn't test any other sequence.

If it applies in another order for you, fine.  Though as
a general policy, I'd be glad to see that cleanup patch
upstream before its one year anniversary [0] passes!

- Dave

[0] http://marc.info/?l=3Dlm-sensors&m=119069752322212&w=3D2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
