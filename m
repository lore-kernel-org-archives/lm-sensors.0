From: Karl Schmidt <karl@xtronics.com>
Date: Sat, 05 Sep 2009 22:03:40 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <4AA2E03C.2030303@xtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sat, 05 Sep 2009 14:16:15 -0500, Karl Schmidt wrote:
>> Jean Delvare wrote:
>>>> This is a Tyan S2865
>>
>> I figured you would want a new listing of this:
>>
>>
>>> #i2cdump 1 0x2e
>>> No size specified (using byte-data access)
>>> Error: Could not open file `/dev/i2c-1' or `/dev/i2c/1': No such file or directory
>>
>>
>> oops?? Not what I expected.
> 


> You forgot: modprobe i2c-dev.i2cdump 1 0x2e
OK -

No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1, address 0x2e, mode byte
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff    ................
20: 64 79 c3 c3 c1 24 1a 17 b2 02 95 02 aa 02 ab 02    dy???$??????????
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 5c 89    ..............\?
40: 05 00 00 00 00 4d 00 ff 00 ff 00 ff 00 ff 81 7f    ?....M........??
50: 81 7f 81 7f a3 02 58 02 ff ff ff ff 02 02 02 a7    ??????X?....????
60: a7 a7 e0 00 00 00 00 2d 2d 2d 64 64 64 44 40 00    ???....---dddD@.
70: 00 00 00 09 09 09 09 09 09 00 30 00 40 00 00 1c    ...??????.0.@..?
80: 00 a4 00 00 44 2a 86 c3 0d 00 4d 4d 0b 0b 0c 00    .?..D*???.MM???.
90: cc cc cc cc 0c 0c 0c 5a f1 c0 ae 00 ff 00 ff 00    ???????Z???.....
a0: 00 00 0c 00 00 00 00 0b 0b fe ff fe ff ff ff ff    ..?....???.?....
b0: ff 00 00 00 00 00 28 28 0e 0e 2b 2b 00 00 00 00    ......((??++....
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................



--------------------------------------------------------------------------------
Karl Schmidt                                  EMail Karl@xtronics.com
Transtronics, Inc.                              WEB http://xtronics.com
3209 West 9th Street                             Ph (785) 841-3089
Lawrence, KS 66049                              FAX (785) 841-0434

If everything seems to be going well,
I've obviously overlooked something.

--------------------------------------------------------------------------------

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
