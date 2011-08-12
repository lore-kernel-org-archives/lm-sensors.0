From: =?ISO-8859-1?Q?Jo=E3o_M=2E_S=2E_Silva?= <joao.m.santos.silva@gmail.com>
Date: Fri, 12 Aug 2011 11:06:07 +0000
Subject: [lm-sensors] lm_sensors: sensors output
Message-Id: <CAAv-bCz-NKoaLr3=L8_AkEg2fQyuadHrh=kQax89_bu3H-mUxg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

When I type "sensors", I get:

acpitz-virtual-0
Adapter: Virtual device
temp1:        +51.0=B0C  (crit =3D +105.0=B0C)

and nothing else. I can't seem to get the chipset info.

"sensors-detect" detected:

(...)
Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `it87':
  * ISA bus, address 0x290
    Chip `ITE IT8705F Super IO Sensors' (confidence: 9)

Do you want to generate /etc/conf.d/lm_sensors? (YES/no):
You should now start the lm_sensors service to load the required
kernel modules.

Unloading i2c-dev... OK
Unloading cpuid... OK
(...)

Why doesn't "sensors" print it87-related info?

I don't know if it is related, but sometimes the temperature gets very
high (I notice it with my fingers) and I have to reboot; then the fan
runs at full speed for about 2 min to cool the CPU.

Any help?

--=20
Jo=E3o M. S. Silva

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
