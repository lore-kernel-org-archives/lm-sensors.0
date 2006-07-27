From: devsku@gmail.com (Sunil Kumar)
Date: Thu, 27 Jul 2006 16:07:00 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607270907x2b40b5e1yf9cdcbbddc996c56@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the timeout happened for the read state with i=2 (yeah, I keep that around
to know how far my uguru could go) i.e in the for loop, it went fine for 2
reads and got stuck at 3rd read, and didn't even make it to the ready state
part in the end of that routine. Although, there is another path to ready
state routine, I haven't seen ready state timeout for a long time now (I
think because of the msleep(1) in the while loops, which we put in right in
the beginning of these discussions). So, 5 probably is fine.

I haven't tried the TIMEOUT 100 as yet but it came back with 250+msleep(1)
even with the retry code in place so I would expect it to hit it at
100+msleep(1) for sure. (this time I left my machine on; one thing to test
at a time, I was trying to test suspend2 reliability by suspending it as
many times as I had the reason for). My uguru (its an AN8 SLI) is really bad
I think. Sometimes it goes hours without the message, while at other times
it comes back within an half hour. But the frequency is low now (with
250+msleep(1)) and I am already glad and thankful for that....:)

I think this is an ideal candidate for parameter because it varies from
board to board so much. That will make me (hopefully some others) really
happy. Rest is upto you.

-Sunil


On 7/27/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
>
>
> Sunil Kumar wrote:
> > actually the reason I am insisting on doing more than one sleep is that
> one
> > sleep actually didn't work for me. It worked for four days (the uptime
> was
> > four days but 'on' time was probably one day cumulative because those
> were
> > working days and I was suspending the system down at night and in the
> > morning before going to work) and I assumed that it was fine but then it
> > popped its head again in the /var/log/messages. My cpu concern is
> already
> > addressed by making the TIMEOUT as 100 as you suggested.
> >
> > I think the middle ground will be to make this a configuration parameter
> > for
> > the driver because this sleep is going to vary from board to board e.g.
> 100
> > works for you and sometimes 100+msleep(1) doesn't work for me. The
> default
> > could be 1 and max could be 50, and these are taken out of the TIMEOUT
> i.e.
> > if value is set to 50, the loop executes for 50 and then starts to sleep
> > for
> > the rest 50.
> >
> > A runtime parameter would be better but I am fine with a config
> parameter
> > too. does that work?
> >
>
> Hmm,
>
> I really don't want to add all kinda knobs a user needs to tune for
> things to work. Did you see this message return despite of the sleep
> with my latest version of the driver? Because with my new driver you
> shouldn't see it as its treated as retryable (which means the driver
> will silently return the old values and try again next update, it will
> only start to scream on 3 (define) or more consecutive errors.)
>
> Noticed you also decreased the ABIT_UGURU_READY_TIMEOUT from 50 to 5,
> maybe that is the problem now. I agree 50 is to much, but maybe 5 isn't
> enough? What was the exact error you saw?
>
> Since the sleep is in what is in essence an error handling path, Its
> fine by me to sleep say 3 times before giving up, it should be very rare
> that the uguru then still isn't responding. Together with making the
> wait for read statsu retryable and thus in this rare occasion returning
> oldvalues to userspace instead of an error I think we should be fine.
> Does this sound like a plan?
>
> I'm glad atleast we agree on the CPU-usage being fixed by setting the
> default TIMEOUT to 100.
>
> Regards,
>
> Hans
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060727/88445e03/attachment.html 
