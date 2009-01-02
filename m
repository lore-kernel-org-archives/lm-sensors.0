From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Fri, 02 Jan 2009 14:15:34 +0000
Subject: [lm-sensors] SHT15 humidity sensor. Hwmon right place to put a
Message-Id: <495E2186.7080609@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear All,

I'm in the process of cleaning up a driver for the Sensiron SHT15 humidity and
temperature sensor chip.

http://www.sensirion.com/en/01_humidity_sensors/00_humidity_sensors.htm

Before I proceed too far with this I have a couple of general requests for
comment.

Is hwmon a sensible place for this driver?

Whilst it could conceivably be used for hardware monitoring that isn't my
use for it.  I think it is more appropriate here than in the upcoming
industrial I/O subsystem principally because I can't envision a use where
the humidity is changing rapidly enough to require the more complex kernel
ring buffering etc provided there.

The other delightful quirk of this device is that it's bus protocol doesn't
conform to anything remotely standard and hence will be implemented by directly
controlling gpios.

Are people happy with such a low level driver in hwmon?

I think he protocol is very much chip specific so not worth a more general
implementation.  All sensiron's other sensors appear to use more standard
protocols.

If there are any similar gpio based drivers please point them out to me
as an example of accepted practice would save both mine and reviewers time!

Thanks,

--
Jonathan Cameron



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
