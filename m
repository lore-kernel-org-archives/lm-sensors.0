From: ms@plain.de (Markus Schorer)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: irq, tasklet and i2c
Message-Id: <3E3F94BE.CD95B34A@plain.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi all,

once again i' having trouble getting things to work.
maybe someone here has more experience with at least one of these
issues.

i'm working on a driver for a radio/rd(b)s device. the rds 
(radio-data-system) chip is attached via i2c. it triggers an interrupt
when data has been decoded (~ every 20ms). the data will be read from 
the v4l device, the tuner is controlled by ioctls on that
same device. all of this does work (in a way).

i've tried several scenarios:

1) reading from the device, i wait in a wait queue.
an interrupt does a wakeup.
then the read process does a i2c_master_recv directly.
works.

2) i assign a buffer for a single piece of data. reading from the
device,
i wait in a wait queue.
an interrupt schedules a tasklet. the tasklet read the data over i2c, 
stores it in the buffer and does a wakeup.
then the read process reads the data out of the buffer.
works.

3) i assign a ringbuffer for the data. reading from the device, i do a
wait_event_interruptible on the ringbuffer. when passed, i
disable_tasklet,
read the data and enable_tasklet.
in the interrupt i schedule_tasklet. in the tasklet i do the buffer 
handling and try to i2c_master_recv. then i get a kernel panic (AIEE
...).
leaving out only the actual receive does work (although i get no data).

i don't see, where case 3 is significantly different from case 2.

where do i cause the kernel panic?

any ideas?

regards,


-- 
_ plain GmbH_______________________________________________________
  markus schorer              fon 089.540.149.0
  daiserstrasse 15 RGB        fax 089.540.149.44
  81371 m?nchen               http://www.plain.de
