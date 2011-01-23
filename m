From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 23 Jan 2011 09:04:43 +0000
Subject: Re: [lm-sensors] user question about how to load xeontemp
Message-Id: <20110123100443.04dc3093@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
In-Reply-To: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 22 Jan 2011 12:39:33 -0800, Guenter Roeck wrote:
> On Sat, Jan 22, 2011 at 02:04:21PM -0500, Jean Delvare wrote:
> [ ... ]
> > > 
> > > I don't know the status of ipmi integration and ipmi module names. There
> > > is the OpenIPMI project, and they have lots of patches to improve ipmi
> > > support. Jean may know better than me if/when/how those patches will be
> > > integrated into the mainline kernel.
> > 
> > The impisensor driver is abandoned for years. I won't look into it as I
> > have many other drivers to work on and I don't have supported hardware.
> > 
> > In the meantime, my recommendation is to use ipmitool. It is _not_
> > integrated with libsensors, but other than that, it should report the
> > sensor values properly.
> > 
> How about OpenIPMI ? Any plans to integrate that code into the mainline, 
> or is that pretty much a parallel effort ?
> 
> Just trying to get an idea where IPMI kernel support is going. Looks like IPMI
> is going to be used in a project here, so we may have to support it.

I have no idea, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
