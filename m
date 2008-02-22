From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 22 Feb 2008 08:00:05 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <47BE8105.30301@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net>	<1202031072.3042.54.camel@acpi-sony.sh.intel.com>	<20080203164410.GL20687@jupiter.solarsys.private>	<20080203175006.GB9159@khazad-dum.debian.net>	<05B550FD4BD2014E841D83547B626008029899FE@bgsmsx411.gar.corp.intel.com>	<20080205135725.GO20687@jupiter.solarsys.private>	<05B550FD4BD2014E841D83547B626008029BF29B@bgsmsx411.gar.corp.intel.com>	<1202915450.7977.607.camel@queen.suse.de>	<20080214140855.GB12412@srcf.ucam.org> <1203659229.3210.45.camel@localhost.localdomain>
In-Reply-To: <1203659229.3210.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: zhangrui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <lenb@kernel.org>, Richard Hughes <hughsient@gmail.com>

zhangrui wrote:
> Hi, all,
> 
> Sorry for the late response as I'm on the Chinese New Year vacation.
> 
> On Thu, 2008-02-14 at 22:08 +0800, Matthew Garrett wrote:
>> On Wed, Feb 13, 2008 at 04:10:50PM +0100, Thomas Renninger wrote:
>>
>>> Why do you want to still export the temperature via ACPI sysfs paths
>>> then?
>>> Once it is there and userspace progs make use of it, you will have
>> to
>>> maintain it forever and HAL is getting crazy and must take care
>> about:
>>>   - How to find the ACPI thermal node
>>>   - Find the hwmon node
>>>   - Both interfaces provide temeratures
>>>   - Parse different output of temperature values (totally crazy)
>>>
>> Quite. There's still been no indication that anyone cares about fixing
>> this interface, and I'm upset that it was merged despite there being
>> clear and valid concerns about it. Do we have a commitment that it's
>> going to be cleaned up before final? If not, it should be pulled
>> before
>> userspace starts depending on it. The only hardware where this
>> currently
>> matters isn't going to be running 2.6.25 anyway.
>>
> 
> Here is my understanding of the problem, please correct me if I say
> something wrong. :)
> It would be great if we can use the hwmon for ACPI thermal model. And
> it's also true that there are some gaps exist just as thomas had already
> listed.
> so let's make the problems clear one by one. Surely it would be great if
> we can solve all the problems so that we can use the hwmon.
> But if not, please let the new thermal sysfs class go upstream as we
> really need this functionality and we don't get any alternatives.
> 
> Here is a typical thermal sys I/F for ACPI thermal zone.
> /sys/class/thermal:
> |thermal_zone1:
>         |-----type:                     ACPI thermal zone
>         |-----temp:                     37
>         |-----mode:                     kernel
>         |----trip_point_0_temp:         100
>         |-----trip_point_0_type:        critical
>         |-----trip_point_1_temp:        80
>         |-----trip_point_1_type:        passive
>         |-----trip_point_2_temp:        70
>         |-----trip_point_2_type:        active0
>         |-----trip_point_3_temp:        60
>         |-----trip_point_3_type:        active1
>         |-----cdev0:
> --->/sys/class/thermal/cooling_device0
>         |-----cdev0_trip_point:         1       /* used for passive */
>         |-----cdev1:		--->/sys/class/thermal/cooling_device1
>         |-----cdev1_trip_point:         1       /* used for passive */
>         |-----cdev2:		--->/sys/class/thermal/cooling_device2
>         |-----cdev2_trip_point:         2       /* used for active0 */
>         |-----cdev3:		--->/sys/class/thermal/cooling_device3
>         |-----cdev3_trip_point:         2       /* used for active0 */
>         |-----cdev4:		--->/sys/class/thermal/cooling_device3
>         |-----cdev4_trip_point:         3       /* used for active1*/
> |thermal_zone2: 
>         |-----type:                     ACPI thermal zone
>         |-----temp:                     43
>         |-----mode:                     kernel
>         |-----trip_point_0_temp:        105
>         |-----trip_point_0_type:        critical
>         |-----trip_point_1_temp:        65
>         |-----trip_point_1_type:        passive
>         |-----cdev0:		--->/sys/class/thermal/cooling_device0
>         |-----cdev0_trip_point:         1       /* used for passive */
> 
> |cooling_device0:
>         |-----type:                     Processor
>         |-----max_state:                8
>         |-----cur_state:                0
> |cooling_device1:
>         |-----type:                     Processor
>         |-----max_state:                8
>         |-----cur_state:                0
> |cooling_device2:
>         |-----type:                     Fan
>         |-----max_state:                1
>         |-----cur_state:                0
> |cooling_device3:
>         |-----type:                     Fan
>         |-----max_state:                1
>         |-----cur_state:                0
> 
> The first problem is how to use hwmon for all cooling device.
> We need a uniform I/F for both fan and passive cooling devices.
> 
> pwm[1-*]_enable, and pwm[1-*] and fan[1-*]_input can be used for fan
> control.
> The same I/F can work for acpi fan, even for all cooling devices, e.g
> pwm[1-*]_enable to enable/disable cooling device control via acpi
> thermal driver, pwm[1-*] to control the device cooling state, where 0
> stands for no cooling and 255 stands for maximum cooling state.
> But it seems really ugly and it's a misuse of pwm[1-*] attribute, right?
> 
> So we should either introduce new hwmon ABIs for cooling device control,
> just like what we've already done in the thermal sys class,
> or give up the idea of making them hwmon compatible.
> 
> If we have generic hwmon ABIs for all cooling devices, let's go further.
> Hwmon also has the ABIs to support multiple trip points for fan device,
> i.e. pwm[1-*]_auto_point[1-*]_pwm and pwm[1-*]_auto_point[1-*]_temp.
> But in order to make this available for all cooling devices, we still
> need to introduce new ABIs, maybe something like
> dev[1-*]_auto_point[1-*]_temp.
> 
> And we also needs to introduce the folder structure to store the list of
> devices associated with a thermal sensor.
> 
> Then the new thermal sys I/F should look like:
> /sys/class/hwmon:
> |hwmon0/device:		--->/sys/class/thermal/thermal_zone0
> |hwmon1/device:		--->/sys/class/thermal/thermal_zone1
> 
> /sys/class/thermal:
> |thermal_zone0:
>         |-----name:                     ACPI thermal zone
>         |-----temp1_input:              37000
>         |-----temp1_crit:               100000
>         |-----dev1_enable:              2
>         |-----dev1_control:	--->/sys/class/thermal/cooling_device0
>         |-----dev1_auto_point1_temp:    80000
>         |-----dev2_enable:              2
>         |-----dev2_control:	--->/sys/class/thermal/cooling_device1
>         |-----dev2_auto_point1_temp:    80000
>         |-----dev3_enable:              2
>         |-----dev3_control:	--->/sys/class/thermal/cooling_device2
>         |-----dev3_auto_point1_temp:    70000
>         |-----dev4_enable:              2
>         |-----dev4__control:	--->/sys/class/thermal/cooling_device3
>         |-----dev4_auto_point1_temp:    60000
> 
> |thermal_zone1:
>         |-----name:                     ACPI thermal zone
>         |-----temp1_input:              43000
>         |-----temp1_crit:               105000
>         |-----dev1_enable:              2
>         |-----dev1__control:	--->/sys/class/thermal/cooling_device1
>         |-----dev1_auto_point1_temp:    85000
> 
> |cooling_device0: no change
> |cooling_device1: ...
> |cooling_device2: ...
> |cooling_device3: ...
> (PS: I don't like the idea of mapping the cur_state to an Integer value
> in the range 0 to 255 like PWM[1-*], cur_state/max_state will be much
> easier for user space to use, what do you think?)
> 
> So this is the prototype proposal. IMO, the hwmon doesn't have any
> framework for us to use, we will end up first doing framework and then
> making use of it which is not worth doing. :(
> If you think something is wrong/improper, or you get some better ideas,
> please just speak it out. Any comments are appreciated. ;)
> 

I think all that is really needed and asked for is for the new thermal ACPI 
code to:
1) provide temp readings in the same format as hwmon (so milli degrees celcius,
not degrees celcius)

2) provide a hwmon interface so that tools like (but not limited too):
* net-snmp
* mrtg
* sensors
* sensors-applet (gnome)
* xfce-sensors-applet
* ksysguard
* ksensors
* gkrellm

Can provide temp and fan readings without having to be modified.

To be clear I am suggesting that the new code exports both:
1) the current full fledged thermal acpi zone interface, as designed for
both reading and configuration
2) a read only hwmon interface for reporting temps and fans

Regards,

Hans (lm_sensors contributer)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
