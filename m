From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Message-Id: <20050425233210.0517300b@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200504210207.02421.dtor_core@ameritech.net>
	<1114089504.29655.93.camel@uganda>
	<d120d5000504210909f0e0713@mail.gmail.com>
	<1114420290.8527.56.camel@uganda>
	<d120d50005042509366e5a0895@mail.gmail.com>
In-Reply-To: <d120d50005042509366e5a0895@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>

On Mon, 25 Apr 2005 11:36:05 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > On Thu, 2005-04-21 at 11:09 -0500, Dmitry Torokhov wrote:
> > > One more thing...
> > >
> > > On 4/21/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > On Thu, 2005-04-21 at 02:07 -0500, Dmitry Torokhov wrote:
> > > >
> > > > > w1-master-drop-attrs.patch
> > > > >    Get rid of unneeded master device attributes:
> > > > >    - 'pointer' and 'attempts' are meaningless for userspace;
> > > > >    - information provided by 'slaves' and 'slave_count' can be gathered
> > > > >      from other sysfs bits;
> > > > >    - w1_slave_found has to be rearranged now that slave_count field is gone.
> > > >
> > > > attempts is usefull for broken lines.
> > >
> > > It simply increments with every search i.e. every 10 secondsby default
> > > and does not provide indication of the quality of the wire.
> > 
> > When slaves can not be found until several attempts, it means line
> > is broken, how many time existing slave appeared/dissapeared during
> > /sys/bus/w1/devices/w1_master1/attempts says about link quality.
> 
> Heh, if you are debugging all you need is "date" command to see how
> quickly slave appears. If you want to keep statistics your program
> need to listen to hotpug events for master and slaves and count these.
> I do not see a reason for a counter that simply increments every 10
> seconds.

It is not counter but attempt does matter, one of course can simply
calculate attempt number using timeout value, but that requires 
timeout knowledge, which is not accessible after driver is loaded.

> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
