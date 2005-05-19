From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Ticket #: 893 lm_sensors 2.6.4.cvs on Intel D850MV with kernel
Message-Id: <3CEC0575.911F6DBB@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0205162124310.948-100000@hal.bit-side.de>
In-Reply-To: <Pine.LNX.4.21.0205162124310.948-100000@hal.bit-side.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So the chip is not responding at all on the non-working boards.
Perhaps it has not been initialized or released from reset?
Does it make a difference if you go into the BIOS 
(or especially the BIOS hardware monitoring screen) before you boot?
Have you asked Intel?
Locate the ADM1025 on a working board. Is it also present on the non-working boards?

Thomas Lazic wrote:
> 
> Hi,
> 
> thanks a lot for your answer
> Now it appears that 2 boards are working and 9 do not.
> 
> All boards have the same bios version but we dont know anything about the
> hardware revision. It is always the same type of board (Intel D850MV).
> 
> Please see below the output of sensors on the working board und i2cdump on
> both the working and non-working board.
> 
> Regards.
> Thomas
> 
> working board
> 
> host:/ # sensors
> adm1025-i2c-1-2d
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Non-I2C SMBus adapter
> +2.5V:     +2.47 V  (min =  +2.22 V, max =  +2.72 V)
> VCore:     +1.44 V  (min =  +1.38 V, max =  +1.69 V)
> +3.3V:     +3.23 V  (min =  +2.93 V, max =  +3.59 V)
> +5V:       +4.97 V  (min =  +4.45 V, max =  +5.44 V)
> VCC:       +3.33 V  (min =  +2.93 V, max =  +3.59 V)
> SYS Temp:  +36.0C  (min =   +0C, max =  +60C)
> CPU Temp:  +37.0C  (min =   +0C, max =  +60C)
> 
> eeprom-i2c-0-50
> Adapter: bt848 #0
> Algorithm: Bit-shift algorithm
> 
> eeprom-i2c-1-50
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Non-I2C SMBus adapter
> 
> eeprom-i2c-1-51
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Non-I2C SMBus adapter
> 
> host:/lm_sensors2/prog/dump# ./i2cdump 1 0x2d
> Warning: no size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
>   I will probe file /dev/i2c-1, address 0x2d, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
> 10: 5b 5b 5b 5b 5b 00 5b 5b 5b 5b 5b 5b 5b 5b 5b 00    [[[[[.[[[[[[[[[.
> 20: be 7c bc bf 00 c2 24 24 5b 5b 5b d1 ab 91 76 d1    ?|??.?$$[[[???v?
> 30: ab d1 ab d1 ab d1 ab 3c 00 3c 00 5b 5b 5b 41 29    ???????<.<.[[[A)
> 40: 01 00 01 5b 5b 5b 5b 0e 5b 80 5b 5b 5b 5b 5b 5b    ?.?[[[[?[?[[[[[[
> 50: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
> 60: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
> 70: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
> 80: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
> 90: 5b 5b 5b 5b 5b 00 5b 5b 5b 5b 5b 5b 5b 5b 5b 00    [[[[[.[[[[[[[[[.
> a0: be 7a bc bf 00 c2 25 24 5b 5b 5b d1 ab 91 76 d1    ?z??.?%$[[[???v?
> b0: ab d1 ab d1 ab d1 ab 3c 00 3c 00 5b 5b 5b 41 29    ???????<.<.[[[A)
> c0: 01 00 01 5b 5b 5b 5b 0e 5b 80 5b 5b 5b 5b 5b 5b    ?.?[[[[?[?[[[[[[
> d0: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
> e0: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
> f0: 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b 5b    [[[[[[[[[[[[[[[[
> 
> non-working board
> 
> host:/lm_sensors2/prog/dump# ./i2cdump 1 0x2d
> Warning: no size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
>   I will probe file /dev/i2c-1, address 0x2d, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
