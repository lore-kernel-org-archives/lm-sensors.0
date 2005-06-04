From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Sat, 04 Jun 2005 00:37:52 +0000
Subject: [lm-sensors] [0/6] New w1 features.
Message-Id: <20050604023807.5d7addf6@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 3 Jun 2005 17:18:25 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On 6/3/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > On Sat, 4 Jun 2005 01:58:36 +0400
> > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > 
> > > On Fri, 3 Jun 2005 16:46:48 -0500
> > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > >
> > > > On 6/3/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > >
> > > > > 6. I wrote reconnect feature: if on start there are no
> > > > > registered families all new devices will have defailt family,
> > > > > later when driver for appropriate family is loaded, slaves,
> > > > > which were faound earlier, will still have defult family instead
> > > > > of right one. Reconnect feature will force control thread to
> > > > > run through all master devices and all slaves found
> > > > > and search for slaves with default family id and try to reconnect
> > > > > them.
> > > >
> > > > Yep, start with one kludge and you'll end up with 10 more.
> > > >
> > > > Would you mind explaining why a w1 device has to be bound to a family
> > > > before it can show in sysfs? We don't have such limitation on other
> > > > buses, why is it needed for w1?
> > >
> > > Because w1 device does not have any sence without appropriate family driver.
> > > You may have a device without a driver for it.
> > > All buses support it - see dmesg when new device was added but there is
> > > no driver for that - usb bus magically says slot is used.
> > > Here is the same.
> > 
> > And, btw, it is _very_ bad that other buses [not usb and not scsi at least]
> > do not have such reconnect feature. You can plug your device in, system
> > failed to detect it, and later, when you found a driver, you may not access
> > it from it's driver.
> 
> Oh, really? For some reason when I plug my USB enclosure into the port
> it even loads all necessary drivers. So somehow it manages to
> recognize device without having a driver for it and then, after
> loading proper driver, "reconnects".

:) because USB controller will catch interrupt about new device attached.
And in it's control interface new message will be put.
I repeat: w1 can not inform about new devices plugged to it, 
so we need either to poll the bus or store found devices with default "driver".

> Btw, that's what my modalias patch was doing for w1 as well.

yep. I liked your hotplug if you remember.
But you broke too many other things.

> > It looks like you do not know how w1 works - there is
> > only one possibility to access w1 device - through appropriate bus master,
> > so bus muster either has to know about all devices found during the last
> > search, which is currently implemented, or perform new search each time
> > new device driver is added which is bogus.
> > Other buses support some notification about devices plugged to it,
> > that is why you do not see some kind of reconnects there, w1 does not,
> > so it has to reconnect.
> 
> If you don't bind to a driver to begin with you don't have to reconnect, do you?

And what to do with that device when there is no driver for it.
Forget about it? This is wrong. Wait for driver and rescan the bus when it is added?
This is wrong.
Do not compare w1 with USB/scsi/PCI any other "advanced" buses, this is completely
different things, so they just can not be compared.

Dmitry, I see this discussion goes wrong way again...
Let's continue it from technical point:
you want different w1 design - like USB for example,
but it is completely wrong with w1 since 
[quite previous e-mail] we can perform the search only
one time, and load a driver far after it. This is a feature, 
which you want to remove [again], which allows such behaviour,
without it you just drop the device and just can not recall
later about it without full rescan.[/quote].

> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
