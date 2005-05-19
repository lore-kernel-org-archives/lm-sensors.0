From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <25381867050428095072f8b2d8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 4/28/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Hi Yani,
> 
> On 4/28/05, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> > On 4/26/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > If void is added directly to the attribute structure that means that same
> > > attribute can not be shared between several instances of the same device
> > > -> unexpected. So far all attributes could be statically created.
> >
> > Dmitry: would you mind explaining this a bit more? Also is there
> > anywhere else you would suggest adding the callback specific void *
> > to? Perhaps creating some new structure(s) to track driver specific
> > data for each device?
> 
> Mosy of the code does something like that:
> 
> static DEVICE_ATTR(blah, 0644, blah_show, blah_store);
> and then
>          sysfs_create_file(mydev, &blah_device_attr);
> or qute often install it as a default driver/bus/device attribute.
> 
> In this case one structure is shared between several instances of
> driver model objects. With your changes people have to be aware that
> they have to allocate attributes dynamically and that they can't use
> bus/driver default attribute mechanism nor attribute_groups.
> 
> Actually I have toyed with attribute_array and attribute_array_group
> for some time. Greg did not like it mostly because there were no
> possible users. But it looks like bmcsensort and infiniband could use
> attribute arrays, so maybe he'll change his mind. With my patches you
> can make initial structure static, all synamic allocations go behind
> the scene.
> 
> attr_array.patch:
> http://marc.theaimsgroup.com/?l=linux-kernel&m1138239422686&q=p3
> 
> attr_group_array.patch:
> http://marc.theaimsgroup.com/?l=linux-kernel&m1138239422686&q=p4
> 
> One can use them like this (i8k laptop has 2 fans, this is a legacy SMM driver):
> 
> static ssize_t i8k_sysfs_fan_speed_show(struct kobject *kobj, unsigned
> int idx, char *buf)
>  {
>         int speed = i8k_get_fan_speed(idx);
>         return speed < 0 ? -EIO : sprintf(buf, "%d\n", speed);
> }
> 
> static struct enumerated_attr i8k_fan_attrs[] = {
>         __ATTR(state, 0644, i8k_sysfs_fan_show, i8k_sysfs_fan_set),
>         __ATTR(speed, 0444, i8k_sysfs_fan_speed_show, NULL),
>         __ATTR_NULL
> };
> 
> static struct attribute_group_array i8k_fan_attr_array = {
>         .name = "fan",
>         .attrs = i8k_fan_attrs,
> };
> ...
> err = sysfs_create_group_array(&i8k_device->dev.kobj, &i8k_fan_attr_array, num);
> 
> --
> Dmitry
> 
Hi Dmitry,

Yes attribute groups would certainly aid bmcsensors in terms of
getting rid of the static callbacks and replacing them with a few,
however in using an array it still has the limitation that bmcsensors
would have to set a limit on the number of sensors that it can see,
and in doing so allocate space that likely will never be used (most
ipmi bmcs have access to 10-40 sensors, but the odd few on high end
servers from people I've been in contact with have at least 60, and so
the current limit is 100).

Sorry my example bmcsensors diff was misleading in that it still used
an array, but a proper patch would change the array to a linked list.
The void * callback is a bit more flexible (and simpler) in that it
allows us to create an unlimited and non-predetermined number of sysfs
entries.

Thanks,
Yani
