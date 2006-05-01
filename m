From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 01 May 2006 15:12:13 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <4456254D.6070507@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Thomas Andrews wrote:
> On Mon, May 01, 2006 at 02:22:52PM +0200, Jean Delvare wrote:
>
>  =20
>>> I have a soekris net4801 which has the same sc-1100.
>>> On my board, ISA addys 2e, 2f talk to a separate Super-IO chip, pc87360.
>>> which IIRC has an acb unit also.
>>>      =20
>> True, we don't have a driver for it at the moment though.
>>
>>    =20
>>> Back when I got the board, the presence of 2 superio devices was somewh=
at
>>> confusing, until Id read both datasheets - 2x.
>>>      =20
>> Does the SC1100 appears at 0x4e/0x4f on your Soekris board? If so,
>> Thomas' code should still work, as long as we probe both possible
>> address pairs.
>>    =20
>
> At the moment I'm probing 2e, 4e, and 15c for the base addresses. The
> addition of the last one was as a result of two things:
>
>     (a) The old i2c-nscacb.c driver had this option
>     (b) The SC1100 data-sheet indicates that it could be located there.
>
> I have also made this a module parameter, so you could actually probe
> anywhere for the base addresses, if you needed to.
>
> I've retained the base addresses as a module parameter, so if you specify
> those, then it will skip the probing at 2e, 4e, and 15c, and just use
> the addresses you give.
>
> Will that satisfy everyone's needs?
>  =20

If theres a device-id, it would be good to check.
I dont know the 1st thing about the ACB (on either chip), but I will=20
(eventually)
try your code, to see if it works on either or both devices.
At this point, I dunno how Ill know about 'works'.

Jean,

> Does the SC1100 appears at 0x4e/0x4f on your Soekris board?=20


dunno, Ill try that too, when I can.

I suppose I should think some more about sio_lockmgr I talked about once.
http://thread.gmane.org/gmane.linux.drivers.sensors/8710/focus=9122

> Regards,
> Thomas
>
>  =20

thanks


