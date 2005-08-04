From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 04 Aug 2005 05:32:21 +0000
Subject: [lm-sensors] Re: [patch] pc87360 de-macro and code shrink
Message-Id: <2538186705080320316e6e8b80@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E87A0F.8060709@divsol.com>
In-Reply-To: <42E87A0F.8060709@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 8/3/05, Jim Cromie <jcromie@divsol.com> wrote:
> IIUC, the 'much better' is passing a *dev-attr,
> doing to_sensor_dev_attr() on it to get the full SDA
> in a typesafe manner, then using whatever new members
> you have added (ex index, and for sda2, nr also)
> 
> or have I missed something ?

Well the change affects more than sensors of course, and there is a
lot of code other places in the kernel with the same problem (and not
just for device_attribute), so I expect to see other structs out there
like sensor_device_attribute, but yes basically :-). Its much less
error prone than a void * as you say because of it's typesafe manner,
and doesn't require us to add anything to the sysfs attribute struct
itself.

> just to follow up,  rc4-mm1 has
> 
> struct sensor_device_attribute{
>         struct device_attribute dev_attr;
>         int index;
> };
> struct sensor_device_attribute_2 {
>         struct device_attribute dev_attr;
>         u8 index;
>         u8 nr;
> };

I never noticed that, looks like it originated in this patch:
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-July/013104.html.

Is sensor_device_attribute_2 useful to enough drivers (>1) to justify
putting it in hwmon-sysfs? Otherwise maybe its better off just being
defined by that driver itself...
 
> Ive used the 1st sda in my latest patch-set, are these structs 'stable' ?
Is anything stable in the kernel? I don't expect it to disappear
anytime soon though.

> .index is still there, with more room than is useful for file-entries in
> a sysfs dir-node.
> Any reason not to shorten the index, to 'reserve' another short ?

Hmm..that's an interesting proposition, what is the limit for the
number of sysfs attributes in a directory? It certainly doesn't make
any sense to use an int if a short will suffice for even the maximum.

Yani
