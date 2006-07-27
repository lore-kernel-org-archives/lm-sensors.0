From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 27 Jul 2006 14:44:52 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44C8D164.80908@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sunil Kumar wrote:
> actually the reason I am insisting on doing more than one sleep is that one
> sleep actually didn't work for me. It worked for four days (the uptime was
> four days but 'on' time was probably one day cumulative because those were
> working days and I was suspending the system down at night and in the
> morning before going to work) and I assumed that it was fine but then it
> popped its head again in the /var/log/messages. My cpu concern is already
> addressed by making the TIMEOUT as 100 as you suggested.
> 
> I think the middle ground will be to make this a configuration parameter
> for
> the driver because this sleep is going to vary from board to board e.g. 100
> works for you and sometimes 100+msleep(1) doesn't work for me. The default
> could be 1 and max could be 50, and these are taken out of the TIMEOUT i.e.
> if value is set to 50, the loop executes for 50 and then starts to sleep
> for
> the rest 50.
> 
> A runtime parameter would be better but I am fine with a config parameter
> too. does that work?
> 

Hmm,

I really don't want to add all kinda knobs a user needs to tune for
things to work. Did you see this message return despite of the sleep
with my latest version of the driver? Because with my new driver you
shouldn't see it as its treated as retryable (which means the driver
will silently return the old values and try again next update, it will
only start to scream on 3 (define) or more consecutive errors.)

Noticed you also decreased the ABIT_UGURU_READY_TIMEOUT from 50 to 5,
maybe that is the problem now. I agree 50 is to much, but maybe 5 isn't
enough? What was the exact error you saw?

Since the sleep is in what is in essence an error handling path, Its
fine by me to sleep say 3 times before giving up, it should be very rare
that the uguru then still isn't responding. Together with making the
wait for read statsu retryable and thus in this rare occasion returning
oldvalues to userspace instead of an error I think we should be fine.
Does this sound like a plan?

I'm glad atleast we agree on the CPU-usage being fixed by setting the
default TIMEOUT to 100.

Regards,

Hans

