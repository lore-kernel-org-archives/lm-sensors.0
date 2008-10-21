From: "David C. Rankin" <drankinatty@suddenlinkmail.com>
Date: Tue, 21 Oct 2008 04:54:13 +0000
Subject: Re: [lm-sensors] f71882fg-* How do you set temp limits for max_hyst
Message-Id: <48FD6075.7090906@suddenlinkmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FBFF2A.608@suddenlinkmail.com>
In-Reply-To: <48FBFF2A.608@suddenlinkmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:
> David C. Rankin wrote:
>> sensor Devs,
>>
>>     I have an MSI K9N2 SLI Platinum board that has the f71882fg- chip.
>> I am unable
>> to set the tempX_max_hyst and tempX_crit_hyst temperature limits with
>> sensors-3.0.2-4.1. Attempting to set the values results in the normal
>> error
>> messages on sensors -s:
>>
>> Error: Line 70: Unknown feature name
>> Error: Line 71: Unknown feature name
>>
>=20
> <snip>
>=20
>>     set temp1_max_hyst 50
>>     set temp1_max 55
>>     set temp1_crit_hyst 56
>>     set temp1_crit 60
>>     set temp2_max_hyst 50
>>     set temp2_max 55
>>     set temp2_crit_hyst 56
>>     set temp2_crit 60
>>
>>     However, all of the _hyst settings result in the errors explained
>> above. So,
>> how do you set the hyst limits with this chipset?
>>
>=20
> Erm, that should work. What does ls /sys/class/hwmon/hwmon*/device show ?
>=20

Left you speechless too....

23:18 sq4~> ls /sys/class/hwmon/hwmon*/device
driver      fan3_beep   in1_beep   in7_input    temp1_crit       temp2_beep
   temp3_alarm      temp3_type
fan1_alarm  fan3_input  in1_input  in8_input    temp1_crit_hyst  temp2_crit
   temp3_beep       uevent
fan1_beep   fan4_alarm  in1_max    modalias     temp1_fault
temp2_crit_hyst  temp3_crit
fan1_input  fan4_beep   in2_input  name         temp1_input      temp2_fault
   temp3_crit_hyst
fan2_alarm  fan4_input  in3_input  power        temp1_max        temp2_input
   temp3_fault
fan2_beep   hwmon       in4_input  subsystem    temp1_max_hyst   temp2_max
   temp3_input
fan2_input  in0_input   in5_input  temp1_alarm  temp1_type       temp2_max_=
hyst
  temp3_max
fan3_alarm  in1_alarm   in6_input  temp1_beep   temp2_alarm      temp2_type
   temp3_max_hyst

	Looking closer at the temp*, some are 0:

23:27 sq4~> ls -l /sys/devices/platform/f71882fg.2560/temp*
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp1_alarm
-rw-r--r-- 1 root root 4096 2008-10-20 23:19
/sys/devices/platform/f71882fg.2560/temp1_beep
-rw-r--r-- 1 root root    0 2008-10-20 00:00
/sys/devices/platform/f71882fg.2560/temp1_crit
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp1_crit_hyst
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp1_fault
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp1_input
-rw-r--r-- 1 root root    0 2008-10-20 00:00
/sys/devices/platform/f71882fg.2560/temp1_max
-rw-r--r-- 1 root root    0 2008-10-19 21:29
/sys/devices/platform/f71882fg.2560/temp1_max_hyst
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp1_type
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp2_alarm
-rw-r--r-- 1 root root 4096 2008-10-20 23:19
/sys/devices/platform/f71882fg.2560/temp2_beep
-rw-r--r-- 1 root root    0 2008-10-20 00:00
/sys/devices/platform/f71882fg.2560/temp2_crit
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp2_crit_hyst
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp2_fault
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp2_input
-rw-r--r-- 1 root root    0 2008-10-20 00:00
/sys/devices/platform/f71882fg.2560/temp2_max
-rw-r--r-- 1 root root    0 2008-10-19 21:29
/sys/devices/platform/f71882fg.2560/temp2_max_hyst
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp2_type
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp3_alarm
-rw-r--r-- 1 root root 4096 2008-10-20 23:19
/sys/devices/platform/f71882fg.2560/temp3_beep
-rw-r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp3_crit
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp3_crit_hyst
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp3_fault
-r--r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp3_input
-rw-r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp3_max
-rw-r--r-- 1 root root 4096 2008-10-19 21:18
/sys/devices/platform/f71882fg.2560/temp3_max_hyst

	All of the hyst devices are there. I don't know why it is giving the error=
