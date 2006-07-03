From: linux-kernel@hansmi.ch (Michael Hanselmann)
Date: Mon, 03 Jul 2006 10:45:47 +0000
Subject: [lm-sensors] [RFC] Apple Motion Sensor driver
Message-Id: <20060703104547.GA25342@hansmi.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060702222649.GA13411@hansmi.ch> <1151921567.10711.22.camel@localhost.localdomain>
In-Reply-To: <1151921567.10711.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stelian Pop <stelian@popies.net>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch, benh@kernel.crashing.org, johannes@sipsolutions.net, chainsaw@gentoo.org

On Mon, Jul 03, 2006 at 12:12:47PM +0200, Stelian Pop wrote:
> > +
> > +static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR,
> > +	ams_mouse_show_mouse, ams_mouse_store_mouse);

> I would prefer three different files for x, y and z instead of a single
> one... 

Because of the way the values are calculated with orientation, that
would mean that if a program needs all three, either all values are read
three times or the ams_sensors function gets much more complicated.

To prevent it from having to read them three times in a row, I joined
all three values.

Do you think I should rewrite the ams_sensors function to only get the
correct value?

Thanks,
Michael

(All other issues, including those in the other mails, are clear and
will be addressed by a new patch)

