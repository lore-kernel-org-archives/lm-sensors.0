From: "Cress, Andrew R" <andrew.r.cress@intel.com>
Date: Tue, 02 Oct 2007 15:27:38 +0000
Subject: Re: [lm-sensors] [Openipmi-developer] IPMI and ipmisensors on an
Message-Id: <102A51607473A4449F0D3E2EF6FFCAD60264FA87@orsmsx416.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4701E789.5020103@jordet.net>
In-Reply-To: <4701E789.5020103@jordet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Stian,

OK, the GetDeviceID response being short indicates that it is
pre-IPMI-1.0, probably IPMI 0.9.
The actual displayed versions from the utilities are being picked out
from the IPMI 1.0+ locations, so they are not valid.  I don't remember
the format of the IPMI 0.9 DeviceID response off-hand, but you do have
something that works, mostly.

Also, decoding the sensor readings in IPMI 0.9 must be different, but at
least you can get the raw readings. =20
There is an Intel IMB IPMI driver that does support IPMI 0.9, and there
are several things that need to be handled differently in IPMI 0.9 (kcs
state machine, GetDeviceID response, SendMessage/GetMessage is
different, ...).  =20

Given that the ipmisensors module is probably coded to IPMI 1.0 and
greater, using it wouldn't yield any advantage over what you currently
get from "ipmiutil sensor", which did try to decode them but with
'unspecified' results.=20

Decoding the sensor readings from raw form into human-readable form
would have to be implemented for IPMI 0.9 in whatever utilities you
pick.  How big a deal is this?   =20

Andy=20

-----Original Message-----
From: openipmi-developer-bounces@lists.sourceforge.net
[mailto:openipmi-developer-bounces@lists.sourceforge.net] On Behalf Of
Stian Jordet
Sent: Tuesday, October 02, 2007 2:39 AM
To: Cress, Andrew R
Cc: openipmi-developer@lists.sourceforge.net; yani.ioannou@gmail.com;
slava@nsys.by; minyard@acm.org; lm-sensors@lm-sensors.org
Subject: Re: [Openipmi-developer] IPMI and ipmisensors on an Intel
SC450NX

Andrew,

first, I'm sorry I am not replying to you email, I  accidentally deleted

it :(

Now we're getting somewhere:

root@buick:~# ipmiutil health -x
ipmiutil ver 2.0
bmchealth ver 1.15
ipmi_open: driver type =3D unknown
ipmi_open_mv: cannot open /dev/ipmi/0
ipmi_open_mv: cannot open /dev/ipmi0
ipmi_open_mv: cannot open /dev/ipmidev0
ipmi_open_mv: cannot open /dev/ipmidev/0
imbapi.c ipmi_open_ia: open(/dev/imb) failed: No such file or directory
ipmi_open_va: cannot open /dev/ipmikcs
ipmi_open_va: cannot open /dev/ipmi/kcs
SMBIOS Table is present at Physical Address 0x000eee60 ...
No IPMI Data Structure Found in SMBIOS Table,
 Continuing with KCS on Default Port 0x0ca2
BMC Initialized.
ipmidir Cmd=01 NetFn=06 Lun=00 Sa  Data(0):
wait_for_OBF_set: max loop 5001
ipmidir Resp: status=3D0 cc=00 Data(6): 05 01 00 35 10 1f
open_direct: status=3D0, KCS drv, ipmi=3D0
ipmi_open rc =3D 0 type =3D kcs
Driver type kcs, open rc =3D 0
ipmidir Cmd=01 NetFn=06 Lun=00 Sa  Data(0):
wait_for_OBF_set: max loop 5001
ipmidir Resp: status=3D0 cc=00 Data(6): 05 01 00 35 10 1f
BMC version 0.35, IPMI version 0.1
BMC manufacturer =3D ca0000 , product =3D 0493
ipmidir Cmd=07 NetFn=06 Lun=00 Sa  Data(0):
wait_for_OBF_set: max loop 5001
ipmidir Resp: status=3D0 cc=C1 Data(0):
ccode c1: Invalid Command
Cannot do ipmi_getpowerstate, ret =3D 193

Altough there still is something it doesn't like about my system, I at=20
least get some output :P But IPMI Version 0.1? Is that a typo for 1.0?
:)

