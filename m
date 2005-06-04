From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Sat, 04 Jun 2005 00:07:26 +0000
Subject: [lm-sensors] [0/6] New w1 features.
Message-Id: <20050604020741.26c1ecd0@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 4 Jun 2005 01:58:36 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> On Fri, 3 Jun 2005 16:46:48 -0500
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On 6/3/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > 
> > > 6. I wrote reconnect feature: if on start there are no
> > > registered families all new devices will have defailt family,
> > > later when driver for appropriate family is loaded, slaves,
> > > which were faound earlier, will still have defult family instead
> > > of right one. Reconnect feature will force control thread to
> > > run through all master devices and all slaves found
> > > and search for slaves with default family id and try to reconnect
> > > them.
> > 
> > Yep, start with one kludge and you'll end up with 10 more.
> > 
> > Would you mind explaining why a w1 device has to be bound to a family
> > before it can show in sysfs? We don't have such limitation on other
> > buses, why is it needed for w1?
> 
> Because w1 device does not have any sence without appropriate family driver.
> You may have a device without a driver for it.
> All buses support it - see dmesg when new device was added but there is
> no driver for that - usb bus magically says slot is used.
> Here is the same.

And, btw, it is _very_ bad that other buses [not usb and not scsi at least]
do not have such reconnect feature. You can plug your device in, system
failed to detect it, and later, when you found a driver, you may not access
it from it's driver. It looks like you do not know how w1 works - there is
only one possibility to access w1 device - through appropriate bus master,
so bus muster either has to know about all devices found during the last 
search, which is currently implemented, or perform new search each time 
new device driver is added which is bogus.
Other buses support some notification about devices plugged to it, 
that is why you do not see some kind of reconnects there, w1 does not, 
so it has to reconnect.

> > -- 
> > Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
