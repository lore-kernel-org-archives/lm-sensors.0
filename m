From: devsku@gmail.com (Sunil Kumar)
Date: Thu, 27 Jul 2006 00:48:34 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607261748g4781e645kecd2eb79e0cc2aaf@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 7/26/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
> Hmm, how did you measure this? According to top gkrellm on my system
> never comes above the 0.7 percent, then again on my system the wait
> function usually returns pretty fast.


by simply staring at the gkrellm chart where it plots cpu usage and shows a
number in %age for it as well. The jump from 2% to 4% is easily noticeable,
particulalrly when it happens every 5 second on a quiet system, but I think
a more detailed analysis should probably be done.

My worries are because abituguru_wait gets called 148 times for one


So many reads actually make the case for  tight loop weaker and for sleeping
stronger, because the loop actually will run 250*148~7000 times per update
without doing anything useful apart from seeing if its ok to read. I am sure
lesser CPUs will see more %age being used every 5 seconds. May be we can
have someone with 1ghz cpu to monitor gkrellm with and without abituguru and
report.

update! So on a system running at 100 HZ, that could get translated to
> blocking the program trying to read a sensor for 1.5 seconds.


This is the unfortunate part. People with 100 hz will suffer terrible delay
if the read state is not reached fast. But we are talking about a monitoring
program, not some essential kernel component which can fail something
critical. For 1000hz it is only 150ms. Note that it is advised to run linux
2.6 with HZ 1000. May be we can make the determination of how early to go to
sleep based upon the value of HZ, by adjusting the difference between
TIMEOUT and TIMEOUT_SLEEP dynamically based on HZ. Please also realize that
with every 1 jiffy sleep, the chances of reaching the next sleep reduce
tremendously (unless uguru has died and not responding at all...:)) But I
have a feeling that sleep in steps of 1 jiffy is in order if loop times out
50 or so iterations.

Also, someone using 100 hz will never like a long tight loop in anything
periodic like sensors because the whole point of choosing hz 100 was to give
as much cpu to useful work as possible (like on a server). But, as I said,
its an unfortunate conflicting requirement.

How about this:

--- /tmp/abituguru.c    2006-07-26 11:16:32.000000000 -0700
+++ ./abituguru.c       2006-07-26 17:41:05.000000000 -0700
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
@@ -221,15 +222,17 @@
 static int abituguru_wait(struct abituguru_data *data, u8 state)
 {
        int timeout = ABIT_UGURU_WAIT_TIMEOUT;
+       int start_sleep = (HZ < 1000) ? ABIT_UGURU_WAIT_TIMEOUT_SLEEP / 2 :
ABIT_UGURU_WAIT_TIMEOUT_SLEEP;

        while (inb_p(data->addr + ABIT_UGURU_DATA) != state) {
                timeout--;
                if (timeout = 0)
                        return -EBUSY;
-               /* sleep a bit before our last try, to give the uGuru one
-                  last chance to respond. */
-               if (timeout = 1)
-                       msleep(1);
+               /* start sleeping a bit after
ABIT_UGURU_WAIT_TIMEOUT-start_sleep
+                * iterations to give the uGuru some chance to respond.
+                */
+               if (timeout <= start_sleep && timeout >= 1)
+                       msleep(0);
        }
        return 0;
 }

So, it will go 150 iterations before it starts sleeping on 100/250hz. Note
also that this patch has reduced READY timeout to 5 as well. Even with 5, I
haven't hit ready state timeout so far.

-Sunil
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060726/f9a3aa52/attachment.html 
