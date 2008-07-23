From: Ben Dooks <ben-linux@fluff.org>
Date: Wed, 23 Jul 2008 19:33:34 +0000
Subject: Re: [lm-sensors] [spi-devel-general] [Patch 0/4] IndustrialIO
Message-Id: <20080723193334.GD26938@trinity.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com>
In-Reply-To: <488763AD.4050400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, spi-devel-general@lists.sourceforge.net, LM Sensors <lm-sensors@lm-sensors.org>, mgross@linux.intel.com, Dmitry Torokhov <dtor@mail.ru>, David Brownell <david-b@pacbell.net>, hmh@hmh.eng.br, Jean Delvare <khali@linux-fr.org>, Ben Nizette <bn@niasdigital.com>

On Wed, Jul 23, 2008 at 06:00:29PM +0100, Jonathan Cameron wrote:
> Dear All,
> 
> The need for an industrialio subsystem was discussed in
> http://lkml.org/lkml/2008/5/20/135
> 
> Firstly thanks to all the people who have contributed to the discussion
> of this in the past.
> 
> In brief the intention is provide a kernel subsystem directed towards the
> handling on sensors (and later related output devices) such as ADC's,
> accelerometers and many others.

Thinking about this, basically we have an event buffer and management
system that could live in  drivers/event. It manages the event sources
and buffering, including tagging the data and buffering it ready for
consumption.

One thing I'd like to see is that the reading application should be
able to choose to have events aggregated or not, so that if a few
events turn up very fast it can choose to take them as one single
item.
 
> Key features of the subsystem include:
> 
> * Provision of sysfs access for direct reading from devices (similar to hwmon
>   but without the buffering / update rate restrictions)

Having an update rate and buffering is possibly useful, given that if you
have say a number of ADC inputs but only one converter, then it is possible
that there will be some form of resource starvation.
 
> * Provision of chrdevs through which events may be passed to userspace in a
>   similar fashion to the input subsystem.  These events may be anything from
>   hardware thresholds set on the sensor itself to sw / hw ring buffer event
>   notifications (50% full etc).
> 
> * Provision of access via chrdevs to hardware ring buffers on devices that
>   provide them.
> 
> * Software ring buffer support to allow semi regular capture of data form the
>   device.  Typically this will be driven from either datardy events, or from
>   a periodic timer interrupt (to this end a very simple wrapper for periodic
>   RTC's is included. This will move to more generic timer interfaces as and when
>   they become available.  For now available rtc's must be registered with the
>   subsystem via the industrialio_register_ptimer function form within a board
>   init.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
