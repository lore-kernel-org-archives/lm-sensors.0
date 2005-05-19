From: ondrej.cecak@centrum.cz (Ondrej Cecak)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: ne1619 (really almost solved)
Message-Id: <200307301857.51608.ondrej.cecak@centrum.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307292322.53518.ondrej.cecak@centrum.cz>
In-Reply-To: <200307292322.53518.ondrej.cecak@centrum.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dne st 30. ?ervence 2003 12:01 jste napsal(a):
> > btw: is possible send emails with attachment to sensors@...?
>
> Yes it is. HTML is prohibited but reasonably-sized attachements are OK.

All right ...

I reproduce Oops ...
I was a normal user with runned gkrellm, xmms, kde3.1, .... After I runned =

"sensors" and it failed with SIGSEGV (after info from eeprom). Output in=20
attachement. (system - 2.4.21 + old CVS XFS, Debian "Woody" 3.0-r1 up to=20
date)

(Maybe it's fixed by new eeprom driver)

> OK, looks like you have DRDRAM (aka Direct Rambus) RIMMs. 2 modules of
> 256MB each, right? That kind of memory is supposed to be found on
> laptops, which isn't your case IIRC. Strange...

Yes, in manual is "RIMMs containing Direct Rambus DRAM (RDRAM) devices".

> Anyway, I added support for DRDRAM to sensors, and to detect-dimms.pl
> too (just the name, only DIMMs are really supported). Feel free to give
> it a try, and feedback will be appreciated if you do so.

great work ...

(I can't reboot now, I made unload/load new modules only)

PC DIMM Serial Presence Detect Tester/Decoder
By Philip Edelbrock, Christian Zuckschwerdt and others
Version 2.6.6

Number of SDRAM DIMMs detected and decoded      0

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at efa0
Algorithm: Non-I2C SMBus adapter
Memory type:            DRDRAM RIMM
Memory size (MB):       256

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at efa0
Algorithm: Non-I2C SMBus adapter
Memory type:            DRDRAM RIMM
Memory size (MB):       256

btw: maybe one more small mistake in new driver ne1619, values of SYS and C=
PU=20
temp looks like changed. e.g. if I run "yes > /dev/null" and load of CPU is=
=20
100%:

SYS Temp:  +49.0?C  (min =3D   +5?C, max =3D  +65?C)
CPU Temp:  +43.0?C  (min =3D   +5?C, max =3D  +65?C)

regards
--=20
Ondrej Cecak
-------------- next part --------------
printing eip:
c0114634
Oops: 0002
sr_mod sg vfat fat NVdriver eeprom adm1025
i2c-proc i2c-i801 i2c-core vmnet parport_pc parport vmmon scanner printer
usb-ohci ehci-hcd usbcore ipt_TOS iptable_mangle ipt_MASQUERADE ipt_limit
ipt_state iptable_nat ip_conntrack_irc ip_conntrack_ftp ip_conntrack serial
iptable_filter ip_tables apm i810_audio ac97_codec soundcore 3c59x ide-scsi
scsi_mod ide-cd cdrom rtc
CPU:    0
EIP:    0010:[<c0114634>]    Tainted: PF
EFLAGS: 00010086
eax: e0954f48   ebx: 00000001   ecx: 00000202   edx: d8c1dd80
esi: d8c1dd78   edi: d8c1c000   ebp: 00000000   esp: d8c1dd60
ds: 0018   es: 0018   ss: 0018
Process gkrellm (pid: 1577, stackpage=D8c1d000)
Stack: e0954f3c d8c1dd78 c0105a39 e0954f3c 00000002 0000002d 00000001 d8c1c=
000
       e0954f48 00000001 c0105b98 e0954f3c e0954f00 e0954ec0 e09510ce 00d88=
14d
       00000000 0120de14 00000000 de693abc de693a80 de693ae0 e09506b4 e0954=
f00
Call Trace: [<e0954f3c>]  [<c0105a39>]
[<e0954f3c>]  [<e0954f48>]  [<c0105b98>]  [<e0954f3c>]  [<e0954f00>]
[<e0954ec0>]  [<e09510ce>]  [<e09506b4>]  [<e0954f00>]  [<c012bfd0>]
[<c012bdc6>]  [<c0122d96>]  [<e095a442>]  [<e095a706>]  [<e095a6c0>]
[<e09576a1>]  [<c014dc71>]  [<c0139ddb>]  [<c0123392>]  [<c01238de>]
[<c01238ea>]  [<c011abd2>]  [<c011ac00>]  [<c0131596>]  [<c0106bd3>]
Code: 89 13 51 9d 5b 5e c3 90 56 53 89 d6 9c
5a fa 8d 5e 08 8b 4b
<1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
printing eip:
c01137a3
Oops: 0000
sr_mod sg vfat fat NVdriver eeprom adm1025
i2c-proc i2c-i801 i2c-core vmnet parport_pc parport vmmon scanner printer
usb-ohci ehci-hcd usbcore ipt_TOS iptable_mangle ipt_MASQUERADE ipt_limit
ipt_state iptable_nat ip_conntrack_irc ip_conntrack_ftp ip_conntrack serial
iptable_filter ip_tables apm i810_audio ac97_codec soundcore 3c59x ide-scsi
scsi_mod ide-cd cdrom rtc
CPU:    0
EIP:    0010:[<c01137a3>]    Tainted: PF
EFLAGS: 00010097
eax: e0954f44   ebx: e0954f44   ecx:
00000000   edx: 00000003
esi: e0954f48   edi: 00000001   ebp:
c2db7cf0   esp: c2db7cd8
ds: 0018   es: 0018   ss: 0018
Process sensors (pid: 2131, stackpage=C2db7000)
Stack: e0954f3c 00000001 00000051 e0954f48 00000286 00000003 00000000 c0105=
9f6
       c0105bbc e0954f3c 0000efa5 e0954f00 e09510d8 0059c6e0 00000000 0100c=
7e4
       00000005 defc8a5c c2db7e2c defc8a3c e0950648 e0954f00 00000051 00000=
000
Call Trace: [<e0954f3c>]  [<e0954f48>]
[<c01059f6>]  [<c0105bbc>]  [<e0954f3c>]  [<e0954f00>]  [<e09510d8>]
[<e0950648>]  [<e0954f00>]  [<e0950f17>]  [<e0954fc5>]
[xfs_zero_last_block+2896/4536]  [<e0950f39>]  [<e0954f00>]
[scanner:__insmod_scanner_O/lib/modules/2.4.21-xfs/kernel/drivers/us+-44971=
5/96]
[scanner:__insmod_scanner_O/lib/modules/2.4.21-xfs/kernel/drivers/us+-44945=
8/96]
[<e09577f4>]  [sys_msgsnd+32781/70192]  [<e0957755>]
[scanner:__insmod_scanner_O/lib/modules/2.4.21-xfs/kernel/drivers/us+-44966=
0/96]
[<c0125158>]  [sys_msgsnd+41779/70192]  [sys_msgsnd+27915/70192]  [<c011a84=
9>]
[<c011a7b5>]  [<c011a5ec>]  [<c011a687>]  [<c0106bd3>]
Jul 30 17:57:40 localhost kernel: Code: 8b 01 85 45 fc 74 4c 31 c0 9c 5e fa=
 c7
01 00 00 00 00 83 79
