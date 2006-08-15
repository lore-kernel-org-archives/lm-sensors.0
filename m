From: david.c.hubbard@gmail.com (David Hubbard)
Date: Tue, 15 Aug 2006 00:09:47 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <4dfa50520608141709r2d4a0a00p95e7413a3b0a1375@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, Jean,

Jean, I have a request to make of the I2C mailing list. See below...

On 8/14/06, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Mark,
>
> > Added w83627hf, which should demonstrate how to do all the remaining
> > hwmon drivers.  There is more (ab)use of sysfs_remove_group() here to
> > make life easier.
>
> Yeah, I like it. Your approach deals nicely with chip-dependent files
> and it can be applied to all drivers as far as I can see.

The w83627ehf driver uses struct sensor_device_attribute instead of
struct device_attribute, and we've put them in arrays, so if I created
a struct attribute *w83627ehf_attributes, it would contain something
like &sda_sf3_arrays[0].device_attr, &sda_sf3_arrays[1].device_attr,
...

I think that would be ugly code. It would allow me to call
sysfs_create_group() just like Mark does, which I would do if I could
find a way. Is there a sysfs_create_* function that takes
sensor_device_attribute arrays instead? If I read correctly, no. :-(


@Jean:

I added some return value checks in w83627ehf_detect(). This is called
from i2c_isa_add_driver using driver->attach_adapter(&isa_adapter). So
I returned an error from w83627ehf_detect(), and was surprised to see
that the module silently succeeded, without fully creating the
w83627ehf sysfs interface. I looked deeper and found that
i2c_isa_add_driver() does not check the return value when calling its
driver->attach_adapter(). i2c_isa_add_driver() is called from
sensors_w83627ehf_init(), which is the module_init function.

I have attached a very short patch for drivers/i2c/busses/i2c-isa.c
which should fix the problem. Instead of returning 0, it returns the
result of driver->attach_adapter(). However, this may cause a great
deal of unexpected grief, considering how many drivers use this
function. So now I can either subscribe to the I2C mailing list for
this (I'd rather not), or I can hand you the patch and ask you to talk
to the I2C developers (easy for me, but...).

Which should it be? If you can pass it on to the I2C developers, I'll
continue with the w83627ehf driver and to check for errors from
device_create_file().

Thanks!
David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-isa_return_attach_adapter.patch
Type: application/octet-stream
Size: 629 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060814/7bd3d8ec/attachment.obj 
