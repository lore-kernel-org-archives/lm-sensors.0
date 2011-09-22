From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Thu, 22 Sep 2011 03:43:20 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: Add notification and uevent
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109ED014580@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316541327-20377-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1316541327-20377-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

This patch looks fine for me.
Please add:
Reviewed-by: R Durgadoss <durgadoss.r@intel.com>

> > > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > > ---
> > > v2: Fixed typos.
> > >     Added faults to attributes triggering notifications.
> > >     Generate uevent on hwmon device kobject.
> > >
> > >  Documentation/hwmon/sysfs-interface |   32
> ++++++++++++++++++++++++++++++++
> > >  1 files changed, 32 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/Documentation/hwmon/sysfs-interface
> b/Documentation/hwmon/sysfs-interface
> > > index e65e7e8..35b09d6 100644
> > > --- a/Documentation/hwmon/sysfs-interface
> > > +++ b/Documentation/hwmon/sysfs-interface
> > > @@ -97,6 +97,17 @@ update_interval	The interval at which the chip will
> update readings.
> > >  		Some devices have a variable update rate or interval.
> > >  		This attribute can be used to change it to the desired value.
> > >
> > > +notification	This attribute exists if the driver supports notifications on
> > > +		alarm, fault, and trigger attributes. Valid attribute values
> > > +		are:
> > > +		0: The driver does not support notifications or uevents.
> > > +		1: The driver supports notifications.
> > > +		2: The driver generates a uevent if an alarm, fault, or trigger
> > > +		   status changes.
> > > +		3: The driver suports notifications and generates a uevent if
> > > +		   an alarm, fault, or trigger status changes.
> > > +		RO
> > > +
> > >
> > >  ************
> > >  * Voltages *
> > > @@ -706,6 +717,27 @@ intrusion[0-*]_beep
> > >  		RW
> > >
> > >
> > > +Notifications and uevents
> > > +-------------------------
> > > +
> > > +Hwmon drivers may support generating notification on sysfs alarm, fault,
> and
> > > +trigger attributes. This support is reflected in the existence of the
> > > +"notification" attribute described above.
> > > +
> > > +If a driver supports notifications, applications do not have to manually
> poll
> > > +alarm, fault, and trigger attributes, but can use poll(2) or epoll(4)
> instead.
> > > +
> > > +If a driver supports notifications, it shall support it for all alarm and
> > > +trigger attributes, and should support it for all fault attributes.
> > > +Notifications shall be generated for all state transistions (0->1 as well
> as
> > > +1->0).
> > > +
> > > +In addition to notifications, drivers may also support uevents. If so, a
> uevent
> > > +shall be generated whenever an alarm or trigger attribute changes its
> state, and
> > > +should be generated whenever a fault attribute changes its state. The
> uevent
> > > +shall be generated on the driver's hwmon device kobject.
> > > +
> > > +
> > >  sysfs attribute writes interpretation
> > >  -------------------------------------
> > >
> >

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
