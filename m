From: njs@scifi.squawk.com (Nick Simicich)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: SMSC 47M14x - where is the output?
Message-Id: <1086642878.5504.1239.camel@quickdraw.squawk.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Using a much older version of the lm78 support, I recall seeing fan
speed output.  I could be wrong, it was quite a while ago.  I upgraded
the system to Fedora core 1, and installed all patches.  Now I get most
sensors, but not fans. I believe that this is because, even though the
module is detected, it is not loaded.  Please assist me with this, if
you can.

Linux quickdraw.squawk.com 2.4.22-1.2188.nptl #1 Wed Apr 21 20:36:05 EDT
2004 i686 i686 i386 GNU/Linux

The motherboard is an Intel D845PT. The motherboard manual claims that
it has an LPC47M142 with, among many other things, two fan tachometer
inputs.  This part number more or less corresponds with the smsc47m1
driver that was selected.

Looking in the dmesg output after I  do a reinsert, I see:

smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.

So that is my specific problem, as far as I can tell.

isadump 0x295 0x296 is all FF.

When I do a sensors-detect, I get the following output:

Driver `adm1025' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at efa0' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x2d
    Chip `Analog Devices ADM1025' (confidence: 8)
=20
Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at efa0' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at efa0' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
=20
Driver `smsc47m1' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0800 (Busdriver `i2c-isa')
    Chip `SMSC 47M14x Super IO Fan Sensors' (confidence: 8)

I am on Fedora core 1, so I elect to use the version of the startup
scripts that allow me to use "system V initialization".  I copy the
lm_sensors file in, and I fix the variable so that the "sensors" command
is found in /usr/bin rather than in /usr/local/bin.

When I issue a "service lm_sensors start", this is the output:

[root@quickdraw root]# service lm_sensors start
Starting up sensors: starting module __i2c-i801__
starting module __i2c-isa__
starting module __adm1025__
starting module __eeprom__
starting module __smsc47m1__
                                                           [  OK  ]
[root@quickdraw root]# sensors
adm1025-i2c-0-2d
Adapter: SMBus I801 adapter at efa0
Algorithm: Non-I2C SMBus adapter
VCore22:   +1.47 V  (min =3D  +1.38 V, max =3D  +1.54 V)
VCore:     +1.45 V  (min =3D  +1.40 V, max =3D  +1.55 V)
+3.3V:     +3.26 V  (min =3D  +2.93 V, max =3D  +3.59 V)
+5V:       +5.00 V  (min =3D  +4.45 V, max =3D  +5.44 V)
VCC:       +3.26 V  (min =3D  +2.93 V, max =3D  +3.59 V)
CPU Temp:  +32.0=C2=B0C  (low =3D   +0=C2=B0C, high =3D  +60=C2=B0C)
M/B Temp:  +35.0=C2=B0C  (low =3D   +0=C2=B0C, high =3D  +60=C2=B0C)
vid:       +1.50 V
=20
eeprom-i2c-0-50
Adapter: SMBus I801 adapter at efa0
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512
=20
eeprom-i2c-0-51
Adapter: SMBus I801 adapter at efa0
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256
=20
[root@quickdraw root]#

[root@quickdraw root]# cat /proc/sys/dev/sensors/chips
256     adm1025-i2c-0-2d
257     eeprom-i2c-0-50
258     eeprom-i2c-0-51
[root@quickdraw root]# ls -l /proc/sys/dev/sensors
total 0
dr-xr-xr-x  2 root root 0 Jun  6 20:25 adm1025-i2c-0-2d
-rw-r--r--  1 root root 0 Jun  6 20:25 chips
dr-xr-xr-x  2 root root 0 Jun  6 20:25 eeprom-i2c-0-50
dr-xr-xr-x  2 root root 0 Jun  6 20:25 eeprom-i2c-0-51
[root@quickdraw root]#=20

Finally, because it claimed that something was detected at address
0x0800 in isa space, so, while I am unsure that this will help, here it
is:

[root@quickdraw root]# isadump -f 0x800
  WARNING! Running this program can cause system crashes, data loss and
worse!
  I will probe address range 0x0800 to 0x08ff.
  You have five seconds to reconsider and press CTRL-C!
=20
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 38 ff 77 bf a0 00 04 00 00 00 00 00
10: 00 04 77 df ca 00 00 00 00 00 00 00 00 00 02 00
20: 00 00 00 80 80 80 80 80 80 80 80 81 81 80 00 80
30: 80 80 84 05 05 04 04 05 04 84 84 04 04 84 80 05
40: 05 05 04 05 04 05 04 81 81 00 00 ff 75 1e 00 57
50: 02 00 00 00 ff ff 01 01 f0 25 32 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: ff ff ff ff 00 00 ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[root@quickdraw root]#

[root@quickdraw root]# modprobe smsc47m1 force_addr=3D0x0800
/lib/modules/2.4.22-1.2188.nptl/kernel/drivers/sensors/smsc47m1.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-1.2188.nptl/kernel/drivers/sensors/smsc47m1.o:
insmod /lib/modules/2.4.22-1.2188.nptl/kernel/drivers/sensors/smsc47m1.o
failed
/lib/modules/2.4.22-1.2188.nptl/kernel/drivers/sensors/smsc47m1.o:
insmod smsc47m1 failed
[root@quickdraw root]#


[root@quickdraw root]# lsmod
Module                  Size  Used by    Not tainted
eeprom                  4980   0  (unused)
adm1025                 7056   0  (unused)
i2c-proc                8496   0  [eeprom adm1025]
i2c-isa                 1896   0  (unused)
i2c-i801                5652   0
i2c-dev                 5060   0
i2c-core               18884   0  [eeprom adm1025 i2c-proc i2c-isa
i2c-i801 i2c-dev]
sr_mod                 17400   0  (autoclean)
smbfs                  42672   1  (autoclean)
i810_audio             27560   1  (autoclean)
ac97_codec             16744   0  (autoclean) [i810_audio]
soundcore               6468   2  (autoclean) [i810_audio]
radeon                119268   7
agpgart                56100   3
binfmt_misc             7212   1
nfsd                   79472   8  (autoclean)
lockd                  57328   1  (autoclean) [nfsd]
sunrpc                 83580   1  (autoclean) [nfsd lockd]
autofs                 12084   1  (autoclean)
8139too                16616   1
mii                     3992   0  [8139too]
ide-scsi               12016   0
scsi_mod              110280   2  [sr_mod ide-scsi]
ide-cd                 34432   0
cdrom                  34592   0  [sr_mod ide-cd]
keybdev                 2656   0  (unused)
mousedev                5268   0  (unused)
hid                    23908   0  (unused)
input                   5888   0  [keybdev mousedev hid]
usb-uhci               26124   0  (unused)
usbcore                78752   1  [hid usb-uhci]
ext3                   71620   8
jbd                    51276   8  [ext3]
[root@quickdraw root]#
[root@quickdraw root]#



That is how I would tell the story. I am looking at your FAQ 5.1, here
is what is missing - this is typescript output.

Script started on Mon 07 Jun 2004 04:25:46 PM EDT
=1B]0;root@quickdraw:~=07[root@quickdraw root]# DMEST=08 =08=08 =08=08 =08=
=08 =08=08 =08=07dmesg
t=3D-104, setting invalid
smb_retry: successful, new pid=1900, generation=3D9
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation=10
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation=11
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation=12
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation=13
usb-uhci.c: interrupt, status 2, frame# 618
usbdevfs: process 27374 (lsusb) did not claim interface 0 before use
i2c-core.o: i2c core module
i2c-proc.o version 2.6.1 (20010825)
lm78.o version 2.6.5 (20020915)
i2c-core.o: driver LM78(-J) and LM79 sensor driver registered.
i2c-i801.o version 2.6.5 (20020915)
i2c-core.o: adapter SMBus I801 adapter at efa0 registered as adapter 0.
i2c-i801.o: I801 bus detected and initialized
i2c-algo-pcf.o: i2c pcf8584 algorithm module
i2c-elektor.o: i2c pcf8584-isa adapter module
i2c-algo-bit.o: i2c bit algorithm module
i2c-elv.o: i2c ELV parallel port adapter module
i2c-algo-bit.o: i2c bit algorithm module
i2c-philips-par.o: i2c Philips parallel port adapter module
i2c-philips-par.o: attaching to parport0
parport0: cannot grant exclusive access for device i2c-philips-par
i2c-philips-par: Unable to register with parport.
i2c-velleman.o: i2c Velleman K8000 adapter module
i2c-velleman.o: Port 0x378 already in use.
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-dev.o: Registered 'SMBus I801 adapter at efa0' as minor 0
i2c-isa.o version 2.6.5 (20020915)
i2c-dev.o: Registered 'ISA main adapter' as minor 1
i2c-core.o: adapter ISA main adapter registered as adapter 1.
i2c-isa.o: ISA bus access for i2c modules initialized.
adm1025.o version 2.6.5 (20020915)
i2c-core.o: driver ADM1025 sensor driver registered.
i2c-core.o: client [ADM1025 chip] registered to adapter [SMBus I801
adapter at efa0](pos. 0).
eeprom.o version 2.6.5 (20020915)
i2c-core.o: driver EEPROM READER registered.
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 1).
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 2).
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation=14
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
i2c-core.o: client [EEPROM chip] unregistered.
i2c-core.o: client [EEPROM chip] unregistered.
i2c-core.o: driver unregistered: EEPROM READER
i2c-core.o: client [ADM1025 chip] unregistered.
i2c-core.o: driver unregistered: ADM1025 sensor driver
i2c-core.o: adapter unregistered: ISA main adapter
i2c-core.o: adapter unregistered: SMBus I801 adapter at efa0
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 44x/40x writer cd/rw xa/form2 cdda tray
i2c-i801.o version 2.6.5 (20020915)
i2c-dev.o: Registered 'SMBus I801 adapter at efa0' as minor 0
i2c-core.o: adapter SMBus I801 adapter at efa0 registered as adapter 0.
i2c-i801.o: I801 bus detected and initialized
i2c-isa.o version 2.6.5 (20020915)
i2c-dev.o: Registered 'ISA main adapter' as minor 1
i2c-core.o: adapter ISA main adapter registered as adapter 1.
i2c-isa.o: ISA bus access for i2c modules initialized.
adm1025.o version 2.6.5 (20020915)
i2c-core.o: driver ADM1025 sensor driver registered.
i2c-core.o: client [ADM1025 chip] registered to adapter [SMBus I801
adapter at efa0](pos. 0).
eeprom.o version 2.6.5 (20020915)
i2c-core.o: driver EEPROM READER registered.
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 1).
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 2).
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
i2c-core.o: client [EEPROM chip] unregistered.
i2c-core.o: client [EEPROM chip] unregistered.
i2c-core.o: driver unregistered: EEPROM READER
i2c-core.o: client [ADM1025 chip] unregistered.
i2c-core.o: driver unregistered: ADM1025 sensor driver
i2c-core.o: adapter unregistered: ISA main adapter
i2c-core.o: adapter unregistered: SMBus I801 adapter at efa0
i2c-i801.o version 2.6.5 (20020915)
i2c-dev.o: Registered 'SMBus I801 adapter at efa0' as minor 0
i2c-core.o: adapter SMBus I801 adapter at efa0 registered as adapter 0.
i2c-i801.o: I801 bus detected and initialized
i2c-isa.o version 2.6.5 (20020915)
i2c-dev.o: Registered 'ISA main adapter' as minor 1
i2c-core.o: adapter ISA main adapter registered as adapter 1.
i2c-isa.o: ISA bus access for i2c modules initialized.
adm1025.o version 2.6.5 (20020915)
i2c-core.o: driver ADM1025 sensor driver registered.
i2c-core.o: client [ADM1025 chip] registered to adapter [SMBus I801
adapter at efa0](pos. 0).
eeprom.o version 2.6.5 (20020915)
i2c-core.o: driver EEPROM READER registered.
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 1).
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 2).
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation=15
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation=16
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation=17
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation=18
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation=19
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation=20
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation!
i2c-core.o: client [EEPROM chip] unregistered.
i2c-core.o: client [EEPROM chip] unregistered.
i2c-core.o: driver unregistered: EEPROM READER
i2c-core.o: client [ADM1025 chip] unregistered.
i2c-core.o: driver unregistered: ADM1025 sensor driver
Unable to handle kernel paging request at virtual address f091b398
 printing eip:
f091b398
*pde =3D 0191a067
*pte =3D 00000000
Oops: 0000
i2c-isa i2c-i801 sr_mod i2c-dev i2c-philips-par i2c-algo-bit lm78
i2c-proc i2c-core smbfs i810_audio ac97_codec soundcore radeon agpgart
binfmt_misc nfsd lock
CPU:    0
EIP:    0060:[<f091b398>]    Not tainted
EFLAGS: 00010286

EIP is at __insmod_i2c-isa_S.data_L292 [i2c-isa] 0x1d58
(2.4.22-1.2188.nptl)
eax: 000000d1   ebx: 00000005   ecx: f0917560   edx: 000000d1
esi: 0000000a   edi: e63b883c   ebp: e63b8800   esp: c4e05dd0
ds: 0068   es: 0068   ss: 0068
Process ksysguardd (pid: 4326, stackpage=C4e05000)
Stack: e63b8800 00000035 f091b64c e63b8800 00000035 e63b8844 2534032c
00000000=20
       e63b883c e63b8800 c4e05e64 f091b88e e63b8800 eea200d1 00000000
ffffffff=20
       000000fa 000000e1 0000014a 000001f4 000004b0 0000014a c013a675
c18be620=20
Call Trace:   [<c013a675>] lru_cache_add [kernel] 0x65 (0xc4e05e28)
[<f4d8c8e2>] i2c_sysctl_real_R8b6718e6 [i2c-proc] 0x122 (0xc4e05e40)
[<c020a3af>] __kfree_skb [kernel] 0xef (0xc4e05eb4)
[<c0259f2b>] unix_stream_recvmsg [kernel] 0x21b (0xc4e05ec4)
[<c0122bba>] do_sysctl_strategy [kernel] 0x17a (0xc4e05ef8)
[<c01227d3>] do_sysctl [kernel] 0x93 (0xc4e05f30)
[<c0122899>] sys_sysctl [kernel] 0x89 (0xc4e05f68)
[<c0109747>] system_call [kernel] 0x33 (0xc4e05fc0)


Code:  Bad EIP value.
 i2c-core.o: adapter unregistered: ISA main adapter
i2c-core.o: adapter unregistered: SMBus I801 adapter at efa0
i2c-core.o: driver unregistered: LM78(-J) and LM79 sensor driver
i2c-core.o: driver unregistered: i2c-dev dummy driver
i2c-core.o: i2c core module
i2c-i801.o version 2.6.5 (20020915)
i2c-core.o: adapter SMBus I801 adapter at efa0 registered as adapter 0.
i2c-i801.o: I801 bus detected and initialized
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-dev.o: Registered 'SMBus I801 adapter at efa0' as minor 0
i2c-core.o: driver unregistered: i2c-dev dummy driver
i2c-core.o: adapter unregistered: SMBus I801 adapter at efa0
i2c-core.o: i2c core module
i2c-proc.o version 2.6.1 (20010825)
i2c-i801.o version 2.6.5 (20020915)
i2c-core.o: adapter SMBus I801 adapter at efa0 registered as adapter 0.
i2c-i801.o: I801 bus detected and initialized
i2c-isa.o version 2.6.5 (20020915)
i2c-core.o: adapter ISA main adapter registered as adapter 1.
i2c-isa.o: ISA bus access for i2c modules initialized.
adm1025.o version 2.6.5 (20020915)
i2c-core.o: driver ADM1025 sensor driver registered.
i2c-core.o: client [ADM1025 chip] registered to adapter [SMBus I801
adapter at efa0](pos. 0).
eeprom.o version 2.6.5 (20020915)
i2c-core.o: driver EEPROM READER registered.
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 1).
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 2).
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
i2c-core.o: client [EEPROM chip] unregistered.
i2c-core.o: client [EEPROM chip] unregistered.
i2c-core.o: driver unregistered: EEPROM READER
i2c-core.o: client [ADM1025 chip] unregistered.
i2c-core.o: driver unregistered: ADM1025 sensor driver
i2c-core.o: adapter unregistered: ISA main adapter
i2c-core.o: adapter unregistered: SMBus I801 adapter at efa0
i2c-core.o: i2c core module
i2c-proc.o version 2.6.1 (20010825)
i2c-core.o: i2c core module
i2c-i801.o version 2.6.5 (20020915)
i2c-core.o: adapter SMBus I801 adapter at efa0 registered as adapter 0.
i2c-i801.o: I801 bus detected and initialized
i2c-isa.o version 2.6.5 (20020915)
i2c-core.o: adapter ISA main adapter registered as adapter 1.
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.6.1 (20010825)
adm1025.o version 2.6.5 (20020915)
i2c-core.o: driver ADM1025 sensor driver registered.
i2c-core.o: client [ADM1025 chip] registered to adapter [SMBus I801
adapter at efa0](pos. 0).
eeprom.o version 2.6.5 (20020915)
i2c-core.o: driver EEPROM READER registered.
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 1).
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 2).
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
smb_get_length: recv error =3D 512
smb_request: result -512, setting invalid
smb_retry: caught signal
i2c-core.o: client [EEPROM chip] unregistered.
i2c-core.o: client [EEPROM chip] unregistered.
i2c-core.o: driver unregistered: EEPROM READER
i2c-core.o: client [ADM1025 chip] unregistered.
i2c-core.o: driver unregistered: ADM1025 sensor driver
Unable to handle kernel paging request at virtual address f0925398
 printing eip:
f0925398
*pde =3D 0191a067
*pte =3D 00000000
Oops: 0000
i2c-isa i2c-i801 i2c-core sr_mod smbfs i810_audio ac97_codec soundcore
radeon agpgart binfmt_misc nfsd lockd sunrpc autofs 8139too mii ide-scsi
scsi_mod ide-c
CPU:    0
EIP:    0060:[<f0925398>]    Not tainted
EFLAGS: 00210286

EIP is at __insmod_i2c-isa_S.data_L292 [i2c-isa] 0x5d58
(2.4.22-1.2188.nptl)
eax: 0000003c   ebx: 00000005   ecx: f091d560   edx: 0000003c
esi: 0000000a   edi: e63b883c   ebp: e63b8800   esp: d9a37dd0
ds: 0068   es: 0068   ss: 0068
Process ksysguardd (pid: 6117, stackpage=D9a37000)
Stack: e63b8800 00000039 f0925692 e63b8800 00000039 e63b8844 0634032c
00000004=20
       e63b883c e63b8800 d9a37e64 f092588e e63b8800 d40e60ca e63b8844
00010d6a=20
       000000fa 000000e1 0000014a 000001f4 000004b0 0000014a f09283eb
ec670e00=20
Call Trace:   [<c020a3af>] __kfree_skb [kernel] 0xef (0xd9a37eb4)
[<c0259f2b>] unix_stream_recvmsg [kernel] 0x21b (0xd9a37ec4)
[<c0122bba>] do_sysctl_strategy [kernel] 0x17a (0xd9a37ef8)
[<c01227d3>] do_sysctl [kernel] 0x93 (0xd9a37f30)
[<c0122899>] sys_sysctl [kernel] 0x89 (0xd9a37f68)
[<c0109747>] system_call [kernel] 0x33 (0xd9a37fc0)


Code:  Bad EIP value.
 i2c-core.o: adapter unregistered: ISA main adapter
i2c-core.o: adapter unregistered: SMBus I801 adapter at efa0
i2c-core.o: i2c core module
i2c-proc.o version 2.6.1 (20010825)
i2c-core.o: i2c core module
i2c-i801.o version 2.6.5 (20020915)
i2c-core.o: adapter SMBus I801 adapter at efa0 registered as adapter 0.
i2c-i801.o: I801 bus detected and initialized
i2c-isa.o version 2.6.5 (20020915)
i2c-core.o: adapter ISA main adapter registered as adapter 1.
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.6.1 (20010825)
adm1025.o version 2.6.5 (20020915)
i2c-core.o: driver ADM1025 sensor driver registered.
i2c-core.o: client [ADM1025 chip] registered to adapter [SMBus I801
adapter at efa0](pos. 0).
eeprom.o version 2.6.5 (20020915)
i2c-core.o: driver EEPROM READER registered.
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 1).
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 2).
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation#
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation$
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation%
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation&
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation'
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation(
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation)
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation0
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation1
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation2
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation3
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation4
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation5
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation6
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation7
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation8
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation9
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generation@
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generationA
smb_request: result -104, setting invalid
smb_retry: successful, new pid=1900, generationB
=1B]0;root@quickdraw:~=07[root@quickdraw root]# sendors-detect
bash: sendors-detect: command not found
=1B]0;root@quickdraw:~=07[root@quickdraw root]# sendors-detect=08 =08=08 =
=08=08 =08=08 =08=08
=08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08so=07rs-detect=20

This program will help you determine which I2C/SMBus modules you need
to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things
may
seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): AMI  =20
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):=20
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801BA ICH2
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):=20
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):=20
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at efa0 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):=20
Client at address 0x2d can not be probed - unload all client drivers
first!
Client found at address 0x44
Client at address 0x50 can not be probed - unload all client drivers
first!
Client at address 0x51 can not be probed - unload all client drivers
first!
Client found at address 0x69
Client found at address 0x7f

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):=20
=1B]0;root@quickdraw:~=07[root@quickdraw root]# sert=08 =08=08 =08rc=08 =08=
vice
lm_sensors sti=08 =08op
Shutting down sensors: =1B[60G[  =1B[0;32mOK=1B[0;39m  ]
=1B]0;root@quickdraw:~=07[root@quickdraw root]# service lm_sensors
stop=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=1B[8Pns=
ors-detect=20

This program will help you determine which I2C/SMBus modules you need
to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things
may
seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): AMI  =20
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):=20
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801BA ICH2
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):=20
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):=20
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at efa0 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):=20
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85'... Failed!
Probing for `Analog Devices ADM1027 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 and EMC6D101'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Success!
    (confidence 8, driver `adm1025')
Probing for `Philips NE1619'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x44
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69
Client found at address 0x7f

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):=20
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no):=20
Probing for `SMSC 47M10x Super IO Fan Sensors'
  Failed! (0x5f)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Success... found at address 0x0800
Probing for `VT1211 Super IO Sensors'
  Failed!
