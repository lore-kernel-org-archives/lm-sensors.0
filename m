From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503311155520.21101@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> My debug environment is linux-2.6.10, so the eeprom.c you mentioned
> should not be in lm-sensors package, but in:
> /usr/src/linux-2.6.10/drivers/i2c/chips/eeprom.c
> Am I right? Btw, all the dump and debug messages are from linux-2.6
> instead of linux-2.4.

Yes but in the package in directory prog/ is different program :)
But never mind. We do not need this in this stage.

>
> I do NOT modify the eeprom.c, instead, I do the dumps below, please
> refer to it.
>
>
> > Please can you obtain several dumps from the bus?
> >
> > like:
> >       #!/bin/bash
> >       while true ; do
> >       i2cdump -y 0 0x50 >>eeprom
> >       i2cdump -y 0 0x50 >>eeprom
> >       i2cdump -y 0 0x2f >>winbon <=your chip adr I think is this one
> >       i2cdump -y 0 0x2f >>winbon <=your chip adr I think is this one
> >       done
> > (ctrl c to stop after several thousends cycles please)
>
> I use such script you gave me to dump it, the attachment is the dump
> output in hundreds of times. Please check it.
>
>     #!/bin/bash
>     while true ; do
>     i2cdump -y 0 0x50
>     i2cdump -y 0 0x50
>     i2cdump -y 0 0x2f
>     i2cdump -y 0 0x2f
>     done
> I have some questions here,
> (1) why the script should contains two lines of " i2cdump -y 0 0x2f"?
> (2) Should I modify the second "i2cdump -y 0 0x50" into " i2cdump -y 0
> 0x51"?

I think at 0x2f is the monitoring device. But you can add two more lines
with 0x51 if you want. Lets wait with this a little.

> > put the module to some other motherboard and perform i2cdump on it.
>
> I dump it again on the platform where can work correctly:
> RIOWORKS PDPLA0250000005
> Intel Corp.82801CA/CAM SMBus Controller
> Intel(R) XEON(TM) CPU 2.00GHz
> Please check it, the dump output mesasge on this platform is:
> [root@ ~]# i2cdump 0 0x50
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c-0, address 0x50, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ac 00 07 0c 0a 01 48 00 04 75 75 02 80 08 08 01    ?.????H.?uu?????
> 10: 0e 04 0c 01 02 26 00 a0 75 00 00 50 3c 50 30 20    ?????&.?u..P<P0
> 20: 00 00 50 50 00 00 00 00 00 41 4b 30 32 75 00 00    ..PP.....AK02u..
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1a    ...............?
> 40: ac 00 00 00 00 00 00 bb ff 00 00 00 00 00 00 00    ?......?........
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ac 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: 00 00 ac ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> [root@ ~]# sensors
> eeprom-i2c-0-54
> Adapter: SMBus I801 adapter at 1100
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       128
>

Hmm it really seems some problem with the SPD chip itself rather than with
SMBUS. Because in your previous dump was sometimes 00 00 and not ac 00
as now again. I think I have seen ac 00 in ABIT environment too.

I will check now the dumps. And then I will write what next is needed
to make us sure what is wrong. And of course good to make a break after
lunch with this :)

Regards

Rudolf
