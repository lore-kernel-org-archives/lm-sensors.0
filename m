From: william.mcclintock@schriever.af.mil (McClintock William J Contr MCOM)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <B8BD20F161298A42A3B513D23A28556701101F42@fsglenex3.schriever.af.mil>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Looks good to me...thanks...

[root@workstation1 lm_sensors2]# cvs status kernel/busses/i2c-nforce2.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3DFile: i2c-nforce2.c     Status: Up-to-date

   Working revision:    1.7
   Repository revision: 1.7
/home/cvs/lm_sensors2/kernel/busses/i2c-nforce2.
c,v
   Sticky Tag:          (none)
   Sticky Date:         (none)
   Sticky Options:      (none)

[root@workstation1 lm_sensors2]# sensors
w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.62 V  (min =3D  +1.57 V, max =3D  +1.73 V)
VCore 2:   +1.63 V  (min =3D  +1.57 V, max =3D  +1.73 V)
+3.3V:     +3.23 V  (min =3D  +3.14 V, max =3D  +3.46 V)
+5V:       +4.92 V  (min =3D  +4.74 V, max =3D  +5.24 V)
+12V:     +11.78 V  (min =3D +10.83 V, max =3D +13.19 V)
-12V:     -11.47 V  (min =3D -13.16 V, max =3D -10.90 V)
-5V:       -4.85 V  (min =3D  -5.26 V, max =3D  -4.76 V)
V5SB:      +5.41 V  (min =3D  +4.74 V, max =3D  +5.24 V)
VBat:      +0.62 V  (min =3D  +2.40 V, max =3D  +3.60 V)
fan1:     5075 RPM  (min =3D 2678 RPM, div =3D 2)
fan2:     5273 RPM  (min =3D 6887 RPM, div =3D 2)
fan3:        0 RPM  (min =3D 2280 RPM, div =3D 4)
temp1:       +23?C  (high =3D   +34?C, hyst =3D   +91?C)   sensor =3D therm=
istor

temp2:     +30.0?C  (high =3D  +120?C, hyst =3D  +115?C)   sensor =3D therm=
istor

temp3:     +25.0?C  (high =3D  +120?C, hyst =3D  +115?C)   sensor =3D therm=
istor

vid:      +1.650 V
alarms:
beep_enable:
          Sound alarm disabled

eeprom-i2c-1-50
Adapter: SMBus nForce2 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-1-51
Adapter: SMBus nForce2 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

[root@workstation1 lm_sensors2]# lsmod | head
Module                  Size  Used by    Tainted: P
i2c-nforce2             4040   0  (unused)
eeprom                  5040   0  (unused)
w83781d                21744   0  (unused)
i2c-proc                7988   0  [eeprom w83781d]
i2c-isa                 1292   0  (unused)
i2c-core               19556   0  [i2c-nforce2 eeprom w83781d i2c-proc
i2c-isa]
nvaudio                39732   0  (unused)
ac97_codec             14536   0  [nvaudio]
soundcore               6468   2  [nvaudio]
[root@workstation1 lm_sensors2]#

