From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 24 Dec 2005 20:33:29 +0000
Subject: [lm-sensors] Patch: abituguru driver version 1.1.1
Message-Id: <43ADB099.7020002@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43AD5940.1090900@hhs.nl>
In-Reply-To: <43AD5940.1090900@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:

>
>/* This is needed untill this gets merged upstream */
>#ifndef __SENSOR_DEVICE_ATTR2
>#define __SENSOR_DEVICE_ATTR2(_name,_mode,_show,_store,_index,_nr)	\
>{	.dev_attr =	__ATTR(_name,_mode,_show,_store),		\
>	.index =	_index,						\
>	.nr =		_nr						\
>}
>#endif
>
>  
>


your macro is nearly identical to one thats already in mainline,
except that your _nr and _index are in a different order.


#define SENSOR_DEVICE_ATTR_2(_name,_mode,_show,_store,_nr,_index)       \
struct sensor_device_attribute_2 sensor_dev_attr_##_name = {    \
        .dev_attr =     __ATTR(_name,_mode,_show,_store),       \
        .index =        _index,                                 \
        .nr =           _nr,                                    \
}



also, I understand why you chose the __ to start the macro name,
but Jean has proposed SENSOR_ATTR(), so I sent a patch
to follow that pattern, adding  SENSOR_ATTR_2()

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-December/014768.html

I trust that Jean will make a choice for us at some point soon.

