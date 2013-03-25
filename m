From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 25 Mar 2013 15:33:51 +0000
Subject: Re: [lm-sensors] [PATCH v5 4/5] ab8500: power: export abx500_res_to_temp tables for hwmon
Message-Id: <20130325153351.GB6509@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1364201328-20881-5-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1364201328-20881-5-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rejected earlier as spam by some servers, resending before giving up.

On Mon, Mar 25, 2013 at 06:26:40AM -0700, Guenter Roeck wrote:
> On Mon, Mar 25, 2013 at 04:48:47PM +0800, Hongbo Zhang wrote:
> > This patch exports the thermistor resistance-to-temperature tables, so that the
> > hwmon driver can access them, and also adds the corresponding table size
> > variables.
> > 
> > Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> > ---
> >  drivers/power/ab8500_bmdata.c | 16 ++++++++++------
> >  include/linux/power/ab8500.h  | 16 ++++++++++++++++
> >  2 files changed, 26 insertions(+), 6 deletions(-)
> >  create mode 100644 include/linux/power/ab8500.h
> > 
> > diff --git a/drivers/power/ab8500_bmdata.c b/drivers/power/ab8500_bmdata.c
> > index 9c25ca8..d9f1f25 100644
> > --- a/drivers/power/ab8500_bmdata.c
> > +++ b/drivers/power/ab8500_bmdata.c
> > @@ -11,7 +11,7 @@
> >   * Note that the res_to_temp table must be strictly sorted by falling resistance
> >   * values to work.
> >   */
> > -static const struct abx500_res_to_temp temp_tbl_a_thermistor[] = {
> > +const struct abx500_res_to_temp ab8500_temp_tbl_a_thermistor[] = {
> >  	{-5, 53407},
> >  	{ 0, 48594},
> >  	{ 5, 43804},
> 
> It probably doesn't matter since the driver is always built into the kernel when
> present, but I think it would make sense to provide EXPORT_SYMBOL_GPL for the
> exported symbols.
> 
> Thanks,
> Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
