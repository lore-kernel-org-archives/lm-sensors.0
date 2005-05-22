From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 22 May 2005 15:39:56 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <20050522153945.04690929.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050519213551.GA806@kroah.com>
	<200505212058.14851.dtor_core@ameritech.net>
	<20050522085026.40e73d49.khali@linux-fr.org>
	<200505220204.52907.dtor_core@ameritech.net>
	<25381867050522051524ea93ec@mail.gmail.com>
	<20050522143244.3648427a.khali@linux-fr.org>
	<25381867050522060561a288c@mail.gmail.com>
In-Reply-To: <25381867050522060561a288c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Yani,

> And i2c-ipmi remember? :) Does that mean Mark's class is finalized and
> I can work with it? Or is there some more work to be done on that
> front too? If so I can probably help out.

I can't tell, I didn't even give his code a try :( If you have some
spare time, try applying the proposed patches, see how they work for you
and how you could use the new class in bmcsensors.

However, as I understand it, the hwmon class will be added to the
drivers, it isn't meant to replace anything. This will simply let us
search for hwmon stuff by class rather than assuming that all hwmon
drivers are devices on i2c busses, so it's more like a helper for
user-space tools. I don't think it solves the hwmon-is-not-i2c issue on
the kernel side at all.

-- 
Jean Delvare
