From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Sun, 22 May 2005 15:05:40 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <25381867050522060561a288c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050519213551.GA806@kroah.com>
	 <200505212058.14851.dtor_core@ameritech.net>
	 <20050522085026.40e73d49.khali@linux-fr.org>
	 <200505220204.52907.dtor_core@ameritech.net>
	 <25381867050522051524ea93ec@mail.gmail.com>
	 <20050522143244.3648427a.khali@linux-fr.org>
In-Reply-To: <20050522143244.3648427a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Dmitry Torokhov <dtor_core@ameritech.net>

> Anyway there's a long long way to go before there is a true separation
> between i2c and hwmon. Mark introduced a hwmon class, which is needed
> but not sufficient. The biggest part of the work will be to move all
> drivers abusing the i2c subsystem to the subsystem where they really
> belong (isa/platform or superio), and get rid of i2c-isa. 

And i2c-ipmi remember? :) Does that mean Mark's class is finalized and
I can work with it? Or is there some more work to be done on that
front too? If so I can probably help out.

Yani
