From: Onkalo Samu <samu.p.onkalo@nokia.com>
Date: Tue, 02 Feb 2010 12:17:59 +0000
Subject: Re: [lm-sensors] API extensions (for IIO,
Message-Id: <1265113079.4166.41.camel@4fid08082>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B65CC6C.7070605@cam.ac.uk>
In-Reply-To: <4B65CC6C.7070605@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2010-02-02 at 12:13 +0100, ext Jonathan Cameron wrote:
> On 02/02/10 09:01, samu.p.onkalo@nokia.com wrote:
> >> -----Original Message-----
> >> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
> >> sensors.org] On Behalf Of ext Jonathan Cameron
> >> Sent: 31 January, 2010 20:31
> >> To: LM Sensors; Greg KH; Manuel Stahl; Torokhov; Hennerich, Michael;
> >> Jean Delvare
> >> Subject: [lm-sensors] API extensions (for IIO, matching hwmon as closely
> >> as possible)
> >>
> >> Dear All,
> >>
> >> We recently proposed an API specification for parts of the Industrial
> >> I/O
> >> subsystem in a thread on LKML.  Greg KH pointed out that a we ought to,
> >> where
> >> sensible keep as close as possible to API's of existing subsystems.  To
> >> that
> >> end we are working on an updated version of the original document.
> >> (original at http://lkml.org/lkml/2010/1/20/195, please note it has
> >> changed
> >> a lot in response to comments made in that thread!)
> > 
> > Hi
> > 
> > Based on the discussion in lkml, it seems that I'm working on "toy" side of the
> > sensors. I agree that we need to have standard interface for different kind
> > of sensors. It has been quite hard to decide what kind of interface is the correct one
> > for different sensors (accelerometers, magnetometers, ambient light sensors,
> > proximity sensors etc). When sensors are used for some kind of user interface control
> > (device orientation, lightning, movement, games, amusement applications),
> > historical or buffered data is not so important. Data is aging quite rapidly.
> Agreed, here as you say the requirements are quite different.  Just as an aside,
> in the case of lighting there is the new ALS framework (in linux-next right now)
> that basically provides an equivalent of hwmon for ambient light sensors.  There
> are quite a few drivers on there way into that from the various places they are
> currently scattered through the kernel (tsl2550, tsl2563, isl20003 and a new acpi-als
> driver).  These things tend to be fairly slow, so we decided IIO was massive overkill!

Hmm, something similar would make sense for proximity sensors also. 

> > In battery powered devices, it is essential to turn off sensor HW whenever possible.
> > Does the proposed interface offer possibility to turn off the sensors when they
> > are not used?
> At the moment a couple of the drivers support this (or at least patches
> with it in have been kicking around), but to a certain extent I'm not
> convinced this is really the job of the core framework.  The driver 
> (and for that matter the bus driver) are much better placed to understand
> when they can go to sleep.  I guess the only exception to this would be if
> one had a slow triggered ring buffer capture off some sort of periodic hardware
> interrupt (perhaps another devices datardy signal).  Here you might want a heads
> up from the triggering device to tell your driver to wake up the sensor prior to
> the trigger actually occurring.  In simpler cases, say where you are using an
> on SoC periodic timer to do the job, if the wakeup takes a fixed time, then maybe
> we can make life easier for userspace by exporting this time and hence allowing it
> to adjust the timing trigger appropriately?
> 
> I'm personally very keen to see more drivers for these sort of devices handle
> power saving well, particularly with respect to interacting with the bus drivers
> etc to power down whole chunks of a board.
> 
> Perhaps if you illustrate what support you would particularly like to see and
> how it should function, you may persuade us that it should be in the IIO core
> rather than the drivers themselves?

It is probably more driver issue to handle chip operating state. For
portable devices, there probably is somekind of device state control 
(like charging, device in some level of standby state (example UI locked
but still listening to network)) which knows when some part of the HW
services are not used. It might be that actual users of the sensor data
are not controlling the state. Device drivers should provide interface
for turning HW off (sensors, regulators feeding the sensor, possible
clocks) in that case. 

I think that sysfs based interface doesn't offer possibility to turn off
the HW when no-one is accessing the interface.

-Samu



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
