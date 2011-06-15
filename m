From: Donggeun Kim <dg77.kim@samsung.com>
Date: Wed, 15 Jun 2011 06:33:15 +0000
Subject: Re: [lm-sensors] [PATCH v8] drivers/hwmon NTC Thermistor Initial
Message-Id: <4DF8522B.3060608@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1308113381-23409-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1308113381-23409-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 2011년 06월 15일 15:00, Shubhrajyoti Datta wrote:
> Hello Kim,
> 
> On Wed, Jun 15, 2011 at 10:19 AM, Donggeun Kim <dg77.kim@samsung.com> wrote:
> 
>> This patch adds support for NTC Thermistor series. In this release, the
>> following thermistors are supported: NCP15WB473, NCP18WB473, NCP03WB473,
>> and NCP15WL333. This driver is based on the datasheet of MURATA.
>>
>> The driver in the patch does conversion from the raw ADC value
>> (either voltage or resistence) to temperature. In order to use
>> voltage values as input, the circuit schematics should be provided
>> with the platform data. A compensation table for each type of thermistor
>> is provided for the conversion.
>>
>> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>
>>
>> --
>> Updates
>> v8
>> - remove compiler warning message
>> - update Documentation/hwmon/ntc_thermistor
>> - add EXPERIMENTAL Kconfig dependency
>> v7
>> - move header file location
>> - rename header and driver file
>> - style fixes
>> v6
>> - updated Documentation/hwmon/ntc
>> - style fixes
>> v5
>> - use binary search on sorted table
>> - removed unnecessary attributes
>> - style fixes
>> v4
>> - put in alphabetic order in Kconfig/Makefile
>> - handle additional error cases
>> - remove the exported function
>> v3
>> - style fixes
>> - removed symbol exports
>> - avoid divide-by-zero
>> - omitted files added (Kconfig/Makefile)
>> - removed unnecessary codes
>> - return error values, not default values for errors.
>> v2
>> - added Documentation/hwmon/ntc
>> - followed hwmon sysfs
>> - detached the monitoring service
>> (thank you for the comments, Guenter Roeck)
>> ---
>>  Documentation/hwmon/ntc_thermistor           |   93 +++++
>>  drivers/hwmon/Kconfig                        |   14 +
>>  drivers/hwmon/Makefile                       |    1 +
>>  drivers/hwmon/ntc_thermistor.c               |  477
>> ++++++++++++++++++++++++++
>>  include/linux/platform_data/ntc_thermistor.h |   53 +++
>>  5 files changed, 638 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/hwmon/ntc_thermistor
>>  create mode 100644 drivers/hwmon/ntc_thermistor.c
>>  create mode 100644 include/linux/platform_data/ntc_thermistor.h
>>
>>
>> <Snip>
> 
>> +
>> +static int __devinit ntc_thermistor_probe(struct platform_device *pdev)
>> +{
>> +       struct ntc_data *data;
>> +       struct ntc_thermistor_platform_data *pdata >> pdev->dev.platform_data;
>> +       int ret = 0, i;
>> +
>> +       if (!pdata) {
>> +               dev_err(&pdev->dev, "No platform init data supplied.\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       /* Either one of the two is required. */
>> +       if (!pdata->read_uV && !pdata->read_ohm) {
>> +               dev_err(&pdev->dev, "Both read_uV and read_ohm missing."
>> +                               "Need either one of the two.\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (pdata->read_uV && pdata->read_ohm) {
>> +               dev_warn(&pdev->dev, "Only one of read_uV and read_ohm "
>> +                               "is needed; ignoring read_uV.\n");
>> +               pdata->read_uV = NULL;
>> +       }
>> +
>> +       if (pdata->read_uV && (pdata->pullup_uV = 0 ||
>> +                               (pdata->pullup_ohm = 0 && pdata->connect
>> =
>> +                                NTC_CONNECTED_GROUND) ||
>> +                               (pdata->pulldown_ohm = 0 && pdata->connect
>> =
>> +                                NTC_CONNECTED_POSITIVE) ||
>> +                               (pdata->connect != NTC_CONNECTED_POSITIVE
>> &&
>> +                                pdata->connect != NTC_CONNECTED_GROUND)))
>> {
>> +               dev_err(&pdev->dev, "Required data to use read_uV not "
>> +                               "supplied.\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       data = kzalloc(sizeof(struct ntc_data), GFP_KERNEL);
>> +       if (!data)
>> +               return -ENOMEM;
>> +
>> +       data->dev = &pdev->dev;
>> +       data->pdata = pdata;
>> +       strncpy(data->name, pdev->id_entry->name, PLATFORM_NAME_SIZE);
>> +
>> +       switch (pdev->id_entry->driver_data) {
>> +       case TYPE_NCPXXWB473:
>> +               data->comp = ncpXXwb473;
>> +               data->n_comp = ARRAY_SIZE(ncpXXwb473);
>> +               break;
>> +       case TYPE_NCPXXWL333:
>> +               data->comp = ncpXXwl333;
>> +               data->n_comp = ARRAY_SIZE(ncpXXwl333);
>> +               break;
>> +       default:
>> +               dev_err(&pdev->dev, "Unknown device type: %lu(%s)\n",
>> +                               pdev->id_entry->driver_data,
>> +                               pdev->id_entry->name);
>> +               ret = -EINVAL;
>> +               goto err;
>> +       }
>> +
>> +       data->mintemp = INT_MAX;
>> +       data->maxtemp = INT_MIN;
>> +
>> +       /*
>> +        * The compensation table is sorted by ohm value. Although it is
>> +        * normally assumed that the temperature value monotonically
>> +        * increases or decreases with the ohm value, but there could be
>> +        * different thermistors.
>> +        */
>> +       for (i = 0; i < data->n_comp; i++) {
>> +               if (data->comp[i].temp_C > data->maxtemp)
>> +                       data->maxtemp = data->comp[i].temp_C;
>> +               if (data->comp[i].temp_C < data->mintemp)
>> +                       data->mintemp = data->comp[i].temp_C;
>> +       }
>> +
>> +       if (data->mintemp != INT_MAX || data->maxtemp != INT_MIN) {
>> +               dev_err(data->dev, "error in compensation table\n");
>> +               ret = -EINVAL;
>> +               goto err;
>> +       }
>>
> Didnt understand this check. Shouldn't the  compensation table allowed to
> modify this?
> 
I think it is my mistake.
The operator of checking line should be changed to '=' from '!='.
Thank you for your review.
> +
>> +       platform_set_drvdata(pdev, data);
>> +
>> +       ret = sysfs_create_group(&data->dev->kobj, &ntc_attr_group);
>> +       if (ret) {
>> +               dev_err(data->dev, "unable to create sysfs files\n");
>> +               goto err;
>> +       }
>> +
>> +       data->hwmon_dev = hwmon_device_register(data->dev);
>> +       if (IS_ERR_OR_NULL(data->hwmon_dev)) {
>> +               dev_err(data->dev, "unable to register as hwmon
>> device.\n");
>> +               ret = -EINVAL;
>> +               goto err_after_sysfs;
>> +       }
>> +
>> +       dev_info(&pdev->dev, "Thermistor %s:%d (type: %s/%lu) successfully
>> probed.\n",
>> +                       pdev->name, pdev->id, pdev->id_entry->name,
>> +                       pdev->id_entry->driver_data);
>> +       return 0;
>> +err_after_sysfs:
>> +       sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
>> +err:
>> +       kfree(data);
>> +       return ret;
>> +}
>> +
>> +static int __devexit ntc_thermistor_remove(struct platform_device *pdev)
>> +{
>> +       struct ntc_data *data = platform_get_drvdata(pdev);
>> +
>> +       hwmon_device_unregister(data->hwmon_dev);
>> +       sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
>> +       platform_set_drvdata(pdev, NULL);
>> +
>> +       kfree(data);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct platform_device_id ntc_thermistor_id[] = {
>> +       { "ncp15wb473", TYPE_NCPXXWB473 },
>> +       { "ncp18wb473", TYPE_NCPXXWB473 },
>> +       { "ncp21wb473", TYPE_NCPXXWB473 },
>> +       { "ncp03wb473", TYPE_NCPXXWB473 },
>> +       { "ncp15wl333", TYPE_NCPXXWL333 },
>> +       { },
>> +};
>> +
>> +static struct platform_driver ntc_thermistor_driver = {
>> +       .driver = {
>> +               .name = "ntc-thermistor",
>> +               .owner = THIS_MODULE,
>> +       },
>> +       .probe = ntc_thermistor_probe,
>> +       .remove = __devexit_p(ntc_thermistor_remove),
>> +       .id_table = ntc_thermistor_id,
>> +};
>> +
>> +static int __init ntc_thermistor_init(void)
>> +{
>> +       return platform_driver_register(&ntc_thermistor_driver);
>> +}
>> +
>> +module_init(ntc_thermistor_init);
>> +
>> +static void __exit ntc_thermistor_cleanup(void)
>> +{
>> +       platform_driver_unregister(&ntc_thermistor_driver);
>> +}
>> +
>> +module_exit(ntc_thermistor_cleanup);
>> +
>> +MODULE_DESCRIPTION("NTC Thermistor Driver");
>> +MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:ntc-thermistor");
>> diff --git a/include/linux/platform_data/ntc_thermistor.h
>> b/include/linux/platform_data/ntc_thermistor.h
>> new file mode 100644
>> index 0000000..abd2862
>> --- /dev/null
>> +++ b/include/linux/platform_data/ntc_thermistor.h
>> @@ -0,0 +1,53 @@
>> +/*
>> + * ntc_thermistor.h - NTC Thermistors
>> + *
>> + *  Copyright (C) 2010 Samsung Electronics
>> + *  MyungJoo Ham <myungjoo.ham@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
>>  USA
>> + */
>> +#ifndef _LINUX_NTC_H
>> +#define _LINUX_NTC_H
>> +
>> +enum ntc_thermistor_type {
>> +       TYPE_NCPXXWB473,
>> +       TYPE_NCPXXWL333,
>> +};
>> +
>> +struct ntc_thermistor_platform_data {
>> +       /*
>> +        * One (not both) of read_uV and read_ohm should be provided and
>> only
>> +        * one of the two should be provided.
>> +        * Both functions should return negative value for an error case.
>> +        *
>> +        * pullup_uV, pullup_ohm, pulldown_ohm, and connect are required to
>> use
>> +        * read_uV()
>> +        *
>> +        * How to setup pullup_ohm, pulldown_ohm, and connect is
>> +        * described at Documentation/hwmon/ntc
>> +        *
>> +        * pullup/down_ohm: 0 for infinite / not-connected
>> +        */
>> +       int (*read_uV)(void);
>> +       unsigned int pullup_uV;
>> +
>> +       unsigned int pullup_ohm;
>> +       unsigned int pulldown_ohm;
>> +       enum { NTC_CONNECTED_POSITIVE, NTC_CONNECTED_GROUND } connect;
>> +
>> +       int (*read_ohm)(void);
>> +};
>> +
>> +#endif /* _LINUX_NTC_H */
>> --
>> 1.7.4.1
>>
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
