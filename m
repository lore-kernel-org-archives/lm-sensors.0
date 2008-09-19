From: "Hector Lahoz" <hectorlahoz@gmail.com>
Date: Fri, 19 Sep 2008 22:11:33 +0000
Subject: [lm-sensors] lost alarms with it87
Message-Id: <efa7127e0809191511q36658c1bse469db9d76e46127@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi
Ok, we won't use interrupts. Now, I'd like to have some kind of signal
that warns about CPU going above max temperature. For example, through
sensord. But the problem is that some seconds after the alarm is
triggered the ALARM message of sensors does not appear any more.
Shouldn't the alarm bit remain set until it is read? And if it's only
read by show_* functions (i.e. it87_update_device() ), why does it go
away?
The result is that the alarm is lost. Am I doing any false assumption
or is my chip not following the specification?

I've done a simple experiment to demonstrate this: First I ran sensors
every 5 seconds and then every 1 second:

# while [ 1 ]; do sensors | grep ^CPU; sleep 5; done

CPU Temp:    +28.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +29.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +30.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +31.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +31.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +31.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +32.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +32.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +32.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +33.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +33.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +33.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +34.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +34.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +34.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +35.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode

# while [ 1 ]; do sensors | grep ^CPU; sleep 1; done

(for clarity I've compressed the output by placing a multiplier at the
end meaning the number of identical lines)

CPU Temp:    +28.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +28.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor =
=3D thermal diode
CPU Temp:    +29.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor th=
ermal diode   *6
CPU Temp:    +30.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor th=
ermal diode   *8
CPU Temp:    +31.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor th=
ermal diode   *10
CPU Temp:    +32.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor th=
ermal diode   *12
CPU Temp:    +33.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  ALARM  se=
nsor
=3D thermal diode
CPU Temp:    +33.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  ALARM  se=
nsor
=3D thermal diode
CPU Temp:    +33.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor th=
ermal diode   *10
CPU Temp:    +34.0=B0C  (low  =3D +29.0=B0C, high =3D +33.0=B0C)  sensor th=
ermal diode   *3

As you can see, I took care to reach the hysteresis temperature (29 deg)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
