From: sergio <mailbox@sergio.spb.ru>
Date: Fri, 27 Mar 2009 03:03:20 +0000
Subject: Re: [lm-sensors] fancontrol
Message-Id: <49CC41F8.7010606@sergio.spb.ru>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070407010503070006000506"
List-Id: <lm-sensors.vger.kernel.org>
References: <1122217880.3578.8.camel@localhost.localdomain>
In-Reply-To: <1122217880.3578.8.camel@localhost.localdomain>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070407010503070006000506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:

> Honestly, fan speed control under busybox doesn't strike me as the most
> needed feature.
Why? Many home nas'es and high performance routers have a fan.

>>> A third possibility which was discussed in the thread I mentioned above
>>> is a helper binary, linked with libsensors, which would take care of
>>> translating hwmonN names to libsensors chip names and back.
>> IMHO this is worst way.
> Why that?
It's look like a crutch.

>> ... If k8temp also present in /etc/modules it is
>> don't matter in which order this modules are written in this file.
>> acpitz always will hwmon0, k8temp -> hwmon1, and it8718 -> hwmon1 (if it
>> present in modules)
> I presume you mean it8718 -> hwmon2.
Yes.

>> (Really, on machine with lenny it87 loads via force_load in
>> initramfs-tools hook, so it87 is (always?) first.)
> What is force_load? And why do you need it?
force_load is function for initramfs-tools hook script (which runs at
build time). It adds a module (and its dependencies) to the initramfs
image and also unconditionally loads the module during boot.
I need it for speed down fan, because it very noisy. Why i need do it at
initrd time? This initrd waits for password for encrypted rootfs...

>> So hwmon names jumping it's not very big problem for me.
> Why are you reporting it then?
Because the problem exists. And i would like that it was not.

>> It is never happens unexpectedly. Only when i change or upgrade something.
> "change or upgrade something" is simply too vague for me to do anything
> useful with the information.
I said this in support of the above-said. I understand which my actions
(and real reason) leads to name changing. But i don't memorize it.

> There may be other similar daemons that can be extended.
So, now only fancontrol can manage fan speed.

> Or feel free to start your own, but then pretty please make its
> configuration file much more flexible and clear than fancontrol's one.
> Shouldn't be too hard ;) If you come up with something really good then I
> will be happy to kill the pwmconfig and fancontrol scripts in favor of your work.
OK.

>> May be should add possibility to define real path to device 
>> (/sys/devices/platform/it87.552)?
> This is a possibility, yes, and it shouldn't be too hard to implement.
> Want to give it a try?
See attachment.

> Not to say that it can't be done properly for hwmon devices. But do
> you have some concrete proposal? "Let's just use udev" doesn't tell me
> much.
I don't clearly understand how udev works.


-- 
sergio




--------------070407010503070006000506
Content-Type: application/octet-stream;
 name="fancontrol.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="fancontrol.patch.bz2"

QlpoOTFBWSZTWYZ/kgEAAlHfgAIwXO//8n8nVYu/7//uUAQHgBIAAAkok0eKm00mnqMmjTEA
0AaAeo0z0SAOYExNBhMmTJkYTBNNMjEwBDAcwJiaDCZMmTIwmCaaZGJgCGA5gTE0GEyZMmRh
ME00yMTAEMAVJI0FMRhNGpqemqeSNME8kepoBo/U1HqNtUnFHBSxrbjj44O2inGM3pelwxro
UNZcUIeZhjZiW9nYvWx7Cx8ksyndTfFpUU8sGAUzyhaFFQDTOF4My6CHLZ7Wk+hVCv/G9Sjp
Oj/RYfFhwuWlFp85pi+0tx8mM6Ptay1Jioxfdzqqr9uVeyu7Ne51GsYuiyxjQup5UapxMtpw
ZFO05HCo1zKFlNZ47G37J6T2zt7cZ9j6rycTsylVKmEKhyPLylV1TGpUtPFUy9092bmTFxVN
E71LSvH5VU72Z+ft6ifwqtlbdxPA3TOskwPh8dkPkfTkrP6WNJReGN1KVClzOixNz8Oxu3E5
skwSkwTsTva/hZPBMGGSazZ9TBqT8frmjTXqzauVrfBM7zvVLuHZWn9v4l5kTbZKb3Z24Sqn
Wu5KptjjONrdXH9GyXZOeCtUxZ50+ibGPXHNGSGokayUPHOK+sq0fyr99KzYxxqraiyrtWGo
i+1l1q7uqhrIQK04lJtciVpcWcen5DIqlzAnh1HODTi/L8z9E+Ydb0nwaP6RKPvep/I6jFhW
p5rp5nRnGB6pmn90/wWbFJ7jz5GDmTN75hpFR2xMCihRcvjwpMj3TIsdOT0dDA5nFXgxLGDe
wM2I7i9kdS06G6aJ+KWlzM54aO83RLyj9xdPyNxtL6Hx4/e1HrnQ8DNlEwm39fBZPVR8y7Ep
NBSeM7m8qKZrQnvUo/66F5uZVPNvWO87hxPAz8Lcuc1aJ0S12JgfqNEzYFnA5ljmdtZpaWHk
cUwLHd4zIxzZpRNyYYkxc1FExJgsKmONea1YLFLTFgjJjEXNHAusYl8C8SonKdcfDiZGsRyT
isexMTaWe/khmvJT1ppE59y7tSnCUUVFHVPUN5iWRlLpxT2yo7Rkd0sYJc7xrE7DGJxLnKzN
gb81sS4eyF42mLfkbvQlF6TQ4ngqJtTU4w+udWp3Ybi2+91NJG1E8bFoxNkTY7z5pwJnOw05
mLaYE95RqV0p1isbpZ1tEnrGL7p0NqM+UPSWnyn/xdyRThQkIZ/kgEA=
--------------070407010503070006000506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070407010503070006000506--
