From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 09 Jun 2007 09:50:45 +0000
Subject: Re: [lm-sensors] sis5595
Message-Id: <20070609115045.03fe30cc@hyperion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_E3O.nSfKnA5Sna5rmI07AIZ"
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
To: lm-sensors@vger.kernel.org

--MP_E3O.nSfKnA5Sna5rmI07AIZ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Ivo,

On Fri, 8 Jun 2007 17:20:10 +0200, Ivo Manca wrote:
> Thanks for helping out, if you need more information, just let me know
>=20
> > Sensors-detect:
> Next adapter: SMBus SIS5595 adapter at 0438 (i2c-0)
> Do you want to scan it? (YES/no/selectively):

Nothing on the SMBus.

> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no): Probing for `National=20
> Semiconductor LM78' at 0x290...       Success!
>     (confidence 6, driver `lm78')
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Silicon Integrated Systems SIS5595'...         Success!
>     (confidence 9, driver `sis5595')
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>=20
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
>=20
> Some CPUs or memory controllers may also contain embedded sensors.
> Do you want to scan for them? (YES/no):
> AMD K8 thermal sensors...                                   No
> Intel Core family thermal sensor...                         No
> Intel AMB FB-DIMM thermal sensor...                         No
>=20
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>=20
> Driver `lm78' (should be inserted):
>   Detects correctly:
>   * ISA bus, address 0x290
>     Chip `National Semiconductor LM78' (confidence: 6)

This is a misdetection, as we know (from the "sensors" output below)
that the SiS5595 hardware monitoring function is mapped to I/O address
0x290. Unfortunately sensors-detect cannot (easily) detect this
address, so we'll have to live with the misdetection for now.

> Driver `sis5595' (should be inserted):
>   Detects correctly:
>   * ISA bus
>     Chip `Silicon Integrated Systems SIS5595' (confidence: 9)

> > BIOS output:
> CPU Temprature                    49` C / 120` F
> CPU FAN Speed                   Disconnected
> Vcc 5.0V                                5.093V
> Vcc 3.3V                                3.382V
> Vcc 2.5V                                2,949V
> Vcore                                      2,048V
>=20
> > sensors -c /dev/null
> [root@localhost ~]# sensors -c /dev/null
> sis5595-isa-0290
> Adapter: ISA adapter
> in0:       +2.96 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in1:       +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in2:       +2.75 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in3:       +2.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in4:       +3.62 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> fan1:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
> fan2:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
> alarms:   Board temperature input (usually LM75 chips) ALARM

OK. There are some correlations, this isn't that bad.

It seems that your SiS5595 is wired for 1 temperature and 4 voltages,
rather than 5 voltages as the driver detects. I guess that your BIOS
doesn't properly set up the relevant configuration bit when the setup
screen isn't entered. Please look for a BIOS update. If there is none,
or if it doesn't solve the problem, we'll have to add a module
parameter to allow the user to force one of the modes when
autodetection fails.

For now, you can try changing the configuration manually. First, do:
lspci -d 1039:0008 -xxx
This will dump the PCI configuration space of your device. I guess that
bit 7 of register 0x7a will be 0, while it should be 1. You can change
it with:
setpci -d 1039:0008 7a.b=3D80:80
Check with lspci that the write worked, then reload the sis5595 driver,
it should list 4 voltages and one temperature. Please provide the
output then.

For voltages, the SiS5595 uses a DAC sampling from 0 to 4.08 V. This
means that voltage values of 3.3 V and below are probably connected
directly. This seems to match. in0 would be "Vcc 2.5V" (which BTW, is
way too high!), in1 would be "Vcc 3.3V", and in3 would be "Vcore". This
leaves in2 for "Vcc 5.0V", with a scaling factor we'll have to guess.
The standard +5V formula doesn't appear to work.

For fans, do you have 3-wire fans? Are they connected to headers on
the motherboard? If they are relatively slow, maybe we need to increase
the divider to get a reading.

Lastly, alarms, given that you don't have any other hardware monitoring
chip on this board, I guess this alarm isn't meaningful and should be
ignored.

I attached a preliminary configuration file for your motherboard.
Please give it a try. You can tell "sensors" to use it with the "-c"
flag. Use "-s" to write the limit values to the chip.

What's your CPU? Do you happen to know its nominal vcore?

> Removing sis5595 & loading lm78 also gives output?
> [root@localhost ~]# rmmod sis5595
> [root@localhost ~]# modprobe lm78
> [root@localhost ~]# sensors
> lm78-isa-0290
> Adapter: ISA adapter
> VCore 1:   +2.96 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> VCore 2:   +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> +3.3V:     +2.75 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> +5V:       +3.44 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> +12V:     +13.74 V  (min =3D  +0.00 V, max =3D  +0.00 V)
> -12V:      -0.00 V  (min =3D  -0.00 V, max =3D  -0.00 V)
> -5V:       -0.00 V  (min =3D  -0.00 V, max =3D  -0.00 V)
> fan1:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
> fan2:        0 RPM  (min =3D   -1 RPM, div =3D 2)          ALARM
> fan3:       -1 RPM  (min =3D   -1 RPM, div =3D 2)
> temp:     +127.0=C2=B0C  (high =3D    +0=C2=B0C, hyst =3D    +0=C2=B0C)
> vid:       +3.50 V
> alarms:   Board temperature input (LM75)               ALARM

This is all noise, you don't have a LM78. Don't load the lm78 driver.

--=20
Jean Delvare

--MP_E3O.nSfKnA5Sna5rmI07AIZ
Content-Type: text/plain; name=sensors-PCChips-M748LMRT.conf
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=sensors-PCChips-M748LMRT.conf

# lm_sensors configuration file for the PCChips M748LMRT motherboard
# 2007-06-09, Jean Delvare <khali@linux-fr.org>
# Preliminary version. Comments welcome!

chip "sis5595-*"

### Voltages

   label in0 "+2.5V"
   label in1 "+3.3V"
   label in2 "+5.0V"
   label in3 "Vcore"

   # Non-standard scaling resistors are used for +5V, so this is guess
   # work.
   compute in2 @*(1+8.6/10),  @/(1+8.6/10)

   set in0_min 2.5 * 0.90
   set in0_max 2.5 * 1.10
   set in1_min 3.3 * 0.95
   set in1_max 3.3 * 1.05
   set in2_min 5.0 * 0.95
   set in2_max 5.0 * 1.05
   set in3_min 2.0 * 0.95
   set in3_max 2.0 * 1.05

### Fans

   set fan1_div 8
   set fan2_div 8
   set fan1_min 1000
   set fan2_min 1000

### Temperatures

   label temp "CPU Temp"

### Misc

   ignore alarms

--MP_E3O.nSfKnA5Sna5rmI07AIZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_E3O.nSfKnA5Sna5rmI07AIZ--
