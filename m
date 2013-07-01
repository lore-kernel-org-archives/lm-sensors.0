From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 01 Jul 2013 16:57:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Atom CPUs don't support TjMax; no warning needed
Message-Id: <20130701165758.GA3376@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372695389-691-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1372695389-691-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 01, 2013 at 04:22:46PM +0000, R, Durgadoss wrote:
> Hi Guenter,
> 
> > -----Original Message-----
> > From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
> > sensors.org] On Behalf Of Guenter Roeck
> > Sent: Monday, July 01, 2013 9:46 PM
> > To: lm-sensors
> > Cc: Yu, Fenghua
> > Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Atom CPUs don't support
> > TjMax; no warning needed
> > 
> > Display warning "Unable to read TjMax from CPU x" only if the CPU
> > is supposed to support it. This is not the case for the various Atom CPUs.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/coretemp.c |   14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > index ade35cf..be58da1 100644
> > --- a/drivers/hwmon/coretemp.c
> > +++ b/drivers/hwmon/coretemp.c
> > @@ -317,6 +317,18 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c,
> > u32 id,
> >  	return tjmax;
> >  }
> > 
> > +static bool cpu_has_tjmax(struct cpuinfo_x86 *c)
> > +{
> > +	u8 model = c->x86_model;
> > +
> > +	return model > 0xe &&
> > +	       model != 0x1c &&
> > +	       model != 0x26 &&
> > +	       model != 0x27 &&
> > +	       model != 0x35 &&
> > +	       model != 0x36;
> > +}
> 
> Thanks for the patch.
> Please add model ids: 0x4a and 0x37.
> 
Hi Durga,

are those for the new Atom CPUs (S1220/S1240/S1260/S1269/S1279/S1289) ?

I am still trying to figure out how to identify those CPUs to add TjMax
information. All I could find in the manual was to use the PCI root bridge ID
for S1220/S1240/S1260; the datasheets for the others are not published yet.

This means we might have to go back to using the PCI ID to identify some
of the chips. On the upside, pci_get_bus_and_slot() can now be called even
if PCI is disabled, the method is more efficient, and we could use the same
mechanism to detect the CE41x0 CPUs, so that might not be too bad.

If you have any additional information which you can share (means to detect
the CPUs, and Tjmax for the S1269/S1279/S1289), please let me know.

Thanks,
Guenter

> Thanks,
> Durga
> 
> > +
> >  static int __cpuinit get_tjmax(struct cpuinfo_x86 *c, u32 id,
> >  			       struct device *dev)
> >  {
> > @@ -330,7 +342,7 @@ static int __cpuinit get_tjmax(struct cpuinfo_x86 *c, u32
> > id,
> >  	 */
> >  	err = rdmsr_safe_on_cpu(id, MSR_IA32_TEMPERATURE_TARGET, &eax,
> > &edx);
> >  	if (err) {
> > -		if (c->x86_model > 0xe && c->x86_model != 0x1c)
> > +		if (cpu_has_tjmax(c))
> >  			dev_warn(dev, "Unable to read TjMax from CPU %u\n",
> > id);
> >  	} else {
> >  		val = (eax >> 16) & 0xff;
> > --
> > 1.7.9.7
> > 
> > 
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
