From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 18 May 2011 15:39:30 +0000
Subject: [lm-sensors] [PATCH 0/2] staging:iio:adc:as1531 driver port from
Message-Id: <1305733172-18519-1-git-send-email-jic23@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DD26311.7070905@armadeus.com>
In-Reply-To: <4DD26311.7070905@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fabien.marteau@armadeus.com
Cc: guenter.roeck@ericsson.com, linux-iio@vger.kernel.org, lm-sensors@lm-sensors.org, Jonathan Cameron <jic23@cam.ac.uk>

Dear All,

This is a quick initial port of the as1531 driver Fabien submitted
to the lm-sensors mailing list.

Based on top of a large series I just sent to Greg KH and posted to
linux-iio. That has a few other dependencies, so might be easier
to just to wait for them all to be in a standard tree (linux-next
or mainline).

Dropped from hwmon driver - max and min values.

Stuff to add at some point (i.e. when needed)

1) Differential channels - trivial to do, just add a few more entries to
the channels array and some signed bits in read_raw

2) Buffered read support - straight forward case where all channels have
to be explicitly requested anyway.

3) Other devices trivially added:
as1530 is directly compatible.
as1532/1533 look like 4 channel equivalents (add iio_chan_spec arrays).

The other similarly numbered parts are different enough to need their
own drivers.

Fabien, as more of the code in the first patch is yours than mine,
I've put you as author of that one.

The second is mostly stuff you'd have gotten in review to the hwmon
driver anyway.


Fabien Marteau (1):
  staging:iio:adc: as1531 driver initial conversion from hwmon
    submission.

Jonathan Cameron (1):
  staging:iio:adc:as1351 general cleanup and conversion to standard
    functions.

 drivers/staging/iio/adc/Kconfig  |   10 ++
 drivers/staging/iio/adc/Makefile |    2 +
 drivers/staging/iio/adc/as1531.c |  168 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/adc/as1531.c

-- 
1.7.3.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
