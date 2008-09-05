From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Sep 2008 08:44:30 +0000
Subject: Re: [lm-sensors] Single Sensor Check
Message-Id: <20080905104430.259c32f3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <06d401c8ff06$1103d690$330b83b0$@com>
In-Reply-To: <06d401c8ff06$1103d690$330b83b0$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ken,

On Tue, 2 Sep 2008 17:31:53 -0400, sensored@CubicC.com wrote:
> Thanks, Matt -- I appreciate the time you took to respond.  I *do* have
> control over the motherboard, so I went looking for documentation on the
> chipset & sensors, but there was nothing offered other than basic "How to
> configure the BIOS" information.  Do you have any suggestions of what,
> specifically, I could ask the manufacturer for (if they'll even oblige me).
> 
> I dug deeper into the lm-sensors code, and determined that lm-sensors is
> parsing a file in /sys/devices/platform/i2c-9191/9191-0290/ (and responding
> accordingly).  Can you help me understand how this file got created there,
> and how it is updated (I assume the data needs to be updated in close to
> real-time)?

You must be using a relatively old kernel to have such a device name...

Anyway, the files in question are created by whatever hardware
monitoring driver your system is using. To find out which it is, look
at the "driver" link in this directory.

The data in these files are updated only when you read from them, and
are cached for a short period of time (1 to 2 seconds, depends on the
driver) to prevent a given user from causing too much I/O traffic to
the monitoring chip.

To answer your question more generically: you can ask libsensors for a
specific input value, however the sensors command-line tool doesn't
offer any interface for this so you would have to either add it or
write your own little program interfacing with libsensors. The
alternative is to read from /sys directly, as you already found out,
but then you lose the labelling and scaling facilities of libsensors.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
