From: kevin.bowling@wans.net (Kevin Bowling)
Date: Fri, 02 Jun 2006 07:53:28 +0000
Subject: [lm-sensors] IBM NetFinity 4000r Support
Message-Id: <447FEE78.308@wans.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <44665DE5.60703@wans.net>
In-Reply-To: <44665DE5.60703@wans.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
>>   If you view the bug, it uses 4 MAX161 sensors for primary temperature
>> sensors.  I also posted the source code for an old driver.  Please let
>> me know what I need to do to get development started.
>>              Kevin
>
> yep I rechecked again. It seems to me at first as a bus problem.
> Please can you do/provide output of following:
>
> 0) power cycle the system
> 1) turn on the I2C bus debugging
> 2) modprobe i2c-piix4
> 3) i2cdetect 0
> 4) i2cdump 0 0x2d
>
> lspci -xxx
>
> Thanks,
> regards
> Rudolf
Sorry for the delay, I brought up a second machine to do the development
on since the first is my server.

Needless to say, I didn't get very far.  Here's the output of the
commands you gave me.  It does indeed sound like a bus issue.

[root at localhost ~]# modprobe i2c-dev
[root at localhost ~]# modprobe i2c-piix4
[root at localhost ~]# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX 18 XX 1a XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX 4c XX 4e XX
50: XX XX 52 53 XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX 66 XX XX 69 XX XX XX XX XX XX
70: XX XX XX 73 XX XX XX XX

[root at localhost ~]# i2cdump 0 0x2d
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2d, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 1c 00 02 00 00 11 00 44 04 04 00 00 00 54 00    .?.?..?.D??...T.
10: 00 02 00 10 44 00 10 10 00 80 00 10 00 08 04 00    .?.?D.??.?.?.??.
20: 01 00 00 18 00 00 08 42 00 90 00 00 a0 00 23 05    ?..?..?B.?..?.#?
30: 00 00 00 00 00 80 02 00 00 00 00 12 00 10 00 08    .....??....?.?.?
40: 08 00 10 00 00 00 40 51 2d c0 c0 c0 c0 c0 c0 00    ?.?... at Q-??????.
50: 08 00 10 00 00 00 40 51 2d c0 c0 c0 c0 c0 c0 00    ?.?... at Q-??????.
60: 01 00 00 18 00 00 08 XX XX XX XX XX XX XX XX XX    ?..?..?XXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

And in dmesg:

i2c_adapter i2c-0: SMBus Timeout!
i2c_adapter i2c-0: Failed reset at end of transaction (01)
i2c_adapter i2c-0: Failed! (01)
[last entry repeated many times]

Thanks for your assistance,
Kevin

