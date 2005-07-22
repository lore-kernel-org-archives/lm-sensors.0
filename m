From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 22 Jul 2005 20:12:09 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.13-rc3 0/3] hwmon: hwmon sysfs class
Message-Id: <20050722201143.4569d0b7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716013537.GA4265@jupiter.solarsys.private>
In-Reply-To: <20050716013537.GA4265@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,

> Actually I'm here at the Ottawa Linux Symposium with him :-), he is a
> bit busy though as usual so I haven't asked him. You should be here!
> :) There are no lm_sensors people here which is a shame because its so
> nice to put a face to a name, and to talk in person for a change.

I'm sorry, I would have come but had to give up due to the overall
price. Next year maybe. I'm more likely to go to European meetings, I
went to Sucon in 2004 and Guadec this year.

> Basically though with hdaps we have two
> temperature sensors temp0, temp1, two acceleration sensors (x_accel,
> y_accel - maybe standardize to accel_0, accel_1?)

I would say accel0 and accel1 if we stick to the current scheme.

> There is also a keyboard/mouse activity sensor (km_activity).

Doesn't sound like something we want to export to hwmon, right? What is
the intended use?

> > I think I can imagine whan an acceleration sensor is about. Not too
> > sure what "variations" would be though. What unit are these
> > variations expressed in? Sensors are typically about measuring a
> > current state rather than expressing variations between states.
> 
> I'm guessing that they are jerk (change in acceleration, or m/s^3),
> but I'm not sure. I wouldn't normally expect such a thing to be
> implemented by the chip, but instead monitored by a driver.

Question is, what would be the use of such sysfs files? Sensor files are
intended for periodic polling. This makes sense for supposedly continous
measurements like voltages or temperatures. I don't quite see how
polling for acceleration values would be useful, let alone jerk.

A driver for such a device would be more useful if it could send events
which would then be converted into actions such as "hdparm -Y". If you
go polling for accelerations, it'll certainly be too late by the time
you get the information.

> I'm going to try to fix my thinkpad now :-),

Good luck.

-- 
Jean Delvare
