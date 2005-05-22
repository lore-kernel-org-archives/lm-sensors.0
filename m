From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 22 May 2005 14:33:02 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <20050522143244.3648427a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050519213551.GA806@kroah.com>
	<200505212058.14851.dtor_core@ameritech.net>
	<20050522085026.40e73d49.khali@linux-fr.org>
	<200505220204.52907.dtor_core@ameritech.net>
	<25381867050522051524ea93ec@mail.gmail.com>
In-Reply-To: <25381867050522051524ea93ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Dmitry Torokhov <dtor_core@ameritech.net>

Hi Yani,

> > > First, it's a matter of hardware monitoring drivers, not i2c
> > > subsystem (both are tightly binded at the moment but I'd like this
> > > to change).
> 
> How is that change going anyway? I could really do with something
> finalized, but the last I heard about it was Mark Hoffman's patch and
> that didn't seem to go anywhere.

My bad, I didn't take the time to review Mark's work yet :(

Anyway there's a long long way to go before there is a true separation
between i2c and hwmon. Mark introduced a hwmon class, which is needed
but not sufficient. The biggest part of the work will be to move all
drivers abusing the i2c subsystem to the subsystem where they really
belong (isa/platform or superio), and get rid of i2c-isa. The hybrid
drivers (w83781d, it87 and lm78) promise to be no fun to convert. We'll
split them if that's what it takes.

-- 
Jean Delvare
