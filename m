From: merky_1@yahoo.com (Tom and Wendy)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Ticket 1159 update
Message-Id: <NCBBIHMBGFFKDDGNDMLKMEOMDMAA.merky_1@yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <NCBBIHMBGFFKDDGNDMLKIEOGDMAA.merky_1@yahoo.com>
In-Reply-To: <NCBBIHMBGFFKDDGNDMLKIEOGDMAA.merky_1@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Okay, compiled, reinserted module.

DMESG output:
ipmi: message handler initialized
ipmi_kcs: Acquiring BMC @ port=0xca2
i2c-core.o: i2c core module
i2c-proc.o version 2.6.1 (20010825)
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-ipmi.o version 2.7.0 (20021208)
i2c-ipmi.o: Registered IPMI interface 0 with version 0.9
i2c-ipmi.o: BMC access for i2c modules initialized.
i2c-proc.o version 2.7.0 (20021208)
bmcsensors.o version 2.7.0 (20021208)
bmcsensors.o: Registered client, scanning for sensors...
bmcsensors.o: Send BMC msg, cmd: 0x22
bmcsensors.o: Got first resid 0x0001
bmcsensors.o: Get SDR 0x0 0x0 0x0
bmcsensors.o: Send BMC msg, cmd: 0x23
bmcsensors.o: Error 0xc9 on cmd 0xa/0x23; state = 2; probably fatal.

lsmod:
Module                  Size  Used by    Not tainted
bmcsensors             16992   0  (unused)
i2c-proc                8480   0  [bmcsensors]
i2c-ipmi                3420   0  (unused)
i2c-core               22536   0  [bmcsensors i2c-proc i2c-ipmi]
ipmi_kcs_drv           10440   1
ipmi_msghandler        19596   0  [i2c-ipmi ipmi_kcs_drv]
hid                    21120   1
input                   6016   0  [hid]
parport_pc             18340   1  (autoclean)
lp                      8320   0  (autoclean)
parport                36448   1  (autoclean) [parport_pc lp]
eepro100               22604   1
mii                     3936   0  [eepro100]
floppy                 58816   0  (autoclean)
usb-uhci               26564   0  (unused)
usbcore                75616   1  [hid usb-uhci]
rtc                     8668   0  (autoclean)
ext3                   71424   2
jbd                    60144   2  [ext3]
sd_mod                 12092   6
aic7xxx               132768   3
scsi_mod              112336   2  [sd_mod aic7xxx]

using linux-ipmi-2.4.20-v17-v18.diff from ipmi.sourceforge.net.

Thanks for looking into this.

-----Original Message-----
From: Mark D. Studebaker [mailto:mds@paradyne.com]
Sent: Sunday, March 16, 2003 9:41 PM
To: Tom and Wendy
Subject: Re: Ticket 1159 update


you can add a } before the else at the compile error to fix it.

Tom and Wendy wrote:
> Added #define DEBUG 1 to kernel/chips/bmcsensors.c.
>
> Now I am getting a compile error:
>
> gcc  -D__SMP__ -DMODVERSIONS -include
>
/lib/modules/2.4.20/build/include/linux/modversions.h -D__KERNEL__ -DMODULE
> -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/inc
lu
> de -I/lib/modules/2.4.20/build/include   -O2   -c
> kernel/chips/bmcsensors.c -o kernel/chips/bmcsensors.o
> kernel/chips/bmcsensors.c: In function `bmcsensors_rcv_sdr_msg':
> kernel/chips/bmcsensors.c:575: parse error before `else'
> make: *** [kernel/chips/bmcsensors.o] Error 1
>
> gcc --version
> 2.96
>
> Redhat 7.2 with updates
>
> Thanks.
>
> -----Original Message-----
> From: Nobody [mailto:nobody@Stimpy.netroedge.com]
> Sent: Saturday, March 08, 2003 7:26 PM
> To: merky_1@yahoo.com
> Subject: ---== Lm_sensors Support DB Entry ==---
>
>
> Your Lm_sensors support entry has been updated.
>
> Please go to http://secure.netroedge.com/~lm78/support.html to check
> the status of your entry.
>
> Ticket # 1159
>
>

