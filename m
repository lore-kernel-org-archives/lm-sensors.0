From: devsku@gmail.com (Sunil Kumar)
Date: Wed, 26 Jul 2006 18:32:01 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607261132q67cc36d1qaa3f33936e96d682@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

yeah, 'done' was remnant of another debugging session and lamely left there.

Hans, I have done some very rudimentary performance analysis of this driver
and I have a feeling that some tuning may be in order. All I did was to look
at gkrellm with abituguru loaded and unloaded. gkrellm updates sensors every
5 seconds (which is kinda high I think) and I see that the cpu usage is 0-2%
if module is unloaded. If module is loaded the cpu usage is as high as 4%
every 5 seconds (more than half of it red). System is quiet and nothing else
is being done on it.

I suspect its to do with the while loop in abitugru_wait(). What I did was
to make the following change on top of what you sent and cpu usage became 2%
every 5 seconds. So, it remains between 0-2%.

I don't think there is any harm in sleeping because most sensor user
programs are working at seconds level and we are talking about ms sleep. And
in most cases first sleep for 1 jiffy will be enough. But this probably
needs testing by our volunteers to see if there are any ill-effects,
although it works perfectly here.

--- /tmp/abituguru.c    2006-07-26 11:16:32.000000000 -0700
+++ ./abituguru.c       2006-07-26 11:14:04.000000000 -0700
@@ -72,9 +72,10 @@
    the CPU should be the bottleneck. Note that 250 sometimes is still not
    enough (only reported on AN7 mb) this is handled by a higher layer. */
 #define ABIT_UGURU_WAIT_TIMEOUT                        250
+#define ABIT_UGURU_WAIT_TIMEOUT_SLEEP          200
 /* Normally all expected status in abituguru_ready, are reported after the
    first read, but sometimes not and we need to poll. */
-#define ABIT_UGURU_READY_TIMEOUT               50
+#define ABIT_UGURU_READY_TIMEOUT               5
 /* Maximum 3 retries on timedout reads/writes, delay 200 ms before retrying
*/
 #define ABIT_UGURU_MAX_RETRIES                 3
 #define ABIT_UGURU_RETRY_DELAY                 (HZ/5)
@@ -226,10 +227,11 @@
                timeout--;
                if (timeout = 0)
                        return -EBUSY;
-               /* sleep a bit before our last try, to give the uGuru one
-                  last chance to respond. */
-               if (timeout = 1)
-                       msleep(1);
+               /* start sleeping a bit after
ABIT_UGURU_WAIT_TIMEOUT-ABIT_UGURU_WAIT_TIMEOUT_SLEEP
+                * iterations to give the uGuru max chance to respond.
+                */
+               if (timeout <= ABIT_UGURU_WAIT_TIMEOUT_SLEEP)
+                       msleep(0);
        }
        return 0;
 }

Thanks,
Sunil


