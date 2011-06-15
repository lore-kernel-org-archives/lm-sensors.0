From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 15 Jun 2011 14:28:25 +0000
Subject: Re: [lm-sensors] [PATCH v9] drivers/hwmon NTC Thermistor Initial
Message-Id: <20110615142825.GA12683@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1308122532-9483-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1308122532-9483-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 15, 2011 at 04:52:03AM -0400, Shubhrajyoti Datta wrote:
> Hi ,
> Not a comment really was a bit curious.
> Feel free to ignore such comments.
> 
> On Wed, Jun 15, 2011 at 12:52 PM, Donggeun Kim <dg77.kim@samsung.com> wrote:
> 
>     This patch adds support for NTC Thermistor series. In this release, the
>     following thermistors are supported: NCP15WB473, NCP18WB473, NCP03WB473,
>     and NCP15WL333. This driver is based on the datasheet of MURATA.
> 
>     The driver in the patch does conversion from the raw ADC value
>     (either voltage or resistence) to temperature. In order to use
>     voltage values as input, the circuit schematics should be provided
>     with the platform data. A compensation table for each type of thermistor
>     is provided for the conversion.
> 
>     Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
>     Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>     Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>
> 
>     --
>     Updates
>     v9
>     - remove unnecessary variables(mintemp, maxtemp) and checking lines for
>     them
>     v8
>     - remove compiler warning message
>     - update Documentation/hwmon/ntc_thermistor
>     - add EXPERIMENTAL Kconfig dependency
>     v7
>     - move header file location
>     - rename header and driver file
>     - style fixes
>     v6
>     - updated Documentation/hwmon/ntc
>     - style fixes
>     v5
>     - use binary search on sorted table
>     - removed unnecessary attributes
>     - style fixes
>     v4
>     - put in alphabetic order in Kconfig/Makefile
>     - handle additional error cases
>     - remove the exported function
>     v3
>     - style fixes
>     - removed symbol exports
>     - avoid divide-by-zero
>     - omitted files added (Kconfig/Makefile)
>     - removed unnecessary codes
>     - return error values, not default values for errors.
>     v2
>     - added Documentation/hwmon/ntc
>     - followed hwmon sysfs
>     - detached the monitoring service
>     (thank you for the comments, Guenter Roeck)
>     ---
>      Documentation/hwmon/ntc_thermistor           |   93 ++++++
>      drivers/hwmon/Kconfig                        |   14 +
>      drivers/hwmon/Makefile                       |    1 +
>      drivers/hwmon/ntc_thermistor.c               |  453
>     ++++++++++++++++++++++++++
>      include/linux/platform_data/ntc_thermistor.h |   53 +++
>      5 files changed, 614 insertions(+), 0 deletions(-)
>      create mode 100644 Documentation/hwmon/ntc_thermistor
>      create mode 100644 drivers/hwmon/ntc_thermistor.c
>      create mode 100644 include/linux/platform_data/ntc_thermistor.h
> 
> 
> 
> <snip>
> Why have a function starting with a  _ 
> 
> 
> 
> 
> 
>     +static int _ntc_thermistor_read(struct ntc_data *data, int *temp)
>     +{
>     +       int ret;
>     +       int read_ohm, read_uV;
>     +       unsigned int ohm = 0;
>     +
>     +       if (data->pdata->read_ohm) {
>     +               read_ohm = data->pdata->read_ohm();
> 
> 
> Is the platform function posted?

What do you mean with "posted" ? It would be defined in the instantiating
platform code.

> What errors could these functions return ?

We neither know nor care. The point is that if an error is returned,
it is passed on.

> Should we mask the errors here?
>  
Definitely not. There is no knowledge about the internals of the function.
If there is an error, just pass it on to the caller.

> 
>     +               if (read_ohm < 0)
>     +                       return -EINVAL;

Actually it should be 
				return read_ohm;

We don't want to replace error codes. Sorry I didn't notice this before.


>     +               ohm = (unsigned int)read_ohm;
>     +       }
>     +
>     +       if (data->pdata->read_uV) {
>     +               read_uV = data->pdata->read_uV();
> 
> same here
> 
>     +               if (read_uV < 0)
>     +                       return -EINVAL;

Same here - return read_uV.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
