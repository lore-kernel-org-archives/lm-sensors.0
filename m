From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Sun, 22 May 2005 14:17:07 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <25381867050522051524ea93ec@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050519213551.GA806@kroah.com>
	 <200505212058.14851.dtor_core@ameritech.net>
	 <20050522085026.40e73d49.khali@linux-fr.org>
	 <200505220204.52907.dtor_core@ameritech.net>
In-Reply-To: <200505220204.52907.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On 5/22/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Sunday 22 May 2005 01:50, Jean Delvare wrote:
> > Hi Dmitry,
> >
> > > I really think that as far as I2C subsystem goes instead of creating
> > > arrays of attributes we should move in direction of drivers
> > > registering individual sensor class devices. So for example it87 would
> > > register 3 fans, 3 temp, sensors and 8 voltage sensors...

Well lets see some code ;-), but yeah I have to agree with Jean here,
I don't see a nice way to standardize this across all hwmon drivers,
things just differ too much.

> > First, it's a matter of hardware monitoring drivers, not i2c subsystem
> > (both are tightly binded at the moment but I'd like this to change).

How is that change going anyway? I could really do with something
finalized, but the last I heard about it was Mark Hoffman's patch and
that didn't seem to go anywhere.

Yani
