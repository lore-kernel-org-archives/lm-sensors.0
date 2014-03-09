From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 09 Mar 2014 10:50:31 +0000
Subject: Re: [lm-sensors] Unsupported Mobo Driver
Message-Id: <20140309115031.0f84afbc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAPgPpwTJKhVA=p+pX_SrBKev4o=cjcEjV3=OS7jmRt-EY6txg@mail.gmail.com>
In-Reply-To: <CAAPgPpwTJKhVA=p+pX_SrBKev4o=cjcEjV3=OS7jmRt-EY6txg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Howard,

Please keep the list in Cc, and don't top-post.

On Fri, 7 Mar 2014 20:59:53 -0800, Howard Nguyen wrote:
> Hi Jean, thanks for the quick reply!
>=20
> *sensors (w/ -10 offsest):*
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +36.0=B0C  (crit =3D +94.0=B0C)
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +37.0=B0C  (high =3D +77.0=B0C, crit =3D +95.0=B0C)
> Core 0:         +36.0=B0C  (high =3D +77.0=B0C, crit =3D +95.0=B0C)
> Core 1:         +35.0=B0C  (high =3D +77.0=B0C, crit =3D +95.0=B0C)
>=20
> *sensors -c /dev/null:*
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +47.0=B0C  (crit =3D +104.0=B0C)
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +47.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
> Core 0:         +46.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
> Core 1:         +45.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
>=20
>=20
> *custom config:*
>=20
> chip "acpitz-virtual-0"
> label temp1 "temp1"
>  compute temp1 @-10, @-10
>=20
> chip "coretemp-isa-0000"
> label temp1 "Physical id 0"
>  compute temp1 @-10, @-10
>=20
> label temp2 "Core 0"
> compute temp2 @-10, @-10
>=20
> label temp3 "Core 1"
> compute temp3 @-10, @-10
>=20
> acpi -v (unaffected by offset):
> Thermal 0: ok, 45.0 degrees C
>=20
> *Other*
> This is within 2 mins of boot up. Usually it boots and its in the 48-53 C
> range. I used to run Windows and it was in the 38-42 range. After I wiped
> Windows, I've had issues with the fan going off every 30-60 seconds.
> I'm *assuming
> *this is caused by bad temp readings.

Even if it was caused by bad temperature readings, adding offsets to
your libsensors configuration file isn't going to help. The offset only
changes what you see as a user. The ACPI subsystem only sees the
original reading.

> I already tried reading up on
> fancontrol and pwmconfig but neither seem to work.

It almost never works on laptops so I'm not surprised.

> Again thanks the help. Sorry in advance if I'm doing something stupid /
> being completely ignorant.

I would guess that your laptop has issues with cpufreq, or cpuidle, or
ACPI. The higher temperatures would be a symptom of improper power
management.

That being said, it is also possible that whatever Windows tool you
were using for monitoring, was returning temperatures with an offset
applied for whatever reason. In my experience it is more reliable to
compare power consumption and autonomy on battery, because these are
external measurements which do not lie. But if you no longer have
Windows on that laptop, you no longer can do that, unfortunately.

So, we can't actually help you on this list. You'll have to ask on
linux-pm and/or linux-acpi. Things you can check first so that you can
provide the information they'll inevitably ask for:

1* Is cpufreq working? Check the CPU frequency in /proc/cpuinfo when
idle, and the "Frequency stats" tab in powertop. The CPU should spend
most time in lowest frequency when the laptop is idle. If that's not
the case, report to linux-pm.

2* Is cpuidle working? Check for cpuidle-related messages in the kernel
log, and the "Idle stats" tab in powertop. The CPU should spend most
time in the deepest C state when the laptop is idle. If that's not the
case, report to linux-pm.

If both items above look right, it's most probably an ACPI issue, so
report to linux-acpi.

Good luck,
--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
