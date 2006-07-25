From: devsku@gmail.com (Sunil Kumar)
Date: Tue, 25 Jul 2006 03:27:35 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607242027y419e5c23t6602fbedb922ae74@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans, I have tested this patch against abituguru.c that you sent me last
time for last 4 days, and found that it works fine (tested both with HZ 250
and 1000). It basically sleep for 2 jiffies if the timeout in abituguru_wait
gets over. Since all other parameters remain the same (I reverted 25 to
original 50), in systems where this driver was working fine, it will keep
working the same way with the same speed. It is zero impact for working
existing systems.

--- abituguru.c.ORG     2006-07-24 20:21:39.000000000 -0700
+++ abituguru.c 2006-07-23 01:05:46.000000000 -0700
@@ -74,7 +74,7 @@
 #define ABIT_UGURU_WAIT_TIMEOUT                        250
 /* Normally all expected status in abituguru_ready, are reported after the
    first read, but sometimes not and we need to poll. */
-#define ABIT_UGURU_READY_TIMEOUT               25
+#define ABIT_UGURU_READY_TIMEOUT               50
 /* Maximum 3 retries on timedout reads/writes, delay 200 ms before retrying
*/
 #define ABIT_UGURU_MAX_RETRIES                 3
 #define ABIT_UGURU_RETRY_DELAY                 (HZ/5)
@@ -221,11 +221,17 @@
 static int abituguru_wait(struct abituguru_data *data, u8 state)
 {
        int timeout = ABIT_UGURU_WAIT_TIMEOUT;
+       int done = 0;

        while (inb_p(data->addr + ABIT_UGURU_DATA) != state) {
                timeout--;
-               if (timeout = 0)
+               if (timeout = 0 && done)
                        return -EBUSY;
+               if (!done && timeout = 1)
+               {
+                       msleep(1);
+                       done = 1;
+               }
        }
        return 0;
 }
@@ -334,8 +340,8 @@
        for (i = 0; i < count; i++) {
                if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
                        ABIT_UGURU_DEBUG(1, "timeout exceeded waiting for "
-                               "read state (bank: %d, sensor: %d)\n",
-                               (int)bank_addr, (int)sensor_addr);
+                               "read state (bank: %d, sensor: %d i: %d)\n",
+                               (int)bank_addr, (int)sensor_addr, i);
                        break;
                }
                buf[i] = inb(data->addr + ABIT_UGURU_CMD);

Please consider it for inclusion.

Thanks,
Sunil


On 7/21/06, Sunil Kumar <devsku at gmail.com> wrote:
>
> Few things I noted:
>
> 1. HZ%0 means that msleep(1) sleeps for  8 ms because msleep does
> schedule_timeout for msecs_to_jiffies(m) + 1, and hence sleeps for 2
> jiffies. That's longer than I desired. Only way out would be make HZ00
> because I can't sleep finer than 4ms with HZ%0. So, msleep(0) which sleeps
> for one jiffy, may be adequate.
>
> 2. The problem that comes after applying the patch is from this part of
> the code in routine abituguru_read():
>
>         /* And read the data */
>         for (i = 0; i < count; i++) {
>                 if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
>                         ABIT_UGURU_DEBUG(1, "timeout exceeded waiting for
> "
>                                 "read state (bank: %d, sensor: %d)\n",
>                                 (int)bank_addr, (int)sensor_addr);
>                         break;
>                 }
>                 buf[i] = inb(data->addr + ABIT_UGURU_CMD);
>         }
>
> I just printed value of i and found that it fails for i=1 i.e. it read
> fine for i=0, which means that consecutive reads don't have enough wait in
> between. This is not solvable in any way apart from doing a msleep(0) for
> every read, which may be as large as 10ms for people with HZ0, and as
> small as 1ms (which is probably ok) for HZ00.
>
> Is it possible to change this loop to something like:
>
>         /* And read the data */
>         for (i = 0; i < count; i++) {
>                 done=1;
>                 while (done)
>                 {
>                         if (abituguru_wait(data, ABIT_UGURU_STATUS_READ))
>                                 msleep(0);
>                         done=0;
>                 }
>                 if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
>                         ABIT_UGURU_DEBUG(1, "timeout exceeded waiting for
> "
>                                 "read state (bank: %d, sensor: %d)\n",
>                                 (int)bank_addr, (int)sensor_addr);
>                         break;
>                 }
>                 buf[i] = inb(data->addr + ABIT_UGURU_CMD);
>         }
>
> (declare done at the top)
>
> i.e. sleep for 1 jiffy if abituguru_wait() fails, at most once. It has no
> impact for boards which return from abituguru_wait in the desired state the
> first time. For some, it might mean longer delays.
>
> I don't want to put msleep(0) in abituguru_wait() because that function is
> used in many places.
>
> OR
>
> Just remove the message from the for loop ...:-) i.e.
>
>         /* And read the data */
>         for (i = 0; i < count; i++) {
>                 if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
>                    break;
>                 }
>                 buf[i] = inb(data->addr + ABIT_UGURU_CMD);
>         }
>
> Basically, I don't have an elegant solution to this problem...:-(
>
> -Sunil
>
>
> On 7/20/06, Hans de Goede < j.w.r.degoede at hhs.nl> wrote:
>
> >
> >
> > Sunil Kumar wrote:
> > > sent too soon. I wanted to mention that the frequency of messages has
> > > reduced by manyfolds after this patch.
> > >
> >
> > I've sightly reduced the ABIT_UGURU_READY_TIMEOUT because we are
> > sleeping now. You decreased it from 50 to 30, I went with 25. Can you
> > try the driver for a couple of days with this set back to 50 and then
> > see if it still happens?
> >
> > Thanks & Regards,
> >
> > Hans
> >
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060724/ff6a5d9b/attachment.html 
