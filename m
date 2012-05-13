From: Ben Kamen <bkamen@benjammin.net>
Date: Sun, 13 May 2012 23:57:36 +0000
Subject: Re: [lm-sensors] Supermicro X7SPA-HF: in4 ALARM
Message-Id: <4FB04A70.2080303@benjammin.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <01fa01cd1430$fed0b990$fc722cb0$@lucidpixels.com>
In-Reply-To: <01fa01cd1430$fed0b990$fc722cb0$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Ok, after looking around some more -- I should be talking though ipmisensor=
s and not directly communicating with the w83627ehf directly.

it finds the ipmi interface:

> Found `IPMI BMC KCS' at 0xca2...                            Success!
>     (confidence 8, driver `ipmisensors')
>

but then tells me:
> Warning: the required module ipmisensors is not currently installed
> on your system. If it is built into the kernel then it's OK.
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> driver availability.

and I'm using the RHEL 6 released version of lm-sensors:

lm_sensors.x86_64	3.1.1-10.el6	@base


So where do I get ipmisensors? The wiki says I should use ipmitool -- but t=
hen how does that integrate?

Thanks,

  -Ben


On 05/13/12 5:30 PM, Ben Kamen wrote:
> Hey guys, in response to this email below from Jean,
>
> Can we still use lm_sensors on the winbond IC on the board or should lm_s=
ensors be disabled entirely?
>
> I'm also using an X7SPA-HF and the thermal management goes wonky after a =
few hours of normal operation.
>
> (temp alarm, fans report erroneous speeds and so forth)
>
> When this started happening, I began to wonder about contention between t=
he IPMI controller onboard and what linux might be trying to do at the same=
 time.
>
> Thanks,
>
> -Ben
>
>> On Fri, 6 Apr 2012 16:08:12 -0400, Justin Piszcz wrote:
>>> Hello,
>>>
>>> Was curious why the max voltage does not show up properly for in4 (VDIM=
M)
>>> for this X7SPA-HF using lm sensors 3.3.1 or 3.3.2?
>>>
>>> On the sensor reading page for IPMI:
>>> VDIMM Normal 1.84 Volts
>>
>> You should not mix IPMI with native Linux hardware monitoring driver.
>> There is no mutual exclusion on device access, and havoc can (and will)
>> happen.
>>
>>> This is with lm_sensors:
>>>
>>> --
>>>
>>> $ sensors
>>> w83627dhg-isa-0ca0
>>> Adapter: ISA adapter
>>> Vcore: +1.16 V (min =3D +0.72 V, max =3D +1.39 V)
>>> Vnbcore: +1.04 V (min =3D +0.94 V, max =3D +1.16 V)
>>> AVCC: +3.34 V (min =3D +2.98 V, max =3D +3.63 V)
>>> +3.3V: +3.34 V (min =3D +2.98 V, max =3D +3.63 V)
>>> VDIMM: +1.84 V (min =3D +1.62 V, max =3D +0.00 V) ALARM
>>> +5V: +1.25 V (min =3D +1.13 V, max =3D +1.38 V)
>>> +12V: +0.75 V (min =3D +0.67 V, max =3D +0.83 V)
>>> 3VSB: +3.30 V (min =3D +2.98 V, max =3D +3.63 V)
>>> Vbat: +3.06 V (min =3D +2.70 V, max =3D +3.30 V)
>>> SYS Temp: +42.0=B0C (high =3D +75.0=B0C, hyst =3D +70.0=B0C) sensor =3D=
 thermistor
>>> CPU Temp: +40.5=B0C (high =3D +90.0=B0C, hyst =3D +87.0=B0C) sensor =3D=
 diode
>>> Case Temp: +24.0=B0C (high =3D +80.0=B0C, hyst =3D +75.0=B0C) sensor =
=3D diode
>>> $ sensors --version
>>> sensors version 3.3.1 with libsensors version 3.3.1
>>>
>>> lm_sensors-3.3.2$ prog/sensors/sensors --version
>>> sensors version 3.3.2 with libsensors version 3.3.1
>>>
>>> w83627dhg-isa-0ca0
>>> Adapter: ISA adapter
>>> Vcore: +1.16 V (min =3D +0.72 V, max =3D +1.39 V)
>>> Vnbcore: +1.04 V (min =3D +0.94 V, max =3D +1.16 V)
>>> AVCC: +3.34 V (min =3D +2.98 V, max =3D +3.63 V)
>>> +3.3V: +3.34 V (min =3D +2.98 V, max =3D +3.63 V)
>>> VDIMM: +1.84 V (min =3D +1.62 V, max =3D +0.00 V) ALARM
>>> +5V: +1.25 V (min =3D +1.13 V, max =3D +1.38 V)
>>> +12V: +0.75 V (min =3D +0.67 V, max =3D +0.83 V)
>>> 3VSB: +3.30 V (min =3D +2.98 V, max =3D +3.63 V)
>>> Vbat: +3.06 V (min =3D +2.70 V, max =3D +3.30 V)
>>> SYS Temp: +42.0=B0C (high =3D +75.0=B0C, hyst =3D +70.0=B0C) sensor =3D=
 thermistor
>>> CPU Temp: +40.5=B0C (high =3D +90.0=B0C, hyst =3D +87.0=B0C) sensor =3D=
 CPU diode
>>> Case Temp: +24.5=B0C (high =3D +80.0=B0C, hyst =3D +75.0=B0C) sensor =
=3D CPU diode
>>>
>>> --
>>>
>>> I also tried hardcoding in4_{min,max}:
>>>
>>> $ cat /etc/sensors3.conf
>>>
>>> chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*"
>>>
>>> label in0 "Vcore"
>>> label in1 "Vnbcore"
>>> label in2 "AVCC"
>>> label in3 "+3.3V"
>>> label in4 "VDIMM"
>>> label in5 "+5V"
>>> label in6 "+12V"
>>> label in7 "3VSB"
>>> label in8 "Vbat"
>>> label temp1 "SYS Temp"
>>> label temp2 "CPU Temp"
>>> label temp3 "Case Temp"
>>>
>>> set in2_min 3.3 * 0.90
>>> set in2_max 3.3 * 1.10
>>> set in3_min 3.3 * 0.90
>>> set in3_max 3.3 * 1.10
>>> # http://lists.lm-sensors.org/pipermail/lm-sensors/2010-November/030368=
.html
>>> set in4_min 1.62
>>> set in4_max 1.98
>>> set in7_min 3.3 * 0.90
>>> set in7_max 3.3 * 1.10
>>> set in8_min 3.0 * 0.90
>>> set in8_max 3.0 * 1.10
>>>
>>> ignore fan1
>>> ignore fan2
>>> ignore fan3
>>> ignore fan4
>>> ignore fan5
>>> ignore cpu0_vid
>>> ignore intrusion0
>>
>> Did you run "sensors -s" after changing the configuration file?
>>
>> --
>> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


--=20
Ben Kamen - O.D.T., S.P.
----------------------------------------------------------------------
eMail: ben@benjammin.net                      http://www.benjammin.net
                                    http://www.linkedin.com/in/benkamen
Fortune says:
Only a fool fights in a burning house.
		-- Kank the Klingon, "Day of the Dove", stardate unknown
-                                                              -
NOTICE: All legal disclaimers sent to benjammin.net/benkamen.net
or any of it's affiliated domains are rendered null and void on
receipt of communications will be handled/considered as such.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
