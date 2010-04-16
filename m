From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Fri, 16 Apr 2010 13:56:43 +0000
Subject: Re: [lm-sensors] [PATCH] lis3lv02d: provide means to disable polled
Message-Id: <4BC86C9B.4010400@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LNX.2.00.1004091453530.8345@pobox.suse.cz> <4BBF2BD1.5050107@tremplin-utc.net> <alpine.LNX.2.00.1004091532150.8345@pobox.suse.cz> <op.va86rulwgp7y00@linux-r26l.site> <62697B07E9803846BC582181BD6FB6B826A8525E8A@NOK-EUMSG-02.mgdnok.nokia.com> <op.va878jw6gp7y00@linux-r26l.site>
In-Reply-To: <op.va878jw6gp7y00@linux-r26l.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Marcin Derlukiewicz <marcin@derlukiewicz.pl>
Cc: samu.p.onkalo@nokia.com, jkosina@suse.cz, akpm@linux-foundation.org, pavel@ucw.cz, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 16/04/10 14:13, Marcin Derlukiewicz wrote:
> Dnia 16-04-2010 o 14:00:15 <samu.p.onkalo@nokia.com> napisa=C5=82(a):
>=20
:
>>
>> Could you check what is the polling period of the device.
>> something like:
>> cat /sys/devices/platform/lis3lv02d/input/input9/poll
>>
>> it is current polling period in milliseconds. 0 disables polling.
>>
>> -Samu
>>
>=20
> I think that on my system this is /sys/devices/platform/lis3lv02d/rate
> but i may be wrong. Anyway it contains 40 as a number.
This file is something else. Isn't there any file like
/sys/devices/platform/lis3lv02d/input/input*/poll ?

Maybe your kernel is too old to have this functionality (I don't know
when it was introduced). Samu is right, here to disable the joystick, I
can indeed do a:
echo 0 > /sys/devices/platform/lis3lv02d/input/input*/poll

Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
