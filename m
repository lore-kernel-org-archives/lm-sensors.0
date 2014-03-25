From: Martin Herrholz <martin@rzschernsdorf.de>
Date: Tue, 25 Mar 2014 11:57:38 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (it87) Add support for IT8623E
Message-Id: <53316F32.90601@rzschernsdorf.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1354475868-10032-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1354475868-10032-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

it works. I didn't thought about trying out "sensors" without the chip=20
being found by sensors-detect. Its properly detected with the updated=20
sensors-detect as well.

Here is the output of sensors:

Before:

martin@computername ~/it87 $ sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:         +4.5=B0C  (high =3D +70.0=B0C)
                        (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)

Now:

martin@computername ~/it87 $ sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:         +5.0=B0C  (high =3D +70.0=B0C)
                        (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)

it8603-isa-0290
Adapter: ISA adapter
in0:          +0.85 V  (min =3D  +1.21 V, max =3D  +0.78 V)  ALARM
in1:          +1.63 V  (min =3D  +0.86 V, max =3D  +1.52 V)  ALARM
in2:          +2.04 V  (min =3D  +1.97 V, max =3D  +0.38 V)  ALARM
in3:          +2.02 V  (min =3D  +0.47 V, max =3D  +0.02 V)  ALARM
in4:          +1.24 V  (min =3D  +0.43 V, max =3D  +0.14 V)  ALARM
3VSB:         +3.34 V  (min =3D  +1.87 V, max =3D  +1.54 V)  ALARM
Vbat:         +3.24 V
+3.3V:        +3.38 V
fan1:        1066 RPM  (min =3D  200 RPM)
fan2:           0 RPM  (min =3D  602 RPM)  ALARM
temp1:        +34.0=B0C  (low  =3D +116.0=B0C, high =3D +32.0=B0C)  ALARM s=
ensor =3D=20
thermistor
temp2:        +33.0=B0C  (low  =3D +99.0=B0C, high =3D  +0.0=B0C)  ALARM se=
nsor =3D=20
thermistor
temp3:       -128.0=B0C  (low  =3D -30.0=B0C, high =3D -80.0=B0C)  sensor =
=3D thermistor
intrusion0:  OK

And sensors-detect:

...

Found `ITE IT8623E Super IO Sensors' Success!
     (address 0x290, driver `it87')

...

Driver `it87':
   * ISA bus, address 0x290
     Chip `ITE IT8623E Super IO Sensors' (confidence: 9)

Thank you all for your help.

Best Regards
Martin


On 25.03.2014 12:36, Jean Delvare wrote:
> Hi Martin,
>
> On Tue, 25 Mar 2014 11:12:46 +0100, Martin Herrholz wrote:
>> i did install the module like mentioned in your linked Instructions and
>> redone the sensors-detect.
>> I still get the same result:
>>
>> Trying family `ITE'...                                      Yes
>> Found unknown chip with ID 0x8623
>>       (logical device 4 has address 0x290, could be sensors)
> This is expected, sensors-detect has its own detection code which is
> independent from the installed drivers. You can try the latest version
> at:
>    http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>
> which should detect your chip properly.
>
>> I had no it87 module installed prior to it, so i had nothing to remove.
>> The module compiles/loads without errors.
> Great. But does it work? What does "sensors" say?
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
