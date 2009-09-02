From: Karl Schmidt <karl@xtronics.com>
Date: Wed, 02 Sep 2009 17:02:47 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <4A9EA537.1090308@xtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Wed, 02 Sep 2009 11:41:31 -0500, Karl Schmidt wrote:
>> Jean Delvare wrote:
>>> Hi Karl,
>>>
>>> On Fri, 28 Aug 2009 13:36:18 -0500, Karl Schmidt wrote:
>>>> I hope this isn't a stupid question -but google didn't get me there..
>>>>
>>>> Please cc -- I'm off list..
>>>>
>>>> I used to be able to get an alarm for fans - but now I don't.
>>>>
>>>>
>>>> chip "lm85c-*" "adm1027-*" "adt7463-*" "lm85-*" "lm85b-*"
>>>>
>>>> # Voltage inputs
>>>> # Depending on the hardware setup, the ADT7463 may not have in4.
>>>>     label in0   "V1.5"      # AGP on Intel S845WD1-E
>>>>     label in1   "VCore"
>>>>     label in2   "V3.3"
>>>>     label in3   "V5"
>>>>     label in4   "V12"
>>>>
>>>> # Temperature inputs
>>>>     label temp1  "CPU Temp"
>>>>     label temp2  "Board Temp"
>>>>     label temp3  "Remote Temp"
>>>>
>>>> # Fan inputs
>>>>     label fan1   "CPU_Fan"
>>>>     label fan2   "Fan2"
>>>>     label fan3   "Fan3"
>>>>     label fan4   "Fan4"
>>>> set fan1_min 8000
>>>>
>>>>
>>>>
>>>>
>>>> lm85b-i2c-0-2e
>>>> Adapter: SMBus nForce2 adapter at 1c00
>>>> V1.5:        +1.30 V  (min =3D  +0.00 V, max =3D  +3.32 V)
>>>> VCore:       +1.42 V  (min =3D  +0.00 V, max =3D  +2.99 V)
>>>> V3.3:        +3.35 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>>>> V5:          +5.08 V  (min =3D  +0.00 V, max =3D  +6.64 V)
>>>> V12:        +12.06 V  (min =3D  +0.00 V, max =3D +15.94 V)
>>>> CPU_Fan:    7837 RPM  (min =3D 8000 RPM)
>>>> Fan2:       8169 RPM  (min =3D    0 RPM)
>>>> Fan3:       7964 RPM  (min =3D    0 RPM)
>>>> Fan4:       7917 RPM  (min =3D    0 RPM)
>>>> CPU Temp:    +37.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
>>>> Board Temp:  +26.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
>>>> Remote Temp: +23.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
>>>>
>>>>
>>>> 2.6.26-2-amd64 #1 SMP
>>> This is strange. The lack of alarms for Fan2, Fan3 and Fan4 can be
>>> easily explained by the min being set to 0. But for CPU_Fan you should
>>> get one.
>>>
>>> Are you able to get _any_ other alarm flag to raise?
>=20
> Please try this too, for example set in0_max to 1.0V and see if
> in0_alarm gets raised.

no joy..
#sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +24.0=B0C

lm85b-i2c-0-2e
Adapter: SMBus nForce2 adapter at 1c00
V1.5:        +1.30 V  (min =3D  +0.00 V, max =3D  +1.00 V)
VCore:       +1.42 V  (min =3D  +0.00 V, max =3D  +2.99 V)
V3.3:        +3.33 V  (min =3D  +0.00 V, max =3D  +4.38 V)
V5:          +5.08 V  (min =3D  +0.00 V, max =3D  +6.64 V)
V12:        +12.06 V  (min =3D  +0.00 V, max =3D +15.94 V)
CPU_Fan:    7826 RPM  (min =3D 8000 RPM)
Fan2:       8181 RPM  (min =3D    0 RPM)
Fan3:       7917 RPM  (min =3D    0 RPM)
Fan4:       7929 RPM  (min =3D    0 RPM)
CPU Temp:    +39.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
Board Temp:  +28.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
Remote Temp: +24.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
cpu0_vid:   +1.550 V




>=20
>>> Which version of lm-sensors are you running?
>> lm-sensors Debian release 1:3.0.2-1+b2
>> #sensors -v
>> sensors version 3.0.2 with libsensors version 3.0.2)
>>  >
>>  > Can you please locate your chip under /sys/class/hwmon and list the
>>  > name and contents of all the "*alarm*" files there? This will tell us
>>  > whether this is a hardware/driver issue or an lm-sensors (user-space)
>>  > issue.
>> /sys/class/hwmon - has two directories: hwmon0 and hwmon1 - no alarm fil=
es under hwmon0
>>
>>
>> /sys/class/hwmon/hwmon1/device# ls *alarm*
>> alarms      fan2_alarm  fan4_alarm  in1_alarm  in3_alarm  temp1_alarm  t=
emp3_alarm
>> fan1_alarm  fan3_alarm  in0_alarm   in2_alarm  in4_alarm  temp2_alarm
>>
>> All return 0
>>
>> /sys/class/hwmon/hwmon1# cat device/fan1_alarm
>> 0
>> /sys/class/hwmon/hwmon1# cat device/fan3_alarm
>> 0
>> /sys/class/hwmon/hwmon1# cat device/in0_alarm
>> 0
>> etc..
>=20
> Does "alarms" read 0 as well?

yes - all alarms files read zero
/sys/class/hwmon/hwmon1/device# cat alarms
0

>=20


--=20
!!!>> INCLUDE ALL TEXT IN TECHNICAL SUPPORT EMAIL REPLIES!!!!!!!
Please reply in plain-text mode
---------------------------------------------------------------------------=
-----
Karl Schmidt                                  EMail Karl@xtronics.com
Transtronics, Inc.                              WEB http://xtronics.com
3209 West 9th Street                             Ph (785) 841-3089
Lawrence, KS 66049                              FAX (785) 841-0434

Misdirection is the key to being a good magician. Magicians tell
you they are doing something while they do something quite
different; much like politicians -- except we can afford magicians.
-KPS

---------------------------------------------------------------------------=
-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
