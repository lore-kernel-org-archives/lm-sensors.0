From: ACCART Julien <bigjulius@free.fr>
Date: Tue, 15 May 2012 19:20:42 +0000
Subject: Re: [lm-sensors] asus_atk0110 doesn't work on motherboard P8B WS
Message-Id: <4FB2AC8A.9060505@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FAAF8EA.3070202@free.fr>
In-Reply-To: <4FAAF8EA.3070202@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Le 14/05/2012 20:57, Jean Delvare a =E9crit :
> On Mon, 14 May 2012 20:44:08 +0200, ACCART Julien wrote:
>> The BIOS of this motherboard can display CPU and M/B temp, voltage, fan
>> speed.
>> Do you think we can use the asus wmi modules to read these data?
>> How can I help?
> Did you try just running sensors-detect and loading the proper drivers?
> Who knows, this may just work. If not, booting with
> acpi_enforce_resources=3Dlax might be a workaround if you can live with
> the risk.
>

Yes I did.
In kernel 3, loading the w83627ehf fails because of conflicts with ACPI.=20
I tried the acp_enforce_resources=3Dlax but I had freezes. It is useless=20
to have the module loading ability if system freezes

So, I'm back to 2.6.39 which lets me load w83627ehf module.

I wanted the atk (or wmi) because of two reasons :
1 - w83627ehf doesn't work with kernel 3 and lax acpi resource freezes=20
my system as I said
2 - mesures with atk or wmi are reliable but are messed up with=20
w83627ehf module
For example :

$ sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +33.0 C  (high =3D +82.0 C, crit =3D +102.0 C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +29.0 C  (high =3D +82.0 C, crit =3D +102.0 C)

nct6776-isa-0290
Adapter: ISA adapter
in0:          +0.90 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:          +1.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in2:          +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in3:          +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in4:          +1.01 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in5:          +2.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in7:          +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in8:          +3.33 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
fan1:         967 RPM  (min =3D    0 RPM)  ALARM
fan2:        1045 RPM  (min =3D    0 RPM)  ALARM
fan3:           0 RPM  (min =3D    0 RPM)  ALARM
fan4:        1086 RPM  (min =3D    0 RPM)  ALARM
fan5:           0 RPM  (min =3D    0 RPM)  ALARM
SYSTIN:       +29.0 C  (high =3D  +0.0 C, hyst =3D  +0.0 C)  ALARM  sensor =
=3D=20
thermistor
CPUTIN:       +91.5 C  (high =3D +58.5 C, hyst =3D +53.5 C)  ALARM  sensor =
=3D=20
thermistor
AUXTIN:       +26.0 C  (high =3D +80.0 C, hyst =3D +75.0 C)  sensor =3D the=
rmistor
PECI Agent 0: +19.5 C
cpu0_vid:    +2.050 V


Coretemp says 30 C  while w83627ehf says 91.5.
min and max are not set in both temp, voltage and RPM.

--=20
Julien


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
