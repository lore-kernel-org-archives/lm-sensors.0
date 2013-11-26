From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 26 Nov 2013 02:47:48 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] tg3: Convert to use hwmon_device_register_with_groups
Message-Id: <52940BD4.9000605@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385186881-7931-1-git-send-email-linux@roeck-us.net>
	<1385186881-7931-2-git-send-email-linux@roeck-us.net>
	<5293FEFA.4000700@broadcom.com>
In-Reply-To: <5293FEFA.4000700@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nithin Nayak Sujir <nsujir@broadcom.com>, netdev@vger.kernel.org
Cc: e1000-devel@lists.sourceforge.net, Bruce Allan <bruce.w.allan@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, lm-sensors@lm-sensors.org, Michael Chan <mchan@broadcom.com>, "David S. Miller" <davem@davemloft.net>

On 11/25/2013 05:52 PM, Nithin Nayak Sujir wrote:
>
>
> On 11/22/2013 10:07 PM, Guenter Roeck wrote:
>> Use new hwmon API to simplify code, provide missing mandatory 'name'
>> sysfs attribute, and attach hwmon attributes to hwmon device instead
>> of pci device.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/net/ethernet/broadcom/tg3.c |   25 ++++++-------------------
>>   1 file changed, 6 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
>> index a9e0684..369b736 100644
>> --- a/drivers/net/ethernet/broadcom/tg3.c
>> +++ b/drivers/net/ethernet/broadcom/tg3.c
>> @@ -10629,10 +10629,8 @@ static void tg3_sd_scan_scratchpad(struct tg3 *tp, struct tg3_ocir *ocir)
>>   static ssize_t tg3_show_temp(struct device *dev,
>>                    struct device_attribute *devattr, char *buf)
>>   {
>> -    struct pci_dev *pdev = to_pci_dev(dev);
>> -    struct net_device *netdev = pci_get_drvdata(pdev);
>> -    struct tg3 *tp = netdev_priv(netdev);
>>       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>> +    struct tg3 *tp = dev_get_drvdata(dev);
>
>
> Shouldn't this be
> struct tg3 *tp = netdev_priv(dev_get_drvdata(dev));
>

'struct tg3 *tp' is attached to the hwmon device in
hwmon_device_register_with_groups(), so it can be retrieved
with dev_get_drvdata() from there. Keep in mind that 'dev'
is no longer the pci device but the hwmon device.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