Probing for `Winbond W83627HF Super IO Sensors'
  Failed!
Probing for `Winbond W83627THF Super IO Sensors'
  Failed!
Probing for `Winbond W83697HF Super IO Sensors'
  Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:=20

Driver `adm1025' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at efa0' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x2d
    Chip `Analog Devices ADM1025' (confidence: 8)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at efa0' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at efa0' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

Driver `smsc47m1' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0800 (Busdriver `i2c-isa')
    Chip `SMSC 47M14x Super IO Fan Sensors' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C
bus.
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?=20

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe adm1025
modprobe eeprom
modprobe smsc47m1
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really
should
try these commands right now to make sure everything is working
properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): no

=1B]0;root@quickdraw:~=07[root@quickdraw root]# sensors-detect
=08=08=08=08=08=08=08=08=08=08=08=08=08rvice lm_sensors stop=08 =08=08 =08a=
e=08 =08rt
Starting up sensors: starting module __i2c-i801__
starting module __i2c-isa__
starting module __adm1025__
starting module __eeprom__
starting module __smsc47m1__
=1B[60G[  =1B[0;32mOK=1B[0;39m  ]
=1B]0;root@quickdraw:~=07[root@quickdraw root]# dmest =08 =08=08 =08g | tai=
lo=08 =08
-25
i2c-core.o: client [EEPROM chip] unregistered.
i2c-core.o: driver unregistered: EEPROM READER
i2c-core.o: client [ADM1025 chip] unregistered.
i2c-core.o: driver unregistered: ADM1025 sensor driver
i2c-core.o: adapter unregistered: ISA main adapter
i2c-core.o: adapter unregistered: SMBus I801 adapter at efa0
i2c-i801.o version 2.6.5 (20020915)
i2c-dev.o: Registered 'SMBus I801 adapter at efa0' as minor 0
i2c-core.o: adapter SMBus I801 adapter at efa0 registered as adapter 0.
i2c-i801.o: I801 bus detected and initialized
i2c-proc.o version 2.6.1 (20010825)
i2c-isa.o version 2.6.5 (20020915)
i2c-dev.o: Registered 'ISA main adapter' as minor 1
i2c-core.o: adapter ISA main adapter registered as adapter 1.
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.6.1 (20010825)
adm1025.o version 2.6.5 (20020915)
i2c-core.o: driver ADM1025 sensor driver registered.
i2c-core.o: client [ADM1025 chip] registered to adapter [SMBus I801
adapter at efa0](pos. 0).
eeprom.o version 2.6.5 (20020915)
i2c-core.o: driver EEPROM READER registered.
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 1).
i2c-core.o: client [EEPROM chip] registered to adapter [SMBus I801
adapter at efa0](pos. 2).
smsc47m1.o version 2.6.5 (20020915)
smsc47m1.o: SMSC47M1xx not detected, module not inserted.
=1B]0;root@quickdraw:~=07[root@quickdraw root]# rpm =3D=08 =08-q k=08 =08ke=
rnet=08 =08l
kernel-2.4.22-1.2115.nptl
kernel-2.4.22-1.2174.nptl
kernel-2.4.22-1.2179.nptl
kernel-2.4.22-1.2188.nptl
=1B]0;root@quickdraw:~=07[root@quickdraw root]# uname -a
Linux quickdraw.squawk.com 2.4.22-1.2188.nptl #1 Wed Apr 21 20:36:05 EDT
2004 i686 i686 i386 GNU/Linux
=1B]0;root@quickdraw:~=07[root@quickdraw root]# rpm -q sensors
package sensors is not installed
=1B]0;root@quickdraw:~=07[root@quickdraw root]# type sensors-detect
sensors-detect is hashed (/usr/sbin/sensors-detect)
=1B]0;root@quickdraw:~=07[root@quickdraw root]# t=08 =08rpm -q --whatpe=08 =
=08roc=08
=08vidd=08 =08es /usr/sn=08 =08bin/sensore=08 =08s-dectect
error: file /usr/sbin/sensors-dectect: No such file or directory
=1B]0;root@quickdraw:~=07[root@quickdraw root]# rpm -q --whatprovides
/usr/sbin/sensors-dectect=08 =08=08 =08=08 =08=08 =08=08 =08tect=20
lm_sensors-2.8.1-1
=1B]0;root@quickdraw:~=07[root@quickdraw root]#=20
Script done on Mon 07 Jun 2004 04:31:05 PM EDT


--=20
Blog: http://majordomo.squawk.com/njs/blog/blogger.html
Atom: http://majordomo.squawk.com/njs/blog/atom.xml
RSS: http://majordomo.squawk.com/njs/blog/atom.rdf
