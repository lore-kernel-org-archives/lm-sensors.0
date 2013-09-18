From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 18 Sep 2013 15:17:46 +0000
Subject: Re: [lm-sensors] [PATCH 06/16] hwmon: tmp102: expose to thermal fw via DT nodes
Message-Id: <20130918151746.GA17065@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1379282563-14650-1-git-send-email-eduardo.valentin@ti.com>
 <1379282563-14650-7-git-send-email-eduardo.valentin@ti.com>
 <523643D4.30208@roeck-us.net>
 <5238D7D9.9010203@ti.com>
 <20130918111849.GA9148@roeck-us.net>
 <5239B8B5.6050702@ti.com>
In-Reply-To: <5239B8B5.6050702-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On Wed, Sep 18, 2013 at 10:29:09AM -0400, Eduardo Valentin wrote:
> On 18-09-2013 07:18, Guenter Roeck wrote:
> > On Tue, Sep 17, 2013 at 06:29:45PM -0400, Eduardo Valentin wrote:
> >> On 15-09-2013 19:33, Guenter Roeck wrote:
> >>> On 09/15/2013 03:02 PM, Eduardo Valentin wrote:
> >>>> This patch adds to tmp102 temperature sensor the possibility to
> >>>> expose itself as thermal zone device, registered on the thermal
> >>>> framework.
> >>>> 
> >>>> The thermal zone is built only if a device tree node describing
> >>>> a thermal zone for this sensor is present inside the tmp102 DT
> >>>> node. Otherwise, the driver behavior will be the same.
> >>>> 
> >>>> Cc: Jean Delvare <khali@linux-fr.org> Cc: Guenter Roeck
> >>>> <linux@roeck-us.net> Cc: lm-sensors@lm-sensors.org Cc:
> >>>> linux-kernel@vger.kernel.org Signed-off-by: Eduardo Valentin
> >>>> <eduardo.valentin@ti.com> --- drivers/hwmon/tmp102.c | 28
> >>>> ++++++++++++++++++++++++++++ 1 file changed, 28 insertions(+)
> >>>> 
> >>>> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c 
> >>>> index d7b47ab..e432444 100644 --- a/drivers/hwmon/tmp102.c +++
> >>>> b/drivers/hwmon/tmp102.c @@ -27,6 +27,8 @@ #include
> >>>> <linux/mutex.h> #include <linux/device.h> #include
> >>>> <linux/jiffies.h> +#include <linux/thermal.h> +#include
> >>>> <linux/of.h>
> >>>> 
> >>>> #define    DRIVER_NAME "tmp102"
> >>>> 
> >>>> @@ -50,6 +52,7 @@
> >>>> 
> >>>> struct tmp102 { struct device *hwmon_dev; +    struct
> >>>> thermal_zone_device *tz; struct mutex lock; u16 config_orig; 
> >>>> unsigned long last_update; @@ -93,6 +96,19 @@ static struct
> >>>> tmp102 *tmp102_update_device(struct i2c_client *client) return
> >>>> tmp102; }
> >>>> 
> >>>> +static int tmp102_read_temp(void *dev, long *temp) +{ +
> >>>> struct tmp102 *tmp102 > >>>> tmp102_update_device(to_i2c_client(dev)); + +    if
> >>>> (tmp102->temp[0] < 0) +        dev_warn(tmp102->hwmon_dev, +
> >>>> "operating in negative temp: %d\n", tmp102->temp[0]); +
> >>> 
> >>> Please drop this warning.
> >>> 
> >> 
> >> Done for both drivers.
> >> 
> >>> Guenter
> >>> 
> >>>> +    *temp = tmp102->temp[0]; + +    return 0; +} + static
> >>>> ssize_t tmp102_show_temp(struct device *dev, struct
> >>>> device_attribute *attr, char *buf) @@ -204,6 +220,16 @@ static
> >>>> int tmp102_probe(struct i2c_client *client, goto
> >>>> fail_remove_sysfs; }
> >>>> 
> >>>> +    tmp102->tz = thermal_zone_of_sensor_register(&client->dev,
> >>>> 0, +                             &client->dev, +
> >>>> tmp102_read_temp, NULL); +    if (IS_ERR(tmp102->tz)) { +
> >>>> dev_warn(&client->dev, +             "Could not parse thermal
> >>>> data in device tree: %ld\n", +
> >>>> PTR_ERR(tmp102->tz));
> >>> 
> >>> Please drop this warning. You already create error messages in 
> >>> thermal_zone_of_sensor_register(). That should be sufficient. The
> >>> same applies to the lm75 patch.
> >> 
> >> OK. Done for both.
> >> 
> >>> 
> >>> As a side note, I would suggest to provide devm_ functions for 
> >>> registration. We are introducing those for hwmon registration,
> >>> which enables us to remove most _remove functions. It would be
> >>> great if we can keep it that way.
> >>> 
> >> 
> >> Right. This side note is taken. Actually this is on my todo list
> >> for quite a while. But I believe this should not block this series,
> >> should it? I will be probably cleaning the thermal framework code
> >> after this current work is accepted at least.
> >> 
> >>> On a higher level, I don't think it is a good idea to make
> >>> thermal zones and thermal zone data mandatory. Many systems may
> >>> neither need nor want it.
> >>> 
> >> 
> >> Well, I agree with you. Did you see something hard required in the
> >> patch I sent. I made it so that it could continue the driver probe
> >> without thermal zones, as you requested.
> >> 
> > If it is not mandatory you should not dump an error message to the
> > console in the thermal registration function. Since you do, you at
> > least consider it mandatory if that function is called.
> > 
> > So please either drop the error message from the registration
> > function or add a check into the drivers to only register into the
> > thermal subsystem if there is a respective thermal entry for that
> > sensor in the devicetree data.
> > 
> > There are systes out there with literally dozens of temperature
> > sensors. In many cases, those are purely for system health
> > monitoring, not for thermal management. I don't want to end up in a
> > situation where users complain about dozens of error messages on the
> > console and no way to avoid it but providing dummy thermal subsystem
> > data.
> > 
> 
> Now I see.
> 
> 
> Then I will rollback to the previous version in which lm sensors were
> first probing for thermal properties within their dt node. Something like:
> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
> index dc96598..cb1c663 100644
> --- a/drivers/hwmon/tmp102.c
> +++ b/drivers/hwmon/tmp102.c
> @@ -216,11 +216,13 @@ static int tmp102_probe(struct i2c_client *client,
>                 goto fail_remove_sysfs;
>         }
> 
> -       tmp102->tz = thermal_zone_of_sensor_register(&client->dev, 0,
> -                                                    &client->dev,
> -                                                    tmp102_read_temp,
> NULL);
> -       if (IS_ERR(tmp102->tz))
> -               tmp102->tz = NULL;
> +       if ((of_find_property(client->dev.of_node, "#sensor-cells", NULL)) {
> +               tmp102->tz > thermal_zone_of_sensor_register(&client->dev, 0,
> +                                                            &client->dev,
> +
> tmp102_read_temp, NULL);
> +               if (IS_ERR(tmp102->tz))
> +                       tmp102->tz = NULL;
> +       }
> 
>         dev_info(&client->dev, "initialized\n");
> 
> 
> Does it sound reasonable?
> 
Personally I would prefer if the registration code fails silently.
Pushing the above code into each driver is just adding the same code
repeatedly all over the place.

Also, each sensor instance will still result in an error if there
is no global "thermal-zones" entry. Checking for that global entry
in each driver would be even more excessive, and I just don't like
that noisyness.

Also, I think you'll need to create devicetree bindings documents
for the two sensors.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