-----Original Message-----
From: Mark Studebaker [mailto:mds@paradyne.com]
Sent: Wednesday, November 26, 2003 7:13 PM
To: McClintock William J Contr MCOM
Cc: sensors@Stimpy.netroedge.com; frdurso@yahoo.com.br; Hans-Frieder
Vogt
Subject: Re: unknown eeprom type (65) [ticket #1449]


I found and fixed what looked like the problem in i2c-nforce
that the eeprom module was seeing with byte writes.
It was writing the wrong data to the wrong place.
Can't say for sure because I don't have a datasheet.
Doubt that this was the cause of the oopses so there may be something
else going on too.
For those of you testing, if the old i2c-nforce won't rmmod you
will have to reboot.=20


McClintock William J Contr MCOM wrote:
>=20
> i2c-core.o: i2c core module version 2.8.1 (20031005)
> i2c-isa.o version 2.8.1 (20031005)
> i2c-proc.o version 2.8.1 (20031005)
> w83781d.o version 2.8.1 (20031005)
> eeprom.o version 2.8.1 (20031005)
> i2c-nforce2.o version 2.8.1 (20031005)
> i2c-nforce2.o: nForce2 SMBus adapter at 0x5000
> i2c-nforce2.o: nForce2 SMBus adapter at 0x5040
> i2c-dev.o: i2c /dev entries driver module version 2.8.1 (20031005)
> i2c-dev.o: Registered 'ISA main adapter' as minor 0
> i2c-dev.o: Registered 'SMBus nForce2 adapter at 5000' as minor 1
> i2c-dev.o: Registered 'SMBus nForce2 adapter at 5040' as minor 2
> Unable to handle kernel NULL pointer dereference at virtual address
00000000
>  printing eip:
> e0a5a216
> *pde =3D 00000000
> Oops: 0000
> i2c-dev i2c-nforce2 eeprom w83781d i2c-proc i2c-isa i2c-core nvaudio
> ac97_codec
> soundcore parport_pc lp parport iptable_filter ip_tables autofs nfs lockd
> sunr
> CPU:    0
> EIP:    0060:[<e0a5a216>]    Tainted: P
> EFLAGS: 00010246
>=20
> EIP is at nforce2_access [i2c-nforce2] 0x1b6 (2.4.20-13.9)
> eax: 00000000   ebx: 00005000   ecx: c17baa00   edx: 00000001
> esi: c17baa00   edi: 00000000   ebp: c17baa00   esp: d82a3e78
> ds: 0068   es: 0068   ss: 0068
> Process i2cdump (pid: 3542, stackpage=D82a3000)
> Stack: d82cd340 dffd2400 00000296 c25a6bb8 dffd2400 003462b0 00500000
> c17baa40
>        00000000 00000001 c17baa04 e0a40cc9 c17baa04 00000050 00000000
> 00000000
>        00000000 00000001 00000000 e0a5af20 d8277420 d83ec180 420ac6a0
> 00000050
> Call Trace:   [<e0a40cc9>] i2c_smbus_xfer_R935cccc0 [i2c-core] 0x89
> (0xd82a3ea4)
> )
> [<e0a5af20>] smbus_algorithm [i2c-nforce2] 0x0 (0xd82a3ec4))
> [<e0a5c14c>] i2cdev_ioctl [i2c-dev] 0x0 (0xd82a3ef0))
> [<e0a5c5af>] i2cdev_ioctl [i2c-dev] 0x463 (0xd82a3ef4))
> [<c01186c0>] schedule [kernel] 0x170 (0xd82a3f40))
> [<c01254d7>] schedule_timeout [kernel] 0x67 (0xd82a3f64))
> [<e0a5c14c>] i2cdev_ioctl [i2c-dev] 0x0 (0xd82a3f90))
> [<c0153d4c>] sys_ioctl [kernel] 0xbc (0xd82a3f94))
> [<c010939f>] system_call [kernel] 0x33 (0xd82a3fc0))
>=20
> Code: 8a 07 8d 53 04 ee e6 80 83 ce 04 e9 a3 fe ff ff 8b 9d f0 00
>=20
> -----Original Message-----
> From: Mark Studebaker [mailto:mds@paradyne.com]
> Sent: Wednesday, November 26, 2003 3:41 PM
> To: sensors@Stimpy.netroedge.com
> Cc: william.mcclintock@schriever.af.mil; frdurso@yahoo.com.br
> Subject: Re: unknown eeprom type (65) [ticket #1449]
>=20
> does dmesg have anything about a module going oops?
>=20
> Jean Delvare wrote:
>=20
> >>>[root@workstation1 cvs2]# i2cdump 1 50 c
> >>>  WARNING! This program can confuse your I2C bus, cause data loss
> >>>  and worse! I will probe file /dev/i2c-1, address 0x32, mode byte
> >>>  consecutive read You have five seconds to reconsider and press
> >>>  CTRL-C!
> >>>
> >>>Segmentation fault
> >
> >
> > Still this needs fixing. Mark, any idea about that? Could it be caused
> > by the i2c-nforce2 driver? Doing the same here (i2c-i801) exits cleanly:
> > Error: Write start address failed, return code -1
> >
