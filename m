From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 29 Dec 2005 11:24:44 +0000
Subject: [lm-sensors] New abituguru version (Re:
Message-Id: <43B3C77C.2020806@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jim Cromie wrote:
> Hi Jean, Hans,
> 
> This patch refactors SENSOR_DEVICE_ATTR_2 macro, following pattern set by
> SENSOR_ATTR.  First it creates a new macro SENSOR_ATTR_2() which expands 
> to an initialization expression, then it uses that in 
> SENSOR_DEVICE_ATTR_2, which declares and initializes a struct 
> sensor_device_attribute_2.
> 
> 
> This version differs from that in Hans' abituguru driver,
> in that it preserves the argument order used in the original 
> SENSOR_DEVICE_ATTR_2 macro, Hans' version invites confusion by
> transposing _nr and _index between 2 closely related macros.
> 
> Happily though, Hans coded with __SENSOR_DEVICE_ATTR2,
> so his driver could coexist with the macro defined here,
> and he could switch at his discretion.
> 
> Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

I've attached a new version which uses the new SENSOR_ATTR_2() macro as 
defined in Jim's patch. Currently a copy of the macro surrounded by an 
#ifndef SENSOR_ATTR_2 is included in the driver for compiling against a 
clean 2.6.14, once this macro gets merged upstream the copy will be removed.

Regards,

Hans
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: abituguru.c.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051229/b0196dc1/abituguru.c-0001.txt
