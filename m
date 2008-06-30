From: "Chris Friedline" <chris@friedline.net>
Date: Mon, 30 Jun 2008 21:43:20 +0000
Subject: Re: [lm-sensors] Only coretemp is found by sensors-detect
Message-Id: <8bdcba610806301443v2af38aacv251cde5179c5f153@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <8bdcba610806250808x6dae4815h7272666180d133b7@mail.gmail.com>
In-Reply-To: <8bdcba610806250808x6dae4815h7272666180d133b7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg,

Unfortunately, I can't do Windows on this box at this time.  Looks
like speedfan is not supported under Wine, either.  Any other ideas?

Chris

On Mon, Jun 30, 2008 at 4:45 PM, Juerg Haefliger <juergh@gmail.com> wrote:
> Chris,
>
> If you can run Windows on this machine, you could give speedfan
> (http://www.almico.com/sfdownload.php) a try. It claims to support the
> LPC47M534. Then we would at least know for sure what it is and add
> detection to sensors-detect. Not that we can support it without a
> datasheet though...
>
> ...juerg
>
>
>
> On Wed, Jun 25, 2008 at 6:40 PM, Chris Friedline <chris@friedline.net> wrote:
>> All,
>>
>> According to google, the SIO is a SMSC EMC2700P. I don't have a
>> datasheet for this chip and doubt that SMSC will provide one given
>> that this is a Dell machine. Without a datasheet, there's nothing we
>> can do.
>>
>>
>> Uh-huh, missed that one :-) You have a chip @ 0x2e. Run 'i2cdump 0
>> 0x2e' and send the output to the list. Maybe it looks familiar to
>> somebody. Per google, it's an LPC47M534. Don't know that chip. You can
>> try force-loading the LM85 driver and check if you get anything
>> useful.
>>
>> ---
>> Here is the output from i2cdump.  Does anyone see anything?
>>
>> Here is the output from i2cdump 0 0x2e:
>>
>> No size specified (using byte-data access)
>> WARNING! This program can confuse your I2C bus, cause data loss and worse!
>> I will probe file /dev/i2c-0, address 0x2e, mode byte
>> Continue? [Y/n] y
>>    0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80    ...............?
>> 10: 00 00 00 00 00 00 00 00 0f 07 07 07 07 0f 0f 0f    ........????????
>> 20: 00 95 bf 96 00 95 5e 5c 5d 5c 57 5c 2c 14 fe 0b    .???.?^\]\W\,???
>> 30: f4 11 83 0a ff ff 2a 57 25 01 00 1a a1 00 5c a0    ????..*W%?.??.\?
>> 40: 01 00 00 00 00 00 00 b8 1e 00 00 00 5a da b3 cd    ?......??...Z???
>> 50: 8d a7 00 00 5a da 00 a4 00 a4 00 a4 00 a4 00 ff    ??..Z?.?.?.?.?..
>> 60: 00 ff 50 46 50 46 50 46 50 46 50 46 00 05 00 00    ..PFPFPFPFPF.?..
>> 70: 00 00 00 00 00 00 00 00 00 00 b9 3e 00 00 00 00    ..........?>....
>> 80: 00 00 00 bb bb dd dd c8 08 88 51 60 54 00 00 00    ...???????Q`T...
>> 90: 83 83 83 83 59 6a a9 a9 a9 a9 00 00 00 00 00 00    ????Yj????......
>> a0: ea ea 2a 00 04 04 04 04 00 00 00 00 0a 2a 88 88    ??*.????....?*??
>> b0: 88 88 6d 76 00 00 ff de 40 00 10 5e 00 00 00 00    ??mv...?@.?^....
>> c0: 00 00 00 00 ff ff ff ff ff ff 00 02 00 00 00 00    ...........?....
>> d0: 00 e5 00 00 00 00 ff 00 00 00 00 ff 00 00 00 00    .?..............
>> e0: 00 00 08 e0 60 00 4f 00 08 00 d5 d5 d5 d5 0f 32    ..??`.O.?.?????2
>> f0: 30 b0 31 b1 9a 00 40 00 40 00 00 00 00 00 00 00    0?1??.@.@.......
>>
>> Thanks,
>> Chris
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
