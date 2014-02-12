From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Feb 2014 14:24:22 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <52FB8416.9070106@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 02/12/2014 04:05 AM, Jean Delvare wrote:
> On Wed, 12 Feb 2014 03:54:44 -0800, Guenter Roeck wrote:
>> On 02/12/2014 03:07 AM, J=FCrgen Fuchsberger wrote:
>>> i2cdump.txt
>>>
>>>
>>>        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcd=
ef
>>> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>>> 20: 36 00 c0 3a c4 80 27 80 ff ff ff ff ff ff ff ff    6.?:??'?........
>>> 30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 5c 8a    ..............\?
>>> 40: 0f db c0 20 ad d3 00 ff ad d3 ad d3 ad d3 81 7f    ??? ??..????????
>>> 50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 cb    ????........bbb?
>>> 60: cb cb e0 00 80 80 80 80 80 80 64 64 64 44 40 00    ???.??????dddD@.
>>> 70: ff ff ff 09 09 09 09 09 09 00 00 00 40 00 ec 10    ...??????...@.??
>>> 80: 7e a4 0e 00 d3 00 87 74 e0 00 4d 4d 0b 0b 0d 00    ~??.?.?t?.MM???.
>>> 90: 04 04 04 04 0c 0c 0c 5a f1 c0 af ad d3 9d c0 00    ???????Z???????.
>>> a0: 00 00 0c 00 02 ff ff 0b 0b fe ff fe ff ff ff ff    ..?.?..???.?....
>>> b0: ff 00 00 00 00 00 28 28 0e 0e 0f 0f 00 00 00 00    ......((????....
>>> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>>
>> That looks normal for the chip as far as I can see, and there are
>> no errors.
>
> The board supports IPMI. I would guess that the errors happen when the
> native driver and IPMI attempt to access the SMBus at the same time.
>
Yes, that would explanin the problem.

> As usual, my recommendation is to either use IPMI or native drivers but
> not mix.
>
Agreed.

Guenter

>> Wonder if the chip may have timing restrictions and not respond
>> to queries under some circumstances (eg if registers are read
>> too quickly back-to-back). Unfortunately I don't seem to be able
>> to find a datasheet for it. Does anyone have one, by any chance ?
>
> I do have it, and Juerg does as well, but at least I am not allowed to
> share it. I'll be happy to answer any question though.
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
