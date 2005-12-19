From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 19 Dec 2005 16:52:46 +0000
Subject: [lm-sensors] revisiting __SENSOR_DEVICE_ATTR() and array
Message-Id: <43A6E55E.60100@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <439A7911.5020904@gmail.com>
In-Reply-To: <439A7911.5020904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Jim,
>
>  
>
>>Start converting adm1026 to use arrays of sensor device attributes.
>>This is compile-tested only, and needs someone with hardware to
>>clean it up, fix the overlooked bits, and test it.
>>
>>Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
>>    
>>
>
>The compiler complains about unused functions, and is right:
>  
>
>show_in should be show_in_min...
>  
>
>... and show_in_max.
>show_fan should be show_fan_min...
>  
>
>... and show_fan_div.
>
>I also had to edit the patch in order to apply it, due to recent
>patches to the adm1026 driver.
>
>Can you respin it based on 2.6.15-rc5-mm1 or later, fixing the bugs
>above?
>
>  
>
Thanks for the review, heres the respin against rc5-mm3
with corrections to the above.

>I'll need someone to test this patch on a real ADM1026 device before I
>can accept it.
>
>Thanks,
>  
>
hmm,  it has no maintainer listed.  I hope someone can test it.
Im CCg the authors named in the file, in case theyre not on lm-sensors.

also, it looks like the following could also benefit some (I havent 
looked closely)
adm1025,
adm1031.
adm9240 ,
asb100,
gl520sm.c
lm{78,85}               several *_fan_##ofset##_{min,max,div,input}

A sligthly sloppy grep for DEVICE_ATTR or  '##' shows 905 lines.
in hwmon/*, some of them are junk, but others are legitimate opportunities
to lose weight.

Also.  I noticed some repeated uses like this:
../../linux-2.6.14.3/drivers/hwmon/gl518sm.c:327:static 
DEVICE_ATTR(in3_input, S_IRUGO, show_in_input3, NULL);

It suggests that DEVICE_ATTR needs a helper initialization macro
just like SENSOR_ATTR, thoughts ?


thanks.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: adm1026-use-sensor-attr-arrays.patch
Type: text/x-patch
Size: 23846 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051219/7cbbc854/adm1026-use-sensor-attr-arrays-0001.bin
