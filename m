From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 12 Jun 2008 15:32:02 +0000
Subject: Re: [lm-sensors] v1211 fan control
Message-Id: <191fb4ca0806120832h15dec5adlf705deaba62f102d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
In-Reply-To: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Sergio,


>
> Em 05/06/2008, =E0s 12:02, Juerg Haefliger escreveu:
>
>> Hi Sergio,
>>
>>
>>> root@nimbus:~# ~sergio/cpuid
>>> eax in    eax      ebx      ecx      edx
>>> 00000000 00000001 746e6543 736c7561 48727561
>>> 00000001 000006a9 00010800 00000181 a7c9bbff
>>> 80000000 80000006 00000000 00000000 00000000
>>> 80000001 00000000 00000000 00000000 00100000
>>> 80000002 20202020 20202020 20202020 20202020
>>> 80000003 56202020 45204149 65687473 72702072
>>> 80000004 7365636f 20726f73 30303031 007a484d
>>> 80000005 00000000 08800880 40040140 40040140
>>> 80000006 00000000 00000000 0080a140 00000000
>>> c0000000 c0000002 00000000 00000000 00000000
>>> c0000001 00000000 00000000 00000000 00003fcc
>>> c0000002 00003b00 080c0810 08100a13 42000000
>>>
>>> Vendor ID: "CentaurHauls"; CPUID level 1
>>>
>>> Unknown vendor
>>
>> Ah very good! Now can you please run cpuid and 'grep ""
>> /sys/class/hwmon/hwmon*/device/temp?_input' in close succession a
>> couple of times (maybe 5 times with a couple of secs in between) while
>> the system is idle and then again while the system is busy (by running
>> cpuburn for example)? This should allow me to calculate the correct
>> values for the conversion that goes into sensors.conf.
>
> attached is a 'better' idle, Ive saw the temp2 temperature even lower and
> got another batch of sensors readings.
>

I looked at your files and it doesn't look too promising
unfortunately. First, FYI, register eax in the last line of the cpuid
dump contains the core temp value in celcius. I.e.,
c0000002 00003b00 080c0810 08100a13 42000000 -> hex 3b =3D dec 59 =3D 59
degrees celcius

From your snapshots, I see that we get a 24C core temp swing (43C to
67C) between idle and after-freeze. You might be able to push the high
temp a little higher by running some stress that doesn't freeze your
CPU. Maybe a kernel compile. But that's irrelevant for this
discussion.
Also, temp1 & temp3 never move so I'm assuming they are not connected
and can be ignored/disabled. temp2 is the vt1211 internal temp which
tracks the CPU temp somewhat. Temp4 is the only other temp input that
changes but I don't think it's the CPU temp. Temp1 is the dedicated
CPU temp input and temp4 is for thermistors only (I believe). The
temp4 values only swing between 2011 and 2022, I don't know if that's
reasonable for a thermistor, maybe others on the list can shed some
light. But it's certainly not the CPU, maybe an on-board thermistor or
nothing at all.
My guess is since it's a fanless board, VIA didn't care to connect the
CPU thermal diode to the vt1211 more so that the C7 has another
thermal diode that can be accessed via SW. No need to take the detour
through the vt1211 to get the temp.
But of course that doesn't help you with using the CPU temp to control
the chassis fan (assuming this is what you want). You have 2 options
as I can see:
1) Use temp2 as the input for the vt1211 PWM controller.
2) Use a user-space tool to periodically check the CPU temp and adjust
the PWM output accordingly.

For option 2) you can either use the cpuid tool to get the temp or you
can wait a couple of hours until I post the c7temp driver to the list
that gives you temp access via sensors. For manually controlling the
PWM outputs, I have a little script that does it which I'll also post
shortly. The script basically puts the vt1211 PWM controller into auto
mode and drives it to extreme values so that the PWM outputs can be
set manually.

Hope this helps
...juerg



>
>
>
> Sergio Bruder
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
