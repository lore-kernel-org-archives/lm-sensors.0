From: Darren Hart <dvhart@linux.intel.com>
Date: Fri, 15 Apr 2011 14:11:31 +0000
Subject: Re: [lm-sensors] w83795 fan control not working
Message-Id: <4DA85213.4030504@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110407150007.51dd1c06@endymion.delvare>
In-Reply-To: <20110407150007.51dd1c06@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



On 04/15/2011 12:59 AM, Jean Delvare wrote:
> On Thu, 14 Apr 2011 22:30:53 -0700, Darren Hart wrote:
>> After trying a different kernel, I was able to get reading from the
>> w83795 again. I applied the fan to the chipset until it reached it's
>> lowest point (52.5C while idle). I then positioned the fan away from the
>> chipset and watched the temperature rise until it reached 84.5C and the
>> fans sped up to > 4000RPM.
>>
>> FAN 1            | 2401.000   | RPM        | ok    | 400.000   | 576.000
>>   | 784.000   | 33856.000 | 34225.000 | 34596.000
>> FAN 2            | 0.000      | RPM        | nr    | 400.000   | 576.000
>>   | 784.000   | 33856.000 | 34225.000 | 34596.000
>> FAN 3            | 2401.000   | RPM        | ok    | 400.000   | 576.000
>>   | 784.000   | 33856.000 | 34225.000 | 34596.000
>> FAN 4            | 4356.000   | RPM        | ok    | 400.000   | 576.000
>>   | 784.000   | 33856.000 | 34225.000 | 34596.000
>> FAN 5            | 3969.000   | RPM        | ok    | 400.000   | 576.000
>>   | 784.000   | 33856.000 | 34225.000 | 34596.000
>>
>>
>> Given that the system is idle, and Super Mictro stated the chipset
>> should not exceed 75C, and I have no obstructions in the case and no
>> expansion boards to add heat, something appears to be wrong.
>>
>> Here is an annotated log of the experiment, one reading every 10 seconds:
>>
>> dvhart@rage:~$ while true; do sensors w83795g-i2c-0-2f | grep temp1;
>> sleep 10; done
>> temp1:       +61.2=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +59.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +57.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +56.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +55.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +54.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +53.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +52.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +52.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +53.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +55.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +56.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +58.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +60.2=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +61.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +63.2=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +64.2=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +65.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +66.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +67.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +68.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +69.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +70.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +71.2=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +72.2=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +72.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +73.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +74.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +75.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +75.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +76.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +77.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +77.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +77.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +78.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +78.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +79.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +79.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +79.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +80.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +80.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +80.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +81.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +81.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +81.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +81.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +82.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +82.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +82.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +82.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +82.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +83.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +83.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +83.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +83.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +83.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +83.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +83.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +83.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +84.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +84.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +84.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +84.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +84.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +84.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +84.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +84.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +84.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>>
>> Fan speed jumped up at this point:
>>
>> FAN 1            | 2401.000   | RPM        | ok    | 400.000   | 576.000
>>   | 784.000   | 33856.000 | 34225.000 | 34596.000
>> FAN 2            | 0.000      | RPM        | nr    | 400.000   | 576.000
>>   | 784.000   | 33856.000 | 34225.000 | 34596.000
>> FAN 3            | 2401.000   | RPM        | ok    | 400.000   | 576.000
>>   | 784.000   | 33856.000 | 34225.000 | 34596.000
>> FAN 4            | 4356.000   | RPM        | ok    | 400.000   | 576.000
>>   | 784.000   | 33856.000 | 34225.000 | 34596.000
>> FAN 5            | 3969.000   | RPM        | ok    | 400.000   | 576.000
>>   | 784.000   | 33856.000 | 34225.000 | 34596.000
>>
>> And stayed at high speed until:
>>
>> temp1:       +79.2=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +79.8=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +79.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +79.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +80.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +80.5=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>> temp1:       +81.0=B0C  (high =3D +127.0=B0C, hyst =3D +127.0=B0C)
>>
>> And sped up again here.
>> And so on.
>=20
> The W83795ADG can be programmed to switch fans to full speed when
> certain temperature limits are exceeded. The driver doesn't currently
> expose these settings, but my guess is that's what you're seeing.
> According to the datasheet, the default value for temperature limit
> registers for this mechanism is 0x50, that is... 80=B0C.

Which is consistent with Super Micro saying the chipset must remain
below 75C. A fan brings it down 30C. I'm looking into adding a fan or
replacing the heat sink, or both. With that, I'll be giving up on
fancontrol for this machine - since it behaves itself just fine when the
chipset isn't overheating.

--=20
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
