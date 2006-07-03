From: dtor@insightbb.com (Dmitry Torokhov)
Date: Mon, 03 Jul 2006 13:16:36 +0000
Subject: [lm-sensors] [RFC] Apple Motion Sensor driver
Message-Id: <200607030916.37896.dtor@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060702222649.GA13411@hansmi.ch> <1151923799.19419.49.camel@localhost.localdomain> <1151926278.10711.25.camel@localhost.localdomain>
In-Reply-To: <1151926278.10711.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stelian Pop <stelian@popies.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch, johannes@sipsolutions.net, chainsaw@gentoo.org

On Monday 03 July 2006 07:31, Stelian Pop wrote:
> Le lundi 03 juillet 2006 ? 20:49 +1000, Benjamin Herrenschmidt a ?crit :
> > On Mon, 2006-07-03 at 12:45 +0200, Michael Hanselmann wrote:
> > > On Mon, Jul 03, 2006 at 12:12:47PM +0200, Stelian Pop wrote:
> > > > > +
> > > > > +static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR,
> > > > > +	ams_mouse_show_mouse, ams_mouse_store_mouse);
> > > 
> > > > I would prefer three different files for x, y and z instead of a single
> > > > one... 
> > > 
> > > Because of the way the values are calculated with orientation, that
> > > would mean that if a program needs all three, either all values are read
> > > three times or the ams_sensors function gets much more complicated.
> > > 
> > > To prevent it from having to read them three times in a row, I joined
> > > all three values.
> > > 
> > > Do you think I should rewrite the ams_sensors function to only get the
> > > correct value?
> > 
> > Cache the values and only re-read from the hardware after a given amount
> > of time has elapsed ?
> 
> Seems to be a good idea indeed.
>

But what is the purpose of that attribute anyway? I'd just drop it completely. 

-- 
Dmitry

