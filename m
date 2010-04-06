From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Apr 2010 08:39:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1031) Increase update rate
Message-Id: <20100406103900.4a2de870@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100330225628.GE20635@ovro.caltech.edu>
In-Reply-To: <20100330225628.GE20635@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 5 Apr 2010 10:51:32 -0700, Ira W. Snyder wrote:
> On Mon, Apr 05, 2010 at 09:46:54AM +0200, Jean Delvare wrote:
> > Hi Ira,
> > 
> > On Tue, 30 Mar 2010 15:56:28 -0700, Ira W. Snyder wrote:
> > > The adm1031 chip is capable of an 8 Hz update rate, configurable at runtime
> > > with the fan filter register. Increase the update rate to get faster
> > > temperature readings.
> > > 
> > > Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> > > ---
> > > 
> > > This may be a bit controversial. The ADM1031 chip may use more power at a
> > > higher update rate. In my (embedded) application, this doesn't matter. The
> > > faster update rate is more important.
> > 
> > If you use the automatic fan speed control capabilities, then indeed a
> > faster update rate can be benefical. But as you suspected, it is
> > somewhat controversial, due to the higher power consumption possibly
> > for no good reason. Also, the BIOS/firmware might have already
> > configured the chip and traditionally the hwmon drivers preserve these
> > settings as much as possible.
> > 
> 
> Yep, that makes perfect sense.
> 
> > > Does anyone have thoughts on this? It is easy enough for me to carry
> > > myself, but I'd much rather have it upstream.
> > 
> > I wouldn't want it upstream as is. However I can think of two
> > alternative implementations which I would be happy with:
> > 
> > 1* Let the adm1031 driver accept platform data, and the update rate be
> > part of that platform data. Then you can instantiate your device
> > explicitly and pass the desired update rate.
> > 
> > 2* Expose the update frequency through sysfs, and make it writable.
> > After all, so many monitoring devices have a configurable update rate
> > that it would make sense to have a standard attribute for it. If you go
> > that route, we have to standardize on it first, and add it to
> > Documentation/hwmon/sysfs-interface. Then implement it in the adm1031
> > driver and possibly other drivers.
> > 
> > Note that both options aren't mutually exclusive, although one of them
> > should be enough to satisfy your need.
> > 
> 
> I like the idea of a sysfs node. Does "update_rate" (in milliseconds)
> sound ok, or do you have another name you'd prefer?

Sounds good, no objection.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
