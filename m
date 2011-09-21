From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 21 Sep 2011 10:24:17 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: Add notification and uevent
Message-Id: <20110921102417.GA25662@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316541327-20377-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1316541327-20377-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 21, 2011 at 05:03:33AM -0400, Jonathan Cameron wrote:
> On 09/20/11 18:55, Guenter Roeck wrote:
> > Some hwmon drivers start adding support for alarm attribute notifications and
> > generate uevents. Standardize the ABI to be used for this purpose.
> > 
> Perhaps some guidance on when uevents make sense rather than notifications?
> Also, why would you do both?

uevents enable script handling. An application or script is started after a uevent
is generated to handle the event. Notifications are useful for running applications
which wait in poll or epoll for an event on a file descriptor.

Both are useful and reflect that application developers have different approaches
on how to handle events.

Thanks,
Guenter

> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > v2: Fixed typos.
> >     Added faults to attributes triggering notifications.
> >     Generate uevent on hwmon device kobject.
> > 
> >  Documentation/hwmon/sysfs-interface |   32 ++++++++++++++++++++++++++++++++
> >  1 files changed, 32 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> > index e65e7e8..35b09d6 100644
> > --- a/Documentation/hwmon/sysfs-interface
> > +++ b/Documentation/hwmon/sysfs-interface
> > @@ -97,6 +97,17 @@ update_interval	The interval at which the chip will update readings.
> >  		Some devices have a variable update rate or interval.
> >  		This attribute can be used to change it to the desired value.
> >  
> > +notification	This attribute exists if the driver supports notifications on
> > +		alarm, fault, and trigger attributes. Valid attribute values
> > +		are:
> > +		0: The driver does not support notifications or uevents.
> > +		1: The driver supports notifications.
> > +		2: The driver generates a uevent if an alarm, fault, or trigger
> > +		   status changes.
> > +		3: The driver suports notifications and generates a uevent if
> > +		   an alarm, fault, or trigger status changes.
> > +		RO
> > +
> >  
> >  ************
> >  * Voltages *
> > @@ -706,6 +717,27 @@ intrusion[0-*]_beep
> >  		RW
> >  
> >  
> > +Notifications and uevents
> > +-------------------------
> > +
> > +Hwmon drivers may support generating notification on sysfs alarm, fault, and
> > +trigger attributes. This support is reflected in the existence of the
> > +"notification" attribute described above.
> > +
> > +If a driver supports notifications, applications do not have to manually poll
> > +alarm, fault, and trigger attributes, but can use poll(2) or epoll(4) instead.
> > +
> > +If a driver supports notifications, it shall support it for all alarm and
> > +trigger attributes, and should support it for all fault attributes.
> > +Notifications shall be generated for all state transistions (0->1 as well as
> > +1->0).
> > +
> > +In addition to notifications, drivers may also support uevents. If so, a uevent
> > +shall be generated whenever an alarm or trigger attribute changes its state, and
> > +should be generated whenever a fault attribute changes its state. The uevent
> > +shall be generated on the driver's hwmon device kobject.
> > +
> > +
> >  sysfs attribute writes interpretation
> >  -------------------------------------
> >  
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
