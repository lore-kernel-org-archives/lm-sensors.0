From: jcromie@divsol.com (Jim Cromie)
Date: Thu, 04 Aug 2005 03:25:30 +0000
Subject: [lm-sensors] Re: [patch] pc87360 de-macro and code shrink
Message-Id: <42F16E75.2080309@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E87A0F.8060709@divsol.com>
In-Reply-To: <42E87A0F.8060709@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yani Ioannou wrote:

>On 7/28/05, Jean Delvare <khali@linux-fr.org> wrote:
>  
>
>>Hi Jim,
>>
>>On 2005-07-28, Jim Cromie wrote:
>>    
>>
>>>attached is a patch which:
>>>
>>>1. adds an __ATTR_N macro to device.h,
>>>which takes an extra _index arg, and initializes device_attibute's new
>>>.index member.
>>>      
>>>
>>This seems to be duplicating the SENSOR_DEVICE_ATTR macro as defined in
>>include/linux/hwmon-sysfs.h.
>>    
>>
>
>Just as a further to Jean's point, I'd like to highlight that
>device_attribute doesn't need new members, rather it now passes an
>extra parameter (a device_attribute *) to it's callbacks. What that
>extra parameter does allow you to do is to embed a device_attribute in
>another type (e.g. sensor_device_attribute) and access anything
>defined in that new type (e.g. index). This is exactly what is defined
>in include/hwmon-sysfs.h. See any of Jean's or my patches to various
>sensor drivers that show how to use them.
>
>With that said I'm glad you are trying to clean these things up :-),
>you might want to look through the archives for "dynamic sysfs
>callbacks" and the ensuing discussions if you are interested. At one
>point early on adding a .index attribute to the device_attribute was
>considered a possibility, but I feel what we ended up with is much,
>much better.
>
>  
>
IIUC, the 'much better' is passing a *dev-attr,
doing to_sensor_dev_attr() on it to get the full SDA
in a typesafe manner, then using whatever new members
you have added (ex index, and for sda2, nr also)

or have I missed something ?

just to follow up,  rc4-mm1 has

struct sensor_device_attribute{
        struct device_attribute dev_attr;
        int index;
};
struct sensor_device_attribute_2 {
        struct device_attribute dev_attr;
        u8 index;
        u8 nr;
};


Ive used the 1st sda in my latest patch-set, are these structs 'stable' ?
.index is still there, with more room than is useful for file-entries in 
a sysfs dir-node.
Any reason not to shorten the index, to 'reserve' another short ?

I also note there is room for another short in the latter, in dark 
(padding) memory.

