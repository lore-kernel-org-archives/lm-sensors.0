From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <425AE9F5.3090707@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Huang0@Winbond.com.tw wrote:
> Hi Rudolf
> 
> I tested your patch "hide_and_seek_2" under linux-2.6.11 under this motherboard
> ASUS NCLV-D, the 792 driver for linux-2.6 can work if I execute "isaset -y -f 0x04b9 0x08" at first, 
even if the eeprom modules is loaded. But the eeprom
> modules can NOT get the memory information.

Hmm thats strange. You should see in syslog the message from the patch and you should
be able to modprobe the 792 driver without the isaset. Can you see the message in the log
from my patch?

If not can you put some printks around to see where is problem? Thanks.
We need to know:

1) if our patch was activated
2) if it works same way as isaset

> I remember that under linux-2.4 on this motherboard, the 792 driver can NOT
> work if eeprom modules is loaded.

yes it was because the i2c-i801 did not handle correctly the i2c-block reads, this is already
fixed in CVS.

> [root@localhost linux-2.6.11]# sensors
> w83792d-i2c-0-2f
> Adapter: SMBus I801 adapter at 0400
> VCoreA:    +1.33 V  (min =  +1.40 V, max =  +1.60 V)       ALARM
> VCoreB:    +0.35 V  (min =  +1.40 V, max =  +1.60 V)       ALARM
> VIN0:      +3.28 V  (min =  +3.20 V, max =  +3.39 V)
> VIN1:      +3.17 V  (min =  +3.09 V, max =  +3.30 V)
> VIN2:      +1.51 V  (min =  +1.39 V, max =  +1.49 V)       ALARM
> VIN3:      +2.50 V  (min =  +2.59 V, max =  +2.64 V)       ALARM
> 5VCC:      +5.08 V  (min =  +4.73 V, max =  +5.23 V)
> 5VSB:      +4.92 V  (min =  +4.73 V, max =  +5.23 V)
> VBAT:      +3.01 V  (min =  +2.85 V, max =  +3.14 V)
> Fan1:        0 RPM  (min =    0 RPM, div = 128)
> Fan2:     1448 RPM  (min = 1500 RPM, div = 4)              ALARM
> Fan3:        0 RPM  (min =    0 RPM, div = 128)
> Fan4:        0 RPM  (min =    0 RPM, div = 128)
> Fan5:        0 RPM  (min =    0 RPM, div = 128)
> Fan6:        0 RPM  (min =    0 RPM, div = 2)
> Fan7:        0 RPM  (min =    0 RPM, div = 128)
> Temp1:     +37.0??C  (high = +42.0??C, hyst = +37.0??C)
> Temp2:     +57.0??C  (high = +43.0??C, hyst = +38.0??C)   ALARM
> Temp3:     -32.0??C  (high = +45.0??C, hyst = +40.0??C)   ALARM
> chassis:  Chassis is normal.
> 
> eeprom-i2c-0-55
> Adapter: SMBus I801 adapter at 0400
> Unknown EEPROM type (255).
> 
> eeprom-i2c-0-54
> Adapter: SMBus I801 adapter at 0400
> Unknown EEPROM type (255).
> 

Hmm again some more problems...

Maybe the "trick" disabled the EEPROM part of the bus.
Can you please try with clean boot:

modprobe i2c-i801  (I hope it is this driver)

i2cdetect 0
isaset .... (put here the trick line)
i2cdetect 0

Afterwards if you still can see address 0x54 and 0x55
can you do:
i2cdump 0 0x55
i2cdump 0 0x55 c
modprobe eeprom
sensors
modprobe your792driver
sensors
i2cdump 0 0x55 c

If you cannot see addresses 54 55 as "responsive - no XX" than it means the trick switched the bus. And because
the quirk did not work and you did it manualy than eeprom driver cant get data because the chip is "away"

thanks

regards

Rudolf

