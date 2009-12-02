From: MC Matti <mcmatti17@googlemail.com>
Date: Wed, 02 Dec 2009 17:15:59 +0000
Subject: Re: [lm-sensors] Zotac itx-f sensor i2cdump
Message-Id: <45354d3e0912020915p6b222b94w23b6f8b8e76f9228@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45354d3e0912020755s5c8f2c00rc9c5611c204ae719@mail.gmail.com>
In-Reply-To: <45354d3e0912020755s5c8f2c00rc9c5611c204ae719@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> root@localhost:~# i2cdump 0 0x4c
>> No size specified (using byte-data access)
>> WARNING! This program can confuse your I2C bus, cause data loss and worse!
>> I will probe file /dev/i2c-0, address 0x4c, mode byte
>> Continue? [Y/n]
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 00: 2e 3b 80 01 08 46 d8 46 d8 ff ff ff ff ff ff ff    .;???F?F?.......
>> 10: 60 00 00 00 00 00 00 04 00 6e 6e 46 d8 00 00 ff    `......?.nnF?...
>> 20: 55 0a ff ff 7f e0 ff ff ff ff ff ff ff ff ff ff    U?..??..........
>> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
>> <more ff>
>> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00    ................
>> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
>> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
>> e0: 00 00 00 84 84 84 00 00 55 00 00 ff ff ff ff ff    ...???..U.......
>> f0: 50 00 00 00 84 00 00 39 a0 00 00 83 00 ff 5c 11    P...?..9?..?..\?
>
> I was discussing with someone from Zotac recently and he told me they
> were using W83L771AWG/ASG. The above looks exactly like one. Please
> give a try to the latest version of sensors-detect, it should confirm
> it:
>  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>
donwloaded:
[...]
Probing for `Winbond W83L771AWG/ASG'...                     Success!
   (confidence 6, driver `to-be-written')
[...]

> We do not have support for this chip yet.
>
Is there a documentation?
Is anyone already working on it?
Which driver would be the best to start with (if theres a doc)?

mcmatti

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
