From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Message-Id: <d120d500050425132250916bcb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200504210207.02421.dtor_core@ameritech.net>
	 <1114089504.29655.93.camel@uganda>
	 <d120d50005042107314cbacdea@mail.gmail.com>
	 <1114420131.8527.52.camel@uganda>
	 <d120d50005042509326241a302@mail.gmail.com>
	 <20050426001500.6a199399@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050426001500.6a199399@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: johnpol@2ka.mipt.ru
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>

On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> While thinking about locking schema
> with respect to sysfs files I recalled,
> why I implemented such a logic -
> now one can _always_ remove _any_ module
> [corresponding object is removed from accessible
> pathes and waits untill all exsting users are gone],
> which is very good - I really like it in networking model,
> while with whole device driver model
> if we will read device's file very quickly
> in several threads we may end up not unloading it at all.

I am sorrry, that is complete bull*. sysfs also allows removing
modules at an arbitrary time (and usually without annoying "waiting
for refcount" at that)... You just seem to not understand how driver
code works, thus the need of inventing your own schema.

BTW, I am looking at the connector code ATM and I am just amazed at
all wied refounting stuff that is going on there. what a single
actomic_dec_and_test() call without checkng reurn vaue is supposed to
do again?

-- 
Dmitry
