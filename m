From: "Manuel Lamotte-Schubert" <mls@pronego.com>
Date: Wed, 13 Jan 2010 16:31:42 +0000
Subject: ***SPAM (-1.2)*** Re: Found unknown SMBus adapter 10de:0aa2 at
Message-Id: <69221798d288dfee8398aada049a493d.squirrel@mail.pronego.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Wed, 13 Jan 2010 15:49:35 +0100, Manuel Lamotte-Schubert wrote:
>> In fact, actually some minutes before your repsonse I've already run the
>> most recent version of sensors-detect as you suggested.
>>
>> Here's the output:
>> ...
>> Intel Atom thermal sensor...                                Success!
>>     (driver `coretemp')
>> ...
>> Using driver `i2c-nforce2' for device 0000:00:03.2: nVidia Corporation
>> nForce SMBus (MCP79)
>> ...
>> Next adapter: SMBus nForce2 adapter at 4d00 (i2c-0)
>> Probing for `Winbond W83L771AWG/ASG'...                     Success!
>>     (confidence 6, driver `to-be-written')
>> ...
>> Driver `to-be-written':
>>   * Bus `SMBus nForce2 adapter at 4d00'
>>     Busdriver `i2c_nforce2', I2C address 0x4c
>>     Chip `Winbond W83L771AWG/ASG' (confidence: 6)
>>
>> Driver `coretemp':
>>   * Chip `Intel Atom thermal sensor' (confidence: 9)
>>
>> Note: there is no driver for Winbond W83L771AWG/ASG yet.
>> Check http://www.lm-sensors.org/wiki/Devices for updates.
>>
>>
>> This means that the sensor could be detected but there is no driver for
>> using it?
>
> Yes. For the Atom CPU, support is in coretemp since kernel 2.6.32, so
> you should have it already. For the W83L771AWG/ASG, support can
> probably be added to the lm90 driver. I hoped that someone would send
> me a board with this chip, so that I could work on it, but it did not
> happen. If you send me a dump of your chip, I can give it a try.
>
> Install i2c-tools, then as root:
> # modprobe i2c-dev
> # i2cdump 0 0x4c b
>
> And send me the output.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

Here's the output.

# i2cdump 0 0x4c b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x4c, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 2d 37 80 01 08 46 d8 46 d8 ff ff ff ff ff ff ff    -7???F?F?.......
10: 00 00 00 00 00 00 00 04 00 6e 6e 46 d8 00 00 ff    .......?.nnF?...
20: 55 0a ff ff 7f e0 ff ff ff ff ff ff ff ff ff ff    U?..??..........
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 00 00 00 84 84 84 00 00 55 00 00 ff ff ff ff ff    ...???..U.......
f0: 08 00 00 00 84 00 00 36 80 fc 36 83 37 ff 5c 11    ?...?..6??6?7.\?

> I hoped that someone would send
> me a board with this chip, so that I could work on it, but it did not
> happen. If you send me a dump of your chip, I can give it a try.
What do you need else for working on it except the board itself? Would an
account on my machine be sufficient? What command do you need to run?

Cheers,
Manuel Lamotte-Schubert


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
