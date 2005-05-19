From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: A question when test W83792D driver on another motherboard
Message-Id: <S072xwh7.1109761934.2007890.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> We tried the command "isaset -y -f 0x4b9 0x08", and find that the w83792d
> driver can "work" now when run "sensors" after load the 792 module, but we
> meet some other problems:
> 1* All of the voltage/fan/temperature measured values are fixed, they
> do NOT change at all. The voltage/fan/temperature limits can NOT be set
> either.
> Here is the output message of "sensors", please refer it.
> Do you ever meet such similar problem before? Our 792 driver for Windows
> can work well.
> ******************  output of "sensors"  ************************
> w83792d-i2c-0-2f
> Adapter: SMBus I801 adapter at 0400
> VCoreA:    +2.05 V  (min =  +2.04 V, max =  +2.04 V)       ALARM
> VCoreB:    +2.05 V  (min =  +2.04 V, max =  +2.04 V)       ALARM
> VIN0:      +4.09 V  (min =  +4.08 V, max =  +4.08 V)       ALARM
> VIN1:      +4.09 V  (min =  +4.08 V, max =  +4.08 V)       ALARM
> VIN2:      +4.09 V  (min =  +4.08 V, max =  +4.08 V)       ALARM
> VIN3:      +4.09 V  (min =  +4.08 V, max =  +4.08 V)       ALARM
> 5VCC:      +6.14 V  (min =  +6.12 V, max =  +6.12 V)       ALARM
> 5VSB:      +6.12 V  (min =  +6.12 V, max =  +6.12 V)
> VBAT:      +4.08 V  (min =  +4.08 V, max =  +4.08 V)
> Fan1:        0 RPM  (min =    0 RPM, div = 1)
> Fan2:        0 RPM  (min =    0 RPM, div = 1)
> Fan3:        0 RPM  (min =    0 RPM, div = 4080)
> Fan4:        0 RPM  (min =    0 RPM, div = 255)
> Fan5:        0 RPM  (min =    0 RPM, div = 255)
> Fan6:        0 RPM  (min =    0 RPM, div = 255)
> Fan7:        0 RPM  (min =    0 RPM, div = 255)
> Temp1:    +255.0??XC  (high = +255.0??XC, hyst = +255.0??XC)
> Temp2:    +255.5??XC  (high = +255.5??XC, hyst = +255.5??XC)
> Temp3:    +255.5??XC  (high = +255.5??XC, hyst = +255.5??XC)
> ERROR: Can't get Chassis data!

This is a typical output when the SMBus is stuck. Reads will return -1,
which is then misinterpreted as 0xff and results in the output above.

Side notes:
1* You should check your code for fan clock dividers. It is very
suspicious that you get different values and some of them are NOT
possible divider values.
2* The chassis data error is probably not related so you should check
your code too (either sensors, or libsensors, or the driver itself).

If you were able to load the driver, it means that at some point the
reads were succesfull (or the chip detection would have failed). So
basically you enabled the chip access using isaset, then some reads
succeeded, then the bus locked itself, or more likely the access to the
chip was locked again. The bus itself my still work. (No message in the
logs?)

When does your windows driver exactly write 0x08 to 0x4b9? Once when you
load the driver? Or before every register read?

> 2* When I rmmod the w83792d module, and insmod it again, the 792 driver
> will NOT work any more: I get nothing from "sensors".

This is expected. If read fails, the detection cannot possibly succeed.
Most probably the chip address is no more responsive anyway.

> I'm sure that the 0x04b9 is still "0x08", it does NOT change.

How do you know for sure?

Also, do you know the value at 0x4b9 before you write 0x08? If you know,
try writing this value again, then 0x08 again, and see if it temporarily
gives you access to the chip again.

> Btw, the "sensors-detect" still can NOT find the 792 chip after I run
> "isaset -y -f 0x4b9 0x08".

sensors-detect does much more probings on the bus than your driver. If
writing 0x08 to 0x4b9 only unlocks the chip access for a limited time or
limited number of bus operations, it will lock again before
sensors-detect reaches the w83792d detection code. Also, if this is
really a bus lockup, it is much more likely to happen with
sensors-detect than anything else.

Blame Asus and their weird design...

--
Jean Delvare
