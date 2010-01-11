From: Huaxu Wan <huaxu.wan@linux.intel.com>
Date: Mon, 11 Jan 2010 06:17:06 +0000
Subject: Re: [lm-sensors] hwmon: (coretemp) Check the sensor existence
Message-Id: <20100111061706.GB6031@owl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100108160144.GA23650@owl>
In-Reply-To: <20100108160144.GA23650@owl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 19:14 Fri 08 Jan, Jean Delvare wrote:
> On Sat, 9 Jan 2010 00:01:44 +0800, Huaxu Wan wrote:
> > It's quote from page 612 of Software Developer=E2=80=99s Manual V3A[1](=
14.5.5 On
> > Die Digital Thermal Sensors). Look from the history, I think it's
> > compatible with Core/Core2/Atom and even the feature CPU. Actually, this
> > patch has tested on old P4, Core2, i3(launched today?) system, all works
> > as expected.
> >=20
> > [1] http://www.intel.com/Assets/PDF/manual/253668.pdf
>=20
> $ wget http://www.intel.com/Assets/PDF/manual/253668.pdf
> --2010-01-08 19:05:33--  http://www.intel.com/Assets/PDF/manual/253668.pdf
> Resolving www.intel.com... 88.221.93.91, 88.221.93.112
> Connecting to www.intel.com|88.221.93.91|:80... connected.
> HTTP request sent, awaiting response... 403 Forbidden
> 2010-01-08 19:05:33 ERROR 403: Forbidden.
> $=20

I can access the above link at external, I don't know why. Try the link:
http://www.intel.com/products/processor/manuals/ or google "253668.pdf".

--=20
Thanks
Huaxu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
