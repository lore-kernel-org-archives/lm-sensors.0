From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 25 Dec 2005 07:21:06 +0000
Subject: [lm-sensors] Patch: abituguru driver version 1.1.1
Message-Id: <43AE4862.5040001@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <43AD5940.1090900@hhs.nl>
In-Reply-To: <43AD5940.1090900@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jim Cromie wrote:
> Hans de Goede wrote:
> 
>> /* This is needed untill this gets merged upstream */
>> #ifndef __SENSOR_DEVICE_ATTR2
>> #define __SENSOR_DEVICE_ATTR2(_name,_mode,_show,_store,_index,_nr)	\
>> {	.dev_attr =	__ATTR(_name,_mode,_show,_store),		\
>> 	.index =	_index,						\
>> 	.nr =		_nr						\
>> }
>> #endif
>>
>>  
>>
> 
> 
> your macro is nearly identical to one thats already in mainline,
> except that your _nr and _index are in a different order.
> 

Erm,

I took this macro from some patch that was submitted to lm_sensors, 
assuming that this is what it would become in mainline, hence also the 
#ifndef around it.

> 
> #define SENSOR_DEVICE_ATTR_2(_name,_mode,_show,_store,_nr,_index)       \
> struct sensor_device_attribute_2 sensor_dev_attr_##_name = {    \
>         .dev_attr =     __ATTR(_name,_mode,_show,_store),       \
>         .index =        _index,                                 \
>         .nr =           _nr,                                    \
> }
> 

This won't work for me as it declares one struct, where as I'm 
initialising an array of struct AFAIK, that is the difference between 
SENSOR_DEVICE_ATTR(...) and __SENSOR_DEVICE_ATTR(...), just like __ATTR 
can be used to initialise an array of plain sysfs device file attributes.

Regards,

Hans

