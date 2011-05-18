From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 May 2011 10:09:11 +0000
Subject: Re: [lm-sensors] EMC6W201 module - Dell Sensors Testing
Message-Id: <20110518120911.104782bc@endymion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/vRsc1FuX8Rmb8R68t4saG=d"
List-Id: <lm-sensors.vger.kernel.org>
References: <4DD30DD1.4080909@myamigos.us>
In-Reply-To: <4DD30DD1.4080909@myamigos.us>
To: lm-sensors@vger.kernel.org

--MP_/vRsc1FuX8Rmb8R68t4saG=d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jeff,

On Tue, 17 May 2011 19:07:45 -0500, Jeff Rickman wrote:
> Download emc6w201 files.
> Did not need "i2c-compat.h" file since my kernel > 2.6.32
>=20
> Output of "uname -a"
> Linux XX.xx.xx.xx 2.6.35.12-90.fc14.x86_64 #1 SMP Fri Apr 22 16:01:29
> UTC 2011 x86_64 x86_64 x86_64 GNU/Linux
> Platform is Dell Precision 670 Workstation with A07 BIOS
>=20
> CPU info
> vendor_id : GenuineIntel
> cpu family : 15
> model : 4
> model name : Intel(R) Xeon(TM) CPU 3.00GHz
> stepping : 1
> cpu MHz : 750.000 ("cpuspeed" package is enabled)
> cache size : 1024 KB
>=20
> Compile the emc6w201 module
> Copy provided "emc6w201.conf" file to "/etc/sensors.d" directory
>=20
> Run "modprobe -v emc6w201"
> No faults on Console. No faults captured to Syslog
> Run "sensors". System kicks me out.
> Reboot required
> Unable to duplicate issue with "sensors"
> Reboot
>=20
> Run "modprobe -v emc6w201" without using "i8k" module
> No errors on Console. No errors in Syslog.
> "emc6w201" module installs
>=20
> Selected "lsmod" output
> Module Size Used by
> emc6w201 8742 0
> ~SNIP~
> i2c_core 27212 6 emc6w201,i2c_i801,nouveau,drm_kms_helper,drm,i2c_algo_bit
>=20
> Output from "sensors"
> emc6w201-i2c-2-2e
> Adapter: SMBus I801 adapter at ece0
> in0: +1.80 V (min =3D +1.64 V, max =3D +1.98 V)
> in1: +1.36 V (min =3D +0.78 V, max =3D +1.70 V)
> +3.3V: +3.38 V (min =3D +3.08 V, max =3D +3.52 V)
> +5V: +5.08 V (min =3D +4.66 V, max =3D +5.34 V)
> in4: +1.51 V (min =3D +1.40 V, max =3D +1.60 V)
> in5: +1.35 V (min =3D +0.78 V, max =3D +1.70 V)
> fan1: 1498 RPM (min =3D 300 RPM)
> fan2: 1795 RPM (min =3D 300 RPM)
> fan3: 1899 RPM (min =3D 200 RPM)
> fan4: 0 RPM (min =3D 82 RPM)
> fan5: 0 RPM (min =3D 82 RPM)
> temp1: +46.0=C2=B0C (low =3D -127.0=C2=B0C, high =3D +88.0=C2=B0C)
> temp2: +48.0=C2=B0C (low =3D -127.0=C2=B0C, high =3D +88.0=C2=B0C)
> temp3: +45.0=C2=B0C (low =3D -127.0=C2=B0C, high =3D +60.0=C2=B0C)
> temp4: +41.0=C2=B0C (low =3D -127.0=C2=B0C, high =3D +55.0=C2=B0C)
> temp5: +44.0=C2=B0C (low =3D -127.0=C2=B0C, high =3D +75.0=C2=B0C)
> Case Temp: +42.0=C2=B0C (low =3D -127.0=C2=B0C, high =3D +80.0=C2=B0C)

Thanks a lot for the detailed report. And glad to see that my driver
works for you :)

> My own guesses at voltages since I am not near this machine right now...
> in0 could be VDIMM since "lshw" reports 400MHz DDR memory
> in4 could be +12V and requires a *8 scaling factor.
> in1 & in5 could be Vcore lines??

