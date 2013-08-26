From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 26 Aug 2013 22:48:43 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (acpi_power_meter) Fix incorrect placement of __initdata
Message-Id: <20130826224843.GA3027@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 26, 2013 at 10:47:34PM +0200, Jean Delvare wrote:
> Hi Sachin,
> 
> On Wed,  7 Aug 2013 15:17:13 +0530, Sachin Kamat wrote:
> > __initdata should be placed between the variable name and equal
> > sign for the variable to be placed in the intended section.
> 
> Really? With gcc 4.7.2 of openSUSE 12.3/x86-64, I see no difference
> with and without this change. pm_dmi_table is in section .init.data in
> both cases. So when/where/how does it actually matter?
> 
> I see that there are hundreds of other occurrences of this in the
> kernel tree, so I admit I have a hard time believing it is actually
> wrong, and I would appreciate extra explanations.
> 

There is this:

http://permalink.gmane.org/gmane.linux.ports.arm.kernel/258149

Maybe target and/or compiler version specific ?

Guenter

> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > Cc: Darrick J. Wong <djwong@us.ibm.com>
> > ---
> >  drivers/hwmon/acpi_power_meter.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> > index 6351aba..d7d9b2f 100644
> > --- a/drivers/hwmon/acpi_power_meter.c
> > +++ b/drivers/hwmon/acpi_power_meter.c
> > @@ -970,7 +970,7 @@ static int __init enable_cap_knobs(const struct dmi_system_id *d)
> >  	return 0;
> >  }
> >  
> > -static struct dmi_system_id __initdata pm_dmi_table[] = {
> > +static struct dmi_system_id pm_dmi_table[] __initdata = {
> >  	{
> >  		enable_cap_knobs, "IBM Active Energy Manager",
> >  		{
> 
> -- 
> Jean Delvare
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
