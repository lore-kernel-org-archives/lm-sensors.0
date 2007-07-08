From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Jul 2007 09:25:07 +0000
Subject: Re: [lm-sensors] f71882fg suggestions
Message-Id: <4690AD73.1000902@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Krzysztof Helt wrote:
> Hi,
> 
> Here are 3 suggestions to your f71882fg driver (I have no code to 
> comment directly, but they should be easy to locate).
> 
> 1. You should be an author in the MODULE_AUTHOR() macro.

Good point!

> 2. You should not set data.addr in f71882fg_find()
Wrong, I must do that, because after that I call f71882fg_read8(data, ...)
and 71882fg_read8 needs addr to be set, notice that I'm operating on a 
temporary data struct on the stack here, which is used only to call 
f71882fg_read8, to read the config register and see if the hwmon is enabled.

> 3. I wonder why you add all these sysfs entries one by one (in 
> loops) instead of creating a group and add them with one function 
> call (see the asb100 driver). You need to create 3 groups, one 
> for each loop.

I do it this way because I have an array of attributes, not an array of 
attribute addresses as the group register function expects. Walking my array 
with a loop is easier then then first creating an array of addresses (with a 
loop, or handfilling it, which is even worse) and then calling the group 
register function.

Now if there would be a group register function which I can pass the address of 
a set of attr, the offsets between all the attr (one needs to specify the 
offset ebcause we use sensor_attr not sysfs_attr which is larger) and the no of 
attr, then that would be great.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
