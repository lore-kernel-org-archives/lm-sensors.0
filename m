From: stefanr@s5r6.in-berlin.de (Stefan Richter)
Date: Mon, 03 Jul 2006 13:25:14 +0000
Subject: [lm-sensors] [RFC] Apple Motion Sensor driver
Message-Id: <44A91ABA.8060304@s5r6.in-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060702222649.GA13411@hansmi.ch> <1151921567.10711.22.camel@localhost.localdomain> <20060703104547.GA25342@hansmi.ch>
In-Reply-To: <20060703104547.GA25342@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch, benh@kernel.crashing.org, johannes@sipsolutions.net, chainsaw@gentoo.org

Michael Hanselmann wrote:
> On Mon, Jul 03, 2006 at 12:12:47PM +0200, Stelian Pop wrote:
>> > +
>> > +static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR,
>> > +	ams_mouse_show_mouse, ams_mouse_store_mouse);

[I think the following discussion is about ams_show_xyz, not
ams_mouse_show_mouse.]

>> I would prefer three different files for x, y and z instead of a single
>> one... 
> 
> Because of the way the values are calculated with orientation, that
> would mean that if a program needs all three, either all values are read
> three times or the ams_sensors function gets much more complicated.
> 
> To prevent it from having to read them three times in a row, I joined
> all three values.

I don't know what a software will be doing with it, but "displacement"
(and its time derivatives "velocity", "acceleration", "jerk") is a
vector. Why not write the component-wise representation of the vector
into a single sysfs attribute? Especially if this keeps the kernel code
simple and small. I suppose even userspace code which evaluates the
attribute is in many cases simpler (and more precise anyway) if only a
single attribute is used.
-- 
Stefan Richter
-===-=-=- -=- ==--
http://arcgraph.de/sr/