Yes, this was exactly my guess as well, in line with Harry's single-CPU
setup.

> If time permits, I need to carefully check voltage lines inside the=20
> system with a digital VOM to compare to "sensors" output. Next, I want=20
> to pull a memory stick or two to see if they are DDR or DDR2. Then I=20
> need to do "load" experiments in an attempt to identify the physical=20
> CPUs in the "sensors" output.

You shouldn't have to tear apart the memory modules, as I can think of
2 ways to get the information without hardware interaction. Not that it
should be needed anyway, as the Dell documentation is pretty clear that
this workstation uses DDR2 memory.

1* Use the eeprom kernel driver together with the decode-dimms script
from i2c-tools:
# modprobe eeprom
$ decode-dimms

2* Use dmidecode:
# dmidecode -t memory

> Since this system has 2 physical CPU packages and each CPU has
> hyperthreading enabled, I wonder which temp sensors from [1-5] would be
> useful?

External temperature monitoring (as opposed to embedded digital
sensors) is per-CPU or per-socket, so hyper-threading doesn't come into
play.

We are lucky that Harry has a single-CPU machine and you have a
dual-CPU one. So the sensors you have and he lacks are likely to be
related to CPU 2. These are clearly fan2 and temp2.

The similar high limit for temp1 and temp2 leads me to the conclusion
that temp1 is CPU1 and temp2 is CPU2. temp6 is a sensor on the EMC6W201
itself, so it's the board temperature.

Harry also lacks temp3 and temp4, I admit I don't understand why. temp3
to temp5 all have different limits so they don't seem to be paired and
thus wouldn't be related to the presence or absence of a second CPU. I
have no idea where these sensors are.

> I noticed that "coretemp" does not load on this platform. Perhaps the
> platform/CPU/whatever is too old or not instrumented for "coretemp", or=20
> "coretemp" isn't instrumented for this Intel CPU family?

The CPU family is indeed too old, it did not include digital sensors.
So it is expected that coretemp won't work.

> I will have to inspect this system to see if the physical fans are
> 3-wire or PWM and what fan headers are on the motherboard and how/if=20
> they are identified.

3-wire and PWM isn't incompatible. People started controlling their
fans with PWM long before 4-wire fans hit the market.

One remaining question for fans is how CPU1 fan and chassis Fan map to
fan1 and fan3. The similar limits for fan1 and fan2 would suggest that
fan1 is the CPU1 fan, however Harry's conclusions were opposite.

I have attached my current attempt at a configuration file for your
system, please give it a try.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

--MP_/vRsc1FuX8Rmb8R68t4saG=d
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=sensors3-Dell-Precision-670.conf

# lm-sensors 3 configuration file for the Dell Precision 670 workstation
# 2011-05-18, Jean Delvare <khali@linux-fr.org>
# Thanks to Harry G McGavran Jr and Jeff Rickman for their feedback.

chip "emc6w201-*"

### Voltages

   # For dual-CPU setups
   label  in0  "Vram"
   label  in1  "Vcore1"
   label  in2  "+3.3V"
   label  in3  "+5V"
   label  in4  "+12V"
   label  in5  "Vcore2"

   # For single-CPU setups
   #label  in1  "Vcore"
   #ignore in5

   compute in4  @ * 8, @ / 8

### Fans

   # fan1 and fan3 may be swapped.

   # For dual-CPU setups
   label  fan1  "CPU1 Fan"
   label  fan2  "CPU2 Fan"
   label  fan3  "Chassis Fan"
   ignore fan4
   ignore fan5

   # For single-CPU setups
   #label  fan1  "CPU Fan"
   #ignore fan2

### Temperatures

   # No idea what temp3, temp4 and temp5 are.

   label  temp1  "CPU1 Temp"
   label  temp2  "CPU2 Temp"
   label  temp6  "Case Temp"

   # For single-CPU setups
   #label  temp1  "CPU Temp"
   #ignore temp2

--MP_/vRsc1FuX8Rmb8R68t4saG=d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/vRsc1FuX8Rmb8R68t4saG=d--
