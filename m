From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: adm1021 (probably) does something VERY,VERY BAD
Message-Id: <4064E2F2.5020201@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4062C734.5000104@gmx.net>
In-Reply-To: <4062C734.5000104@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This looks to me like a lm75-compatible or adm1021-compatible chip;
the address range 48-4f is traditionally for temperature sensors;
it wouldn't be that unusual for a board with a w83627hf (with 3 temp sensors)
to have another chip to provide additional temperatures.

I agree w/ Khali that you can watch the registers with i2cdump
(esp. at data address 0x00) to see if it varies with CPU load,
if so try loading lm75.

The first 4 locations look somewhat like temp, control, hyst, and max to me....
then again, maybe not.

I see the lm75 section in sensors-detect has grown a lot,
I don't pretend to understand it all but perhaps there is a new
case here or perhaps it is too restrictive?

Our first guess for a chip in the range 48-4f should always be lm75
or compatible.

Eric perhaps you can look at your board and find out what chip this is,
that would be a big help to us.

mds



Eric wrote:
> Well, I should have seen it, so consider me a stoopid as well :-)
> 
> root@pathfinder eric # i2cdump 0 0x4e
> No size specified (using byte-data access)
>  WARNING! This program can confuse your I2C bus, cause data loss and worse!
>  I will probe file /dev/i2c-0, address 0x4e, mode byte
>  You have five seconds to reconsider and press CTRL-C!
> 
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 6d 2d 10 72 00 80 0f 00 00 00 ff 00 00 00 e0 ff    m-?r.??.......?.
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 
> Jean Delvare wrote:
> 
>> Quoting Eric <plukje@gmx.net>:
>>
>>
>>> About the version I used, I couldn't find a version number in
>>> sensors-detect
>>>
>>
>> We don't include any version in it because it would be a real pain to
>> update it with each new release.
>>
>>
>>> but I'm fairly sure this is 2.8.5 (from sensors --version) or
>>> better.
>>>
>>
>> So you did the right thing, this was the right way to get the
>> information :)
>>
>>
>>> root@pathfinder eric # i2cdump 0 0x2e
>>>
>>
>> OK, I am too stupid. This was "i2cdump 0 0x4e", since the mysterious
>> chip is as 0x04e.
>>
>>
> 
> 
