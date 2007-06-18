From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Date: Mon, 18 Jun 2007 15:23:53 +0000
Subject: Re: [lm-sensors] Possible support for the SMSC SCH5317? (found on
Message-Id: <4676A389.50408@onelan.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <46711ACE.3070809@onelan.co.uk>
In-Reply-To: <46711ACE.3070809@onelan.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Simon Farnsworth wrote:
> sensors output:
>=20
> # sensors
> smsc47b397-isa-0480
> Adapter: ISA adapter
> temp1:       +44=B0C
> temp2:       +53=B0C
> temp3:       +26=B0C
> temp4:      -128=B0C
> fan1:     2011 RPM
> fan2:       82 RPM
> fan3:     1262 RPM
> fan4:     1095 RPM
>=20
> temp1 and temp2 both look likely for CPU, while temp3 might well be
> system temperature. temp4 is completely out, and I'm not sure how I'd
> relate the fan speeds to the fans in the system (I have a fan in the
> front, a CPU fan, and a fan in the PSU.

I've now experimented with cpuburn and stopping fans. It looks like 82
RPM is the lowest speed this chip reports, as stopping a fan briefly
caused it to report 82 RPM.

I've determined that on my HP dc7700, temp1 is CPU temperature, temp2
appears to be chipset temperature, and temp3 is system temperature.

fan1 is CPU, fan3 is PSU fan, and fan4 is the chassis fan on the front
of the box. fan2 and temp4 appear to be disconnected.
--=20
Hope this is of interest to someone,

Simon Farnsworth


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
