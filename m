From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Fri, 03 Jun 2005 23:58:28 +0000
Subject: [lm-sensors] [0/6] New w1 features.
Message-Id: <20050604015836.77d8ed94@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050604013008.05d3bc87@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 3 Jun 2005 16:46:48 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On 6/3/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > 
> > 6. I wrote reconnect feature: if on start there are no
> > registered families all new devices will have defailt family,
> > later when driver for appropriate family is loaded, slaves,
> > which were faound earlier, will still have defult family instead
> > of right one. Reconnect feature will force control thread to
> > run through all master devices and all slaves found
> > and search for slaves with default family id and try to reconnect
> > them.
> 
> Yep, start with one kludge and you'll end up with 10 more.
> 
> Would you mind explaining why a w1 device has to be bound to a family
> before it can show in sysfs? We don't have such limitation on other
> buses, why is it needed for w1?

Because w1 device does not have any sence without appropriate family driver.
You may have a device without a driver for it.
All buses support it - see dmesg when new device was added but there is
no driver for that - usb bus magically says slot is used.
Here is the same.

> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
