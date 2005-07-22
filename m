From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Fri, 22 Jul 2005 16:52:49 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.13-rc3 0/3] hwmon: hwmon sysfs class
Message-Id: <25381867050722075118e116b4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716013537.GA4265@jupiter.solarsys.private>
In-Reply-To: <20050716013537.GA4265@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 7/22/05, Jean Delvare <khali@linux-fr.org> wrote:
> It was accepted by me, for what it's worth. I'd expect Greg KH to ack
> it when he gets around, but he is currently busy with the various Linux
> summer summits.

Actually I'm here at the Ottawa Linux Symposium with him :-), he is a
bit busy though as usual so I haven't asked him. You should be here!
:) There are no lm_sensors people here which is a shame because its so
nice to put a face to a name, and to talk in person for a change.

> 
> > Aside from ipmisensors (which is blocked on other
> > work anyway) I'm looking into adding a sysfs/hwmon interface to the
> > new hdaps driver (see http://hdaps.sourceforge.net/), any opinions?
> 
> The site lacks documentation. Care to explain to us what exactly the
> project does, and why you do think it is related with hardware
> monitoring? Any precise example of what sysfs files would be created?

HDAPS is a driver for the Thinkpad 'Active Protection System' which
uses a gyroscope chip (I will have to dig up again exactly which one)
to detect falls and try to protect the hard drive by parking the head
before it hits the ground. From what I understand the Powerbook uses
the same chip on the i2c bus instead of ISA.

Actually I created a patch to add sysfs support...but I trashed that
notebook last night messing with an experimental kernel, and on top of
that the CD drive isn't working, so I don't know if I'll be able to
recover that work :(. Basically though with hdaps we have two
temperature sensors temp0, temp1, two acceleration sensors (x_accel,
y_accel - maybe standardize to accel_0, accel_1?) and two 'variations'
x_variation, y_variation which I think techinically are jerk - change
in acceleration. There is also a keyboard/mouse activity sensor
(km_activity).

> I think I can imagine whan an acceleration sensor is about. Not too sure
> what "variations" would be though. What unit are these variations
> expressed in? Sensors are typically about measuring a current state
> rather than expressing variations between states.

I'm guessing that they are jerk (change in acceleration, or m/s^3),
but I'm not sure. I wouldn't normally expect such a thing to be
implemented by the chip, but instead monitored by a driver.

I'm going to try to fix my thinkpad now :-),

Yani
