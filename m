From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 16 Dec 2005 17:28:15 +0000
Subject: [lm-sensors] revisiting __SENSOR_DEVICE_ATTR() and array
Message-Id: <43A2F92F.1040707@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <439A7911.5020904@gmail.com>
In-Reply-To: <439A7911.5020904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:

>Hi Jean, Jim:
>
>
>  
>
>Although I haven't been involved in the macro cleanup and conversion work
>up to this point... a long time ago I complained that the sysfs inits make
>the hwmon drivers much bigger than they need to be.  Anyway, thanks for
>working on this stuff; and that patch looks OK to me.
>
>[...]
>
>  
>
cool.  Ive started converting adm1026 to use this array init,
it compiles ok, but I cannot test it, so Im certain it has latent
bugs.  Im attaching in case anyone wants to pick it up and run
with it.

>>1* Using sysfs_create_group(), as Greg KH suggested. This doesn't need
>>any preliminary patch. The patch is here:
>>
>>http://jdelvare.net2.nerim.net/sensors/hwmon-f71805f-sysfs-group.patch
>>
>>2* Using arrays of attributes and looping over them, as you proposed
>>for the pc87360 driver. This needs the preliminary hwmon-sysfs.h patch.
>>The patch is here:
>>
>>http://jdelvare.net2.nerim.net/sensors/hwmon-f71805f-use-attr-array.patch
>>
>>This second patch has my preference as it makes the code significantly
>>smaller. I don't much like the sysfs_create_group interface because it
>>forces you to create two additional data structures you otherwise have
>>no need for.
>>    
>>
>
>I agree, but I wonder if sysfs_create_group() has benefits on the back
>end.  It's possible that looping over the attributes uses more memory
>after all. [checks code]  No, your second patch has the exact same
>effect, less one big array and one small one.
>
>  
>
>>I am not totally sure what I want to do here, so hints in either
>>direction are welcome.
>>    
>>
>
>Also, in the sysfs-group patch, there was this line...
>
>  
>
>>>>static struct attribute_group attr_group_fan[3] __initdata = {
>>>>        
>>>>
>
>"array of structs containing a pointer to array of pointers to struct attribute"
>
>My own preference is to avoid that kind of stuff like the plague.
>
>Regards,
>
>  
>

<conjecture>

I noticed that, if a 2nd param was passed to the show/store callbacks,
then the type-safe cast to_sensor_dev() woundnt be needed
( since its done to fetch the index out of the struct sensor_devicee_attr,
 which is now passed directly. )
With that done, we would no longer need all the  individual 
sensor_device_attrs,
since the 2nd arg can carry that info.

then, posit a pair of group-layering constructs:
struct attr_set  would hold  the attrs for each of the attrubutes,
ex:  a voltage device attr_set would have min, max, crit

now, posit that every attr be elevated to a 1 element array,
allowing for full converson later .  (useful for vin0..vin10 )

Now suppose user reads in0_max from sysfs.
sysfs invokes show_in_input(),   passes a 'sysfs-devno'
as the 2nd arg.

then show_in_input, uses the 2nd arg as the index.

Ive left out the attr-selection process - it requires a bit more setup;
when the (say voltage) attr-set-array is 1st registered, it names the 
attributes
its working for (inpu, min, max, crit), and the array lengths.  

The registration routine will, in essence, create a major device number 
for the
voltage unit, then split the minor-numbers so that the array range is 
covered,
and to select from amongst the available attrs.  Because this is done 
per-dev
at registration time, the split is made independently for each device.

so callbaks get pointer to the voltage 'sub-group', and the 2nd arg
will allow it to get the right unit/element number and attr-function.

UNFORTUNATELY, this all falls apart because there is nowhere
in the sysfs infrastructure to carry the 2nd param so its available
to pass into the callbacks.  (the conjecture is kinda handwavey cuz
Id concluded it cant work due to lack of space for the 2nd param)

Q.  are there any fields in sysfs infrastructure that we can
commandeer to carry a 2nd arg ?   For pc87360, I could imagine
a consolidation:
50 vin devices            ->  1 composite attr descriptor
14*5 temp devices      -> 1 composite attr descriptor.

IOW, the 50 individual voltage related sensor-dev-attrs, carrying;
 2 fn-ptrs, mode, name, index
are replaced by 1 common structure + 1 integer (devno)

I hope for one of these answers:
    HUH ?
    nope, youve missed some important deatails....
    it looks like it would work, but for the missing param.
    we can steal field X for this.

</>



for the attached patch,

Start converting adm1026 to use arrays of sensor device attributes.
This is compile-tested only, and needs someone with hardware to
clean it up, fix the overlooked bits, and test it.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: diff.adm1026.only
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051216/2d16e135/diff.adm1026-0001.pl
