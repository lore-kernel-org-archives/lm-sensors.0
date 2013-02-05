From: Dag Wieers <dag@wieers.com>
Date: Tue, 05 Feb 2013 10:40:50 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <alpine.LRH.2.02.1302051137310.2736@pikachu.3ti.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Feb 2013, Jean Delvare wrote:

> On Tue, 5 Feb 2013 11:33:49 +0100 (CET), Dag Wieers wrote:
>
>> Ok, I included i2ctools as part of the OpenELEC build and this is now what
>> I get:
>>
>> root ~ # ./i2cdetect -l
>> i2c-0   smbus           SMBus I801 adapter at efa0              SMBus adapter
>> i2c-1   i2c             Afatech AF9015 reference design         I2C adapter
>> i2c-2   i2c             NVIDIA i2c adapter 1 at 1:00.0          I2C adapter
>> i2c-3   i2c             NVIDIA i2c adapter 2 at 1:00.0          I2C adapter
>>
>> root ~ # ./i2cdetect -F 0
>> Functionalities implemented by /dev/i2c-0:
>> I2C                              no
>> SMBus Quick Command              yes
>> SMBus Send Byte                  yes
>> SMBus Receive Byte               yes
>> SMBus Write Byte                 yes
>> SMBus Read Byte                  yes
>> SMBus Write Word                 yes
>> SMBus Read Word                  yes
>> SMBus Process Call               no
>> SMBus Block Write                yes
>> SMBus Block Read                 yes
>> SMBus Block Process Call         no
>> SMBus PEC                        yes
>> I2C Block Write                  yes
>> I2C Block Read                   yes
>>
>> What's next ?
>
> # ./i2cdetect 0

root ~ # ./i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] Y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

Anything I can read to understand the output ?

-- 
-- dag wieers, dag@wieers.com, http://dag.wieers.com/
-- dagit linux solutions, info@dagit.net, http://dagit.net/

[Any errors in spelling, tact or fact are transmission errors]

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
