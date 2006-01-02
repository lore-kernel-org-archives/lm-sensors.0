From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Mon, 02 Jan 2006 10:51:22 +0000
Subject: [lm-sensors] hwmon-sensor-attr-array-2.patch
Message-Id: <43B905AA.5030402@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <43B306FB.9040301@gmail.com>
In-Reply-To: <43B306FB.9040301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Jim,
> 
> Jim Cromie wrote:
>> This patch refactors SENSOR_DEVICE_ATTR_2 macro, following pattern set by
>> SENSOR_ATTR.  First it creates a new macro SENSOR_ATTR_2() which expands 
>> to an initialization expression, then it uses that in SENSOR_DEVICE_ATTR_2, 
>> which declares and initializes a struct sensor_device_attribute_2.
> 
> Looks OK to me, consider it applied. I won't push it until I am also
> able to push a driver which uses it though (but that should happen soon
> enough.)
> 
> We should probably think of this part of the code and see what can be
> done to improve it. struct sensor_device_attribute is currently
> *larger* than struct sensor_device_attribute_2, which makes one wonder
> if we shouldn't use sensor_device_attribute_2 everywhere even when we
> don't actually need the second parameter. Also, the field names "index"
> and "nr" are too generic IMHO and this might get confusing in the long
> run. I was thinking of "channel" instead of "index". No idea for "nr"
> though. Or maybe we are generic on purpose for reusability, but then
> "index" and "nr" should be "nr0" and "nr1" or something equally
> symmetrical. Thoughts?
> 
> Thanks,

I use the 2 fields in a number of different ways (table use 8-width tabs):

		nr selects 			index selects
values		NA				sensor
pwm_auto/min/ma	min/max	(offset)		sensor/pwm
xxx_mask_xxx	beep/shutdown/alarm (bitmask)	sensor_type (volt/temp)*

*) NA for bank2 as bank2 only contains fan sensors

I've attached a new version of the uGuru driver which adds the above 
table as a comment for future reference.

Anyways considering the wide number of uses I've found for the 2 params 
in 1 driver I think we should keep the names as generic as possible, 
maybe index and param?, which would suggest swapping the order of the 2 
in the MACRO arg lists.

Regards,

Hans

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: abituguru.c.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060102/29f17edb/abituguru.c-0001.txt
