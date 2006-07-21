From: devsku@gmail.com (Sunil Kumar)
Date: Fri, 21 Jul 2006 16:15:56 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <ce9ef0d90607210915h70b5ec1bk57accd794e7a7629@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Few things I noted:

1. HZ%0 means that msleep(1) sleeps for  8 ms because msleep does
schedule_timeout for msecs_to_jiffies(m) + 1, and hence sleeps for 2
jiffies. That's longer than I desired. Only way out would be make HZ00
because I can't sleep finer than 4ms with HZ%0. So, msleep(0) which sleeps
for one jiffy, may be adequate.

2. The problem that comes after applying the patch is from this part of the
code in routine abituguru_read():

        /* And read the data */
        for (i = 0; i < count; i++) {
                if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
                        ABIT_UGURU_DEBUG(1, "timeout exceeded waiting for "
                                "read state (bank: %d, sensor: %d)\n",
                                (int)bank_addr, (int)sensor_addr);
                        break;
                }
                buf[i] = inb(data->addr + ABIT_UGURU_CMD);
        }

I just printed value of i and found that it fails for i=1 i.e. it read fine
for i=0, which means that consecutive reads don't have enough wait in
between. This is not solvable in any way apart from doing a msleep(0) for
every read, which may be as large as 10ms for people with HZ0, and as
small as 1ms (which is probably ok) for HZ00.

Is it possible to change this loop to something like:

        /* And read the data */
        for (i = 0; i < count; i++) {
                done=1;
                while (done)
                {
                        if (abituguru_wait(data, ABIT_UGURU_STATUS_READ))
                                msleep(0);
                        done=0;
                }
                if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
                        ABIT_UGURU_DEBUG(1, "timeout exceeded waiting for "
                                "read state (bank: %d, sensor: %d)\n",
                                (int)bank_addr, (int)sensor_addr);
                        break;
                }
                buf[i] = inb(data->addr + ABIT_UGURU_CMD);
        }

(declare done at the top)

i.e. sleep for 1 jiffy if abituguru_wait() fails, at most once. It has no
impact for boards which return from abituguru_wait in the desired state the
first time. For some, it might mean longer delays.

I don't want to put msleep(0) in abituguru_wait() because that function is
used in many places.

OR

Just remove the message from the for loop ...:-) i.e.

        /* And read the data */
        for (i = 0; i < count; i++) {
                if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
                   break;
                }
                buf[i] = inb(data->addr + ABIT_UGURU_CMD);
        }

Basically, I don't have an elegant solution to this problem...:-(

-Sunil


On 7/20/06, Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
>
>
>
> Sunil Kumar wrote:
> > sent too soon. I wanted to mention that the frequency of messages has
> > reduced by manyfolds after this patch.
> >
>
> I've sightly reduced the ABIT_UGURU_READY_TIMEOUT because we are
> sleeping now. You decreased it from 50 to 30, I went with 25. Can you
> try the driver for a couple of days with this set back to 50 and then
> see if it still happens?
>
> Thanks & Regards,
>
> Hans
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060721/ae22e0d6/attachment.html 
