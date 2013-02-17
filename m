From: Dag Wieers <dag@wieers.com>
Date: Sun, 17 Feb 2013 14:42:49 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <alpine.LRH.2.02.1302171536080.26996@pikachu.3ti.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 11 Feb 2013, Jean Delvare wrote:

> On Thu, 7 Feb 2013 12:03:10 +0100, Jean Delvare wrote:
>> The dump above rules out the DS75 and DS1621. Could be an LM73, but
>> then the lm73 driver would have found it. What did you try before
>> coming to the conclusion that it "don't seem to do anything"?
>>
>> Next thing you can try is:
>>
>> # i2cdump -r 0-0x3f 0 0x48 b
>>
>> And then as usual:
>>
>> # i2cget 0 0x48
>
> Did you try? Did it return anything useful?

I'll let you decide :-)

----
root ~ # i2cdump -r 0-0x3f 0 0x48 b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x48, mode byte
Probe range limited to 0x00-0x3f.
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

root ~ # i2cget 0 0x48
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will read from device file /dev/i2c-0, chip address 0x48, current data
address, using read byte.
Continue? [Y/n] y
Error: Read failed
----


What's weird is that now it behaves the same as the other device. Address 
0x48 no longer responds. Not sure if this behaviour relates to other 
changes on the system or if it was because of the above commands.

----
root ~ # i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --
70: -- -- -- -- -- -- -- -- 
----

Did I break it ? :)


-- 
-- dag wieers,    dag@wieers.com,    http://dag.wieers.com/
-- dagit linux solutions, info@dagit.net, http://dagit.net/

[Any errors in spelling, tact or fact are transmission errors]

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
