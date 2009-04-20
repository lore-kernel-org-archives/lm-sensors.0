From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Date: Mon, 20 Apr 2009 20:40:51 +0000
Subject: Re: [lm-sensors] w83793 related question
Message-Id: <49ECDDD3.5040808@aei.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <49E45712.6020906@aei.mpg.de>
In-Reply-To: <49E45712.6020906@aei.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Rudolf Marek schrieb:
> Hi
> The problem is elsewhere. ACPI code is OK. Maybe the SMM mode is into a
> play, or i2c hw problem might be too.
> 
> Can you recompile the kernel with i2c debugging on? (for i2c-i801) module?
> 
> Does the errors occcur right after start, or they are all of sudden?
> 
> if you unload the w83793 driver but leave i2c-i801 driver loaded and do
> some script like:
> 
> while true ; do
> i2cdump -y 0 0x2f
> sleep 5
> done
> 

Small problem:

I've enabled debugging in the kernel
n0550:~# zgrep I2C /proc/config.gz
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_HELPER_AUTO=y
# I2C Hardware Bus support
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
# CONFIG_I2C_NFORCE2_S4985 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# I2C system bus drivers (mostly embedded / system-on-chip)
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_SIMTEC is not set
# External I2C/SMBus adapter drivers
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set
# Graphics adapter I2C/DDC channel drivers
# CONFIG_I2C_VOODOO3 is not set
# Other I2C/SMBus bus drivers
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_STUB is not set
# Miscellaneous I2C Chip support
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
CONFIG_I2C_DEBUG_CHIP=y
# I2C RTC drivers

and got i2cdump installed, created the device entry

and when I do a single call
i2cdump -y 0 0x2f

the output is
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 bd bb b1 bb 64 64 5e c8 a3 7b 13    .....????dd^??{?
10: a0 b9 97 ff 20 70 d1 7a cf cc c8 3e 1c 90 80 80    ???. p?z???>????
20: 20 1d 0b 00 77 00 73 00 77 0f ff 0f ff 0f ff 0f     ??.w.s.w?.?.?.?
30: ff 0f ff 0f ff 0f ff 00 00 00 00 ff ff ff ff ff    .?.?.?..........
40: 09 00 00 00 40 00 f7 ef e3 7f 3f 00 00 e0 0f 00    ?...@.?????..??.
50: 06 1e 01 00 00 00 00 00 28 01 00 00 1f 00 55 03    ???.....(?..?.U?
60: b9 73 c5 b2 9d 8e ff ff 23 20 2b 1c 7c 65 d9 c4    ?s????..# +?|e??
70: 83 77 db c6 db c6 e5 bb 50 4b 55 50 3c 37 af af    ?w??????PKUP<7??
80: 3c 37 55 50 3c 37 55 50 50 4b 55 50 32 2d 55 50    <7UP<7UPPKUP2-UP
90: 07 68 07 68 07 68 07 68 07 68 07 68 07 68 07 68    ?h?h?h?h?h?h?h?h
a0: 07 68 07 68 ff ff ff ff f7 f6 f6 f6 00 00 ff ff    ?h?h....????....
b0: 00 00 3f 3f 3f 3f 3f 3f 3f 3f 3f 89 89 89 89 89    ..??????????????
c0: 89 89 89 02 03 7f ff 00 00 ff ff ff ff ff ff ff    ??????..........
d0: 00 46 46 46 XX 00 f0 ff 80 01 80 01 80 01 80 01    .FFFX.?.????????
e0: bb c0 82 ff 80 2a fb 13 00 00 88 00 ff ff ff ff    ???.?*??..?.....
f0: 00 00 00 00 00 00 60 80 1b 00 ff 00 00 10 00 00    ......`??....?..

more interestingly, the sysog gets flooded with messages:
Apr 20 22:39:13 n0550 kernel: [  617.540836] i2c-adapter i2c-0: ioctl,
cmd=0x705, arg=0x7fffcbf214d8
Apr 20 22:39:13 n0550 kernel: [  617.540873] i2c-adapter i2c-0: ioctl,
cmd=0x703, arg=0x2f
Apr 20 22:39:13 n0550 kernel: [  617.540912] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:13 n0550 kernel: [  617.563768] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:13 n0550 kernel: [  617.583989] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:13 n0550 kernel: [  617.603769] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:13 n0550 kernel: [  617.623768] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
[...]
Apr 20 22:39:17 n0550 kernel: [  621.743765] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:17 n0550 kernel: [  621.763766] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:17 n0550 kernel: [  621.783765] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:17 n0550 kernel: [  621.803757] i801_smbus 0000:00:1f.3:
Lost arbitration
Apr 20 22:39:17 n0550 kernel: [  621.803794] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:18 n0550 kernel: [  622.803767] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:18 n0550 kernel: [  622.823765] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:18 n0550 kernel: [  622.843768] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
[...]
Apr 20 22:39:19 n0550 kernel: [  623.563766] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:19 n0550 kernel: [  623.583765] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:19 n0550 kernel: [  623.603765] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480
Apr 20 22:39:19 n0550 kernel: [  623.623765] i2c-adapter i2c-0: ioctl,
cmd=0x720, arg=0x7fffcbf21480


Does this help a bit?

Cheers

Carsten

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
