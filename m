From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 11 Sep 2008 02:16:43 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc6 2/6] hwmon/pc87360 separate
Message-Id: <48C87F8B.4010009@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C79487.1010105@gmail.com>
In-Reply-To: <48C79487.1010105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Andrew Morton wrote:
> On Wed, 10 Sep 2008 03:47:32 -0600
> Jim Cromie <jim.cromie@gmail.com> wrote:
>
>   
>> +static ssize_t show_in_min_alarm(struct device *dev, struct device_attribute
>> +			     *devattr, char *buf)
>> +{
>> +	struct pc87360_data *data = pc87360_update_device(dev);
>> +	unsigned nr = to_sensor_dev_attr(devattr)->index;
>> +
>> +	return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MIN));
>> +}
>> +static ssize_t show_in_max_alarm(struct device *dev, struct device_attribute
>> +			     *devattr, char *buf)
>>     
>
> coding-style nit: it is highly unusual to put a newline between the
> argument's type and its identifier.
>
>   

Ack.

I chose to put as much as possible on 1 line, based upon the notion that
greps for 'struct device_attribute' would report as much useful context 
as possible.
(namely that its an arg to this function, arg name is unneede in this case)

Having said that, it strikes me that 'static ssize_t' should be on a 
separate line,
since C has no overloaded functions returning different types, so it 
should have
said:

static ssize_t 
show_in_max_alarm(struct device *dev, struct device_attribute *devattr, char *buf)

This style is already used in some hwmon drivers.
(but I could see it other ways too)



> This:
>
> --- a/drivers/hwmon/pc87360.c~hwmon-pc87360-separate-alarm-files-add-in-min-max-alarms-cleanup
> +++ a/drivers/hwmon/pc87360.c
> @@ -498,16 +498,16 @@ static struct sensor_device_attribute in
>     register (sec 11.5.12), not the vin event status registers (sec
>     11.5.2) that (legacy) show_in_alarm() resds (via data->in_alarms) */
>  
> -static ssize_t show_in_min_alarm(struct device *dev, struct device_attribute
> -			     *devattr, char *buf)
> +static ssize_t show_in_min_alarm(struct device *dev,
> +			struct device_attribute *devattr, char *buf)
>  {
>  	struct pc87360_data *data = pc87360_update_device(dev);
>  	unsigned nr = to_sensor_dev_attr(devattr)->index;
>  
>  	return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MIN));
>  }
> -static ssize_t show_in_max_alarm(struct device *dev, struct device_attribute
> -			     *devattr, char *buf)
> +static ssize_t show_in_max_alarm(struct device *dev,
> +			struct device_attribute *devattr, char *buf)
>  {
>  	struct pc87360_data *data = pc87360_update_device(dev);
>  	unsigned nr = to_sensor_dev_attr(devattr)->index;
> _
>
> is not really any better-looking, but it's more conventional.
>
>   

SO...

Im completely fine with your implied (very diplomatically) preference.
Given that youve patched this nit already, Id add it to the patchset 
instead of reworking patch 2/6.

If you want to go this way, pls consider this my
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
If not, I'll reroll them.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
