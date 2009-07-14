From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 14 Jul 2009 16:57:44 +0000
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire
Message-Id: <4A5CB908.4060404@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>
In-Reply-To: <528f13590907140925h7aa36452o60da32d3bf941241-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

alfred steele wrote:
> Hi,
> I was looking at  the implementation of the i2 dev interface and the
> bitbanging interface supplied by kernel v 2.6.24.  What i intend to do
> is use the i2c kernel subsystem to write a userspace driver(using the
> dev - ioctl interface) for a sensor SHT11 which uses a two wire
> interface and a protocol with a packet structure which is different
> from traditional I2C.
Worth noting at this point that there is already a driver for this chip
in mainline (sht15 under hwmon - I've copied this to the lm-sensors where
that driver has previously been discussed).
I can't recall exactly when it was merged, but it's not there in 2.6.29
and is in 2.6.30.


> 
>>From the header files and the API's therein, it looks like the
> bitbanging interface should allow any  protocol header to be passed
> as a "payload"(void *data) to the linux kernel i2c bitbanging driver
> using gpio api.  Please let me know if this is a correct approach if
> we intend to write a sensore driver with a proprietary 2 wire
> interface protocol.
> 
> This would allow us to write  a user-space driver which is more
> generic for the sensor and that can be changed to a I2C driver if the
> GPIOs are later or tied in hardware to a  dedicated I2C controller. We
> are using the mx31 pdk
 
First thing to note is that this device is in no way using an i2c type
comms protocol. I'd be somewhat surprised if any i2c controllers are
generic enough to talk to it.  The start condition is non standard,
it uses a 3 bit address (with only 000) supported, and it also has a
fairly hideous means of indicating that the sampling process
has finished.  Basically you'd have more luck using the gpio's directly
than through anything to do with i2c.

---
Jonathan Cameron

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
