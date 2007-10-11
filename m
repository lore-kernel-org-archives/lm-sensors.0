From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 11 Oct 2007 18:29:14 +0000
Subject: Re: [lm-sensors] Need some input for cleaning up FSC userspace code
Message-Id: <470E6B7A.6030801@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <470E3938.3010601@hhs.nl>
In-Reply-To: <470E3938.3010601@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Please ignore my rambling. While cycling home from work I gave this some more 
thought and I think I know how to solve this while keeping full compatibility 
with the current libsensors and apps using it.

Regards,

Hans


Hans de Goede wrote:
> Hi all,
> 
> I've been working today on creating support for the new fschmd in the 2.10.x 
> tree for the 2.10.5 release.
> 
> I've added code like this too the current fscpos (and fscher and fscscy) print 
> code:
> 
> void print_fscpos(const sensors_chip_name *name)
> {
>    char *label;
>    double voltage, temp, state, fan;
>    int valid;
> 
>    /* Check for the non standard temp1_state sysfs attr the old driver uses
>       if it isn't present we are talking to the new fschmd driver */
>    if (sensors_get_feature(*name,SENSORS_FSCPOS_TEMP1_STATE,&state) != 0) {
>      print_fschmd(name);
>      return;
>    }
> 
>    /* no need to read TEMP1_STATE, as we just successfully did that above */
>    if (!sensors_get_label_and_valid(*name,SENSORS_FSCPOS_TEMP1,&label,&valid) &&
>        !sensors_get_feature(*name,SENSORS_FSCPOS_TEMP1,&temp)) {
> ......
> 
> 
> 
> This works fine with the old driver, however it won't work with the new driver 
> as currently lib/chips.c still contains the features list for the old driver, 
> which btw is not in a good state:
> 
> [hans@localhost lm-sensors]$ /usr/local/bin/sensors -u
> fscher-i2c-0-73
> Adapter: SMBus I801 adapter at 2400
> ERROR: Can't get feature `rev' data!
> alarms: 0.00 (alarms)
> control: 0.00 (control)
> +12V: 1.89 (in0)
> +5V: 1.98 (in1)
> Battery: 2.45 (in2)
> Temp1/CPU: 39.00 (temp1)
>    temp1_state: 1.00 (temp1_state)
> Temp2/MB: 34.00 (temp2)
>    temp2_state: 1.00 (temp2_state)
> Temp3/AUX: 127.00 (temp3)
>    temp3_state: 0.00 (temp3_state)
> Fan1/PS: 1320.00 (fan1)
>    pwm1: 1.00 (pwm1)
>    fan1_state: 0.00 (fan1_state)
> ERROR: Can't get feature `fan1_ripple' data!
> Fan2/CPU: 0.00 (fan2)
>    pwm2: 1.00 (pwm2)
>    fan2_state: 0.00 (fan2_state)
> ERROR: Can't get feature `fan2_ripple' data!
> Fan3/AUX: 0.00 (fan3)
>    pwm3: 1.00 (pwm3)
>    fan3_state: 0.00 (fan3_state)
> ERROR: Can't get feature `fan3_ripple' data!
> ERROR: Can't get feature `wdog_preset' data!
> ERROR: Can't get feature `wdog_state' data!
> ERROR: Can't get feature `wdog_control' data!
> 
> As you can see it refers to several 2.4 features not present or renamed in the 
> 2.6 driver.
> 
> 
> So what I want todo is add features for the old driver non sysfs interface 
> compliant attributes which are used in the old print_fscpos code, like 
> temp#_state and fan#_state, to the fschmd features list, and then use that 
> features list for all fsc chip prefixes. Then I'll update the old print code 
> for the old fscpos, scy and her drivers to use the new feature numbers and 
> things will work.
> 
> However this will break any existing applications which depend on the old FSC 
> SCY / POS / HER feature numbers. We have no in tree users of these, but still.
> 
> So what todo?
> 
> I guess it would be best to:
> -use my suggested fix to make one fschmd feature list including needed old
>   features and use that everywhere, but ....
> -make the feature numbers so that they are compatible with the feature numbers
>   of the old attributes
> 
> But then what todo with the no longer existing features, avoid the numbers in 
> the new fschmd feature list I guess, or still put them in for 2.4 users?
> 
> I guess I need to think a bit more about this, in the mean time any input is 
> appreciated.
> 
> Regards,
> 
> Hans
> 
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
