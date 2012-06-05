From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Jun 2012 16:29:22 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <1338913762.478.232.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338827851-702-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1338827851-702-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-06-05 at 04:02 -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Mon,  4 Jun 2012 09:37:31 -0700, Guenter Roeck wrote:
> > Atom CPUs don't have a register to retrieve TjMax. Detection so far is
> > incomplete. Use the X86 model ID to improve it.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Wonder if we can improve TjMax detection for Atom CPUs with this code.
> > Anyone with Atom CPUs out there for some testing ?
> 
> Not here, sorry.
> 
> >  drivers/hwmon/coretemp.c |   44 ++++++++++++++++++++++++++++++++------------
> >  1 files changed, 32 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > index b9d5123..9689a0d 100644
> > --- a/drivers/hwmon/coretemp.c
> > +++ b/drivers/hwmon/coretemp.c
> > @@ -191,6 +191,29 @@ static ssize_t show_temp(struct device *dev,
> >  	return tdata->valid ? sprintf(buf, "%d\n", tdata->temp) : -EAGAIN;
> >  }
> >  
> > +struct tjmax {
> > +    	char const *id;
> > +	int tjmax;
> > +};
> > +
> > +static struct tjmax atom_tjmax[] = {
> > +	{ "CPU D410", 100000 },
> > +	{ "CPU D425", 100000 },
> > +	{ "CPU D510", 100000 },
> > +	{ "CPU D525", 100000 },
> > +	{ "CPU N450", 100000 },
> > +	{ "CPU N455", 100000 },
> > +	{ "CPU N470", 100000 },
> > +	{ "CPU N475", 100000 },
> > +	{ "CPU 230", 100000 },
> > +	{ "CPU 330", 125000 },
> 
> I suspect this won't work, there seems to be a double space between
> "CPU" and the number. See:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-May/028544.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2012-June/036236.html
> 
> Oh, this is fixed in v2, ignore.
> 
> > +	{ "CPU E620T", 110000 },
> > +	{ "CPU E640T", 110000 },
> > +	{ "CPU E660T", 110000 },
> > +	{ "CPU E680T", 110000 },
> 
> This probably won't work either, as for an unknown reason Intel did not
> encode the model number for at least some of these Atom CPUs:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2011-June/033010.html
> This is even the reason why we did not use the processor name strings
> back then.
> 
Ah, now I remember. That explains why I didn't find any online logs with
those IDs. Would be great to find PCI bridge ID we could use instead ...

> > +	{ },
> > +};
> > +
> >  static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
> >  				  struct device *dev)
> >  {
> > @@ -201,7 +224,6 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
> >  	int usemsr_ee = 1;
> >  	int err;
> >  	u32 eax, edx;
> > -	struct pci_dev *host_bridge;
> >  
> >  	/* Early chips have no MSR for TjMax */
> >  
> > @@ -211,18 +233,16 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
> >  	/* Atom CPUs */
> >  
> >  	if (c->x86_model = 0x1c) {
> > -		usemsr_ee = 0;
> > +		struct tjmax *tj;
> >  
> > -		host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> > -
> > -		if (host_bridge && host_bridge->vendor = PCI_VENDOR_ID_INTEL
> > -		    && (host_bridge->device = 0xa000	/* NM10 based nettop */
> > -		    || host_bridge->device = 0xa010))	/* NM10 based netbook */
> > -			tjmax = 100000;
> > -		else
> > -			tjmax = 90000;
> > -
> > -		pci_dev_put(host_bridge);
> 
> You are dropping a known-to-work heuristic for one which hasn't been
> tested on these models. Don't get me wrong, I'd be very happy to get
> rid of this code, I just don't want us to introduce a regression.
> 
Good point. I'll keep it.

> > +		usemsr_ee = 0;
> > +		tjmax = 90000;
> > +		for (tj = atom_tjmax; tj->tjmax; tj++) {
> 
> Any reason for not using a regular array and ARRAY_SIZE?
> 
No.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
