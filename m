From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 15 Apr 2011 00:06:10 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Driver for MAX16065/MAX16066
Message-Id: <1302825970.26780.617.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302322322-3978-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1302322322-3978-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-04-12 at 05:03 -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Fri, 8 Apr 2011 21:12:02 -0700, Guenter Roeck wrote:
> > This patch adds hardware monitoring support for Maxim MAX16065, MAX16066,
> > MAX16067, MAX16068, MAX16070, and MAX16071 flash-configurable system managers
> > with nonvolatile fault registers.
> >
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > v3:
> > - Tested driver with MAX16067 and MAX16068.
> > - Number of ADC channels is no longer always a multiple of four. Thus, we have
> >   to round up the loop count limit when reading the ADC range (four range values
> >   per register).
> 
> I had noticed the problem during my first review, and refrained from
> reporting it, thinking "maybe it will never be a problem so why bother
> Guenter with it"...
> 
:)

> > v2:
> > - Added support for MAX16067, MAX16068, MAX16070, and MAX16071 (untested).
> > - Refer to Documentation/i2c/instantiating-devices for details about device
> >   instantiation.
> > - Define and use MAX16065_SCALE(x) instead of MAX16065_SCALE_BASE + x.
> > - Replace MAX16065_SECONDARY(x), MAX16065_CRIT(x), and MAX16065_LCRIT(x) with
> >   MAX16065_LIMIT(l, x).
> > - Removed unused / duplicate defines.
> > - Replaced function macros with inline functions.
> > - Replaced secondary[], lcrit[], and crit[] arrays in max16065_data with
> >   two-dimensional array limit[nLimit][nAdc].
> > - In max16065_read_adc(), use single 16-bit read instead of two 8-bit read
> >   operations to ensure that data is consistent.
> > - In max16065_update_device(), only read device registers if the device supports
> >   it. Specifically, use data->num_adc instead of MAX16065_NUM_ADC, and only read
> >   current sense information if supported and enabled.
> > - In max16065_show_alarm(), use to_i2c_client(dev) directly and drop 'client'
> >   variable.
> > - Use unlikely() for all error checks.
> > - Use single function to read and set all limits.
> > - When setting a limit, ensure that limit range is valid.
> > - In sensor groups, remove unnecessary ',' after NULL entries.
> > - Rearranged sensor groups to be more flexible regarding the number of supported
> >   sensors. Use sysfs_create_file() instead of sysfs_create_group() to create
> >   sysfs entries for groups supporting a variable number of sensors (voltages and
> >   voltage limits).
> >
> >  Documentation/hwmon/max16065 |  100 ++++++
> >  drivers/hwmon/Kconfig        |   16 +
> >  drivers/hwmon/Makefile       |    1 +
> >  drivers/hwmon/max16065.c     |  721 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 838 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/hwmon/max16065
> >  create mode 100644 drivers/hwmon/max16065.c
> 
> Overall it looks pretty good and you can add:
> 
> Reviewed-by: Jean Delvare <khali@linux-fr.org>
> 
> I found a few minor things you might want to check though:
> 
All fixed (see below). I'll resubmit the driver with added support for
MAX16047/MAX16049 for which I just received samples.

One question:

[ ... ]
> > +
> > +/* ADC registers have 10 bit resolution. */
> > +static inline int ADC_TO_MV(int adc, int range)
> > +{
> > +     return (adc * range) / 1024;
> > +}
> > +
> > +/*
> > + * Limit registers have 8 bit resolution and match upper 8 bits of ADC
> > + * registers.
> > + */
> > +static inline int LIMIT_TO_MV(int limit, int range)
> > +{
> > +     return DIV_ROUND_CLOSEST(limit * range, 256);
> > +}
> 
> It is inconsistent to use DIV_ROUND_CLOSEST() for displaying limits and
> not monitored values. This could cause values to look out-of-limits when
> they aren't, or vice-versa.
> 
Any thought on what is better ? Use DIV_ROUND_CLOSEST for both, or
none ? I tend to none, since the chip does not round either, but I am
not really sure.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
