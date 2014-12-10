From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 10 Dec 2014 18:25:59 +0000
Subject: Re: [lm-sensors] Is w83627ehf driver working with lm-sensors?
Message-Id: <20141210182559.GC2821@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <003a01d01492$fe2458c0$fa6d0a40$@es>
In-Reply-To: <003a01d01492$fe2458c0$fa6d0a40$@es>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Dec 10, 2014 at 05:04:35PM +0100, Pablo Jose Royo wrote:
> Hi
>=20
> I have a Nexcom vehicular console running Ubuntu 14.04 LTS (x86_64) with
> voltage monitoring enabled in BIOS. I=B4m using both 3.13.0-32 and 3.13.1=
1.10
> x86_64 kernels, with winbond w83627ehf driver (loaded using modprobe
> force_id=3D0x8850)=20
>=20
> I need to check when input voltage is low in order to shutdown the system=
 in
> proper way. Using lm-sensors from the distribution, or from last source, i
> always see same values in all voltage sensors (Vcc, CPU,..etc) . I mean,
> there is no CHANGE in it when I vary input voltage from a variable power
> supply (with constant current limit to emulate a battery). My
> /etc/sensor3.conf is Ok for this chip. Temperature sensors seem to work w=
ith
> this driver (and with coretemp).=20
>=20
> Do you know if lm-sensors works with this driver? What more could I check?
> In sources, I see last date shown is 2012, so it seems quite recent.
>=20

Since you specify force_id, the chip in your system is obviously not one
supported by the driver. So, no, you can not assume that it is working at a=
ll.

Maybe you could help us by letting us know what chip you actually have in y=
our
system. Running sensors-detect might give you a hint. Unfortunately the Nex=
com
datasheets don't say.

In general, the voltages supported and measured by the SuperIO chip are reg=
ulated
by circuitry on the board. Modifying the board input voltage doesn't necess=
arily
mean that you see any change in a regulated voltage, and the SuperIO chip
very likely reports only regulated voltages. You would have to get detailed
technical information to know if it reports any unregulated voltages, or if
there is some other chip on the board which reports those voltages. Most
likely you would have to ask the board vendor to give you that information.

Hope this helps,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
