From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 10 Oct 2006 10:21:22 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <20061010122122.21c41059.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hallo Michael,

> Jean Delvare wrote:
> > Is the attached version any better? I had forgotten to create the
> > "name" attribute file, and libsensors needs it. This is fixed now,
> > hopefully this is all that was missing.
>
> Yeah, it seems 2b perfect like this - thank you very much for your effort!

Thanks for testing :)

> [root at matrix PC87427-platform-driver]# sensors
> pc87427-isa-0840
> Adapter: ISA adapter
> case-fan1:3698 RPM  (min =3D 2000 RPM)
> case-fan2:3400 RPM  (min =3D 2000 RPM)
> case-fan3:3400 RPM  (min =3D 2000 RPM)
> case-fan4:3375 RPM  (min =3D 2000 RPM)
> CPU0-fan: 3075 RPM  (min =3D 2000 RPM)
> CPU1-fan: 2934 RPM  (min =3D 2000 RPM)

Looks alright. Did you try unloading and reloading the driver a couple
time? If everything works OK for you I'll push the driver into -mm
soon, so that it can receive wider testing.

> [root at matrix PC87427-platform-driver]# dmesg | tail -n 8
> pc87427: readall_fan: data=FFff88003f09e540, nr=3D0
> pc87427: readall_fan: data=FFff88003f09e540, nr=3D1
> pc87427: readall_fan: data=FFff88003f09e540, nr=3D2
> pc87427: readall_fan: data=FFff88003f09e540, nr=3D3
> pc87427: readall_fan: data=FFff88003f09e540, nr=3D4
> pc87427: readall_fan: data=FFff88003f09e540, nr=3D5
> pc87427: readall_fan: data=FFff88003f09e540, nr=3D6
> pc87427: readall_fan: data=FFff88003f09e540, nr=3D7

These are temporary debugging messages which I put in there to
investigate an older bug, which of course never happened again. You can
get rid of them by removing -DDEBUG in the Makefile and building the
driver again. You can also replace -g with -O2 for faster and smaller
code.

Thanks,
--=20
Jean Delvare

