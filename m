From: Stian Jordet <liste@jordet.net>
Date: Mon, 01 Oct 2007 07:57:55 +0000
Subject: [lm-sensors] IPMI and ipmisensors on an Intel SC450NX
Message-Id: <4700A883.9040101@jordet.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Sorry, this is going to be long and probably cross-posted too many
places, but it isn't easy to know where to direct this! The persons in
the CC-field I have found after searching on the net, hoping any of them
have some bright ideas!

I've used the weekend (again!) trying to get sensors working on my good
old Intel SC450NX server, with no luck.

First of all, I'm not even sure what IPMI version this system has. I
found this mail:

http://sourceforge.net/mailarchive/message.php?msg_idtA9A71929931E40967CA9F27B1D7396014D46A2%40hdsmsx401.amr.corp.intel.com

where an Intel employee thinks it is IPMI 1.0, and either way it should
work with the ipmi_imb emulation driver, which supposedly uses the same
interface as the original Intel Server Manager uses. I'm still afraid it
is IPMI 0.9 I have.

I have updated both BIOS, BMC and FRUSDR (whatever that is) to the
latest available versions. dmidecode doesn't have any traces of ipmi.
But lm-sensors sensors-detect reports this:

[...]
Probing for `IPMI BMC KCS' at 0xca0...                      Success!
     (confidence 4, driver `ipmisensors')
Probing for `IPMI BMC SMIC' at 0xca8...                     No
[...]

which at least gave me some hope. The ipmisensors page says I need to
use ipmi_si before loading the ipmisensors-module. I then tried loading
some modules...

root@buick:~# modprobe ipmi_si
IPMI System Interface driver.
ipmi_si: Unable to find any System Interface(s)
FATAL: Error inserting ipmi_si
(/lib/modules/2.6.21/kernel/drivers/char/ipmi/ipmi_si.ko): No such
device

root@buick:~# modprobe ipmi_si type="kcs" addrs="0xca0"
IPMI System Interface driver.
ipmi_si: Trying hardcoded-specified kcs state machine at mem address
0xca0, slave address 0x0, irq 0
Could not set up I/O space
ipmi_si: Unable to find any System Interface(s)
FATAL: Error inserting ipmi_si
(/lib/modules/2.6.21/kernel/drivers/char/ipmi/ipmi_si.ko): No such
device

After applying ipmi_emu.diff from http://openipmi.sf.net, I tried the
earlier promised ipmi_imb driver:

root@buick:~# modprobe ipmi_imb
ipmi: can't create user -22
FATAL: Error inserting ipmi_imb
(/lib/modules/2.6.21/kernel/drivers/char/ipmi/ipmi_imb.ko): Invalid
argument

Not looking that good... What does "can't create user -22" mean? I found
this in my dmesg:

pnp: 00:01: ioport range 0xca0-0xca7 has been reserved

Which gave me hope that pnp was "locking" the ipmi addresses. Booted
with pnpbios=no and pnpacpi=off and even acpi=off, no difference.

I ran the FRUSDR utility from a boot disk, and got this output:

a:\>frusdr /p /d fru

    FRU & SDR Load Utility Version 3.4

    FRU IMBDEVICE on bus FFh, IMB address 20h, LUN 00

Display Header Area
Common Header Area      (Version 1, Length 8)
    Internal Area Offset    = 01h
    Chassis Area Offset     = 1Ah
    Board Area Offset       = 1Eh
    Product Area Offset     = 26h
    Multirecord Area Offset = 00h
    PAD                     = 00h
    CHECKSUM                = A0h

Don't know what any of this means, except it kinda says it does have a
"imbdevice" (Which I had some hopes the ipmi_imb driver would
support...)

Ok, I found this http://bubble.nsys.by/projects/ipmi/ and this
http://archives.andrew.net.au/lm-sensors/msg29983.html on the web,
showing at least two attempts trying to get bmcsensors working with IPMI
0.9 (if that's what my system has), but I haven't found any sign of
success or not. I am especially curious as to whether Yani's attempt to
make bmcsensors working with IPMI 0.9 will have any effect now that
ipmisensors seems to use ipmi_si and OpenIPMI does not suppoert IPMI
0.9...

Anyone have any bright ideas where to look next? Or am I really out of
luck?

Thanks.

Regards,
Stian

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