root@buick:~# ipmiutil sel
ipmiutil ver 2.0
showsel: version 1.54
-- BMC version 0.35, IPMI version 0.1
SEL Ver 10 Support 2, Size =3D 488 records, Free space =3D 482 records
RecId Date/Time_______ Source_ Evt_Type SensNum Evt_detail - Trig
[Evt_data]
8001 01/01/70 01:00:07 BMC  05 Platform Security #33 - 03 [01 ff ff]
9001 09/30/07 22:54:23 0011 12 System Event #ef - e7 [01 ff ff]
a001 01/01/70 01:00:07 BMC  05 Platform Security #33 - 03 [01 ff ff]
b001 10/01/07 17:22:54 0011 12 System Event #ef - e7 [01 ff ff]
c001 01/01/70 01:00:07 BMC  05 Platform Security #33 - 03 [01 ff ff]
d001 10/01/07 17:35:21 0011 12 System Event #ef - e7 [01 ff ff]
showsel: completed successfully


root@buick:~# ipmiutil sensor
ipmiutil ver 2.0
sensor: version 1.59
-- BMC version 0.35, IPMI version 0.1
_ID_ SDR_Type_xx Sz Own Typ S_Num Sens_Description   Hex & Interp
Reading
0020 SDR Full 01 39 20 a f8 snum 04 Baseboard -12V   =3D 6a OK* =20
2520000212.00 unspecified
4020 SDR Full 01 3b 20 a f8 snum 14 Basebrd PCI Temp =3D 9c OK* =20
2360080184.00 unspecified
8020 SDR Full 01 3b 20 a f8 snum 15 Basebrd PXB Temp =3D a0 OK* =20
2360082240.00 unspecified
c020 SDR Full 01 3b 20 a f8 snum 16 Processor 1 Temp =3D 9a OK* =20
2360079156.00 unspecified
0021 SDR Full 01 3b 20 a f8 snum 17 Processor 2 Temp =3D 9b OK* =20
2360079670.00 unspecified
4021 SDR Full 01 3b 20 a f8 snum 18 Processor 3 Temp =3D 9d OK* =20
2360080698.00 unspecified
8021 SDR Full 01 3b 20 a f8 snum 19 Processor 4 Temp =3D 9c OK* =20
2360080184.00 unspecified
c021 SDR Full 01 37 20 a f8 snum 01 Baseboard 5V     =3D bd OK* =20
440012474.00 unspecified
0022 SDR Full 01 38 20 a f8 snum 02 Baseboard 12V    =3D aa OK* =20
440000340.00 unspecified
4022 SDR Full 01 39 20 a f8 snum 03 Baseboard 3.3V   =3D df OK* =20
440000446.00 unspecified
8022 SDR Full 01 39 20 a f8 snum 0c Baseboard 2.5V   =3D cb OK* =20
440000406.00 unspecified
c022 SDR Full 01 39 20 a f8 snum 0b Baseboard 1.5V   =3D 9b OK* =20
440000310.00 unspecified
0023 SDR Full 01 36 20 a f8 snum 13 SCSI-N Volt      =3D ca OK* =20
440000404.00 unspecified
4023 SDR Full 01 3a 20 a f8 snum 1a Baseboard Fan 2  =3D 5e OK* =20
80000188.00 unspecified
8023 SDR Full 01 3a 20 a f8 snum 1b Baseboard Fan 1  =3D 63 OK* =20
80000198.00 unspecified
c023 SDR Full 01 3a 20 a f8 snum 1c Baseboard Fan 4  =3D 5b OK* =20
80000182.00 unspecified
0024 SDR Full 01 3a 20 a f8 snum 1d Baseboard Fan 3  =3D 64 OK* =20
80000200.00 unspecified
4024 SDR Full 01 3a 20 a f8 snum 1e Baseboard Fan 5  =3D 5a OK* =20
80000180.00 unspecified
8024 SDR Full 01 3a 20 a f8 snum 1f Baseboard Fan 8  =3D 5c OK* =20
80000184.00 unspecified
c024 SDR Full 01 3a 20 a f8 snum 20 Baseboard Fan 7  =3D 5f OK* =20
80000190.00 unspecified
0025 SDR Full 01 3a 20 a f8 snum 21 Baseboard Fan 6  =3D 5a OK* =20
80000180.00 unspecified
4025 SDR Full 01 39 20 a f8 snum 22 PwrShare Fan 1   =3D 57 OK* =20
80000174.00 unspecified
8025 SDR Full 01 39 20 a f8 snum 23 PwrShare Fan 2   =3D 55 OK* =20
80000170.00 unspecified
c025 SDR Full 01 39 20 a f8 snum 24 PwrShare Fan 3   =3D 56 OK* =20
80000172.00 unspecified
0026 SDR Full 01 38 20 a f8 snum 2d PwrShare Temp    =3D 9f OK* =20
2360081726.00 unspecified
4026 SDR Comp 02 25 20 a 49 snum 2c 3-4 L2 VID       =3D c0 c0 fb b7
Deassert
7026 SDR Comp 02 25 20 a 49 snum 2b 1-2 L2 VID       =3D c0 00 00 00 OK
a026 SDR Comp 02 22 20 a 49 snum 31 oc Term          =3D c0 00 00 00 OK
d026 SDR Comp 02 26 20 a 09 snum 27 ssor 1 Stat      =3D 80 80 00 00
Enabled
0027 SDR Comp 02 26 20 a 09 snum 28 ssor 2 Stat      =3D 80 80 00 00
Enabled
3027 SDR Comp 02 26 20 a 09 snum 29 ssor 3 Stat      =3D 80 80 00 00
Enabled
6027 SDR Comp 02 26 20 a 09 snum 2a ssor 4 Stat      =3D 80 80 00 00
Enabled
9027 SDR Comp 02 25 20 a 49 snum 25 edund Lost       =3D 00 80 00 00 OK
c027 SDR Comp 02 20 20 a 09 snum 26  Unit            =3D 00 00 00 00=20
NotAvailable
f027 SDR Comp 02 24 20 a 49 snum 32 Post Code        =3D 00 00 00 00=20
NotAvailable
2028 SDR Comp 02 26 20 a 49 snum 41 MP Password      =3D c0 00 00 00 OK
5028 SDR Comp 02 26 20 a 49 snum 33 ntrusion ID      =3D c1 00 00 00 OK
8028 SDR Comp 02 24 20 a 49 snum 36 rtPnl NMI        =3D 00 80 00 00 OK
b028 SDR Comp 02 22 20 a 49 snum 37 atchdog          =3D 00 80 00 00 OK
e028 SDR Comp 02 25 20 a 49 snum 34  Violation       =3D c0 00 00 00 OK
1029 SDR Comp 02 1f 20 a 43 snum 35 tate             =3D c0 00 00 00 OK
4029 SDR Comp 02 24 20 a 49 snum 2e are Sup 1        =3D 01 80 00 00 OK
7029 SDR Comp 02 24 20 a 49 snum 2f are Sup 2        =3D 01 80 00 00 OK
a029 SDR Comp 02 24 20 a 49 snum 30 are Sup 3        =3D 01 80 00 00 OK
d029 SDR Comp 02 1f 20 a 49 snum 38 tate             =3D c0 00 00 00 OK
002a SDR Comp 02 26 20 a 49 snum 0d Term Vlt A1      =3D c0 00 00 00 OK
302a SDR Comp 02 26 20 a 49 snum 0e Term Vlt A2      =3D c0 00 00 00 OK
602a SDR Comp 02 26 20 a 49 snum 0f Term Vlt A3      =3D c0 00 00 00 OK
902a SDR Comp 02 26 20 a 49 snum 10 Term Vlt B1      =3D c0 00 00 00 OK
c02a SDR Comp 02 26 20 a 49 snum 11 Term Vlt B2      =3D c0 00 00 00 OK
f02a SDR Comp 02 26 20 a 49 snum 12 Term Vlt B3      =3D c0 00 00 00 OK
202b SDR Comp 02 24 c0 a 49 snum 01 rv Status        =3D bd c0 00 00 OK
502b SDR Comp 02 26 c0 a 49 snum 07 rv Presence      =3D 00 00 00 00=20
NotAvailable
802b SDR DLoc 10 1b dev: 20 00 00 05 00 bd Basbrd Mgmt Ctlr
a02b SDR DLoc 10 1a dev: ae 50 00 20 08 00 Processor 1 FRU
c02b SDR DLoc 10 1a dev: aa 50 00 20 08 00 Processor 2 FRU
e02b SDR DLoc 10 1a dev: a6 50 00 20 08 00 Processor 3 FRU
002c SDR DLoc 10 1a dev: a2 50 00 20 08 00 Processor 4 FRU
202c SDR DLoc 10 17 dev: d0 40 00 20 09 02 PwrShare FRU
402c SDR DLoc 10 18 dev: c0 00 00 02 00 85 Hot Swap Ctlr
602c SDR DLoc 10 1b dev: aa 40 00 20 09 02 Memory Board FRU
802c SDR DLoc 10 1b dev: d2 40 00 20 09 02 Pwr Supply 1 FRU
a02c SDR DLoc 10 1b dev: d4 40 00 20 09 02 Pwr Supply 2 FRU
c02c SDR DLoc 10 1b dev: d6 40 00 20 09 02 Pwr Supply 3 FRU
e02c SDR OEM  c0 10 manufS91443: 20 56 65 72 73 69 6f 6e 20 31 2e 33
37
sensor: completed successfully

