From: devsku@gmail.com (Sunil Kumar)
Date: Thu, 20 Jul 2006 05:23:04 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607192223o3de8550eka9d24fe1773b12a2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok, this patch seems to have made the messages go away for good (even with
suspend/resume cycle). Because this patch helps fix it, I suspect that its a
race between setting the ready state and doing a read because the while loop
executes really fast and the hardware is not really that fast to respond
when you expect it in ABIT_UGURU_STATUS_READ state in the abituguru_read
call.

$ diff -u abituguru.c.timeouts abituguru.c
--- abituguru.c.timeouts        2006-07-19 15:46:02.000000000 -0700
+++ abituguru.c 2006-07-19 21:03:39.000000000 -0700
@@ -30,6 +30,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <asm/io.h>
+#include <linux/delay.h>

 /* Banks */
 #define ABIT_UGURU_ALARM_BANK                  0x20 /* 1x 3 bytes */
@@ -74,7 +75,7 @@
 /* Normally all expected status in abituguru_ready, are reported after the
    first read, but sometimes not and we need to poll, 5 polls was not
enough
    50 sofar is. */
-#define ABIT_UGURU_READY_TIMEOUT               50
+#define ABIT_UGURU_READY_TIMEOUT               30
 /* Maximum 3 retries on timedout reads/writes, delay 200 ms before retrying
*/
 #define ABIT_UGURU_MAX_RETRIES                 3
 #define ABIT_UGURU_RETRY_DELAY                 (HZ/5)
@@ -251,6 +252,7 @@
        /* Cmd port MUST be read now and should contain 0xAC */
        while (inb_p(data->addr + ABIT_UGURU_CMD) != 0xAC) {
                timeout--;
+               msleep(1);
                if (timeout = 0) {
                        ABIT_UGURU_DEBUG(1,
                           "CMD reg does not hold 0xAC after ready
command\n");
@@ -263,6 +265,7 @@
        timeout = ABIT_UGURU_READY_TIMEOUT;
        while (inb_p(data->addr + ABIT_UGURU_DATA) !ABIT_UGURU_STATUS_INPUT) {
                timeout--;
+               msleep(1);
                if (timeout = 0) {
                        ABIT_UGURU_DEBUG(1,
                                "state != more input after ready
command\n");

Please see if its ok and include it in next release. You can ignore the
ABIT_UGURU_READY_TIMEOUT change if you want. I decreased it because I am
sleeping for 1 millisecond everytime in the loop and even lower numbers may
be enough. The original while loops were much much faster on my machine
(3800+ X2) than 30ms...:)

-Sunil

On 7/19/06, Sunil Kumar <devsku at gmail.com> wrote:
>
> ok, doubling both the timeouts you mentioned doesn't help. It doesn't help
> because its not a wait in that while loop. Instead, its a tight loop which
> now runs 500 iterations instead of 250 before and most of todays processors
> will complete it in few micro seconds. I think we need a genuine sleep wait
> there, don't we? what is the kernel routine to sleep for a few msecs?
>
> -Sunil
>
>
> On 7/19/06, Sunil Kumar <devsku at gmail.com> wrote:
> >
> > one thing I noticed is that now the occurrence of these messages has
> > increased a lot. They are just crowding my /var/log/messages like nothing
> > else. I am not sure what to do next.
> >
> >
> >
> > On 7/19/06, Sunil Kumar <devsku at gmail.com> wrote:
> > >
> > > leaving it loaded during suspend doesn't help with the messages, they
> > > still popup. Do you think I should try and adjust the timeouts that you had
> > > mentioned once?
> > >
> > >
> > > On 7/18/06, Hans de Goede < j.w.r.degoede at hhs.nl > wrote:
> > > >
> > > >
> > > >
> > > > Sunil Kumar wrote:
> > > > > I used the file you provided with the 1.1.8 sources that I had
> > > > from the
> > > > > tar and I still get the same problem after resume from suspend:
> > > > >
> > > > > abituguru: timeout exceeded waiting for read state (bank: 33,
> > > > sensor: 8)
> > > > > abituguru: timeout exceeded waiting for ready state
> > > > > abituguru: timeout exceeded waiting for ready state
> > > > > abituguru: timeout exceeded waiting for ready state
> > > > > abituguru: timeout exceeded waiting for read state (bank: 34,
> > > > sensor: 15)
> > > > > abituguru: timeout exceeded waiting for ready state
> > > > >
> > > > > bank:34 and bank: 33 messages are separated by half hour, while
> > > > > consecutive messages separate by few seconds, if that helps...:)
> > > > >
> > > > > Also, note that I rmmod the module before I suspend and modprobe
> > > > it
> > > > > after I resume. With your code in place for suspend/resume, is
> > > > that
> > > > > still required? I want a safe suspend/resume, so I rmmod as many
> > > > modules
> > > > > I can before suspend.
> > > > >
> > > >
> > > > That no longer should be nescesarry and might even be the cause of
> > > > your
> > > > problems, could you try just leaving it in the kernel during
> > > > suspend?
> > > >
> > > > > I am not sure if the messages are a problem but you are a better
> > > > judge
> > > > > than me on that one.
> > > > >
> > > >
> > > > They are harmless, but it would be nice to fix them never the less.
> > > >
> > > > Regards,
> > > >
> > > > Hans
> > > >
> > > >
> > >
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060719/09bf3a4e/attachment-0001.html 
