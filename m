From: Thomas Mitterfellner <thomas.mitterfellner@gmail.com>
Date: Sat, 30 Nov 2013 11:37:15 +0000
Subject: Re: [lm-sensors] How can temp_crit for virtual device be set?
Message-Id: <5299CDEB.9040502@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5297B848.4080906@gmail.com>
In-Reply-To: <5297B848.4080906@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

>> So, how can I adjust the temp_crit1 value of the acpitz-virtual-0 device?
>=20
> You can't, thermal zones are read-only at least through the hwmon
> interface. If anything can be done, this is through ACPI.

Just for reference: I asked at the linux-acpi list and they advised me
to add termal.crt=3D<value> to the kernel boot paramters, which I did
(<value>=99) and it actually sets the temperature of the virtual device.

Now I get:

# acpi -V
Thermal 0: ok, 64.0 degrees C
Thermal 0: trip point 0 switches to mode critical at temperature 99.0
degrees C
Thermal 0: trip point 1 switches to mode passive at temperature 105.0
degrees C

and

acpitz-virtual-0
Adapter: Virtual device
temp1:
  temp1_input: 66.000
  temp1_crit: 99.000

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:
  temp1_input: 66.000
  temp1_max: 86.000
  temp1_crit: 100.000
  temp1_crit_alarm: 0.000
Core 0:
  temp2_input: 63.000
  temp2_max: 86.000
  temp2_crit: 100.000
  temp2_crit_alarm: 0.000
Core 1:
  temp3_input: 66.000
  temp3_max: 86.000
  temp3_crit: 100.000
  temp3_crit_alarm: 0.000

pkg-temp-0-virtual-0
Adapter: Virtual device
temp1:
  temp1_input: 67.000


Thanks for your hints,

Thomas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
