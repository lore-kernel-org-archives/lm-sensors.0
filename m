From: pierre.lamon@epfl.ch (Pierre Lamon)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Follow up for Ticket 1538
Message-Id: <LAECJBKLNEJMMONPNMGPOEGDCBAA.pierre.lamon@epfl.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <LAECJBKLNEJMMONPNMGPGEFPCBAA.pierre.lamon@epfl.ch>
In-Reply-To: <LAECJBKLNEJMMONPNMGPGEFPCBAA.pierre.lamon@epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

it would be nice if you can find what's going on. Here is a detailed
description of the problem (kernel 2.4.24):

While modprobing the module the following error occurs (modprobe
i2c-pcf-epp):

On the console:
/lib/modules/2.4.20/kernel/drivers/i2c/i2c-pcf-epp.o: init_module: No such
device or address
Hint: insmod errors can be caused by incorrect module parameters, including
invalid IO or IRQ parameters
/lib/modules/2.4.20/kernel/drivers/i2c/i2c-pcf-epp.o: insmod
/lib/modules/2.4.20/kernel/drivers/i2c/i2c-pcf-epp.o failed
/lib/modules/2.4.20/kernel/drivers/i2c/i2c-pcf-epp.o: insmod i2c-pcf-epp
failed

Here is the content of dmesg:
i2c-core.o: i2c core module version 2.8.2 (20031211)
i2c-pcf-epp.o: i2c pcf8584-epp adapter module version 2.8.2 (20031211)
i2c_pcf_add_bus caused an error: -6

Before loading the module (less /proc/interrupts):
      CPU0
  0:      34934          XT-PIC  timer
  1:        112          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 10:         14          XT-PIC  ide1
 11:         40          XT-PIC  usb-uhci, eth0
 12:         20          XT-PIC  PS/2 Mouse
 14:       3193          XT-PIC  ide0
NMI:          0
ERR:          0

After (there is a segfault)
Unable to handle kernel paging request at virtual address cf86666b
*pde =3D 0ed3e067
*pte =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02308a0>]    Not tainted
EFLAGS: 00010297
eax: cf86666b   ebx: cd6770b2   ecx: cf86666b   edx: fffffffe
esi: cd9a9f1c   edi: ffffffff   ebp: cf86666b   esp: cd9a9ec4
ds: 0018   es: 0018   ss: 0018
Process less (pid: 1319, stackpage=CD9a9000)
Stack: cd6770b0 cdc5aa00 00000007 000000e0 cdc5aa00 00000007 ffffffff
00000000
       ffffffff c0230aa5 cd6770b0 32988f50 c0234f37 cd9a9f18 c0230abd
cd6770b0
       c0234f34 cd9a9f18 c01095d2 cd6770b0 c0234f34 cf86666b cd6770a1
c0234f2e
Call Trace:    [<c0230aa5>] [<c0230abd>] [<c01095d2>] [<c0148c46>]
[<c0146cfd>]
  [<c012cb2e>] [<c01084a3>]

Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 89 44 24 10 8b 44
 Segmentation fault


The available bios options are as follow (related to the parallel port):

Onboard parallel port : [3BC/IRQ7] or [378/IRQ7] or [278/IRQ5] (choosen
[378/IRQ7])
Onboard parallel mode : [EPP] or [ECP] or [ECP/EPP] (choosen [EPP])
EPP type: [EPP1.7] or [EPP1.9] (choosen [EPP1.9])

IRQ-7 assigned to [Legacy ISA] or [PCI/ISA PnP] (choosen [PCI/ISA PnP])

Which configuration should I use ?

>Great. Couldn't you do the same with more simple parallel-ports
>adapters, such as i2c-philips-par, i2c-elv or i2c-velleman? These have
>been ported to Linux 2.6 already, and are supported by my unified driver
>too, while i2c-pport hasn't been ported and isn't part of the unified
>driver.

Since we have developped our own PC104 motherboard we wanted to integrate
the i2c circuit on it. I couldn't find the elv and velleman schematics.
Furthermore, I was concerning about the performances: hoping that the use of
the PCF8584 will provide better performance. (less cpu load, interrupt
driven for byte reading, etc.)

>Actually I wonder if I will port and/or integrate the i2c-pport logic in
>Linux 2.6, because in most cases, the additional complexity shouldn't be
>required. But if you really need it, I'll think of it.

i2c-pport was very convenient for testing. It took less than an hour for
wiring the cables, loading the module and detecting the slave with
i2cdetect. I might not be the only one who needs it.

Thanks for all!

~Pierre

PS : btw, here is the robot I'm working on
http://asl.epfl.ch/index.html?content=3Dresearch/systems/Solero/solero.php


-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: Tuesday, January 27, 2004 10:01 PM
To: pierre.lamon@epfl.ch
Cc: LM Sensors
Subject: Re: Follow up for Ticket 1538


> thanks a lot for your answer. I've finally choosen not to use the
> PCF8584 for interfacing the i2c bus because I was not able to modprobe
> it whatever the kernel or the i2c-x version (I've been trying for
> around 3 days). However, I'm still interested to know if it has been
> tested and if anybody uses it successfully.

I'm surprised you couldn't get it to work. As far as I know, the driver
is precisely made for people who build a board according to Simon Vogl's
schematics. If you provide details about the failures, we might try to
help.

> Finally I'm using direct parallel port access and everything works
> fine with the i2c-pport driver :-)

Great. Couldn't you do the same with more simple parallel-ports
adapters, such as i2c-philips-par, i2c-elv or i2c-velleman? These have
been ported to Linux 2.6 already, and are supported by my unified driver
too, while i2c-pport hasn't been ported and isn't part of the unified
driver.

Actually I wonder if I will port and/or integrate the i2c-pport logic in
Linux 2.6, because in most cases, the additional complexity shouldn't be
required. But if you really need it, I'll think of it.

--
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