s on
set. However, I wonder if the way it is symlinked could be causing the
problems? Note above, the actual /sys directory for the values is:

/sys/devices/platform/f71882fg.2560/
=09

> If there are temp#_max_hyst files there try:
> echo -n 56000 > /sys/class/hwmon/hwmon#/device/temp#_max_hyst
>=20

	Blind faith required.... A quick check first:

23:33 sq4~> cat /sys/devices/platform/f71882fg.2560/temp1_max_hyst
51000

	Hmm, 51000, and that is what the temp1_max_hyst shows with sensors:

23:35 sq4~> sensors
f71882fg-isa-0a00
Adapter: ISA adapter
<snip>
CPU:         +28.0=B0C  (high =3D +55.0=B0C, hyst =3D +51.0=B0C)
                      (crit =3D +60.0=B0C, hyst =3D +56.0=B0C)  sensor =3D =
thermistor
System:      +32.0=B0C  (high =3D +55.0=B0C, hyst =3D +51.0=B0C)
                      (crit =3D +60.0=B0C, hyst =3D +56.0=B0C)  sensor =3D =
transistor

	OK, I'll try 50000 since that is actually what I wanted to set the max_hys=
t to:

[23:39 sq4/home/david] # echo -n 50000 >
/sys/class/hwmon/hwmon0/device/temp1_max_hyst
[23:40 sq4/home/david] # echo -n 50000 >
/sys/class/hwmon/hwmon0/device/temp2_max_hyst

[23:40 sq4/home/david] # sensors
f71882fg-isa-0a00
Adapter: ISA adapter
<snip>
CPU:         +28.0=B0C  (high =3D +55.0=B0C, hyst =3D +50.0=B0C)
                      (crit =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor =3D =
thermistor
System:      +31.0=B0C  (high =3D +55.0=B0C, hyst =3D +50.0=B0C)
                      (crit =3D +60.0=B0C, hyst =3D +55.0=B0C)  sensor =3D =
transistor

	Well that worked nicely! Now why wouldn't it accept the set variables from=
 the
sensors3.conf file? Let's try again. A quick vi of sensors3.conf leaving:

# Set CPU and System temp limits

    set temp1_max_hyst 50
    set temp1_max 55
#    set temp1_crit_hyst 56
    set temp1_crit 60
    set temp2_max_hyst 50
    set temp2_max 55
#    set temp2_crit_hyst 56
    set temp2_crit 60

	WTF? It worked! Hmm..., something is fishy here. Let's do another test:

23:42 sq4~> sudo echo -n 50000 > /sys/class/hwmon/hwmon0/device/temp1_max_h=
yst
-bash: /sys/class/hwmon/hwmon0/device/temp1_max_hyst: Permission denied

	$%#@%^@$%$ing sudo! I see the problem, but I don't know why. When the error
was generated, I was running sensors -s with sudo "sudo sensors -s" which h=
as
always worked before with all my other boxes. I wonder what the deal is her=
e.
Mystery solved, and another one to track down -- normal...

> Note that the hysteresis is shared between max and crit, so only the
> temp#_max_hyst attributes are writable the temp#_crit_hyst attributes
> are readonly.

	Yep, the above file permission bear that out.

>=20
> If the echo works and your sensors.conf still gives errors after
> removing the set statements for temp#_crit_hyst, we probably have a bug
> in libsensors or sensors somewhere.
>=20
>>     If you need additional information, please just ask and I'll be
>> glad to
>> provide it. Also, I tried enabling temp3 and that resulted in a wild
>> value of
>> 127 deg.C which is way off-scale high. Any ideas what this sensor does?
>=20
> 127 looks like not connected to me, I would expect the output of
> "sensors" to give a FAULT as reading for that sensors, what does:
> cat /sys/class/hwmon/hwmon#/device/temp3_fault
> Give as output?
>=20
> Regards,
>=20
> Hans
>=20

	Thank you Hans. Bitten by sudo. At least we know libsensors is as good as =
ever
and it was just another "id ten t" error. (change the text within the quote=
s to
all-caps and numerical 10 and remove the spaces)...

--=20
David C. Rankin, J.D., P.E.
Rankin Law Firm, PLLC
www.rankinlawfirm.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
