From: Laszlo Papp <lpapp@kde.org>
Date: Tue, 11 Feb 2014 15:15:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6650) Rename the device ids to contain the hwmon suffix
Message-Id: <CAOMwXhO5P32W6CyCUx3-B=mT4b9ad6u1oJXKXwzOZq8beoXS0Q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392045953-26596-1-git-send-email-lpapp@kde.org>
	<20140210160842.GB26997@lee--X1>
	<20140210173811.04ba5964@endymion.delvare>
	<CAOMwXhPTkrUUaUL-H_0fvZBO9_kt4jqKXs5BJYthDfu0_1c3xg@mail.gmail.com>
	<20140211085014.4ef32b56@endymion.delvare>
	<CAOMwXhMhKdp420+SPTih+C3fAgTmrpJgPnGBxsfPO3pEhESGTA@mail.gmail.com>
	<1392108545.4700.4.camel@chaos.site>
	<CAOMwXhM4eaoEcQeeRgoXxxGzXkwSoypFLMd2qPwckgayEqsu_g@mail.gmail.com>
	<20140211095717.GI32042@lee--X1>
In-Reply-To: <20140211095717.GI32042@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Jean Delvare <jdelvare@suse.de>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Tue, Feb 11, 2014 at 9:57 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> >> Time to revisit this decision....
>> >>
>> >> So, based on the fact that children device names usually contain
>> >> dashes, I do not understand why hwmon would be any special in this
>> >> regard. It is possible that the hwmon developers have not faced much
>> >> MFD situation before, and so, this was not considered to be handled
>> >> like in other subsystems.
>> >>
>> >> I am proposing to change this "rule"...  Any objection?
>> >
>> > I'm giving up here, sorry. There's no point in me writing any more on
>> > the topic as you are not listening to me. I do not have the impression
>> > you are doing any effort to understand what I'm saying. Plus you keep
>> > focusing on things that do not matter and problems for which a solution
>> > has already been provided.
>>
>> Does it mean the people cannot come up with ideas if they think
>> something may be better than some provided way? Surely, software
>> evolves over time and people are sometimes right, and sometimes wrong
>> right?
>>
>> I can assure you that I do listen, please assume good faith with ideas
>> thrown in. If you think it is that bad an idea, you could have
>> explained why so, so that I and others can also understand it who do
>> not yet, right?
>
> In the small amount of time you've been working in the kernel I've
> seen 3-4 Maintainers completely give up on you and 2-3 driven close to
> the end of their tether (myself included).
>
> Ranting and demanding will not work well for you here. Please, for
> your own sake, learn some diplomacy and be courteous to others on the
> list. If people are replying it means they're trying to help. Jumping
> down their throats is not conducive to your success and will not
> result in a win.

I have not intended to demand anything, but I must confess that I was
frustrated about my long work being wasted, and I could probably have
spent my time with sipping some tea instead of replying. :-)

Apologies if I had hurt anyone involved. It is far from my intention.
I just really wished to proceed with this feature. Will try to grab my
cup next time earlier. Cheers.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
