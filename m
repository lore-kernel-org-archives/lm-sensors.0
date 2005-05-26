From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 26 May 2005 06:18:08 +0000
Subject: [lm-sensors] Re: [RFC PATCH 2.6.12-rc3-mm2 1/2] i2c: new sysfs
Message-Id: <2538186705052521176779c75d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050503034928.GC4977@jupiter.solarsys.private>
In-Reply-To: <20050503034928.GC4977@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > At first I assumed you would probably be using the device_attributes
> > under /sys/class/hwmon/blah/device/ (assuming the particular hwmon
> > driver has an associated device - its optional), but on further though
> 
> That is just it, nothing more.
> 
> We could use class device attributes, sure.  We could move all the
> existing device attributes, even.  It's not like the sensors kernel
> interface has been stable in 2.6.x since... well... ever.

lol..ok, you have a point. I'm thinking about things without regard to
the size/pain of the change, I let people with more sense think about
that and shoot me down ;-). Using class_device_attributes is
definitely something to keep in the back of our minds though.

> I suggested the current path (use hwmon class just for the link to
> device attributes) to Khali, rather than something more elaborate,
> mostly so that I could hope to actually complete it while leaving
> libsensors looking less ugly than it does now.  When libsensors has
> a more flexible and maintainable way of parsing sysfs structure (like
> using libsysfs, for one) then the rest may follow.

OK, fair enough. I'm a fair way along re-writing bmcsensors (probably
to be called ipmisensors now) to take advantage of the hwmon patch and
dynamic device attributes, and its all looking very promising and much
cleaner so far, so thanks for writing the patch. When it's at a stage
that it works I'll CC a copy to you guys and the list for comment. I
definitely think hwmon is the way forward, but I have a much different
perspective than most other lm_sensors authors due to the nature of
bmc/ipmisensors.

Oh, is there a userspace patch somewhere that I can use to test things
out when I get to that stage?

Thanks,
Yani
