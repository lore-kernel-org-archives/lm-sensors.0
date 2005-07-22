From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Fri, 22 Jul 2005 22:37:20 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.13-rc3 0/3] hwmon: hwmon sysfs class
Message-Id: <2538186705072213361966a8c2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716013537.GA4265@jupiter.solarsys.private>
In-Reply-To: <20050716013537.GA4265@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > :) There are no lm_sensors people here which is a shame because its so
> > nice to put a face to a name, and to talk in person for a change.
> 
> I'm sorry, I would have come but had to give up due to the overall
> price. Next year maybe. I'm more likely to go to European meetings, I
> went to Sucon in 2004 and Guadec this year.

I live in Toronto, so I have no excuse :) but yes, its expensive
especially from Europe, although there are a surprising number of
people here from outside North America. Actually I think Mark might be
here - I'm not sure though.

> > There is also a keyboard/mouse activity sensor (km_activity).
> 
> Doesn't sound like something we want to export to hwmon, right? What is
> the intended use?

I think the basic premise is there won't be much keyboard/mouse
activity if the thinkpad is in free fall ;-). If the userspace driver
is implemented on top of the hwmon interface it might be needed...
 
> Question is, what would be the use of such sysfs files? Sensor files are
> intended for periodic polling. This makes sense for supposedly continous
> measurements like voltages or temperatures. I don't quite see how
> polling for acceleration values would be useful, let alone jerk.
> 
> A driver for such a device would be more useful if it could send events
> which would then be converted into actions such as "hdparm -Y". If you
> go polling for accelerations, it'll certainly be too late by the time
> you get the information.

From what I understand the hdaps people (talking to one of them here)
plan to implement the actual hard drive monitor in userspace and seem
to think the userspace associated delays would not be prohibitive. At
the moment the driver uses a strange (IMHO) device interface and
identifies itself as a misc platform device, however I think that if
it were go into the mainstream kernel a sysfs/hwmon interface, and
identifying it as a sensor driver would be much more suitable. Since
there are potentially other similair drivers out there its even more
imperative.

Yani
