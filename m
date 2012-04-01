From: Alex Atkin <alexatkin@csdprojects.co.uk>
Date: Sun, 01 Apr 2012 16:42:30 +0000
Subject: [lm-sensors] Gigabyte H67N-USB3-B3 missing voltage sensors
Message-Id: <4F788576.9030705@csdprojects.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have a Gigabyte H67N-USB3-B3 motherboard and am having some problems=20
getting lm_sensors to work fully on it.

I downloaded the driver and the latest sensors-detect from the=20
lm_sensors website to ensure I had the latest version.
sensors-detect reports:

Trying family `ITE'...                                      Yes
Found `ITE IT8728F Super IO Sensors'                        Success!
     (address 0x290, driver `it87')

However it still doesn't load automatically on boot and a manual=20
"modprobe it87" reveals:

FATAL: Error inserting it87=20
(/lib/modules/3.1.6-server-69mib/kernel/drivers/hwmon/it87.ko.gz): No=20
such device

So I found a note somewhere that "modprobe it87 force_id=3D0x8721" forces=20
it to work, but then I get the following from sensors:

it8721-isa-0290
Adapter: ISA adapter
in0:          +1.04 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in1:          +0.14 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in2:          +2.89 V  (min =3D  +0.00 V, max =3D  +3.06 V)
+3.3V:        +3.31 V  (min =3D  +0.00 V, max =3D  +6.12 V)
in4:          +0.02 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in5:          +1.01 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in6:          +1.54 V  (min =3D  +0.00 V, max =3D  +3.06 V)
3VSB:         +3.38 V  (min =3D  +0.00 V, max =3D  +6.12 V)
Vbat:         +3.17 V
fan1:        1198 RPM  (min =3D    0 RPM)
fan2:         896 RPM  (min =3D    0 RPM)
temp1:        +43.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
thermistor
temp2:        +45.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
thermistor
temp3:        +31.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
thermistor
intrusion0:  ALARM

The problem is that I am not getting any output for +12V, +5V or +5VSB,=20
which are the main reason I want to use the monitoring.

I am also not sure how to identify which of the above is the VCore (I=20
suspect its in0), although that is less important to me.

Do you have any suggestions/fixes?

Alex.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
