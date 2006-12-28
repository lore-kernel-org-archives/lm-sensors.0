From: r.marek@assembler.cz (Rudolf Marek)
Date: Thu, 28 Dec 2006 20:58:59 +0000
Subject: [lm-sensors] Working on a driver for the Andigilog aSC7621
Message-Id: <45943013.2080804@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <22E26940476D1E48AA6F292B5316C9C33738@bes1.peakin.com>
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33738@bes1.peakin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello George,

Sorry for the delay. I had some time to look into the driver before Jean will
do. Jean will have final word, I'm just a preprocessor.

I'm afraid Jean will not accept your driver without some major changes. Here is
the list:

1) Do you have some customer which requested all possible registers to be
exported? Our current policy is to export just what might be necessary, like
obvious things as voltages etc etc plus the trip points. The advanced chip setup
is not exported unless there is some reason for this - like bad bios setup,
silly default value etc...

As you noticed we have a sysfs-interface file which describes the "standard" for
the exported files, we want to get rid of "raw" register values as much as
possible. If this is inevitable the documentation file in Documentation/ should
document the non-standard sysfs names and their I/O (pointing to datasheet is
always good, but we prefer to have the info right in that file ;)

Is it possible just to export what avarage user needs?

2) Sysfs binding

It seems you have chosen very own way how to do that, and I think this can't be
accepted this way. We would prefer to use the method as other drivers use.

Please use SENSOR_ATTR and SENSOR_ATTR_2 macros for your job. You will get rid
of that get_index_from_name and create_param functions which sucks (looks like
windows coding style to me)

This is closely connected with the use of the "register" cache and way how you
handle the values stored in the driver (data->registers[i] instead of the
variable names) Please note that some MSB LSB registers often require to read
them in particular order to "lock" the second value - to obtain correct result.
I'm not sure if this is always your case. This needs to be checked.

I would like to ask what you do not like on following design:

a) have the data->fan data->in etc etc Separate files for registers
b) use of the SENSOR_ATTR_XXXX which construct the sysfs name and pass index or
more to the data->fan[ ][ ] arrays.

If you think that you can't reuse one routine for a "integer %d printout" that
is not true. We have some drivers which (ab)use one index member in SENSORS_ATTR
to enumarate what "kind" of value is to be printed and later in the code:

show_fan(struct device *dev, struct device_attribute *attr, char *buf)

{

        struct sensor_device_attribute_2 *sensor_attr 
            to_sensor_dev_attr_2(attr);

        int nr = sensor_attr->nr;

        int index = sensor_attr->index;

        struct w83793_data *data = w83793_update_device(dev);

        u16 val;
       if (FAN_INPUT = nr) {

                val = data->fan[index] & 0x0fff;

        } else {

                val = data->fan_min[index] & 0x0fff;

        }
        return sprintf(buf, "%lu\n", FAN_FROM_REG(val));

This function print either fan or fan_min value and use the SENSOR_ATTR to store
the index.

I think you did not use that because you missed a way how to point to a custom
array (I think you wanted to pass the string there???)

Also for a latest kernels you could use sysfs_create_group to create whole bunch
of sysfs files with one call.

You will also need to add error code checking to the device_create_file(dev,
.,.. and also destroy all files when the driver is removed (this is also a new
stuff required by recent kernels)

3) non-standard sysfs files

I spotted that you create sometimes non-standard sysfs files, maybe there is
away to make them standard or use standard names:

fan1_input OK (some drivers do not report -1 for stuck fan anymore)
fan1_min OK
fan1_alarm OK if there is just 0 or 1 in the file


I'm attaching the rest without any notice right now. My time is up. It needs to
be discussed anyway.

fan1_config

fan1_spinup ???

temp1_abs_limit
temp1_alarm
temp1_fan_temp_limit
temp1_high_alert_limit
temp1_hyst
temp1_input
temp1_input_fault
temp1_low_alert_limit
temp1_max
temp1_min
temp1_offset
temp1_range
temp1_smoothing
temp1_smoothing_enable
temp1_source
temp1_type

pwm1
pwm1_config
pwm1_config_alt
pwm1_freq
pwm1_invert
pwm1_max
pwm1_min
pwm1_spinup

gpio1
gpio1_func
gpio2
gpio2_func
gpio3
gpio3_func
gpio_alert_assign
peci_4domain
peci_avg
peci_cpu0_enable
peci_cpu1_enable
peci_cpu2_enable
peci_cpu3_enable
peci_diode
peci_domain
peci_enable
peci_legacy
peci_temp1_input
peci_temp2_input
peci_temp3_input
peci_temp4_input

Please try to think about using the standard temperature/pwm automatic control
files like pwm[1-*]_auto_point[1-*]_pwm  or temp[1-*]_auto_point[1-*]_pwm

Thanks,

Rudolf


