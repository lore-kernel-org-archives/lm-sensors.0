From: Stefan Monnier <monnier@iro.umontreal.ca>
Date: Fri, 02 Mar 2012 20:27:57 +0000
Subject: Re: [lm-sensors] Interpreting lm-sensors's output
Message-Id: <jwvehtag3nm.fsf-monnier+INBOX@gnu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <jwv1upbxcso.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
In-Reply-To: <jwv1upbxcso.fsf-monnier+gmane.linux.drivers.sensors@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

>> OT1H the "high=3D70" and "crit=3D100" would seem to give me the answer, =
but
>> OTOH I don't know whether I can trust them (actually, I hope some of
>> the output is "wrong" since the sensor readings go up routinely to 80=B0
>> during long compilations).
> They are correct and you should trust them.  If you reach 80=B0C then you
> probably need better thermal dissipation or a different CPU / graphics
> power management strategy.

The thing that puzzles me is that this low-power mini-ITX board (fanless
Brazos E350) is in a full-size ATX chassis (Antec Sonata) which
previously held an high-power Athlon X2 board (first with the stock
AMD heatsink+fan, and then later with a monster fanless heatsink), so
I have a hard time understanding how this low-power board can heat up
worse than the other one in the exact same context (same chassis,
power-supply, devices, system fan spinning at the same speed, ...).
The Athlon X2 barely reached 70=B0C in the hottest part of the summer,
under full load.

> BTW, you may have other (unsupported) sensors on the board... Give a
> try to http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
> and report the full output.

OK, I finally added "acpi_enforce_resources=3Dlax" and loaded the it87
module, which does give me a bit more data:

   k10temp-pci-00c3
   Adapter: PCI adapter
   temp1:        +51.6=B0C  (high =3D +70.0=B0C)
                          (crit =3D +100.0=B0C, hyst =3D +97.0=B0C)
  =20
   radeon-pci-0008
   Adapter: PCI adapter
   temp1:        +52.0=B0C
  =20
   it8721-isa-0a00
   Adapter: ISA adapter
   in0:          +3.06 V  (min =3D  +1.46 V, max =3D  +1.98 V)  ALARM
   in1:          +1.07 V  (min =3D  +0.00 V, max =3D  +1.52 V)
   in2:          +2.23 V  (min =3D  +0.00 V, max =3D  +1.52 V)  ALARM
   in3:          +0.01 V  (min =3D  +0.00 V, max =3D  +1.52 V)
   in4:          +1.02 V  (min =3D  +1.09 V, max =3D  +0.83 V)  ALARM
   in5:          +1.52 V  (min =3D  +1.31 V, max =3D  +0.78 V)  ALARM
   in6:          +1.12 V  (min =3D  +1.69 V, max =3D  +2.69 V)  ALARM
   3VSB:         +3.26 V  (min =3D  +0.00 V, max =3D  +3.05 V)  ALARM
   Vbat:         +3.24 V =20
   fan1:           0 RPM  (min =3D   20 RPM)  ALARM
   fan2:           0 RPM  (min =3D   20 RPM)  ALARM
   temp1:        +30.0=B0C  (low  =3D  +0.0=B0C, high =3D +127.0=B0C)  sens=
or =3D thermal diode
   temp2:       -128.0=B0C  (low  =3D +13.0=B0C, high =3D -18.0=B0C)  senso=
r =3D disabled
   temp3:       -128.0=B0C  (low  =3D -67.0=B0C, high =3D  -3.0=B0C)  senso=
r =3D disabled
   intrusion0:  ALARM

So I guess the it87 "temp1" is a "motherboard" sensor.  This one always
stays much lower than the other two sensors.


        Stefan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