On 7/26/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
>
>
> Sunil Kumar wrote:
> > Hans, I have tested this patch against abituguru.c that you sent me last
> > time for last 4 days, and found that it works fine (tested both with HZ
> 250
> > and 1000). It basically sleep for 2 jiffies if the timeout in
> > abituguru_wait
> > gets over. Since all other parameters remain the same (I reverted 25 to
> > original 50), in systems where this driver was working fine, it will
> keep
> > working the same way with the same speed. It is zero impact for working
> > existing systems.
> >
>
> Thanks,
>
> Thats an excellent way to fix it! But I see no need for the done flag,
> just checking timeout should suffice, or am I missing something? Anywasy
> the attached version has your patch but with the done flag removed.
>
> I was thinking a bit about this myself too and I decided to make those
> read timeouts retryable errors instead of throwing an error the first
> time things fail. I've added this to this version too. With the
> combination of these 2 these type of errors should really be history.
>
> Please give the attached version a spin for a day or two, I assume it
> will work fine, but better safe then sorry.
>
> If it turns out ok then I'll submit this version for merging.
>
> Thanks! & Regards,
>
> Hans
>
>
>
>
> > --- abituguru.c.ORG     2006-07-24 20:21:39.000000000 -0700
> > +++ abituguru.c 2006-07-23 01:05:46.000000000 -0700
> > @@ -74,7 +74,7 @@
> > #define ABIT_UGURU_WAIT_TIMEOUT                        250
> > /* Normally all expected status in abituguru_ready, are reported after
> the
> >    first read, but sometimes not and we need to poll. */
> > -#define ABIT_UGURU_READY_TIMEOUT               25
> > +#define ABIT_UGURU_READY_TIMEOUT               50
> > /* Maximum 3 retries on timedout reads/writes, delay 200 ms before
> retrying
> > */
> > #define ABIT_UGURU_MAX_RETRIES                 3
> > #define ABIT_UGURU_RETRY_DELAY                 (HZ/5)
> > @@ -221,11 +221,17 @@
> > static int abituguru_wait(struct abituguru_data *data, u8 state)
> > {
> >        int timeout = ABIT_UGURU_WAIT_TIMEOUT;
> > +       int done = 0;
> >
> >        while (inb_p(data->addr + ABIT_UGURU_DATA) != state) {
> >                timeout--;
> > -               if (timeout = 0)
> > +               if (timeout = 0 && done)
> >                        return -EBUSY;
> > +               if (!done && timeout = 1)
> > +               {
> > +                       msleep(1);
> > +                       done = 1;
> > +               }
> >        }
> >        return 0;
> > }
> > @@ -334,8 +340,8 @@
> >        for (i = 0; i < count; i++) {
> >                if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
> >                        ABIT_UGURU_DEBUG(1, "timeout exceeded waiting for
> "
> > -                               "read state (bank: %d, sensor: %d)\n",
> > -                               (int)bank_addr, (int)sensor_addr);
> > +                               "read state (bank: %d, sensor: %d i:
> > %d)\n",
> > +                               (int)bank_addr, (int)sensor_addr, i);
> >                        break;
> >                }
> >                buf[i] = inb(data->addr + ABIT_UGURU_CMD);
> >
> > Please consider it for inclusion.
> >
> > Thanks,
> > Sunil
> >
> >
> > On 7/21/06, Sunil Kumar <devsku at gmail.com> wrote:
> >>
> >> Few things I noted:
> >>
> >> 1. HZ%0 means that msleep(1) sleeps for  8 ms because msleep does
> >> schedule_timeout for msecs_to_jiffies(m) + 1, and hence sleeps for 2
> >> jiffies. That's longer than I desired. Only way out would be make
> HZ00
> >> because I can't sleep finer than 4ms with HZ%0. So, msleep(0) which
> >> sleeps
> >> for one jiffy, may be adequate.
> >>
> >> 2. The problem that comes after applying the patch is from this part of
> >> the code in routine abituguru_read():
> >>
> >>         /* And read the data */
> >>         for (i = 0; i < count; i++) {
> >>                 if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
> >>                         ABIT_UGURU_DEBUG(1, "timeout exceeded waiting
> for
> >> "
> >>                                 "read state (bank: %d, sensor: %d)\n",
> >>                                 (int)bank_addr, (int)sensor_addr);
> >>                         break;
> >>                 }
> >>                 buf[i] = inb(data->addr + ABIT_UGURU_CMD);
> >>         }
> >>
> >> I just printed value of i and found that it fails for i=1 i.e. it read
> >> fine for i=0, which means that consecutive reads don't have enough
> >> wait in
> >> between. This is not solvable in any way apart from doing a msleep(0)
> for
> >> every read, which may be as large as 10ms for people with HZ0, and
> as
> >> small as 1ms (which is probably ok) for HZ00.
> >>
> >> Is it possible to change this loop to something like:
> >>
> >>         /* And read the data */
> >>         for (i = 0; i < count; i++) {
> >>                 done=1;
> >>                 while (done)
> >>                 {
> >>                         if (abituguru_wait(data,
> ABIT_UGURU_STATUS_READ))
> >>                                 msleep(0);
> >>                         done=0;
> >>                 }
> >>                 if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
> >>                         ABIT_UGURU_DEBUG(1, "timeout exceeded waiting
> for
> >> "
> >>                                 "read state (bank: %d, sensor: %d)\n",
> >>                                 (int)bank_addr, (int)sensor_addr);
> >>                         break;
> >>                 }
> >>                 buf[i] = inb(data->addr + ABIT_UGURU_CMD);
> >>         }
> >>
> >> (declare done at the top)
> >>
> >> i.e. sleep for 1 jiffy if abituguru_wait() fails, at most once. It has
> no
> >> impact for boards which return from abituguru_wait in the desired
> >> state the
> >> first time. For some, it might mean longer delays.
> >>
> >> I don't want to put msleep(0) in abituguru_wait() because that
> >> function is
> >> used in many places.
> >>
> >> OR
> >>
> >> Just remove the message from the for loop ...:-) i.e.
> >>
> >>         /* And read the data */
> >>         for (i = 0; i < count; i++) {
> >>                 if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
> >>                    break;
> >>                 }
> >>                 buf[i] = inb(data->addr + ABIT_UGURU_CMD);
> >>         }
> >>
> >> Basically, I don't have an elegant solution to this problem...:-(
> >>
> >> -Sunil
> >>
> >>
> >> On 7/20/06, Hans de Goede < j.w.r.degoede at hhs.nl> wrote:
> >>
> >> >
> >> >
> >> > Sunil Kumar wrote:
> >> > > sent too soon. I wanted to mention that the frequency of messages
> has
> >> > > reduced by manyfolds after this patch.
> >> > >
> >> >
> >> > I've sightly reduced the ABIT_UGURU_READY_TIMEOUT because we are
> >> > sleeping now. You decreased it from 50 to 30, I went with 25. Can you
> >> > try the driver for a couple of days with this set back to 50 and then
> >> > see if it still happens?
> >> >
> >> > Thanks & Regards,
> >> >
> >> > Hans
> >> >
> >>
> >>
> >
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060726/8bfa2219/attachment-0001.html 