Is there anything that can be done, so that the ipmi_si module will work

on this system? (And by extension, hopefully the ipmisensors module).

Last, the fan and temperature readings, aren't they supposed to be human

readable?

Thanks for your great help, all of you! Much appreciated!

Regards,
Stian

Stian Jordet wrote:
> On man, 2007-10-01 at 05:53 -0700, Cress, Andrew R wrote:
>  =20
>> Stian,
>>
>> I believe the port should be 0xCA2, not 0xCA0. =20
>> According to the docs, it does have IPMI support, but it would be
only
>> local (no IPMI LAN).
>>
>> Try modprobe ipmi_si type=3D"kcs" addrs=3D"0xca0"
>> or just modprobe ipmi_si
>>    =20
>
> Unfortunately, neither of this works. I've tried=20
>
> root@buick:~# modprobe ipmi_si
> FATAL: Error inserting ipmi_si
(/lib/modules/2.6.21/kernel/drivers/char/ipmi/ipmi_si.ko): No such
device
> root@buick:~# modprobe ipmi_si type=3D"kcs" ports=3D"0xca0"
> FATAL: Error inserting ipmi_si
(/lib/modules/2.6.21/kernel/drivers/char/ipmi/ipmi_si.ko): No such
device
> root@buick:~# modprobe ipmi_si type=3D"kcs" ports=3D"0xca2"
> FATAL: Error inserting ipmi_si
(/lib/modules/2.6.21/kernel/drivers/char/ipmi/ipmi_si.ko): No such
device
>
> I don't really know if there is more to try. But as you say, the board
> should support IPMI, so I don't really know why it doesn't seem to.
> Hmm.=20
>
> I guess it was worth a try :)
>
> Thanks to everyone who replied :)
>
> Regards,
> Stian
>
>  =20
>> -----Original Message-----
>> From: Stian Jordet [mailto:liste@jordet.net]=20
>> Sent: Monday, October 01, 2007 3:58 AM
>> To: lm-sensors@lm-sensors.org
>> Cc: yani.ioannou@gmail.com; Cress, Andrew R; slava@nsys.by
>> Subject: IPMI and ipmisensors on an Intel SC450NX
>>
>> Hi,
>>
>> Sorry, this is going to be long and probably cross-posted too many
>> places, but it isn't easy to know where to direct this! The persons
in
>> the CC-field I have found after searching on the net, hoping any of
them
>> have some bright ideas!
>>
>> I've used the weekend (again!) trying to get sensors working on my
good
>> old Intel SC450NX server, with no luck.
>>
>> First of all, I'm not even sure what IPMI version this system has. I
>> found this mail:
>>
>>
http://sourceforge.net/mailarchive/message.php?msg_idtA9A71929931E4096
>> 7CA9F27B1D7396014D46A2%40hdsmsx401.amr.corp.intel.com
>>
>> where an Intel employee thinks it is IPMI 1.0, and either way it
should
>> work with the ipmi_imb emulation driver, which supposedly uses the
same
>> interface as the original Intel Server Manager uses. I'm still afraid
it
>> is IPMI 0.9 I have.
>>
>> I have updated both BIOS, BMC and FRUSDR (whatever that is) to the
>> latest available versions. dmidecode doesn't have any traces of ipmi.
>> But lm-sensors sensors-detect reports this:
>>
>> [...]
>> Probing for `IPMI BMC KCS' at 0xca0...                      Success!
>>      (confidence 4, driver `ipmisensors')
>> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>> [...]
>>
>> which at least gave me some hope. The ipmisensors page says I need to
>> use ipmi_si before loading the ipmisensors-module. I then tried
loading
>> some modules...
>>
>> root@buick:~# modprobe ipmi_si
>> IPMI System Interface driver.
>> ipmi_si: Unable to find any System Interface(s)
>> FATAL: Error inserting ipmi_si
>> (/lib/modules/2.6.21/kernel/drivers/char/ipmi/ipmi_si.ko): No such
>> device
>>
>> root@buick:~# modprobe ipmi_si type=3D"kcs" addrs=3D"0xca0"
>> IPMI System Interface driver.
>> ipmi_si: Trying hardcoded-specified kcs state machine at mem address
>> 0xca0, slave address 0x0, irq 0
>> Could not set up I/O space
>> ipmi_si: Unable to find any System Interface(s)
>> FATAL: Error inserting ipmi_si
>> (/lib/modules/2.6.21/kernel/drivers/char/ipmi/ipmi_si.ko): No such
>> device
>>
>> After applying ipmi_emu.diff from http://openipmi.sf.net, I tried the
>> earlier promised ipmi_imb driver:
>>
>> root@buick:~# modprobe ipmi_imb
>> ipmi: can't create user -22
>> FATAL: Error inserting ipmi_imb
>> (/lib/modules/2.6.21/kernel/drivers/char/ipmi/ipmi_imb.ko): Invalid
>> argument
>>
>> Not looking that good... What does "can't create user -22" mean? I
found
>> this in my dmesg:
>>
>> pnp: 00:01: ioport range 0xca0-0xca7 has been reserved
>>
>> Which gave me hope that pnp was "locking" the ipmi addresses. Booted
>> with pnpbios=3Dno and pnpacpi=3Doff and even acpi=3Doff, no difference.
>>
>> I ran the FRUSDR utility from a boot disk, and got this output:
>>
>> a:\>frusdr /p /d fru
>>
>>     FRU & SDR Load Utility Version 3.4
>>
>>     FRU IMBDEVICE on bus FFh, IMB address 20h, LUN 00
>>
>> Display Header Area
>> Common Header Area      (Version 1, Length 8)
>>     Internal Area Offset    =3D 01h
>>     Chassis Area Offset     =3D 1Ah
>>     Board Area Offset       =3D 1Eh
>>     Product Area Offset     =3D 26h
>>     Multirecord Area Offset =3D 00h
>>     PAD                     =3D 00h
>>     CHECKSUM                =3D A0h
>>
>> Don't know what any of this means, except it kinda says it does have
a
>> "imbdevice" (Which I had some hopes the ipmi_imb driver would
>> support...)
>>
>> Ok, I found this http://bubble.nsys.by/projects/ipmi/ and this
>> http://archives.andrew.net.au/lm-sensors/msg29983.html on the web,
>> showing at least two attempts trying to get bmcsensors working with
IPMI
>> 0.9 (if that's what my system has), but I haven't found any sign of
>> success or not. I am especially curious as to whether Yani's attempt
to
>> make bmcsensors working with IPMI 0.9 will have any effect now that
>> ipmisensors seems to use ipmi_si and OpenIPMI does not suppoert IPMI
>> 0.9...
>>
>> Anyone have any bright ideas where to look next? Or am I really out
of
>> luck?
>>
>> Thanks.
>>
>> Regards,
>> Stian
>>
>>    =20
>
>
>
------------------------------------------------------------------------
-
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer
>
>  =20


------------------------------------------------------------------------
-
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Openipmi-developer mailing list
Openipmi-developer@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openipmi-developer

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
