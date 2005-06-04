From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 04 Jun 2005 00:12:47 +0000
Subject: [lm-sensors] [0/6] New w1 features.
Message-Id: <d120d500050603151238686ef0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/3/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
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
> 

You still have not answered the question - why a family (i.e. a
driver) is needed? I have bunch of PCI devices in my box that don't
have drivers and they show up in sysfs just fine. The same with other
buses.

As it stands now you decided that you won't show devices without a
driver - then you realized that a "default" driver is needed - then
you realized that you need to reconnect when you load a "specialized"
driver. That's why I am saying start with one kludge and you'll end up
with 10 more.

-- 
Dmitry
