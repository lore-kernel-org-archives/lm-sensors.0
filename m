From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Message-Id: <20050426001500.6a199399@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200504210207.02421.dtor_core@ameritech.net>
	<1114089504.29655.93.camel@uganda>
	<d120d50005042107314cbacdea@mail.gmail.com>
	<1114420131.8527.52.camel@uganda>
	<d120d50005042509326241a302@mail.gmail.com>
In-Reply-To: <d120d50005042509326241a302@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>

While thinking about locking schema
with respect to sysfs files I recalled,
why I implemented such a logic - 
now one can _always_ remove _any_ module
[corresponding object is removed from accessible
pathes and waits untill all exsting users are gone],
which is very good - I really like it in networking model,
while with whole device driver model
if we will read device's file very quickly
in several threads we may end up not unloading it at all.

So decision is simple from the first point of view -
just remove appropriate objects from accessible pathes
and free them from finall callbacks [device's remove method].

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
