From: Laszlo Papp <lpapp@kde.org>
Date: Fri, 07 Mar 2014 15:47:08 +0000
Subject: Re: [lm-sensors] Tachometer speed returned rather than absolute fan speed?
Message-Id: <CAOMwXhPpObWqd1vR3t+ifKd-_ZbnGTm1TNNUakmVAR3CB=pzTg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOMwXhPXPN+21N11cHBENvw0QZ1qPvo9GTbM9V2SwDmgBQZssw@mail.gmail.com>
	<20140307162524.6abd34be@endymion.delvare>
	<CAOMwXhOB=1HA57jwKCx3-hU8A_ypjrm0J3R9huO25xa4B_gw8w@mail.gmail.com>
	<20140307163717.336873f5@endymion.delvare>
In-Reply-To: <20140307163717.336873f5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>

On Fri, Mar 7, 2014 at 3:37 PM, Jean Delvare <jdelvare@suse.de> wrote:
>> > I'm quite confused. While I admit that the term "tachometer speed" is
>> > awkward, the max6650 driver is reporting fan speeds in RPM as every
>> > other hwmon driver. So I really have no idea what you think is wrong.
>> > What did you think "tachometer speed" was, if not the fan speed? Does
>> > the max6650 driver not return correct fan speeds for you?

That is some strange behavior. If I do "echo 1 > pwm1_enable; echo 0 >
pwm1; cat fan1_input", I still see 30 for the connected fan, whereas I
can see it stopped. Is this an expected behavior? I would expect zero
as a user.

>> Better wording would have definitely helped in here. Fwiw, I asked
>> another kernel hacker person who also got confused telling me that he
>> would not know without reading the source code. I think that it is an
>> indication to improve the documentation. There might be better
>> alternatives than the one I am proposing, but at least that one clears
>> up that for me.
>
> I agree. I think I would just go with "measured fan speed in RPM", as
> tachometer is quite a technical term and the user doesn't need to know.
> Care to send a patch?

Hmm, yeah, perhaps. I can try to do that during the weekend.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
