From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: missing sensor readings
Message-Id: <3F14636A.5060001@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <6A5ECC095A43E94180D288C357027544ABEA2E@cvexch01.atitech.com>
In-Reply-To: <6A5ECC095A43E94180D288C357027544ABEA2E@cvexch01.atitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I wouldn't call them false, more like just being undetected (if they 
exist).  The 0x5X addresses are almost certainly eeproms, as detected.  
Your only other addresses are 0x00 (probably just the bus host) and 0x30 
which is also unlikely to be a sensor.

Do you see sensor readings in the Bios screens?  Or is there software 
for Windows or some other OS which sees something?  If so, it may be 
possible that the readings can only be seen through a proprietary 
(bios?) interface.  Or, perhaps, you simply have no hardware heath 
monitoring on this box.


Phil

John Kok wrote:

> Hi,
>
> I get false sensor readings from an IBM xServer 335.  This is what I get:
> eeprom-i2c-0-50
> Adapter: SMBus OSB4/CSB5 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
>
> eeprom-i2c-0-51
> Adapter: SMBus OSB4/CSB5 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
>
> eeprom-i2c-0-52
> Adapter: SMBus OSB4/CSB5 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
>
> eeprom-i2c-0-53
> Adapter: SMBus OSB4/CSB5 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
>
> eeprom-i2c-0-57
> Adapter: SMBus OSB4/CSB5 adapter at 0440
> Algorithm: Non-I2C SMBus adapter
>
> The temperature readings seems to be missing.  I talked to IBM and 
> they couldn't tell me what sensors are on their motherboard.  The 
> motherboard of that machine is custom made for that server so there is 
> no motherboard model.  Attached are the readings I get by running 
> sensors-detect, lsmod, i2cdetect and i2cdump.
>
> Thanks for your help,
> John
>
> By the way, the kernel version is 2.4.18-3 bigmem. <<Running 
> sensors.doc>>
>
