From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 04 Jun 2006 12:47:58 +0000
Subject: [lm-sensors] IBM NetFinity 4000r Support
Message-Id: <4482D67E.7000905@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44665DE5.60703@wans.net>
In-Reply-To: <44665DE5.60703@wans.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> Sorry for the delay, I brought up a second machine to do the development
> on since the first is my server.

Good,

> Needless to say, I didn't get very far.  Here's the output of the
> commands you gave me.  It does indeed sound like a bus issue.
> 
> [root at localhost ~]# modprobe i2c-dev
> [root at localhost ~]# modprobe i2c-piix4
> [root at localhost ~]# i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX 18 XX 1a XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX 4c XX 4e XX
> 50: XX XX 52 53 XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX 66 XX XX 69 XX XX XX XX XX XX
> 70: XX XX XX 73 XX XX XX XX
> 
> [root at localhost ~]# i2cdump 0 0x2d
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x2d, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 1c 00 02 00 00 11 00 44 04 04 00 00 00 54 00    .?.?..?.D??...T.
> 10: 00 02 00 10 44 00 10 10 00 80 00 10 00 08 04 00    .?.?D.??.?.?.??.
> 20: 01 00 00 18 00 00 08 42 00 90 00 00 a0 00 23 05    ?..?..?B.?..?.#?
> 30: 00 00 00 00 00 80 02 00 00 00 00 12 00 10 00 08    .....??....?.?.?
> 40: 08 00 10 00 00 00 40 51 2d c0 c0 c0 c0 c0 c0 00    ?.?... at Q-??????.
> 50: 08 00 10 00 00 00 40 51 2d c0 c0 c0 c0 c0 c0 00    ?.?... at Q-??????.
> 60: 01 00 00 18 00 00 08 XX XX XX XX XX XX XX XX XX    ?..?..?XXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 
> And in dmesg:
> 
> i2c_adapter i2c-0: SMBus Timeout!
> i2c_adapter i2c-0: Failed reset at end of transaction (01)
> i2c_adapter i2c-0: Failed! (01)
> [last entry repeated many times]
> 

Please can you provide output of
lspci -xxx

and additionally please turn on debug of i2c bus, plus repeat above sequence and
send here also the logs so situation can be analyzed.

Preliminary i think some of the bus devices wants to send something to bus
master so it is truly a multi master bus and maybe it confuses the driver...

Thanks,
Regards
Rudolf


