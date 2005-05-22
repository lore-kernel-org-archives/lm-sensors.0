From: dtor_core@ameritech.net (Dmitry Torokhov)
Date: Sun, 22 May 2005 09:05:26 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <200505220204.52907.dtor_core@ameritech.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050519213551.GA806@kroah.com> <200505212058.14851.dtor_core@ameritech.net> <20050522085026.40e73d49.khali@linux-fr.org>
In-Reply-To: <20050522085026.40e73d49.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>

On Sunday 22 May 2005 01:50, Jean Delvare wrote:
> Hi Dmitry,
> 
> > I really think that as far as I2C subsystem goes instead of creating
> > arrays of attributes we should move in direction of drivers
> > registering individual sensor class devices. So for example it87 would
> > register 3 fans, 3 temp, sensors and 8 voltage sensors...
> 
> First, it's a matter of hardware monitoring drivers, not i2c subsystem
> (both are tightly binded at the moment but I'd like this to change).
>

Right, it's just i2c is pretty much the only supplier of these for now.
 
> Second, not all devices have the same attributes for a temperature, fan
> or voltage channel. Sure there are commonly found feature sets, but some
> channels will lack some feature (e.g. it87's in8 has no min and max
> limits), other chips will provide additional features (extra limits or
> enhanced configurability). So I don't think you can have all devices
> (and thus all drivers) fit into a single sensor class.
>

Well, userspace code manages it somehow, plus nothing stops driver from
adding some additional attributes to class devices.
 
> But of course I can be convinced your approach is better, with patches.

Heh, I was afraid you'd say so... Input sysfs conversion first and then
we'll see...

-- 
Dmitry
