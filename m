From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Sun, 20 May 2007 00:57:38 +0000
Subject: Re: [lm-sensors] get rid of i2c-isa - h now - fixes of w82627ehf
Message-Id: <4dfa50520705191757p9aea273o72b84223b9f1e56e@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_65819_21859819.1179622658900"
List-Id: <lm-sensors.vger.kernel.org>
References: <45F47B44.8010108@assembler.cz>
In-Reply-To: <45F47B44.8010108@assembler.cz>
To: lm-sensors@vger.kernel.org

------=_Part_65819_21859819.1179622658900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jean,

> Hi David,
>
> On Thu, 29 Mar 2007 12:13:29 -0700, David Hubbard wrote:
> > Here's a patch for your review.
>
> Sorry for the delay, here's my review. Next time please avoid patches
> as base64 attachments.

Gmail picks a bad encoding for .patch files, and I forgot to send them
as .patch.txt. Sorry :-)

> These are cleanups which do not belong to this patch.

I removed them.

(snip)
> >
> > -static int w83627ehf_detach_client(struct i2c_client *client)
> > +static int __devexit w83627ehf_remove(struct platform_device *pdev)
> >  {
> > -     struct w83627ehf_data *data = i2c_get_clientdata(client);
> > -     int err;
> > +     struct w83627ehf_data *data = platform_get_drvdata(pdev);
> >
> >       hwmon_device_unregister(data->class_dev);
> > -     w83627ehf_device_remove_files(&client->dev);
> > +     w83627ehf_device_remove_files(&pdev->dev);
> > +     platform_set_drvdata(pdev, NULL);
> >
> > -     if ((err = i2c_detach_client(client)))
> > -             return err;
> > -     release_region(client->addr + REGION_OFFSET, REGION_LENGTH);
>
> You shouldn't remove this. You requested the region in .probe(), you
> _must_ release it in .remove()!
>
> >       kfree(data);
>
> OTOH it's weird to free data here while you did not allocate it
> in .probe().

So I added release_region() to w83627ehf_remove(). I left the kfree()
in place (notice that the patch doesn't move it) even though I
modified the way the data was allocated, because it is the simplest
way of freeing the data. A more correct approach would be to get
pdev->dev.platform_data in sensors_w83627ehf_exit and free it there.
It does break the device driver model, and needs revision when the
driver is moved over to a Super-I/O bus. I added a comment noting
this.

> >
> >       return 0;
> >  }
> >
> > -static struct i2c_driver w83627ehf_driver = {
> > +static struct platform_driver w83627ehf_driver = {
> >       .driver = {
> >               .owner  = THIS_MODULE,
> > -             .name   = "w83627ehf",
> > +             .name   = DRVNAME,
> >       },
> > -     .attach_adapter = w83627ehf_detect,
> > -     .detach_client  = w83627ehf_detach_client,
> > +     .probe          = w83627ehf_probe,
> > +     .remove         = __devexit_p(w83627ehf_remove),
> >  };
> >
> > -static int __init w83627ehf_find(int sioaddr, unsigned short *addr)
> > +/* w83627ehf_superio_probe() looks for a '627 in the Super-I/O config space */
> > +static int __init w83627ehf_superio_probe(int sioaddr,
> > +                                       struct w83627ehf_data *data)
> >  {
> >       u16 val;
> >
> > -     REG = sioaddr;
> > -     VAL = sioaddr + 1;
> > -     superio_enter();
> > +     static const char * __initdata sio_names[] = {
> > +             "W83627EHF",
> > +             "W83627EHG",
> > +             "W83627DHG",
> > +     };
>
> This probably doesn't do what you think it does. Here the __initdata
> only applies to the pointers, not to the strings. So you aren't saving
> anything compared to putting the strings directly in the switch/case
> code.
>
> If you really want the strings themselves to be __initdata, then you
> have to define an array of arrays of chars, not an array of pointers:
>
>         static const char __initdata sio_names[][10] = {
>                 "W83627EHF",
>                 "W83627EHG",
>                 "W83627DHG",
>         };
>
> With the drawback that you have to be careful to size the buffers
> properly. gcc will unfortunately not complain if the trailing \0
> doesn't fit, so it seems safer to explicitly add it yourself. (I
> consider it a bug in gcc.)
>
> Quite frankly, I don't think this is worth the trouble, and I would put
> the strings in the code directly.

I revised the code to declare three separate __initdata strings. This
should work.

> > +
> > +     const char * sio_name;
> >
> > -     val = (superio_inb(SIO_REG_DEVID) << 8)
> > -         | superio_inb(SIO_REG_DEVID + 1);
> > +     data->sioreg = sioaddr;
> > +
> > +     superio_enter(data->sioreg);
> > +
> > +     val = (superio_inb(data->sioreg, SIO_REG_DEVID) << 8)
> > +         | superio_inb(data->sioreg, SIO_REG_DEVID + 1);
> >       switch (val & SIO_ID_MASK) {
> > -     case SIO_W83627DHG_ID:
> > -             w83627ehf_num_in = 9;
> > -             break;
> >       case SIO_W83627EHF_ID:
> > +             data->kind = w83627ehf;
> > +             sio_name = sio_names[0];
> > +             break;
> >       case SIO_W83627EHG_ID:
> > -             w83627ehf_num_in = 10;
> > +             data->kind = w83627ehf;
> > +             sio_name = sio_names[1];
> > +             break;
> > +     case SIO_W83627DHG_ID:
> > +             data->kind = w83627dhg;
> > +             sio_name = sio_names[2];
> >               break;
> >       default:
> > -             printk(KERN_WARNING "w83627ehf: unsupported chip ID: 0x%04x\n",
> > +             pr_info(DRVNAME ": unsupported chip ID: 0x%04x\n",
> >                       val);
> > -             superio_exit();
> > +             superio_exit(data->sioreg);
> >               return -ENODEV;
> >       }
> >
> > -     superio_select(W83627EHF_LD_HWM);
> > -     val = (superio_inb(SIO_REG_ADDR) << 8)
> > -         | superio_inb(SIO_REG_ADDR + 1);
> > -     *addr = val & REGION_ALIGNMENT;
> > -     if (*addr == 0) {
> > -             superio_exit();
> > +     /* we have known chip find the HWMON base */
> > +
> > +     superio_select(data->sioreg, W83627EHF_LD_HWM);
> > +     val = (superio_inb(data->sioreg, SIO_REG_ADDR) << 8)
> > +         | superio_inb(data->sioreg, SIO_REG_ADDR + 1);
> > +     data->addr = val & REGION_ALIGNMENT;
> > +     if (data->addr == 0) {
> > +             superio_exit(data->sioreg);
>
> Note for a future patch: it would be user-friendly to log the reason
> why we're exiting here.

I am sending four patches this time. They apply to 2.6.22-rc2 and the
third adds a warning here, as you suggest.

> >               return -ENODEV;
> >       }
> >
> >       /* Activate logical device if needed */
> > -     val = superio_inb(SIO_REG_ENABLE);
> > +     val = superio_inb(data->sioreg, SIO_REG_ENABLE);
> >       if (!(val & 0x01))
> > -             superio_outb(SIO_REG_ENABLE, val | 0x01);
> > +             superio_outb(data->sioreg, SIO_REG_ENABLE, val | 0x01);
>
> Note for a future patch: it would be user-friendly to warn that the
> device was forcibly enabled and that the readings may not make sense.

Patch 03 adds a warning here also.

> >
> > -     superio_exit();
> > +     superio_exit(data->sioreg);
> > +     pr_info(DRVNAME ": Found %s chip at %#x\n",
> > +             sio_name, data->addr);
> >       return 0;
> >  }
> >
> > +/* when Super-I/O functions move to a separate file, the Super-I/O
> > + * bus will manage the lifetime of the device and the w83627ehf driver
> > + * but since we platform_device_alloc(), we must keep track of the device */
>
> The "and the w83627ehf driver" part of your sentence doesn't make much
> sense and should be removed? Either that, or a part is missing.

You're right. I updated the comment.

>
> > +struct platform_device * pdev;
>
> Should be declared static. Usually we leave no space between the "*"
> and the variable name.

Fixed.

> > +
> >  static int __init sensors_w83627ehf_init(void)
> >  {
> > -     if (w83627ehf_find(0x2e, &address)
> > -      && w83627ehf_find(0x4e, &address))
> > -             return -ENODEV;
> > +     int err;
> > +     struct resource res;
> > +     struct w83627ehf_data *data;
> > +
> > +     if (!(data = kzalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
> > +             err = -ENOMEM;
> > +             goto exit;
> > +     }
>
> This is an interesting approach. I did it differently in the other
> drivers. Your way saves some memory and some code, but OTOH it breaks
> the device driver model. The platform-specific data is supposed to be
> stored in dev.platform_data, NOT dev.driver_data. The code which
> instantiates the device isn't supposed to know how the driver is
> implemented. Nothing prevents a given device from being supported by
> more than one driver!
>
> So setting dev.driver_dat before .probe() is called sounds bad, and I
> suspect we will have to move this part to the .probe() function once
> we have a superio subsystem, anyway. So we might as well do it now.
> What do you think?

Yes, I've changed the code to use dev.platform_data instead of
dev.driver_data. I guess I was uncomfortable with dev.platform_data
because I looked at the function platform_device_add_data():
int platform_device_add_data(struct platform_device *pdev, const void
*data, size_t size)
{
        void *d;

        d = kmalloc(size, GFP_KERNEL);
        if (d) {
                memcpy(d, data, size);
                pdev->dev.platform_data = d;
        }
        return d ? 0 : -ENOMEM;
}
EXPORT_SYMBOL_GPL(platform_device_add_data);

If pdev->dev.platform_data is non-null on entry to this function it
does not warn, it just leaks memory. (Example: a broken driver calls
platform_device_add_data() twice in a row.) Or, I have misunderstood
the function.

Is this a bug in platform.c? I notice you just modify
pdev->dev.platform_data directly in w83627hf.c (2.6.22-rc2).

Either way, the driver needs revision in the future when devices are
probed from a Super-I/O bus driver.

> > +
> > +     /* initialize data->kind, data->sioreg, and data->addr.
> > +      *
> > +      * when Super-I/O functions move to a separate file, the Super-I/O
> > +      * driver will probe 0x23 and 0x4e and auto-detect the presence of a
>
> Typo: 0x2e, not Ox23.

Good catch. Fixed.

> > +      * w83627ehf hardware monitor, and call probe() */
> > +     if (w83627ehf_superio_probe(0x2e, data) &&
> > +         w83627ehf_superio_probe(0x4e, data)) {
> > +             err = -ENODEV;
> > +             goto exit_free;
> > +     }
> >
> > -     return i2c_isa_add_driver(&w83627ehf_driver);
> > +     if ((err = platform_driver_register(&w83627ehf_driver))!=0)
> > +             goto exit_free;
>
> Please remove the "!=0".

When I do that, I get the following warning:

  CC [M]  drivers/hwmon/w83627ehf.o
drivers/hwmon/w83627ehf.c: In function 'sensors_w83627ehf_init':
drivers/hwmon/w83627ehf.c:1428: warning: suggest parentheses around
assignment used as truth value

So for now, the !=0 is still there, but I also added a comment.

> > +
> > +     if (!(pdev = platform_device_alloc(DRVNAME, data->addr))) {
> > +             err = -ENOMEM;
> > +             printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> > +             goto exit_unregister;
> > +     }
> > +
> > +     platform_set_drvdata(pdev, data);
> > +
> > +     memset(&res, 0, sizeof(res));
> > +     data->name = w83627ehf_device_names[data->kind];
> > +     res.name = data->name;
> > +     res.start = data->addr + REGION_OFFSET;
> > +     res.end   = data->addr + REGION_OFFSET + REGION_LENGTH - 1;
>
> No alignment in code blocks please.

Fixed.

> > +     res.flags = IORESOURCE_IO;
> > +     err = platform_device_add_resources(pdev, &res, 1);
> > +     if (err) {
> > +             printk(KERN_ERR DRVNAME ": Device resource addition failed "
> > +                    "(%d)\n", err);
> > +             goto exit_device_put;
> > +     }
> > +
> > +     /* platform_device_add calls probe() */
> > +     err = platform_device_add(pdev);
> > +     if (err) {
> > +             printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
> > +                    err);
> > +             goto exit_device_put;
> > +     }
> > +
> > +     return 0;
> > +
> > +exit_device_put:
> > +     pdev->dev.platform_data = NULL;
> > +     platform_device_put(pdev);
> > +exit_unregister:
> > +     platform_driver_unregister(&w83627ehf_driver);
> > +exit_free:
> > +     kfree(data);
> > +exit:
> > +     return err;
> >  }
> >
> >  static void __exit sensors_w83627ehf_exit(void)
> >  {
> > -     i2c_isa_del_driver(&w83627ehf_driver);
> > +     /* when Super-I/O functions move to a separate file, devices
> > +      * will be unregistered before unloading the module.
>
> Not true. When Super-I/O handling is moved to a separate module,
> devices will live their life independently from a driver being loaded
> for them or not. So devices will survive the w83627ehf driver unloading.

Thank you for (patiently!) getting this through my head. So, I fixed
the comment. I'll try to keep it from creeping in again. ;-)

> > +      *
> > +      * for now, only one device is added in sensors_w83627ehf_init */
> > +     platform_device_unregister(pdev);
> > +     platform_driver_unregister(&w83627ehf_driver);
> >  }
> >
> >  MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");
> > --- linux-2.6.21-rc5/drivers/hwmon/Kconfig    2007-03-28 17:25:43.000000000 -0700
> > +++ linux-2.6.21-rc5/drivers/hwmon/Kconfig    2007-03-28 20:50:11.000000000 -0700
> > @@ -527,7 +527,6 @@
> >  config SENSORS_W83793
> >       tristate "Winbond W83793"
> >       depends on HWMON && I2C && EXPERIMENTAL
> > -     select HWMON_VID
> >       help
> >         If you say yes here you get support for the Winbond W83793
> >         hardware monitoring chip.
>
> You definitely don't want to do that.

Patch problems here stemmed from using the wrong file as the
"original." Fixed. Note that there are Kconfig changes in both patch
01 and patch 02.

> > @@ -560,17 +559,15 @@
> >         will be called w83627hf.
> >
> >  config SENSORS_W83627EHF
> > -     tristate "Winbond W83627EHF"
> > -     depends on HWMON && I2C && EXPERIMENTAL
> > -     select I2C_ISA
> > +     tristate "Winbond W83627EHF/DHG"
> > +     depends on HWMON && EXPERIMENTAL
> >       help
> > -       If you say yes here you get preliminary support for the hardware
> > -       monitoring functionality of the Winbond W83627EHF Super-I/O chip.
> > -       Only fan and temperature inputs are supported at the moment, while
> > -       the chip does much more than that.
> > +       If you say yes here you get support for the hardware
> > +       monitoring functionality of the Winbond W83627EHF/DHG Super-I/O chip.
> >
> >         This driver also supports the W83627EHG, which is the lead-free
> > -       version of the W83627EHF.
> > +       version of the W83627EHF. The driver also supports the W83627DHG,
> > +       which is a version suited for specific Intel processor sensing (PECI).
> >
> >         This driver can also be built as a module.  If so, the module
> >         will be called w83627ehf.
>
> Most of this doesn't belong to this patch and should be moved to a
> separate patch.

So it's now patch 01. The stuff that belongs in patch 02 is (I think)
now all in patch 02. Patch 03 revises the error handling in a couple
of places to give more meaningful error messages. Patch 04 fixes a
long-standing bug where the driver outputs "Increasing fan 4 clock
divider from 4 to 8" and fills up the kernel message log.

Please review when you get time.

Thanks,
David

------=_Part_65819_21859819.1179622658900
Content-Type: text/plain; 
	name=01-kconfig-w83627ehf-new-chips-supported.patch.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1wu526v
Content-Disposition: attachment;
	filename="01-kconfig-w83627ehf-new-chips-supported.patch.txt"

QWRkIGRlc2NyaXB0aW9ucyBmb3IgdzgzNjI3ZWhnIGFuZCB3ODM2MjdkaGcgY2hpcHMgdG8gS2Nv
bmZpZwoKU2lnbmVkLW9mZi1ieTogRGF2aWQgSHViYmFyZCA8ZGF2aWQuYy5odWJiYXJkQGdtYWls
LmNvbT4KCkluZGV4OiBsaW51eC0yLjYuMjItcmMyL2RyaXZlcnMvaHdtb24vS2NvbmZpZwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSBsaW51eC0yLjYuMjItcmMyL2RyaXZlcnMvaHdtb24vS2NvbmZpZwkyMDA3LTA1
LTE3IDExOjAxOjIzLjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42LjIyLXJjMi9kcml2ZXJz
L2h3bW9uL0tjb25maWcJMjAwNy0wNS0xNyAxMToyMDo1Mi4wMDAwMDAwMDAgLTA3MDAKQEAgLTU4
NCwxNyArNTg0LDE3IEBACiAJICB3aWxsIGJlIGNhbGxlZCB3ODM2MjdoZi4KIAogY29uZmlnIFNF
TlNPUlNfVzgzNjI3RUhGCi0JdHJpc3RhdGUgIldpbmJvbmQgVzgzNjI3RUhGIgorCXRyaXN0YXRl
ICJXaW5ib25kIFc4MzYyN0VIRi9ESEciCiAJZGVwZW5kcyBvbiBJMkMgJiYgRVhQRVJJTUVOVEFM
CiAJc2VsZWN0IEkyQ19JU0EKIAloZWxwCi0JICBJZiB5b3Ugc2F5IHllcyBoZXJlIHlvdSBnZXQg
cHJlbGltaW5hcnkgc3VwcG9ydCBmb3IgdGhlIGhhcmR3YXJlCi0JICBtb25pdG9yaW5nIGZ1bmN0
aW9uYWxpdHkgb2YgdGhlIFdpbmJvbmQgVzgzNjI3RUhGIFN1cGVyLUkvTyBjaGlwLgotCSAgT25s
eSBmYW4gYW5kIHRlbXBlcmF0dXJlIGlucHV0cyBhcmUgc3VwcG9ydGVkIGF0IHRoZSBtb21lbnQs
IHdoaWxlCi0JICB0aGUgY2hpcCBkb2VzIG11Y2ggbW9yZSB0aGFuIHRoYXQuCisJICBJZiB5b3Ug
c2F5IHllcyBoZXJlIHlvdSBnZXQgc3VwcG9ydCBmb3IgdGhlIGhhcmR3YXJlCisJICBtb25pdG9y
aW5nIGZ1bmN0aW9uYWxpdHkgb2YgdGhlIFdpbmJvbmQgVzgzNjI3RUhGL0RIRyBTdXBlci1JL08g
Y2hpcC4KIAogCSAgVGhpcyBkcml2ZXIgYWxzbyBzdXBwb3J0cyB0aGUgVzgzNjI3RUhHLCB3aGlj
aCBpcyB0aGUgbGVhZC1mcmVlCi0JICB2ZXJzaW9uIG9mIHRoZSBXODM2MjdFSEYuCisJICB2ZXJz
aW9uIG9mIHRoZSBXODM2MjdFSEYuIFRoZSBkcml2ZXIgYWxzbyBzdXBwb3J0cyB0aGUgVzgzNjI3
REhHLAorCSAgd2hpY2ggaXMgYSBzaW1pbGFyIGNoaXAgc3VpdGVkIGZvciBzcGVjaWZpYyBJbnRl
bCBwcm9jZXNzb3JzIHRoYXQKKwkgIHVzZSBQRUNJIHN1Y2ggYXMgdGhlIENvcmUgMiBEdW8uCiAK
IAkgIFRoaXMgZHJpdmVyIGNhbiBhbHNvIGJlIGJ1aWx0IGFzIGEgbW9kdWxlLiAgSWYgc28sIHRo
ZSBtb2R1bGUKIAkgIHdpbGwgYmUgY2FsbGVkIHc4MzYyN2VoZi4K
------=_Part_65819_21859819.1179622658900
Content-Type: text/plain; 
	name=02-w83627ehf-convert-to-platform-driver.patch.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1wu700m
Content-Disposition: attachment;
	filename="02-w83627ehf-convert-to-platform-driver.patch.txt"

VGhpcyBwYXRjaCByZW1vdmVzIGkyYy1pc2EgZnJvbSB0aGUgdzgzNjI3ZWhmIGRyaXZlciwgYW5k
IHVzZXMKYSBwbGF0Zm9ybSBkcml2ZXIgaW5zdGVhZC4KClNpZ25lZC1vZmYtYnk6IERhdmlkIEh1
YmJhcmQgPGRhdmlkLmMuaHViYmFyZEBnbWFpbC5jb20+CgpJbmRleDogbGludXgtMi42LjIyLXJj
Mi9kcml2ZXJzL2h3bW9uL3c4MzYyN2VoZi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi4yMi1y
YzIvZHJpdmVycy9od21vbi93ODM2MjdlaGYuYwkyMDA3LTA1LTE3IDE0OjExOjI4LjAwMDAwMDAw
MCAtMDcwMAorKysgbGludXgtMi42LjIyLXJjMi9kcml2ZXJzL2h3bW9uL3c4MzYyN2VoZi5jCTIw
MDctMDUtMTkgMTc6Mjk6MjEuMDAwMDAwMDAwIC0wNzAwCkBAIC00MSw4ICs0MSw4IEBACiAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+CiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPgogI2luY2x1ZGUg
PGxpbnV4L3NsYWIuaD4KLSNpbmNsdWRlIDxsaW51eC9pMmMuaD4KLSNpbmNsdWRlIDxsaW51eC9p
MmMtaXNhLmg+CisjaW5jbHVkZSA8bGludXgvamlmZmllcy5oPgorI2luY2x1ZGUgPGxpbnV4L3Bs
YXRmb3JtX2RldmljZS5oPgogI2luY2x1ZGUgPGxpbnV4L2h3bW9uLmg+CiAjaW5jbHVkZSA8bGlu
dXgvaHdtb24tc3lzZnMuaD4KICNpbmNsdWRlIDxsaW51eC9lcnIuaD4KQEAgLTUwLDI1ICs1MCwx
OSBAQAogI2luY2x1ZGUgPGFzbS9pby5oPgogI2luY2x1ZGUgImxtNzUuaCIKIAotLyogVGhlIGFj
dHVhbCBJU0EgYWRkcmVzcyBpcyByZWFkIGZyb20gU3VwZXItSS9PIGNvbmZpZ3VyYXRpb24gc3Bh
Y2UgKi8KLXN0YXRpYyB1bnNpZ25lZCBzaG9ydCBhZGRyZXNzOworZW51bSBraW5kcyB7IHc4MzYy
N2VoZiwgdzgzNjI3ZGhnIH07CiAKLS8qCi0gKiBTdXBlci1JL08gY29uc3RhbnRzIGFuZCBmdW5j
dGlvbnMKLSAqLworLyogdXNlZCB0byBzZXQgZGF0YS0+bmFtZSA9IHc4MzYyN2VoZl9kZXZpY2Vf
bmFtZXNbZGF0YS0+a2luZF0gKi8KK3N0YXRpYyBjb25zdCBjaGFyICogdzgzNjI3ZWhmX2Rldmlj
ZV9uYW1lc1tdID0geworCSJ3ODM2MjdlaGYiLAorCSJ3ODM2MjdkaGciLAorfTsKKworI2RlZmlu
ZSBEUlZOQU1FICJ3ODM2MjdlaGYiCiAKIC8qCi0gKiBUaGUgdGhyZWUgZm9sbG93aW5nIGdsb2Jh
bHMgYXJlIGluaXRpYWxpemVkIGluIHc4MzYyN2VoZl9maW5kKCksIGJlZm9yZQotICogdGhlIGky
Yy1pc2EgZGV2aWNlIGlzIGNyZWF0ZWQuIE90aGVyd2lzZSwgdGhleSBjb3VsZCBiZSBzdG9yZWQg
aW4KLSAqIHc4MzYyN2VoZl9kYXRhLiBUaGlzIGlzIHVnbHksIGJ1dCBuZWNlc3NhcnksIGFuZCB3
aGVuIHRoZSBkcml2ZXIgaXMgbmV4dAotICogdXBkYXRlZCB0byBiZWNvbWUgYSBwbGF0Zm9ybSBk
cml2ZXIsIHRoZSBnbG9iYWxzIHdpbGwgZGlzYXBwZWFyLgorICogU3VwZXItSS9PIGNvbnN0YW50
cyBhbmQgZnVuY3Rpb25zCiAgKi8KLXN0YXRpYyBpbnQgUkVHOwkJLyogVGhlIHJlZ2lzdGVyIHRv
IHJlYWQvd3JpdGUgKi8KLXN0YXRpYyBpbnQgVkFMOwkJLyogVGhlIHZhbHVlIHRvIHJlYWQvd3Jp
dGUgKi8KLS8qIFRoZSB3ODM2MjdlaGYvZWhnIGhhdmUgMTAgdm9sdGFnZSBpbnB1dHMsIGJ1dCB0
aGUgdzgzNjI3ZGhnIGhhcyA5LiBUaGlzCi0gKiB2YWx1ZSBpcyBhbHNvIHVzZWQgaW4gdzgzNjI3
ZWhmX2RldGVjdCgpIHRvIGV4cG9ydCBhIGRldmljZSBuYW1lIGluIHN5c2ZzCi0gKiAoZS5nLiB3
ODM2MjdlaGYgb3IgdzgzNjI3ZGhnKSAqLwotc3RhdGljIGludCB3ODM2MjdlaGZfbnVtX2luOwog
CiAjZGVmaW5lIFc4MzYyN0VIRl9MRF9IV00JMHgwYgogCkBAIC04Myw0NyArNzcsNDcgQEAKICNk
ZWZpbmUgU0lPX0lEX01BU0sJCTB4RkZGMAogCiBzdGF0aWMgaW5saW5lIHZvaWQKLXN1cGVyaW9f
b3V0YihpbnQgcmVnLCBpbnQgdmFsKQorc3VwZXJpb19vdXRiKGludCBpb3JlZywgaW50IHJlZywg
aW50IHZhbCkKIHsKLQlvdXRiKHJlZywgUkVHKTsKLQlvdXRiKHZhbCwgVkFMKTsKKwlvdXRiKHJl
ZywgaW9yZWcpOworCW91dGIodmFsLCBpb3JlZyArIDEpOwogfQogCiBzdGF0aWMgaW5saW5lIGlu
dAotc3VwZXJpb19pbmIoaW50IHJlZykKK3N1cGVyaW9faW5iKGludCBpb3JlZywgaW50IHJlZykK
IHsKLQlvdXRiKHJlZywgUkVHKTsKLQlyZXR1cm4gaW5iKFZBTCk7CisJb3V0YihyZWcsIGlvcmVn
KTsKKwlyZXR1cm4gaW5iKGlvcmVnICsgMSk7CiB9CiAKIHN0YXRpYyBpbmxpbmUgdm9pZAotc3Vw
ZXJpb19zZWxlY3QoaW50IGxkKQorc3VwZXJpb19zZWxlY3QoaW50IGlvcmVnLCBpbnQgbGQpCiB7
Ci0Jb3V0YihTSU9fUkVHX0xEU0VMLCBSRUcpOwotCW91dGIobGQsIFZBTCk7CisJb3V0YihTSU9f
UkVHX0xEU0VMLCBpb3JlZyk7CisJb3V0YihsZCwgaW9yZWcgKyAxKTsKIH0KIAogc3RhdGljIGlu
bGluZSB2b2lkCi1zdXBlcmlvX2VudGVyKHZvaWQpCitzdXBlcmlvX2VudGVyKGludCBpb3JlZykK
IHsKLQlvdXRiKDB4ODcsIFJFRyk7Ci0Jb3V0YigweDg3LCBSRUcpOworCW91dGIoMHg4NywgaW9y
ZWcpOworCW91dGIoMHg4NywgaW9yZWcpOwogfQogCiBzdGF0aWMgaW5saW5lIHZvaWQKLXN1cGVy
aW9fZXhpdCh2b2lkKQorc3VwZXJpb19leGl0KGludCBpb3JlZykKIHsKLQlvdXRiKDB4MDIsIFJF
Ryk7Ci0Jb3V0YigweDAyLCBWQUwpOworCW91dGIoMHgwMiwgaW9yZWcpOworCW91dGIoMHgwMiwg
aW9yZWcgKyAxKTsKIH0KIAogLyoKICAqIElTQSBjb25zdGFudHMKICAqLwogCi0jZGVmaW5lIElP
UkVHSU9OX0FMSUdOTUVOVAl+NwotI2RlZmluZSBJT1JFR0lPTl9PRkZTRVQJCTUKLSNkZWZpbmUg
SU9SRUdJT05fTEVOR1RICQkyCisjZGVmaW5lIFJFR0lPTl9BTElHTk1FTlQJfjcKKyNkZWZpbmUg
UkVHSU9OX09GRlNFVAkJNQorI2RlZmluZSBSRUdJT05fTEVOR1RICQkyCiAjZGVmaW5lIEFERFJf
UkVHX09GRlNFVAkJNQogI2RlZmluZSBEQVRBX1JFR19PRkZTRVQJCTYKIApAQCAtMjU1LDcgKzI0
OSwxMSBAQAogICovCiAKIHN0cnVjdCB3ODM2MjdlaGZfZGF0YSB7Ci0Jc3RydWN0IGkyY19jbGll
bnQgY2xpZW50OworCWludCBzaW9yZWc7CisJZW51bSBraW5kcyBraW5kOworCWludCBhZGRyOwkv
KiBJTyBiYXNlIG9mIGh3IG1vbml0b3IgYmxvY2sgKi8KKwljb25zdCBjaGFyICpuYW1lOworCiAJ
c3RydWN0IGNsYXNzX2RldmljZSAqY2xhc3NfZGV2OwogCXN0cnVjdCBtdXRleCBsb2NrOwogCkBA
IC0yNjQsNiArMjYyLDcgQEAKIAl1bnNpZ25lZCBsb25nIGxhc3RfdXBkYXRlZDsJLyogSW4gamlm
ZmllcyAqLwogCiAJLyogUmVnaXN0ZXIgdmFsdWVzICovCisJdTggaW5fbnVtOwkJLyogbnVtYmVy
IG9mIGluIGlucHV0cyB3ZSBoYXZlICovCiAJdTggaW5bMTBdOwkJLyogUmVnaXN0ZXIgdmFsdWUg
Ki8KIAl1OCBpbl9tYXhbMTBdOwkJLyogUmVnaXN0ZXIgdmFsdWUgKi8KIAl1OCBpbl9taW5bMTBd
OwkJLyogUmVnaXN0ZXIgdmFsdWUgKi8KQEAgLTMwMywxMjEgKzMwMiwxMTcgQEAKICAgIG5vdGhp
bmcgZm9yIHJlZ2lzdGVycyB3aGljaCBsaXZlIGluIGJhbmsgMC4gRm9yIG90aGVycywgdGhleSBy
ZXNwZWN0aXZlbHkKICAgIHNldCB0aGUgYmFuayByZWdpc3RlciB0byB0aGUgY29ycmVjdCB2YWx1
ZSAoYmVmb3JlIHRoZSByZWdpc3RlciBpcwogICAgYWNjZXNzZWQpLCBhbmQgYmFjayB0byAwIChh
ZnRlcndhcmRzKS4gKi8KLXN0YXRpYyBpbmxpbmUgdm9pZCB3ODM2MjdlaGZfc2V0X2Jhbmsoc3Ry
dWN0IGkyY19jbGllbnQgKmNsaWVudCwgdTE2IHJlZykKK3N0YXRpYyBpbmxpbmUgdm9pZCB3ODM2
MjdlaGZfc2V0X2Jhbmsoc3RydWN0IHc4MzYyN2VoZl9kYXRhICpkYXRhLCB1MTYgcmVnKQogewog
CWlmIChyZWcgJiAweGZmMDApIHsKLQkJb3V0Yl9wKFc4MzYyN0VIRl9SRUdfQkFOSywgY2xpZW50
LT5hZGRyICsgQUREUl9SRUdfT0ZGU0VUKTsKLQkJb3V0Yl9wKHJlZyA+PiA4LCBjbGllbnQtPmFk
ZHIgKyBEQVRBX1JFR19PRkZTRVQpOworCQlvdXRiX3AoVzgzNjI3RUhGX1JFR19CQU5LLCBkYXRh
LT5hZGRyICsgQUREUl9SRUdfT0ZGU0VUKTsKKwkJb3V0Yl9wKHJlZyA+PiA4LCBkYXRhLT5hZGRy
ICsgREFUQV9SRUdfT0ZGU0VUKTsKIAl9CiB9CiAKLXN0YXRpYyBpbmxpbmUgdm9pZCB3ODM2Mjdl
aGZfcmVzZXRfYmFuayhzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LCB1MTYgcmVnKQorc3RhdGlj
IGlubGluZSB2b2lkIHc4MzYyN2VoZl9yZXNldF9iYW5rKHN0cnVjdCB3ODM2MjdlaGZfZGF0YSAq
ZGF0YSwgdTE2IHJlZykKIHsKIAlpZiAocmVnICYgMHhmZjAwKSB7Ci0JCW91dGJfcChXODM2MjdF
SEZfUkVHX0JBTkssIGNsaWVudC0+YWRkciArIEFERFJfUkVHX09GRlNFVCk7Ci0JCW91dGJfcCgw
LCBjbGllbnQtPmFkZHIgKyBEQVRBX1JFR19PRkZTRVQpOworCQlvdXRiX3AoVzgzNjI3RUhGX1JF
R19CQU5LLCBkYXRhLT5hZGRyICsgQUREUl9SRUdfT0ZGU0VUKTsKKwkJb3V0Yl9wKDAsIGRhdGEt
PmFkZHIgKyBEQVRBX1JFR19PRkZTRVQpOwogCX0KIH0KIAotc3RhdGljIHUxNiB3ODM2MjdlaGZf
cmVhZF92YWx1ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LCB1MTYgcmVnKQorc3RhdGljIHUx
NiB3ODM2MjdlaGZfcmVhZF92YWx1ZShzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEgKmRhdGEsIHUxNiBy
ZWcpCiB7Ci0Jc3RydWN0IHc4MzYyN2VoZl9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRh
KGNsaWVudCk7CiAJaW50IHJlcywgd29yZF9zaXplZCA9IGlzX3dvcmRfc2l6ZWQocmVnKTsKIAog
CW11dGV4X2xvY2soJmRhdGEtPmxvY2spOwogCi0JdzgzNjI3ZWhmX3NldF9iYW5rKGNsaWVudCwg
cmVnKTsKLQlvdXRiX3AocmVnICYgMHhmZiwgY2xpZW50LT5hZGRyICsgQUREUl9SRUdfT0ZGU0VU
KTsKLQlyZXMgPSBpbmJfcChjbGllbnQtPmFkZHIgKyBEQVRBX1JFR19PRkZTRVQpOworCXc4MzYy
N2VoZl9zZXRfYmFuayhkYXRhLCByZWcpOworCW91dGJfcChyZWcgJiAweGZmLCBkYXRhLT5hZGRy
ICsgQUREUl9SRUdfT0ZGU0VUKTsKKwlyZXMgPSBpbmJfcChkYXRhLT5hZGRyICsgREFUQV9SRUdf
T0ZGU0VUKTsKIAlpZiAod29yZF9zaXplZCkgewogCQlvdXRiX3AoKHJlZyAmIDB4ZmYpICsgMSwK
LQkJICAgICAgIGNsaWVudC0+YWRkciArIEFERFJfUkVHX09GRlNFVCk7Ci0JCXJlcyA9IChyZXMg
PDwgOCkgKyBpbmJfcChjbGllbnQtPmFkZHIgKyBEQVRBX1JFR19PRkZTRVQpOworCQkgICAgICAg
ZGF0YS0+YWRkciArIEFERFJfUkVHX09GRlNFVCk7CisJCXJlcyA9IChyZXMgPDwgOCkgKyBpbmJf
cChkYXRhLT5hZGRyICsgREFUQV9SRUdfT0ZGU0VUKTsKIAl9Ci0JdzgzNjI3ZWhmX3Jlc2V0X2Jh
bmsoY2xpZW50LCByZWcpOworCXc4MzYyN2VoZl9yZXNldF9iYW5rKGRhdGEsIHJlZyk7CiAKIAlt
dXRleF91bmxvY2soJmRhdGEtPmxvY2spOwogCiAJcmV0dXJuIHJlczsKIH0KIAotc3RhdGljIGlu
dCB3ODM2MjdlaGZfd3JpdGVfdmFsdWUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwgdTE2IHJl
ZywgdTE2IHZhbHVlKQorc3RhdGljIGludCB3ODM2MjdlaGZfd3JpdGVfdmFsdWUoc3RydWN0IHc4
MzYyN2VoZl9kYXRhICpkYXRhLCB1MTYgcmVnLCB1MTYgdmFsdWUpCiB7Ci0Jc3RydWN0IHc4MzYy
N2VoZl9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CiAJaW50IHdvcmRf
c2l6ZWQgPSBpc193b3JkX3NpemVkKHJlZyk7CiAKIAltdXRleF9sb2NrKCZkYXRhLT5sb2NrKTsK
IAotCXc4MzYyN2VoZl9zZXRfYmFuayhjbGllbnQsIHJlZyk7Ci0Jb3V0Yl9wKHJlZyAmIDB4ZmYs
IGNsaWVudC0+YWRkciArIEFERFJfUkVHX09GRlNFVCk7CisJdzgzNjI3ZWhmX3NldF9iYW5rKGRh
dGEsIHJlZyk7CisJb3V0Yl9wKHJlZyAmIDB4ZmYsIGRhdGEtPmFkZHIgKyBBRERSX1JFR19PRkZT
RVQpOwogCWlmICh3b3JkX3NpemVkKSB7Ci0JCW91dGJfcCh2YWx1ZSA+PiA4LCBjbGllbnQtPmFk
ZHIgKyBEQVRBX1JFR19PRkZTRVQpOworCQlvdXRiX3AodmFsdWUgPj4gOCwgZGF0YS0+YWRkciAr
IERBVEFfUkVHX09GRlNFVCk7CiAJCW91dGJfcCgocmVnICYgMHhmZikgKyAxLAotCQkgICAgICAg
Y2xpZW50LT5hZGRyICsgQUREUl9SRUdfT0ZGU0VUKTsKKwkJICAgICAgIGRhdGEtPmFkZHIgKyBB
RERSX1JFR19PRkZTRVQpOwogCX0KLQlvdXRiX3AodmFsdWUgJiAweGZmLCBjbGllbnQtPmFkZHIg
KyBEQVRBX1JFR19PRkZTRVQpOwotCXc4MzYyN2VoZl9yZXNldF9iYW5rKGNsaWVudCwgcmVnKTsK
KwlvdXRiX3AodmFsdWUgJiAweGZmLCBkYXRhLT5hZGRyICsgREFUQV9SRUdfT0ZGU0VUKTsKKwl3
ODM2MjdlaGZfcmVzZXRfYmFuayhkYXRhLCByZWcpOwogCiAJbXV0ZXhfdW5sb2NrKCZkYXRhLT5s
b2NrKTsKIAlyZXR1cm4gMDsKIH0KIAogLyogVGhpcyBmdW5jdGlvbiBhc3N1bWVzIHRoYXQgdGhl
IGNhbGxlciBob2xkcyBkYXRhLT51cGRhdGVfbG9jayAqLwotc3RhdGljIHZvaWQgdzgzNjI3ZWhm
X3dyaXRlX2Zhbl9kaXYoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwgaW50IG5yKQorc3RhdGlj
IHZvaWQgdzgzNjI3ZWhmX3dyaXRlX2Zhbl9kaXYoc3RydWN0IHc4MzYyN2VoZl9kYXRhICpkYXRh
LCBpbnQgbnIpCiB7Ci0Jc3RydWN0IHc4MzYyN2VoZl9kYXRhICpkYXRhID0gaTJjX2dldF9jbGll
bnRkYXRhKGNsaWVudCk7CiAJdTggcmVnOwogCiAJc3dpdGNoIChucikgewogCWNhc2UgMDoKLQkJ
cmVnID0gKHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNjI3RUhGX1JFR19GQU5ESVYx
KSAmIDB4Y2YpCisJCXJlZyA9ICh3ODM2MjdlaGZfcmVhZF92YWx1ZShkYXRhLCBXODM2MjdFSEZf
UkVHX0ZBTkRJVjEpICYgMHhjZikKIAkJICAgIHwgKChkYXRhLT5mYW5fZGl2WzBdICYgMHgwMykg
PDwgNCk7CiAJCS8qIGZhbjUgaW5wdXQgY29udHJvbCBiaXQgaXMgd3JpdGUgb25seSwgY29tcHV0
ZSB0aGUgdmFsdWUgKi8KIAkJcmVnIHw9IChkYXRhLT5oYXNfZmFuICYgKDEgPDwgNCkpID8gMSA6
IDA7Ci0JCXc4MzYyN2VoZl93cml0ZV92YWx1ZShjbGllbnQsIFc4MzYyN0VIRl9SRUdfRkFORElW
MSwgcmVnKTsKLQkJcmVnID0gKHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNjI3RUhG
X1JFR19WQkFUKSAmIDB4ZGYpCisJCXc4MzYyN2VoZl93cml0ZV92YWx1ZShkYXRhLCBXODM2MjdF
SEZfUkVHX0ZBTkRJVjEsIHJlZyk7CisJCXJlZyA9ICh3ODM2MjdlaGZfcmVhZF92YWx1ZShkYXRh
LCBXODM2MjdFSEZfUkVHX1ZCQVQpICYgMHhkZikKIAkJICAgIHwgKChkYXRhLT5mYW5fZGl2WzBd
ICYgMHgwNCkgPDwgMyk7Ci0JCXc4MzYyN2VoZl93cml0ZV92YWx1ZShjbGllbnQsIFc4MzYyN0VI
Rl9SRUdfVkJBVCwgcmVnKTsKKwkJdzgzNjI3ZWhmX3dyaXRlX3ZhbHVlKGRhdGEsIFc4MzYyN0VI
Rl9SRUdfVkJBVCwgcmVnKTsKIAkJYnJlYWs7CiAJY2FzZSAxOgotCQlyZWcgPSAodzgzNjI3ZWhm
X3JlYWRfdmFsdWUoY2xpZW50LCBXODM2MjdFSEZfUkVHX0ZBTkRJVjEpICYgMHgzZikKKwkJcmVn
ID0gKHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGRhdGEsIFc4MzYyN0VIRl9SRUdfRkFORElWMSkgJiAw
eDNmKQogCQkgICAgfCAoKGRhdGEtPmZhbl9kaXZbMV0gJiAweDAzKSA8PCA2KTsKIAkJLyogZmFu
NSBpbnB1dCBjb250cm9sIGJpdCBpcyB3cml0ZSBvbmx5LCBjb21wdXRlIHRoZSB2YWx1ZSAqLwog
CQlyZWcgfD0gKGRhdGEtPmhhc19mYW4gJiAoMSA8PCA0KSkgPyAxIDogMDsKLQkJdzgzNjI3ZWhm
X3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNjI3RUhGX1JFR19GQU5ESVYxLCByZWcpOwotCQlyZWcg
PSAodzgzNjI3ZWhmX3JlYWRfdmFsdWUoY2xpZW50LCBXODM2MjdFSEZfUkVHX1ZCQVQpICYgMHhi
ZikKKwkJdzgzNjI3ZWhmX3dyaXRlX3ZhbHVlKGRhdGEsIFc4MzYyN0VIRl9SRUdfRkFORElWMSwg
cmVnKTsKKwkJcmVnID0gKHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGRhdGEsIFc4MzYyN0VIRl9SRUdf
VkJBVCkgJiAweGJmKQogCQkgICAgfCAoKGRhdGEtPmZhbl9kaXZbMV0gJiAweDA0KSA8PCA0KTsK
LQkJdzgzNjI3ZWhmX3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNjI3RUhGX1JFR19WQkFULCByZWcp
OworCQl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoZGF0YSwgVzgzNjI3RUhGX1JFR19WQkFULCByZWcp
OwogCQlicmVhazsKIAljYXNlIDI6Ci0JCXJlZyA9ICh3ODM2MjdlaGZfcmVhZF92YWx1ZShjbGll
bnQsIFc4MzYyN0VIRl9SRUdfRkFORElWMikgJiAweDNmKQorCQlyZWcgPSAodzgzNjI3ZWhmX3Jl
YWRfdmFsdWUoZGF0YSwgVzgzNjI3RUhGX1JFR19GQU5ESVYyKSAmIDB4M2YpCiAJCSAgICB8ICgo
ZGF0YS0+ZmFuX2RpdlsyXSAmIDB4MDMpIDw8IDYpOwotCQl3ODM2MjdlaGZfd3JpdGVfdmFsdWUo
Y2xpZW50LCBXODM2MjdFSEZfUkVHX0ZBTkRJVjIsIHJlZyk7Ci0JCXJlZyA9ICh3ODM2MjdlaGZf
cmVhZF92YWx1ZShjbGllbnQsIFc4MzYyN0VIRl9SRUdfVkJBVCkgJiAweDdmKQorCQl3ODM2Mjdl
aGZfd3JpdGVfdmFsdWUoZGF0YSwgVzgzNjI3RUhGX1JFR19GQU5ESVYyLCByZWcpOworCQlyZWcg
PSAodzgzNjI3ZWhmX3JlYWRfdmFsdWUoZGF0YSwgVzgzNjI3RUhGX1JFR19WQkFUKSAmIDB4N2Yp
CiAJCSAgICB8ICgoZGF0YS0+ZmFuX2RpdlsyXSAmIDB4MDQpIDw8IDUpOwotCQl3ODM2MjdlaGZf
d3JpdGVfdmFsdWUoY2xpZW50LCBXODM2MjdFSEZfUkVHX1ZCQVQsIHJlZyk7CisJCXc4MzYyN2Vo
Zl93cml0ZV92YWx1ZShkYXRhLCBXODM2MjdFSEZfUkVHX1ZCQVQsIHJlZyk7CiAJCWJyZWFrOwog
CWNhc2UgMzoKLQkJcmVnID0gKHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNjI3RUhG
X1JFR19ESU9ERSkgJiAweGZjKQorCQlyZWcgPSAodzgzNjI3ZWhmX3JlYWRfdmFsdWUoZGF0YSwg
VzgzNjI3RUhGX1JFR19ESU9ERSkgJiAweGZjKQogCQkgICAgfCAoZGF0YS0+ZmFuX2RpdlszXSAm
IDB4MDMpOwotCQl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoY2xpZW50LCBXODM2MjdFSEZfUkVHX0RJ
T0RFLCByZWcpOwotCQlyZWcgPSAodzgzNjI3ZWhmX3JlYWRfdmFsdWUoY2xpZW50LCBXODM2MjdF
SEZfUkVHX1NNSV9PVlQpICYgMHg3ZikKKwkJdzgzNjI3ZWhmX3dyaXRlX3ZhbHVlKGRhdGEsIFc4
MzYyN0VIRl9SRUdfRElPREUsIHJlZyk7CisJCXJlZyA9ICh3ODM2MjdlaGZfcmVhZF92YWx1ZShk
YXRhLCBXODM2MjdFSEZfUkVHX1NNSV9PVlQpICYgMHg3ZikKIAkJICAgIHwgKChkYXRhLT5mYW5f
ZGl2WzNdICYgMHgwNCkgPDwgNSk7Ci0JCXc4MzYyN2VoZl93cml0ZV92YWx1ZShjbGllbnQsIFc4
MzYyN0VIRl9SRUdfU01JX09WVCwgcmVnKTsKKwkJdzgzNjI3ZWhmX3dyaXRlX3ZhbHVlKGRhdGEs
IFc4MzYyN0VIRl9SRUdfU01JX09WVCwgcmVnKTsKIAkJYnJlYWs7CiAJY2FzZSA0OgotCQlyZWcg
PSAodzgzNjI3ZWhmX3JlYWRfdmFsdWUoY2xpZW50LCBXODM2MjdFSEZfUkVHX0RJT0RFKSAmIDB4
NzMpCi0JCSAgICB8ICgoZGF0YS0+ZmFuX2Rpdls0XSAmIDB4MDMpIDw8IDIpCisJCXJlZyA9ICh3
ODM2MjdlaGZfcmVhZF92YWx1ZShkYXRhLCBXODM2MjdFSEZfUkVHX0RJT0RFKSAmIDB4NzMpCisJ
CSAgICB8ICgoZGF0YS0+ZmFuX2Rpdls0XSAmIDB4MDMpIDw8IDMpCiAJCSAgICB8ICgoZGF0YS0+
ZmFuX2Rpdls0XSAmIDB4MDQpIDw8IDUpOwotCQl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoY2xpZW50
LCBXODM2MjdFSEZfUkVHX0RJT0RFLCByZWcpOworCQl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoZGF0
YSwgVzgzNjI3RUhGX1JFR19ESU9ERSwgcmVnKTsKIAkJYnJlYWs7CiAJfQogfQogCiBzdGF0aWMg
c3RydWN0IHc4MzYyN2VoZl9kYXRhICp3ODM2MjdlaGZfdXBkYXRlX2RldmljZShzdHJ1Y3QgZGV2
aWNlICpkZXYpCiB7Ci0Jc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQo
ZGV2KTsKLQlzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEo
Y2xpZW50KTsKKwlzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEgKmRhdGEgPSBkZXYtPnBsYXRmb3JtX2Rh
dGE7CiAJaW50IHB3bWNmZyA9IDAsIHRvbGVyYW5jZSA9IDA7IC8qIHNodXQgdXAgdGhlIGNvbXBp
bGVyICovCiAJaW50IGk7CiAKQEAgLTQyNiwzMyArNDIxLDMzIEBACiAJaWYgKHRpbWVfYWZ0ZXIo
amlmZmllcywgZGF0YS0+bGFzdF91cGRhdGVkICsgSFopCiAJIHx8ICFkYXRhLT52YWxpZCkgewog
CQkvKiBGYW4gY2xvY2sgZGl2aWRlcnMgKi8KLQkJaSA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGNs
aWVudCwgVzgzNjI3RUhGX1JFR19GQU5ESVYxKTsKKwkJaSA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVl
KGRhdGEsIFc4MzYyN0VIRl9SRUdfRkFORElWMSk7CiAJCWRhdGEtPmZhbl9kaXZbMF0gPSAoaSA+
PiA0KSAmIDB4MDM7CiAJCWRhdGEtPmZhbl9kaXZbMV0gPSAoaSA+PiA2KSAmIDB4MDM7Ci0JCWkg
PSB3ODM2MjdlaGZfcmVhZF92YWx1ZShjbGllbnQsIFc4MzYyN0VIRl9SRUdfRkFORElWMik7CisJ
CWkgPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShkYXRhLCBXODM2MjdFSEZfUkVHX0ZBTkRJVjIpOwog
CQlkYXRhLT5mYW5fZGl2WzJdID0gKGkgPj4gNikgJiAweDAzOwotCQlpID0gdzgzNjI3ZWhmX3Jl
YWRfdmFsdWUoY2xpZW50LCBXODM2MjdFSEZfUkVHX1ZCQVQpOworCQlpID0gdzgzNjI3ZWhmX3Jl
YWRfdmFsdWUoZGF0YSwgVzgzNjI3RUhGX1JFR19WQkFUKTsKIAkJZGF0YS0+ZmFuX2RpdlswXSB8
PSAoaSA+PiAzKSAmIDB4MDQ7CiAJCWRhdGEtPmZhbl9kaXZbMV0gfD0gKGkgPj4gNCkgJiAweDA0
OwogCQlkYXRhLT5mYW5fZGl2WzJdIHw9IChpID4+IDUpICYgMHgwNDsKIAkJaWYgKGRhdGEtPmhh
c19mYW4gJiAoKDEgPDwgMykgfCAoMSA8PCA0KSkpIHsKLQkJCWkgPSB3ODM2MjdlaGZfcmVhZF92
YWx1ZShjbGllbnQsIFc4MzYyN0VIRl9SRUdfRElPREUpOworCQkJaSA9IHc4MzYyN2VoZl9yZWFk
X3ZhbHVlKGRhdGEsIFc4MzYyN0VIRl9SRUdfRElPREUpOwogCQkJZGF0YS0+ZmFuX2RpdlszXSA9
IGkgJiAweDAzOwogCQkJZGF0YS0+ZmFuX2Rpdls0XSA9ICgoaSA+PiAyKSAmIDB4MDMpCiAJCQkJ
CSB8ICgoaSA+PiA1KSAmIDB4MDQpOwogCQl9CiAJCWlmIChkYXRhLT5oYXNfZmFuICYgKDEgPDwg
MykpIHsKLQkJCWkgPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShjbGllbnQsIFc4MzYyN0VIRl9SRUdf
U01JX09WVCk7CisJCQlpID0gdzgzNjI3ZWhmX3JlYWRfdmFsdWUoZGF0YSwgVzgzNjI3RUhGX1JF
R19TTUlfT1ZUKTsKIAkJCWRhdGEtPmZhbl9kaXZbM10gfD0gKGkgPj4gNSkgJiAweDA0OwogCQl9
CiAKIAkJLyogTWVhc3VyZWQgdm9sdGFnZXMgYW5kIGxpbWl0cyAqLwotCQlmb3IgKGkgPSAwOyBp
IDwgdzgzNjI3ZWhmX251bV9pbjsgaSsrKSB7Ci0JCQlkYXRhLT5pbltpXSA9IHc4MzYyN2VoZl9y
ZWFkX3ZhbHVlKGNsaWVudCwKKwkJZm9yIChpID0gMDsgaSA8IGRhdGEtPmluX251bTsgaSsrKSB7
CisJCQlkYXRhLT5pbltpXSA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGRhdGEsCiAJCQkJICAgICAg
VzgzNjI3RUhGX1JFR19JTihpKSk7Ci0JCQlkYXRhLT5pbl9taW5baV0gPSB3ODM2MjdlaGZfcmVh
ZF92YWx1ZShjbGllbnQsCisJCQlkYXRhLT5pbl9taW5baV0gPSB3ODM2MjdlaGZfcmVhZF92YWx1
ZShkYXRhLAogCQkJCQkgIFc4MzYyN0VIRl9SRUdfSU5fTUlOKGkpKTsKLQkJCWRhdGEtPmluX21h
eFtpXSA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGNsaWVudCwKKwkJCWRhdGEtPmluX21heFtpXSA9
IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGRhdGEsCiAJCQkJCSAgVzgzNjI3RUhGX1JFR19JTl9NQVgo
aSkpOwogCQl9CiAKQEAgLTQ2MSw5ICs0NTYsOSBAQAogCQkJaWYgKCEoZGF0YS0+aGFzX2ZhbiAm
ICgxIDw8IGkpKSkKIAkJCQljb250aW51ZTsKIAotCQkJZGF0YS0+ZmFuW2ldID0gdzgzNjI3ZWhm
X3JlYWRfdmFsdWUoY2xpZW50LAorCQkJZGF0YS0+ZmFuW2ldID0gdzgzNjI3ZWhmX3JlYWRfdmFs
dWUoZGF0YSwKIAkJCQkgICAgICAgVzgzNjI3RUhGX1JFR19GQU5baV0pOwotCQkJZGF0YS0+ZmFu
X21pbltpXSA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGNsaWVudCwKKwkJCWRhdGEtPmZhbl9taW5b
aV0gPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShkYXRhLAogCQkJCQkgICBXODM2MjdFSEZfUkVHX0ZB
Tl9NSU5baV0pOwogCiAJCQkvKiBJZiB3ZSBmYWlsZWQgdG8gbWVhc3VyZSB0aGUgZmFuIHNwZWVk
IGFuZCBjbG9jawpAQCAtNDcxLDE2ICs0NjYsMTYgQEAKIAkJCSAgIHRpbWUgKi8KIAkJCWlmIChk
YXRhLT5mYW5baV0gPT0gMHhmZgogCQkJICYmIGRhdGEtPmZhbl9kaXZbaV0gPCAweDA3KSB7Ci0J
CQkgCWRldl9kYmcoJmNsaWVudC0+ZGV2LCAiSW5jcmVhc2luZyBmYW4lZCAiCisJCQkgCWRldl9k
YmcoZGV2LCAiSW5jcmVhc2luZyBmYW4gJWQgIgogCQkJCQkiY2xvY2sgZGl2aWRlciBmcm9tICV1
IHRvICV1XG4iLAotCQkJCQlpICsgMSwgZGl2X2Zyb21fcmVnKGRhdGEtPmZhbl9kaXZbaV0pLAor
CQkJCQlpLCBkaXZfZnJvbV9yZWcoZGF0YS0+ZmFuX2RpdltpXSksCiAJCQkJCWRpdl9mcm9tX3Jl
ZyhkYXRhLT5mYW5fZGl2W2ldICsgMSkpOwogCQkJCWRhdGEtPmZhbl9kaXZbaV0rKzsKLQkJCQl3
ODM2MjdlaGZfd3JpdGVfZmFuX2RpdihjbGllbnQsIGkpOworCQkJCXc4MzYyN2VoZl93cml0ZV9m
YW5fZGl2KGRhdGEsIGkpOwogCQkJCS8qIFByZXNlcnZlIG1pbiBsaW1pdCBpZiBwb3NzaWJsZSAq
LwogCQkJCWlmIChkYXRhLT5mYW5fbWluW2ldID49IDIKIAkJCQkgJiYgZGF0YS0+ZmFuX21pbltp
XSAhPSAyNTUpCi0JCQkJCXc4MzYyN2VoZl93cml0ZV92YWx1ZShjbGllbnQsCisJCQkJCXc4MzYy
N2VoZl93cml0ZV92YWx1ZShkYXRhLAogCQkJCQkJVzgzNjI3RUhGX1JFR19GQU5fTUlOW2ldLAog
CQkJCQkJKGRhdGEtPmZhbl9taW5baV0gLz0gMikpOwogCQkJfQpAQCAtNDg5LDkgKzQ4NCw5IEBA
CiAJCWZvciAoaSA9IDA7IGkgPCA0OyBpKyspIHsKIAkJCS8qIHB3bWNmZywgdG9sYXJhbmNlIG1h
cHBlZCBmb3IgaT0wLCBpPTEgdG8gc2FtZSByZWcgKi8KIAkJCWlmIChpICE9IDEpIHsKLQkJCQlw
d21jZmcgPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShjbGllbnQsCisJCQkJcHdtY2ZnID0gdzgzNjI3
ZWhmX3JlYWRfdmFsdWUoZGF0YSwKIAkJCQkJCVc4MzYyN0VIRl9SRUdfUFdNX0VOQUJMRVtpXSk7
Ci0JCQkJdG9sZXJhbmNlID0gdzgzNjI3ZWhmX3JlYWRfdmFsdWUoY2xpZW50LAorCQkJCXRvbGVy
YW5jZSA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGRhdGEsCiAJCQkJCQlXODM2MjdFSEZfUkVHX1RP
TEVSQU5DRVtpXSk7CiAJCQl9CiAJCQlkYXRhLT5wd21fbW9kZVtpXSA9CkBAIC01MDAsMTQgKzQ5
NSwxNCBAQAogCQkJZGF0YS0+cHdtX2VuYWJsZVtpXSA9CiAJCQkJCSgocHdtY2ZnID4+IFc4MzYy
N0VIRl9QV01fRU5BQkxFX1NISUZUW2ldKQogCQkJCQkJJiAzKSArIDE7Ci0JCQlkYXRhLT5wd21b
aV0gPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShjbGllbnQsCisJCQlkYXRhLT5wd21baV0gPSB3ODM2
MjdlaGZfcmVhZF92YWx1ZShkYXRhLAogCQkJCQkJVzgzNjI3RUhGX1JFR19QV01baV0pOwotCQkJ
ZGF0YS0+ZmFuX21pbl9vdXRwdXRbaV0gPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShjbGllbnQsCisJ
CQlkYXRhLT5mYW5fbWluX291dHB1dFtpXSA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGRhdGEsCiAJ
CQkJCQlXODM2MjdFSEZfUkVHX0ZBTl9NSU5fT1VUUFVUW2ldKTsKLQkJCWRhdGEtPmZhbl9zdG9w
X3RpbWVbaV0gPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShjbGllbnQsCisJCQlkYXRhLT5mYW5fc3Rv
cF90aW1lW2ldID0gdzgzNjI3ZWhmX3JlYWRfdmFsdWUoZGF0YSwKIAkJCQkJCVc4MzYyN0VIRl9S
RUdfRkFOX1NUT1BfVElNRVtpXSk7CiAJCQlkYXRhLT50YXJnZXRfdGVtcFtpXSA9Ci0JCQkJdzgz
NjI3ZWhmX3JlYWRfdmFsdWUoY2xpZW50LAorCQkJCXc4MzYyN2VoZl9yZWFkX3ZhbHVlKGRhdGEs
CiAJCQkJCVc4MzYyN0VIRl9SRUdfVEFSR0VUW2ldKSAmCiAJCQkJCShkYXRhLT5wd21fbW9kZVtp
XSA9PSAxID8gMHg3ZiA6IDB4ZmYpOwogCQkJZGF0YS0+dG9sZXJhbmNlW2ldID0gKHRvbGVyYW5j
ZSA+PiAoaSA9PSAxID8gNCA6IDApKQpAQCAtNTE1LDI2ICs1MTAsMjYgQEAKIAkJfQogCiAJCS8q
IE1lYXN1cmVkIHRlbXBlcmF0dXJlcyBhbmQgbGltaXRzICovCi0JCWRhdGEtPnRlbXAxID0gdzgz
NjI3ZWhmX3JlYWRfdmFsdWUoY2xpZW50LAorCQlkYXRhLT50ZW1wMSA9IHc4MzYyN2VoZl9yZWFk
X3ZhbHVlKGRhdGEsCiAJCQkgICAgICBXODM2MjdFSEZfUkVHX1RFTVAxKTsKLQkJZGF0YS0+dGVt
cDFfbWF4ID0gdzgzNjI3ZWhmX3JlYWRfdmFsdWUoY2xpZW50LAorCQlkYXRhLT50ZW1wMV9tYXgg
PSB3ODM2MjdlaGZfcmVhZF92YWx1ZShkYXRhLAogCQkJCSAgVzgzNjI3RUhGX1JFR19URU1QMV9P
VkVSKTsKLQkJZGF0YS0+dGVtcDFfbWF4X2h5c3QgPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShjbGll
bnQsCisJCWRhdGEtPnRlbXAxX21heF9oeXN0ID0gdzgzNjI3ZWhmX3JlYWRfdmFsdWUoZGF0YSwK
IAkJCQkgICAgICAgVzgzNjI3RUhGX1JFR19URU1QMV9IWVNUKTsKIAkJZm9yIChpID0gMDsgaSA8
IDI7IGkrKykgewotCQkJZGF0YS0+dGVtcFtpXSA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGNsaWVu
dCwKKwkJCWRhdGEtPnRlbXBbaV0gPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShkYXRhLAogCQkJCQlX
ODM2MjdFSEZfUkVHX1RFTVBbaV0pOwotCQkJZGF0YS0+dGVtcF9tYXhbaV0gPSB3ODM2MjdlaGZf
cmVhZF92YWx1ZShjbGllbnQsCisJCQlkYXRhLT50ZW1wX21heFtpXSA9IHc4MzYyN2VoZl9yZWFk
X3ZhbHVlKGRhdGEsCiAJCQkJCSAgICBXODM2MjdFSEZfUkVHX1RFTVBfT1ZFUltpXSk7Ci0JCQlk
YXRhLT50ZW1wX21heF9oeXN0W2ldID0gdzgzNjI3ZWhmX3JlYWRfdmFsdWUoY2xpZW50LAorCQkJ
ZGF0YS0+dGVtcF9tYXhfaHlzdFtpXSA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGRhdGEsCiAJCQkJ
CQkgVzgzNjI3RUhGX1JFR19URU1QX0hZU1RbaV0pOwogCQl9CiAKLQkJZGF0YS0+YWxhcm1zID0g
dzgzNjI3ZWhmX3JlYWRfdmFsdWUoY2xpZW50LAorCQlkYXRhLT5hbGFybXMgPSB3ODM2MjdlaGZf
cmVhZF92YWx1ZShkYXRhLAogCQkJCQlXODM2MjdFSEZfUkVHX0FMQVJNMSkgfAotCQkJICAgICAg
ICh3ODM2MjdlaGZfcmVhZF92YWx1ZShjbGllbnQsCisJCQkgICAgICAgKHc4MzYyN2VoZl9yZWFk
X3ZhbHVlKGRhdGEsCiAJCQkJCVc4MzYyN0VIRl9SRUdfQUxBUk0yKSA8PCA4KSB8Ci0JCQkgICAg
ICAgKHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGNsaWVudCwKKwkJCSAgICAgICAodzgzNjI3ZWhmX3Jl
YWRfdmFsdWUoZGF0YSwKIAkJCQkJVzgzNjI3RUhGX1JFR19BTEFSTTMpIDw8IDE2KTsKIAogCQlk
YXRhLT5sYXN0X3VwZGF0ZWQgPSBqaWZmaWVzOwpAQCAtNTY3LDE1ICs1NjIsMTQgQEAKIHN0b3Jl
X2luXyMjcmVnIChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICph
dHRyLCBcCiAJCQljb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkgXAogeyBcCi0Jc3RydWN0
IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQoZGV2KTsgXAotCXN0cnVjdCB3ODM2
MjdlaGZfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOyBcCisJc3RydWN0
IHc4MzYyN2VoZl9kYXRhICpkYXRhID0gZGV2LT5wbGF0Zm9ybV9kYXRhOyBcCiAJc3RydWN0IHNl
bnNvcl9kZXZpY2VfYXR0cmlidXRlICpzZW5zb3JfYXR0ciA9IHRvX3NlbnNvcl9kZXZfYXR0cihh
dHRyKTsgXAogCWludCBuciA9IHNlbnNvcl9hdHRyLT5pbmRleDsgXAogCXUzMiB2YWwgPSBzaW1w
bGVfc3RydG91bChidWYsIE5VTEwsIDEwKTsgXAogIFwKIAltdXRleF9sb2NrKCZkYXRhLT51cGRh
dGVfbG9jayk7IFwKIAlkYXRhLT5pbl8jI3JlZ1tucl0gPSBpbl90b19yZWcodmFsLCBucik7IFwK
LQl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoY2xpZW50LCBXODM2MjdFSEZfUkVHX0lOXyMjUkVHKG5y
KSwgXAorCXc4MzYyN2VoZl93cml0ZV92YWx1ZShkYXRhLCBXODM2MjdFSEZfUkVHX0lOXyMjUkVH
KG5yKSwgXAogCQkJICAgICAgZGF0YS0+aW5fIyNyZWdbbnJdKTsgXAogCW11dGV4X3VubG9jaygm
ZGF0YS0+dXBkYXRlX2xvY2spOyBcCiAJcmV0dXJuIGNvdW50OyBcCkBAIC02NzMsOCArNjY3LDcg
QEAKIHN0b3JlX2Zhbl9taW4oc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJp
YnV0ZSAqYXR0ciwKIAkgICAgICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkKIHsKLQlz
dHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOwotCXN0cnVjdCB3
ODM2MjdlaGZfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOworCXN0cnVj
dCB3ODM2MjdlaGZfZGF0YSAqZGF0YSA9IGRldi0+cGxhdGZvcm1fZGF0YTsKIAlzdHJ1Y3Qgc2Vu
c29yX2RldmljZV9hdHRyaWJ1dGUgKnNlbnNvcl9hdHRyID0gdG9fc2Vuc29yX2Rldl9hdHRyKGF0
dHIpOwogCWludCBuciA9IHNlbnNvcl9hdHRyLT5pbmRleDsKIAl1bnNpZ25lZCBpbnQgdmFsID0g
c2ltcGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAxMCk7CkBAIC03MjUsOSArNzE4LDkgQEAKIAkJCW5y
ICsgMSwgZGl2X2Zyb21fcmVnKGRhdGEtPmZhbl9kaXZbbnJdKSwKIAkJCWRpdl9mcm9tX3JlZyhu
ZXdfZGl2KSk7CiAJCWRhdGEtPmZhbl9kaXZbbnJdID0gbmV3X2RpdjsKLQkJdzgzNjI3ZWhmX3dy
aXRlX2Zhbl9kaXYoY2xpZW50LCBucik7CisJCXc4MzYyN2VoZl93cml0ZV9mYW5fZGl2KGRhdGEs
IG5yKTsKIAl9Ci0JdzgzNjI3ZWhmX3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNjI3RUhGX1JFR19G
QU5fTUlOW25yXSwKKwl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoZGF0YSwgVzgzNjI3RUhGX1JFR19G
QU5fTUlOW25yXSwKIAkJCSAgICAgIGRhdGEtPmZhbl9taW5bbnJdKTsKIAltdXRleF91bmxvY2so
JmRhdGEtPnVwZGF0ZV9sb2NrKTsKIApAQCAtNzg4LDEzICs3ODEsMTIgQEAKIHN0b3JlX3RlbXAx
XyMjcmVnKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIs
IFwKIAkJICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkgXAogeyBcCi0Jc3RydWN0IGky
Y19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQoZGV2KTsgXAotCXN0cnVjdCB3ODM2Mjdl
aGZfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOyBcCisJc3RydWN0IHc4
MzYyN2VoZl9kYXRhICpkYXRhID0gZGV2LT5wbGF0Zm9ybV9kYXRhOyBcCiAJdTMyIHZhbCA9IHNp
bXBsZV9zdHJ0b3VsKGJ1ZiwgTlVMTCwgMTApOyBcCiAgXAogCW11dGV4X2xvY2soJmRhdGEtPnVw
ZGF0ZV9sb2NrKTsgXAogCWRhdGEtPnRlbXAxXyMjcmVnID0gdGVtcDFfdG9fcmVnKHZhbCwgLTEy
ODAwMCwgMTI3MDAwKTsgXAotCXc4MzYyN2VoZl93cml0ZV92YWx1ZShjbGllbnQsIFc4MzYyN0VI
Rl9SRUdfVEVNUDFfIyNSRUcsIFwKKwl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoZGF0YSwgVzgzNjI3
RUhGX1JFR19URU1QMV8jI1JFRywgXAogCQkJICAgICAgZGF0YS0+dGVtcDFfIyNyZWcpOyBcCiAJ
bXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7IFwKIAlyZXR1cm4gY291bnQ7IFwKQEAg
LTgyMiwxNSArODE0LDE0IEBACiBzdG9yZV8jI3JlZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBcCiAJICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90
IGNvdW50KSBcCiB7IFwKLQlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVu
dChkZXYpOyBcCi0Jc3RydWN0IHc4MzYyN2VoZl9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRk
YXRhKGNsaWVudCk7IFwKKwlzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEgKmRhdGEgPSBkZXYtPnBsYXRm
b3JtX2RhdGE7IFwKIAlzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGUgKnNlbnNvcl9hdHRy
ID0gdG9fc2Vuc29yX2Rldl9hdHRyKGF0dHIpOyBcCiAJaW50IG5yID0gc2Vuc29yX2F0dHItPmlu
ZGV4OyBcCiAJdTMyIHZhbCA9IHNpbXBsZV9zdHJ0b3VsKGJ1ZiwgTlVMTCwgMTApOyBcCiAgXAog
CW11dGV4X2xvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsgXAogCWRhdGEtPnJlZ1tucl0gPSBMTTc1
X1RFTVBfVE9fUkVHKHZhbCk7IFwKLQl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoY2xpZW50LCBXODM2
MjdFSEZfUkVHX1RFTVBfIyNSRUdbbnJdLCBcCisJdzgzNjI3ZWhmX3dyaXRlX3ZhbHVlKGRhdGEs
IFc4MzYyN0VIRl9SRUdfVEVNUF8jI1JFR1tucl0sIFwKIAkJCSAgICAgIGRhdGEtPnJlZ1tucl0p
OyBcCiAJbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7IFwKIAlyZXR1cm4gY291bnQ7
IFwKQEAgLTg3Nyw4ICs4NjgsNyBAQAogc3RvcmVfcHdtX21vZGUoc3RydWN0IGRldmljZSAqZGV2
LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKIAkJCWNvbnN0IGNoYXIgKmJ1Ziwgc2l6
ZV90IGNvdW50KQogewotCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50
KGRldik7Ci0Jc3RydWN0IHc4MzYyN2VoZl9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRh
KGNsaWVudCk7CisJc3RydWN0IHc4MzYyN2VoZl9kYXRhICpkYXRhID0gZGV2LT5wbGF0Zm9ybV9k
YXRhOwogCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZSAqc2Vuc29yX2F0dHIgPSB0b19z
ZW5zb3JfZGV2X2F0dHIoYXR0cik7CiAJaW50IG5yID0gc2Vuc29yX2F0dHItPmluZGV4OwogCXUz
MiB2YWwgPSBzaW1wbGVfc3RydG91bChidWYsIE5VTEwsIDEwKTsKQEAgLTg4NywxMiArODc3LDEy
IEBACiAJaWYgKHZhbCA+IDEpCiAJCXJldHVybiAtRUlOVkFMOwogCW11dGV4X2xvY2soJmRhdGEt
PnVwZGF0ZV9sb2NrKTsKLQlyZWcgPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShjbGllbnQsIFc4MzYy
N0VIRl9SRUdfUFdNX0VOQUJMRVtucl0pOworCXJlZyA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGRh
dGEsIFc4MzYyN0VIRl9SRUdfUFdNX0VOQUJMRVtucl0pOwogCWRhdGEtPnB3bV9tb2RlW25yXSA9
IHZhbDsKIAlyZWcgJj0gfigxIDw8IFc4MzYyN0VIRl9QV01fTU9ERV9TSElGVFtucl0pOwogCWlm
ICghdmFsKQogCQlyZWcgfD0gMSA8PCBXODM2MjdFSEZfUFdNX01PREVfU0hJRlRbbnJdOwotCXc4
MzYyN2VoZl93cml0ZV92YWx1ZShjbGllbnQsIFc4MzYyN0VIRl9SRUdfUFdNX0VOQUJMRVtucl0s
IHJlZyk7CisJdzgzNjI3ZWhmX3dyaXRlX3ZhbHVlKGRhdGEsIFc4MzYyN0VIRl9SRUdfUFdNX0VO
QUJMRVtucl0sIHJlZyk7CiAJbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CiAJcmV0
dXJuIGNvdW50OwogfQpAQCAtOTAxLDE1ICs4OTEsMTQgQEAKIHN0b3JlX3B3bShzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAogCQkJY29uc3QgY2hhciAq
YnVmLCBzaXplX3QgY291bnQpCiB7Ci0Jc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2ky
Y19jbGllbnQoZGV2KTsKLQlzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2Ns
aWVudGRhdGEoY2xpZW50KTsKKwlzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEgKmRhdGEgPSBkZXYtPnBs
YXRmb3JtX2RhdGE7CiAJc3RydWN0IHNlbnNvcl9kZXZpY2VfYXR0cmlidXRlICpzZW5zb3JfYXR0
ciA9IHRvX3NlbnNvcl9kZXZfYXR0cihhdHRyKTsKIAlpbnQgbnIgPSBzZW5zb3JfYXR0ci0+aW5k
ZXg7CiAJdTMyIHZhbCA9IFNFTlNPUlNfTElNSVQoc2ltcGxlX3N0cnRvdWwoYnVmLCBOVUxMLCAx
MCksIDAsIDI1NSk7CiAKIAltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CiAJZGF0YS0+
cHdtW25yXSA9IHZhbDsKLQl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoY2xpZW50LCBXODM2MjdFSEZf
UkVHX1BXTVtucl0sIHZhbCk7CisJdzgzNjI3ZWhmX3dyaXRlX3ZhbHVlKGRhdGEsIFc4MzYyN0VI
Rl9SRUdfUFdNW25yXSwgdmFsKTsKIAltdXRleF91bmxvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsK
IAlyZXR1cm4gY291bnQ7CiB9CkBAIC05MTgsOCArOTA3LDcgQEAKIHN0b3JlX3B3bV9lbmFibGUo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKIAkJCWNv
bnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQogewotCXN0cnVjdCBpMmNfY2xpZW50ICpjbGll
bnQgPSB0b19pMmNfY2xpZW50KGRldik7Ci0Jc3RydWN0IHc4MzYyN2VoZl9kYXRhICpkYXRhID0g
aTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CisJc3RydWN0IHc4MzYyN2VoZl9kYXRhICpkYXRh
ID0gZGV2LT5wbGF0Zm9ybV9kYXRhOwogCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZSAq
c2Vuc29yX2F0dHIgPSB0b19zZW5zb3JfZGV2X2F0dHIoYXR0cik7CiAJaW50IG5yID0gc2Vuc29y
X2F0dHItPmluZGV4OwogCXUzMiB2YWwgPSBzaW1wbGVfc3RydG91bChidWYsIE5VTEwsIDEwKTsK
QEAgLTkyOCwxMSArOTE2LDExIEBACiAJaWYgKCF2YWwgfHwgKHZhbCA+IDIpKQkvKiBvbmx5IG1v
ZGVzIDEgYW5kIDIgYXJlIHN1cHBvcnRlZCAqLwogCQlyZXR1cm4gLUVJTlZBTDsKIAltdXRleF9s
b2NrKCZkYXRhLT51cGRhdGVfbG9jayk7Ci0JcmVnID0gdzgzNjI3ZWhmX3JlYWRfdmFsdWUoY2xp
ZW50LCBXODM2MjdFSEZfUkVHX1BXTV9FTkFCTEVbbnJdKTsKKwlyZWcgPSB3ODM2MjdlaGZfcmVh
ZF92YWx1ZShkYXRhLCBXODM2MjdFSEZfUkVHX1BXTV9FTkFCTEVbbnJdKTsKIAlkYXRhLT5wd21f
ZW5hYmxlW25yXSA9IHZhbDsKIAlyZWcgJj0gfigweDAzIDw8IFc4MzYyN0VIRl9QV01fRU5BQkxF
X1NISUZUW25yXSk7CiAJcmVnIHw9ICh2YWwgLSAxKSA8PCBXODM2MjdFSEZfUFdNX0VOQUJMRV9T
SElGVFtucl07Ci0JdzgzNjI3ZWhmX3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNjI3RUhGX1JFR19Q
V01fRU5BQkxFW25yXSwgcmVnKTsKKwl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoZGF0YSwgVzgzNjI3
RUhGX1JFR19QV01fRU5BQkxFW25yXSwgcmVnKTsKIAltdXRleF91bmxvY2soJmRhdGEtPnVwZGF0
ZV9sb2NrKTsKIAlyZXR1cm4gY291bnQ7CiB9CkBAIC05NTUsMTUgKzk0MywxNCBAQAogc3RvcmVf
dGFyZ2V0X3RlbXAoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAq
YXR0ciwKIAkJCWNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQogewotCXN0cnVjdCBpMmNf
Y2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50KGRldik7Ci0Jc3RydWN0IHc4MzYyN2VoZl9k
YXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CisJc3RydWN0IHc4MzYyN2Vo
Zl9kYXRhICpkYXRhID0gZGV2LT5wbGF0Zm9ybV9kYXRhOwogCXN0cnVjdCBzZW5zb3JfZGV2aWNl
X2F0dHJpYnV0ZSAqc2Vuc29yX2F0dHIgPSB0b19zZW5zb3JfZGV2X2F0dHIoYXR0cik7CiAJaW50
IG5yID0gc2Vuc29yX2F0dHItPmluZGV4OwogCXU4IHZhbCA9IHRlbXAxX3RvX3JlZyhzaW1wbGVf
c3RydG91bChidWYsIE5VTEwsIDEwKSwgMCwgMTI3MDAwKTsKIAogCW11dGV4X2xvY2soJmRhdGEt
PnVwZGF0ZV9sb2NrKTsKIAlkYXRhLT50YXJnZXRfdGVtcFtucl0gPSB2YWw7Ci0JdzgzNjI3ZWhm
X3dyaXRlX3ZhbHVlKGNsaWVudCwgVzgzNjI3RUhGX1JFR19UQVJHRVRbbnJdLCB2YWwpOworCXc4
MzYyN2VoZl93cml0ZV92YWx1ZShkYXRhLCBXODM2MjdFSEZfUkVHX1RBUkdFVFtucl0sIHZhbCk7
CiAJbXV0ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CiAJcmV0dXJuIGNvdW50OwogfQpA
QCAtOTcyLDggKzk1OSw3IEBACiBzdG9yZV90b2xlcmFuY2Uoc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKIAkJCWNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90
IGNvdW50KQogewotCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50KGRl
dik7Ci0Jc3RydWN0IHc4MzYyN2VoZl9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNs
aWVudCk7CisJc3RydWN0IHc4MzYyN2VoZl9kYXRhICpkYXRhID0gZGV2LT5wbGF0Zm9ybV9kYXRh
OwogCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZSAqc2Vuc29yX2F0dHIgPSB0b19zZW5z
b3JfZGV2X2F0dHIoYXR0cik7CiAJaW50IG5yID0gc2Vuc29yX2F0dHItPmluZGV4OwogCXUxNiBy
ZWc7CkBAIC05ODEsMTMgKzk2NywxMyBAQAogCXU4IHZhbCA9IHRlbXAxX3RvX3JlZyhzaW1wbGVf
c3RydG91bChidWYsIE5VTEwsIDEwKSwgMCwgMTUwMDApOwogCiAJbXV0ZXhfbG9jaygmZGF0YS0+
dXBkYXRlX2xvY2spOwotCXJlZyA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGNsaWVudCwgVzgzNjI3
RUhGX1JFR19UT0xFUkFOQ0VbbnJdKTsKKwlyZWcgPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShkYXRh
LCBXODM2MjdFSEZfUkVHX1RPTEVSQU5DRVtucl0pOwogCWRhdGEtPnRvbGVyYW5jZVtucl0gPSB2
YWw7CiAJaWYgKG5yID09IDEpCiAJCXJlZyA9IChyZWcgJiAweDBmKSB8ICh2YWwgPDwgNCk7CiAJ
ZWxzZQogCQlyZWcgPSAocmVnICYgMHhmMCkgfCB2YWw7Ci0JdzgzNjI3ZWhmX3dyaXRlX3ZhbHVl
KGNsaWVudCwgVzgzNjI3RUhGX1JFR19UT0xFUkFOQ0VbbnJdLCByZWcpOworCXc4MzYyN2VoZl93
cml0ZV92YWx1ZShkYXRhLCBXODM2MjdFSEZfUkVHX1RPTEVSQU5DRVtucl0sIHJlZyk7CiAJbXV0
ZXhfdW5sb2NrKCZkYXRhLT51cGRhdGVfbG9jayk7CiAJcmV0dXJuIGNvdW50OwogfQpAQCAtMTA1
OCwxNCArMTA0NCwxMyBAQAogc3RvcmVfIyNyZWcoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qg
ZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgXAogCQkJICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90
IGNvdW50KSBcCiB7XAotCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50
KGRldik7IFwKLQlzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRh
dGEoY2xpZW50KTsgXAorCXN0cnVjdCB3ODM2MjdlaGZfZGF0YSAqZGF0YSA9IGRldi0+cGxhdGZv
cm1fZGF0YTsgXAogCXN0cnVjdCBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZSAqc2Vuc29yX2F0dHIg
PSB0b19zZW5zb3JfZGV2X2F0dHIoYXR0cik7IFwKIAlpbnQgbnIgPSBzZW5zb3JfYXR0ci0+aW5k
ZXg7IFwKIAl1MzIgdmFsID0gU0VOU09SU19MSU1JVChzaW1wbGVfc3RydG91bChidWYsIE5VTEws
IDEwKSwgMSwgMjU1KTsgXAogCW11dGV4X2xvY2soJmRhdGEtPnVwZGF0ZV9sb2NrKTsgXAogCWRh
dGEtPnJlZ1tucl0gPSB2YWw7IFwKLQl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoY2xpZW50LCBXODM2
MjdFSEZfUkVHXyMjUkVHW25yXSwgIHZhbCk7IFwKKwl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoZGF0
YSwgVzgzNjI3RUhGX1JFR18jI1JFR1tucl0sICB2YWwpOyBcCiAJbXV0ZXhfdW5sb2NrKCZkYXRh
LT51cGRhdGVfbG9jayk7IFwKIAlyZXR1cm4gY291bnQ7IFwKIH0KQEAgLTEwODcsMjEgKzEwNzIs
MjkgQEAKIHN0b3JlXyMjcmVnKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRy
aWJ1dGUgKmF0dHIsIFwKIAkJCWNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KSBcCiB7IFwK
LQlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOyBcCi0Jc3Ry
dWN0IHc4MzYyN2VoZl9kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7IFwK
KwlzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEgKmRhdGEgPSBkZXYtPnBsYXRmb3JtX2RhdGE7IFwKIAlz
dHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGUgKnNlbnNvcl9hdHRyID0gdG9fc2Vuc29yX2Rl
dl9hdHRyKGF0dHIpOyBcCiAJaW50IG5yID0gc2Vuc29yX2F0dHItPmluZGV4OyBcCiAJdTggdmFs
ID0gc3RlcF90aW1lX3RvX3JlZyhzaW1wbGVfc3RydG91bChidWYsIE5VTEwsIDEwKSwgXAogCQkJ
CQlkYXRhLT5wd21fbW9kZVtucl0pOyBcCiAJbXV0ZXhfbG9jaygmZGF0YS0+dXBkYXRlX2xvY2sp
OyBcCiAJZGF0YS0+cmVnW25yXSA9IHZhbDsgXAotCXc4MzYyN2VoZl93cml0ZV92YWx1ZShjbGll
bnQsIFc4MzYyN0VIRl9SRUdfIyNSRUdbbnJdLCB2YWwpOyBcCisJdzgzNjI3ZWhmX3dyaXRlX3Zh
bHVlKGRhdGEsIFc4MzYyN0VIRl9SRUdfIyNSRUdbbnJdLCB2YWwpOyBcCiAJbXV0ZXhfdW5sb2Nr
KCZkYXRhLT51cGRhdGVfbG9jayk7IFwKIAlyZXR1cm4gY291bnQ7IFwKIH0gXAogCiBmYW5fdGlt
ZV9mdW5jdGlvbnMoZmFuX3N0b3BfdGltZSwgRkFOX1NUT1BfVElNRSkKIAorc3RhdGljIHNzaXpl
X3Qgc2hvd19uYW1lKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUK
KwkJCSAqZGV2YXR0ciwgY2hhciAqYnVmKQoreworCXN0cnVjdCB3ODM2MjdlaGZfZGF0YSAqZGF0
YSA9IGRldi0+cGxhdGZvcm1fZGF0YTsKKworCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVzXG4iLCBk
YXRhLT5uYW1lKTsKK30KKworc3RhdGljIERFVklDRV9BVFRSKG5hbWUsIFNfSVJVR08sIHNob3df
bmFtZSwgTlVMTCk7CiAKIHN0YXRpYyBzdHJ1Y3Qgc2Vuc29yX2RldmljZV9hdHRyaWJ1dGUgc2Rh
X3NmM19hcnJheXNfZmFuNFtdID0gewogCVNFTlNPUl9BVFRSKHB3bTRfc3RvcF90aW1lLCBTX0lX
VVNSIHwgU19JUlVHTywgc2hvd19mYW5fc3RvcF90aW1lLApAQCAtMTEyNiw3ICsxMTE5LDcgQEAK
IH07CiAKIC8qCi0gKiBEcml2ZXIgYW5kIGNsaWVudCBtYW5hZ2VtZW50CisgKiBEcml2ZXIgYW5k
IHBsYXRmb3JtIG1hbmFnZW1lbnQKICAqLwogCiBzdGF0aWMgdm9pZCB3ODM2MjdlaGZfZGV2aWNl
X3JlbW92ZV9maWxlcyhzdHJ1Y3QgZGV2aWNlICpkZXYpCkBAIC0xMTM0LDEyICsxMTI3LDEzIEBA
CiAJLyogc29tZSBlbnRyaWVzIGluIHRoZSBmb2xsb3dpbmcgYXJyYXlzIG1heSBub3QgaGF2ZSBi
ZWVuIHVzZWQgaW4KIAkgKiBkZXZpY2VfY3JlYXRlX2ZpbGUoKSwgYnV0IGRldmljZV9yZW1vdmVf
ZmlsZSgpIHdpbGwgaWdub3JlIHRoZW0gKi8KIAlpbnQgaTsKKwlzdHJ1Y3QgdzgzNjI3ZWhmX2Rh
dGEgKmRhdGEgPSBkZXYtPnBsYXRmb3JtX2RhdGE7CiAKIAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlf
U0laRShzZGFfc2YzX2FycmF5cyk7IGkrKykKIAkJZGV2aWNlX3JlbW92ZV9maWxlKGRldiwgJnNk
YV9zZjNfYXJyYXlzW2ldLmRldl9hdHRyKTsKIAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShz
ZGFfc2YzX2FycmF5c19mYW40KTsgaSsrKQogCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoZGV2LCAmc2Rh
X3NmM19hcnJheXNfZmFuNFtpXS5kZXZfYXR0cik7Ci0JZm9yIChpID0gMDsgaSA8IHc4MzYyN2Vo
Zl9udW1faW47IGkrKykgeworCWZvciAoaSA9IDA7IGkgPCBkYXRhLT5pbl9udW07IGkrKykgewog
CQlkZXZpY2VfcmVtb3ZlX2ZpbGUoZGV2LCAmc2RhX2luX2lucHV0W2ldLmRldl9hdHRyKTsKIAkJ
ZGV2aWNlX3JlbW92ZV9maWxlKGRldiwgJnNkYV9pbl9hbGFybVtpXS5kZXZfYXR0cik7CiAJCWRl
dmljZV9yZW1vdmVfZmlsZShkZXYsICZzZGFfaW5fbWluW2ldLmRldl9hdHRyKTsKQEAgLTExNjAs
ODYgKzExNTQsNzMgQEAKIAl9CiAJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoc2RhX3RlbXAp
OyBpKyspCiAJCWRldmljZV9yZW1vdmVfZmlsZShkZXYsICZzZGFfdGVtcFtpXS5kZXZfYXR0cik7
Ci19CiAKLXN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciB3ODM2MjdlaGZfZHJpdmVyOworCWRldmlj
ZV9yZW1vdmVfZmlsZShkZXYsICZkZXZfYXR0cl9uYW1lKTsKK30KIAotc3RhdGljIHZvaWQgdzgz
NjI3ZWhmX2luaXRfY2xpZW50KHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpCisvKiB3ODM2Mjdl
aGZfaW5pdF9kZXZpY2UoKSBnZXRzIHRoZSBtb25pdG9yaW5nIGZ1bmN0aW9ucyBzdGFydGVkICov
CitzdGF0aWMgaW5saW5lIHZvaWQgX19kZXZpbml0IHc4MzYyN2VoZl9pbml0X2RldmljZShzdHJ1
Y3QgdzgzNjI3ZWhmX2RhdGEgKmRhdGEpCiB7CiAJaW50IGk7CiAJdTggdG1wOwogCiAJLyogU3Rh
cnQgbW9uaXRvcmluZyBpcyBuZWVkZWQgKi8KLQl0bXAgPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShj
bGllbnQsIFc4MzYyN0VIRl9SRUdfQ09ORklHKTsKKwl0bXAgPSB3ODM2MjdlaGZfcmVhZF92YWx1
ZShkYXRhLCBXODM2MjdFSEZfUkVHX0NPTkZJRyk7CiAJaWYgKCEodG1wICYgMHgwMSkpCi0JCXc4
MzYyN2VoZl93cml0ZV92YWx1ZShjbGllbnQsIFc4MzYyN0VIRl9SRUdfQ09ORklHLAorCQl3ODM2
MjdlaGZfd3JpdGVfdmFsdWUoZGF0YSwgVzgzNjI3RUhGX1JFR19DT05GSUcsCiAJCQkJICAgICAg
dG1wIHwgMHgwMSk7CiAKIAkvKiBFbmFibGUgdGVtcDIgYW5kIHRlbXAzIGlmIG5lZWRlZCAqLwog
CWZvciAoaSA9IDA7IGkgPCAyOyBpKyspIHsKLQkJdG1wID0gdzgzNjI3ZWhmX3JlYWRfdmFsdWUo
Y2xpZW50LAorCQl0bXAgPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShkYXRhLAogCQkJCQkgICBXODM2
MjdFSEZfUkVHX1RFTVBfQ09ORklHW2ldKTsKIAkJaWYgKHRtcCAmIDB4MDEpCi0JCQl3ODM2Mjdl
aGZfd3JpdGVfdmFsdWUoY2xpZW50LAorCQkJdzgzNjI3ZWhmX3dyaXRlX3ZhbHVlKGRhdGEsCiAJ
CQkJCSAgICAgIFc4MzYyN0VIRl9SRUdfVEVNUF9DT05GSUdbaV0sCiAJCQkJCSAgICAgIHRtcCAm
IDB4ZmUpOwogCX0KIH0KIAotc3RhdGljIGludCB3ODM2MjdlaGZfZGV0ZWN0KHN0cnVjdCBpMmNf
YWRhcHRlciAqYWRhcHRlcikKKy8qIHc4MzYyN2VoZl9wcm9iZSgpIGxvb2tzIGZvciBhIFN1cGVy
LUkvTyBjaGlwIGF0IGtub3duIGFkZHJlc3NlcyAqLworc3RhdGljIGludCBfX2RldmluaXQgdzgz
NjI3ZWhmX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7Ci0Jc3RydWN0IGky
Y19jbGllbnQgKmNsaWVudDsKLQlzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEgKmRhdGE7Ci0Jc3RydWN0
IGRldmljZSAqZGV2OworCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7CisJc3RydWN0
IHc4MzYyN2VoZl9kYXRhICpkYXRhID0gcGRldi0+ZGV2LnBsYXRmb3JtX2RhdGE7CiAJdTggZmFu
NHBpbiwgZmFuNXBpbjsKIAlpbnQgaSwgZXJyID0gMDsKIAotCWlmICghcmVxdWVzdF9yZWdpb24o
YWRkcmVzcyArIElPUkVHSU9OX09GRlNFVCwgSU9SRUdJT05fTEVOR1RILAotCSAgICAgICAgICAg
ICAgICAgICAgdzgzNjI3ZWhmX2RyaXZlci5kcml2ZXIubmFtZSkpIHsKKwlpZiAoIXJlcXVlc3Rf
cmVnaW9uKGRhdGEtPmFkZHIgKyBSRUdJT05fT0ZGU0VULCBSRUdJT05fTEVOR1RILAorCQkJICAg
RFJWTkFNRSkpIHsKIAkJZXJyID0gLUVCVVNZOworCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBy
ZXF1ZXN0IHJlZ2lvbiAweCVseC0weCVseFxuIiwKKwkJCSh1bnNpZ25lZCBsb25nKSAoZGF0YS0+
YWRkciArIFJFR0lPTl9PRkZTRVQpLAorCQkJKHVuc2lnbmVkIGxvbmcpICgKKwkJCWRhdGEtPmFk
ZHIgKyBSRUdJT05fT0ZGU0VUICsgUkVHSU9OX0xFTkdUSCAtIDEpKTsKIAkJZ290byBleGl0Owog
CX0KIAotCWlmICghKGRhdGEgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEp
LCBHRlBfS0VSTkVMKSkpIHsKLQkJZXJyID0gLUVOT01FTTsKLQkJZ290byBleGl0X3JlbGVhc2U7
Ci0JfQotCi0JY2xpZW50ID0gJmRhdGEtPmNsaWVudDsKLQlpMmNfc2V0X2NsaWVudGRhdGEoY2xp
ZW50LCBkYXRhKTsKLQljbGllbnQtPmFkZHIgPSBhZGRyZXNzOwotCW11dGV4X2luaXQoJmRhdGEt
PmxvY2spOwotCWNsaWVudC0+YWRhcHRlciA9IGFkYXB0ZXI7Ci0JY2xpZW50LT5kcml2ZXIgPSAm
dzgzNjI3ZWhmX2RyaXZlcjsKLQljbGllbnQtPmZsYWdzID0gMDsKLQlkZXYgPSAmY2xpZW50LT5k
ZXY7Ci0KLQlpZiAodzgzNjI3ZWhmX251bV9pbiA9PSA5KQotCQlzdHJsY3B5KGNsaWVudC0+bmFt
ZSwgInc4MzYyN2RoZyIsIEkyQ19OQU1FX1NJWkUpOwotCWVsc2UJLyoganVzdCBzYXkgZWhmLiA2
MjdFSEcgaXMgNjI3RUhGIGluIGxlYWQtZnJlZSBwYWNrYWdpbmcuICovCi0JCXN0cmxjcHkoY2xp
ZW50LT5uYW1lLCAidzgzNjI3ZWhmIiwgSTJDX05BTUVfU0laRSk7CisJLyogZmlsbCBpbiBmaWVs
ZHMgaW4gKmRhdGEgc28gdzgzNjI3ZWhmX3JlYWRfdmFsdWUoKSwgZXRjLiwgd29yayAqLwogCiAJ
ZGF0YS0+dmFsaWQgPSAwOworCW11dGV4X2luaXQoJmRhdGEtPmxvY2spOwogCW11dGV4X2luaXQo
JmRhdGEtPnVwZGF0ZV9sb2NrKTsKIAotCS8qIFRlbGwgdGhlIGkyYyBsYXllciBhIG5ldyBjbGll
bnQgaGFzIGFycml2ZWQgKi8KLQlpZiAoKGVyciA9IGkyY19hdHRhY2hfY2xpZW50KGNsaWVudCkp
KQotCQlnb3RvIGV4aXRfZnJlZTsKKwkvKiA2MjdFSEcgYW5kIDYyN0VIRiBoYXZlIDEwIHZvbHRh
Z2UgaW5wdXRzOyBESEcgaGFzIDkgKi8KKwlkYXRhLT5pbl9udW0gPSAoZGF0YS0+a2luZCA9PSB3
ODM2MjdkaGcpID8gOSA6IDEwOwogCiAJLyogSW5pdGlhbGl6ZSB0aGUgY2hpcCAqLwotCXc4MzYy
N2VoZl9pbml0X2NsaWVudChjbGllbnQpOworCXc4MzYyN2VoZl9pbml0X2RldmljZShkYXRhKTsK
IAotCS8qIEEgZmV3IHZhcnMgbmVlZCB0byBiZSBmaWxsZWQgdXBvbiBzdGFydHVwICovCiAJZm9y
IChpID0gMDsgaSA8IDU7IGkrKykKLQkJZGF0YS0+ZmFuX21pbltpXSA9IHc4MzYyN2VoZl9yZWFk
X3ZhbHVlKGNsaWVudCwKKwkJZGF0YS0+ZmFuX21pbltpXSA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVl
KGRhdGEsCiAJCQkJICAgVzgzNjI3RUhGX1JFR19GQU5fTUlOW2ldKTsKIAogCS8qIGZhbjQgYW5k
IGZhbjUgc2hhcmUgc29tZSBwaW5zIHdpdGggdGhlIEdQSU8gYW5kIHNlcmlhbCBmbGFzaCAqLwog
Ci0Jc3VwZXJpb19lbnRlcigpOwotCWZhbjVwaW4gPSBzdXBlcmlvX2luYigweDI0KSAmIDB4MjsK
LQlmYW40cGluID0gc3VwZXJpb19pbmIoMHgyOSkgJiAweDY7Ci0Jc3VwZXJpb19leGl0KCk7CisJ
c3VwZXJpb19lbnRlcihkYXRhLT5zaW9yZWcpOworCWZhbjVwaW4gPSBzdXBlcmlvX2luYihkYXRh
LT5zaW9yZWcsIDB4MjQpICYgMHgyOworCWZhbjRwaW4gPSBzdXBlcmlvX2luYihkYXRhLT5zaW9y
ZWcsIDB4MjkpICYgMHg2OworCXN1cGVyaW9fZXhpdChkYXRhLT5zaW9yZWcpOwogCiAJLyogSXQg
bG9va3MgbGlrZSBmYW40IGFuZCBmYW41IHBpbnMgY2FuIGJlIGFsdGVybmF0aXZlbHkgdXNlZAog
CSAgIGFzIGZhbiBvbi9vZmYgc3dpdGNoZXMsIGJ1dCBmYW41IGNvbnRyb2wgaXMgd3JpdGUgb25s
eSA6LwpAQCAtMTI0OCw3ICsxMjI5LDcgQEAKIAkgICBpcyBub3QgdGhlIGRlZmF1bHQuICovCiAK
IAlkYXRhLT5oYXNfZmFuID0gMHgwNzsgLyogZmFuMSwgZmFuMiBhbmQgZmFuMyAqLwotCWkgPSB3
ODM2MjdlaGZfcmVhZF92YWx1ZShjbGllbnQsIFc4MzYyN0VIRl9SRUdfRkFORElWMSk7CisJaSA9
IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGRhdGEsIFc4MzYyN0VIRl9SRUdfRkFORElWMSk7CiAJaWYg
KChpICYgKDEgPDwgMikpICYmICghZmFuNHBpbikpCiAJCWRhdGEtPmhhc19mYW4gfD0gKDEgPDwg
Myk7CiAJaWYgKCEoaSAmICgxIDw8IDEpKSAmJiAoIWZhbjVwaW4pKQpAQCAtMTI1Nyw3ICsxMjM4
LDcgQEAKIAkvKiBSZWdpc3RlciBzeXNmcyBob29rcyAqLwogICAJZm9yIChpID0gMDsgaSA8IEFS
UkFZX1NJWkUoc2RhX3NmM19hcnJheXMpOyBpKyspCiAJCWlmICgoZXJyID0gZGV2aWNlX2NyZWF0
ZV9maWxlKGRldiwKLQkJCSZzZGFfc2YzX2FycmF5c1tpXS5kZXZfYXR0cikpKQorCQkJCSZzZGFf
c2YzX2FycmF5c1tpXS5kZXZfYXR0cikpKQogCQkJZ290byBleGl0X3JlbW92ZTsKIAogCS8qIGlm
IGZhbjQgaXMgZW5hYmxlZCBjcmVhdGUgdGhlIHNmMyBmaWxlcyBmb3IgaXQgKi8KQEAgLTEyNjgs
NyArMTI0OSw3IEBACiAJCQkJZ290byBleGl0X3JlbW92ZTsKIAkJfQogCi0JZm9yIChpID0gMDsg
aSA8IHc4MzYyN2VoZl9udW1faW47IGkrKykKKwlmb3IgKGkgPSAwOyBpIDwgZGF0YS0+aW5fbnVt
OyBpKyspCiAJCWlmICgoZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxlKGRldiwgJnNkYV9pbl9pbnB1
dFtpXS5kZXZfYXR0cikpCiAJCQl8fCAoZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxlKGRldiwKIAkJ
CQkmc2RhX2luX2FsYXJtW2ldLmRldl9hdHRyKSkKQEAgLTEzMDgsNiArMTI4OSwxMCBAQAogCQlp
ZiAoKGVyciA9IGRldmljZV9jcmVhdGVfZmlsZShkZXYsICZzZGFfdGVtcFtpXS5kZXZfYXR0cikp
KQogCQkJZ290byBleGl0X3JlbW92ZTsKIAorCWVyciA9IGRldmljZV9jcmVhdGVfZmlsZShkZXYs
ICZkZXZfYXR0cl9uYW1lKTsKKwlpZiAoZXJyKQorCQlnb3RvIGV4aXRfcmVtb3ZlOworCiAJZGF0
YS0+Y2xhc3NfZGV2ID0gaHdtb25fZGV2aWNlX3JlZ2lzdGVyKGRldik7CiAJaWYgKElTX0VSUihk
YXRhLT5jbGFzc19kZXYpKSB7CiAJCWVyciA9IFBUUl9FUlIoZGF0YS0+Y2xhc3NfZGV2KTsKQEAg
LTEzMTgsOTUgKzEzMDMsMTg0IEBACiAKIGV4aXRfcmVtb3ZlOgogCXc4MzYyN2VoZl9kZXZpY2Vf
cmVtb3ZlX2ZpbGVzKGRldik7Ci0JaTJjX2RldGFjaF9jbGllbnQoY2xpZW50KTsKLWV4aXRfZnJl
ZToKLQlrZnJlZShkYXRhKTsKLWV4aXRfcmVsZWFzZToKLQlyZWxlYXNlX3JlZ2lvbihhZGRyZXNz
ICsgSU9SRUdJT05fT0ZGU0VULCBJT1JFR0lPTl9MRU5HVEgpOworCXJlbGVhc2VfcmVnaW9uKGRh
dGEtPmFkZHIgKyBSRUdJT05fT0ZGU0VULCBSRUdJT05fTEVOR1RIKTsKIGV4aXQ6CiAJcmV0dXJu
IGVycjsKIH0KIAotc3RhdGljIGludCB3ODM2MjdlaGZfZGV0YWNoX2NsaWVudChzdHJ1Y3QgaTJj
X2NsaWVudCAqY2xpZW50KQorc3RhdGljIGludCBfX2RldmV4aXQgdzgzNjI3ZWhmX3JlbW92ZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogewotCXN0cnVjdCB3ODM2MjdlaGZfZGF0YSAq
ZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOwotCWludCBlcnI7CisJc3RydWN0IHc4
MzYyN2VoZl9kYXRhICpkYXRhID0gcGRldi0+ZGV2LnBsYXRmb3JtX2RhdGE7CiAKIAlod21vbl9k
ZXZpY2VfdW5yZWdpc3RlcihkYXRhLT5jbGFzc19kZXYpOwotCXc4MzYyN2VoZl9kZXZpY2VfcmVt
b3ZlX2ZpbGVzKCZjbGllbnQtPmRldik7Ci0KLQlpZiAoKGVyciA9IGkyY19kZXRhY2hfY2xpZW50
KGNsaWVudCkpKQotCQlyZXR1cm4gZXJyOwotCXJlbGVhc2VfcmVnaW9uKGNsaWVudC0+YWRkciAr
IElPUkVHSU9OX09GRlNFVCwgSU9SRUdJT05fTEVOR1RIKTsKKwl3ODM2MjdlaGZfZGV2aWNlX3Jl
bW92ZV9maWxlcygmcGRldi0+ZGV2KTsKKwlwZGV2LT5kZXYucGxhdGZvcm1fZGF0YSA9IE5VTEw7
CisJcmVsZWFzZV9yZWdpb24oZGF0YS0+YWRkciArIFJFR0lPTl9PRkZTRVQsIFJFR0lPTl9MRU5H
VEgpOworCisJLyogUGxlYXNlIG5vdGUgdGhhdCB0aGUga3phbGxvYygpIGlzIG5vdCBpbiB3ODM2
MjdlaGZfcHJvYmUoKSAtLSBpdCBpcworCSAqIGluIHNlbnNvcnNfdzgzNjI3ZWhmX2luaXQoKSBi
ZWNhdXNlIFN1cGVyLUkvTyBjb25maWd1cmF0aW9uIGRhdGEKKwkgKiBpcyBzdG9yZWQgaW4gaXQg
KHNwZWNpZmljYWxseSwgZGF0YS0+c2lvcmVnIGFuZCBkYXRhLT5hZGRyKS4gVGhpcworCSAqIGlz
IG5vdCBjb25zaXN0ZW50IHdpdGggdGhlIGRldmljZSBkcml2ZXIgbW9kZWwsIGFuZCBuZWVkcyB0
byBiZQorCSAqIGZpeGVkIHdoZW4gYSBmdWxsIFN1cGVyLUkvTyBidXMgZHJpdmVyIGlzIGluIHBs
YWNlLiBrZnJlZSB0aGUgZGF0YQorCSAqIGhlcmUgZm9yIG5vdyBiZWNhdXNlIGl0IGlzIHNpbXBs
ZXIgdGhhbiBkb2luZyBpdCBpbgorCSAqIHNlbnNvcnNfdzgzNjI3ZWhmX2V4aXQoKSAqLwogCWtm
cmVlKGRhdGEpOwogCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciB3
ODM2MjdlaGZfZHJpdmVyID0geworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgdzgzNjI3
ZWhmX2RyaXZlciA9IHsKIAkuZHJpdmVyID0gewogCQkub3duZXIJPSBUSElTX01PRFVMRSwKLQkJ
Lm5hbWUJPSAidzgzNjI3ZWhmIiwKKwkJLm5hbWUJPSBEUlZOQU1FLAogCX0sCi0JLmF0dGFjaF9h
ZGFwdGVyCT0gdzgzNjI3ZWhmX2RldGVjdCwKLQkuZGV0YWNoX2NsaWVudAk9IHc4MzYyN2VoZl9k
ZXRhY2hfY2xpZW50LAorCS5wcm9iZQkJPSB3ODM2MjdlaGZfcHJvYmUsCisJLnJlbW92ZQkJPSBf
X2RldmV4aXRfcCh3ODM2MjdlaGZfcmVtb3ZlKSwKIH07CiAKLXN0YXRpYyBpbnQgX19pbml0IHc4
MzYyN2VoZl9maW5kKGludCBzaW9hZGRyLCB1bnNpZ25lZCBzaG9ydCAqYWRkcikKKy8qIHc4MzYy
N2VoZl9zdXBlcmlvX3Byb2JlKCkgbG9va3MgZm9yIGEgJzYyNyBpbiB0aGUgU3VwZXItSS9PIGNv
bmZpZyBzcGFjZSAqLworc3RhdGljIGludCBfX2luaXQgdzgzNjI3ZWhmX3N1cGVyaW9fcHJvYmUo
aW50IHNpb2FkZHIsCisJCQkJCSAgc3RydWN0IHc4MzYyN2VoZl9kYXRhICpkYXRhKQogewogCXUx
NiB2YWw7CiAKLQlSRUcgPSBzaW9hZGRyOwotCVZBTCA9IHNpb2FkZHIgKyAxOwotCXN1cGVyaW9f
ZW50ZXIoKTsKKwlzdGF0aWMgY29uc3QgY2hhciBfX2luaXRkYXRhIHNpb19uYW1lX1c4MzYyN0VI
RltdID0gIlc4MzYyN0VIRiI7CisJc3RhdGljIGNvbnN0IGNoYXIgX19pbml0ZGF0YSBzaW9fbmFt
ZV9XODM2MjdFSEdbXSA9ICJXODM2MjdFSEciOworCXN0YXRpYyBjb25zdCBjaGFyIF9faW5pdGRh
dGEgc2lvX25hbWVfVzgzNjI3REhHW10gPSAiVzgzNjI3REhHIjsKKworCWNvbnN0IGNoYXIgKiBz
aW9fbmFtZTsKIAotCXZhbCA9IChzdXBlcmlvX2luYihTSU9fUkVHX0RFVklEKSA8PCA4KQotCSAg
ICB8IHN1cGVyaW9faW5iKFNJT19SRUdfREVWSUQgKyAxKTsKKwlkYXRhLT5zaW9yZWcgPSBzaW9h
ZGRyOworCisJc3VwZXJpb19lbnRlcihkYXRhLT5zaW9yZWcpOworCisJdmFsID0gKHN1cGVyaW9f
aW5iKGRhdGEtPnNpb3JlZywgU0lPX1JFR19ERVZJRCkgPDwgOCkKKwkgICAgfCBzdXBlcmlvX2lu
YihkYXRhLT5zaW9yZWcsIFNJT19SRUdfREVWSUQgKyAxKTsKIAlzd2l0Y2ggKHZhbCAmIFNJT19J
RF9NQVNLKSB7Ci0JY2FzZSBTSU9fVzgzNjI3REhHX0lEOgotCQl3ODM2MjdlaGZfbnVtX2luID0g
OTsKLQkJYnJlYWs7CiAJY2FzZSBTSU9fVzgzNjI3RUhGX0lEOgorCQlkYXRhLT5raW5kID0gdzgz
NjI3ZWhmOworCQlzaW9fbmFtZSA9IHNpb19uYW1lX1c4MzYyN0VIRjsKKwkJYnJlYWs7CiAJY2Fz
ZSBTSU9fVzgzNjI3RUhHX0lEOgotCQl3ODM2MjdlaGZfbnVtX2luID0gMTA7CisJCWRhdGEtPmtp
bmQgPSB3ODM2MjdlaGY7CisJCXNpb19uYW1lID0gc2lvX25hbWVfVzgzNjI3RUhHOworCQlicmVh
azsKKwljYXNlIFNJT19XODM2MjdESEdfSUQ6CisJCWRhdGEtPmtpbmQgPSB3ODM2MjdkaGc7CisJ
CXNpb19uYW1lID0gc2lvX25hbWVfVzgzNjI3REhHOwogCQlicmVhazsKIAlkZWZhdWx0OgotCQlw
cmludGsoS0VSTl9XQVJOSU5HICJ3ODM2MjdlaGY6IHVuc3VwcG9ydGVkIGNoaXAgSUQ6IDB4JTA0
eFxuIiwKKwkJcHJfaW5mbyhEUlZOQU1FICI6IHVuc3VwcG9ydGVkIGNoaXAgSUQ6IDB4JTA0eFxu
IiwKIAkJCXZhbCk7Ci0JCXN1cGVyaW9fZXhpdCgpOworCQlzdXBlcmlvX2V4aXQoZGF0YS0+c2lv
cmVnKTsKIAkJcmV0dXJuIC1FTk9ERVY7CiAJfQogCi0Jc3VwZXJpb19zZWxlY3QoVzgzNjI3RUhG
X0xEX0hXTSk7Ci0JdmFsID0gKHN1cGVyaW9faW5iKFNJT19SRUdfQUREUikgPDwgOCkKLQkgICAg
fCBzdXBlcmlvX2luYihTSU9fUkVHX0FERFIgKyAxKTsKLQkqYWRkciA9IHZhbCAmIElPUkVHSU9O
X0FMSUdOTUVOVDsKLQlpZiAoKmFkZHIgPT0gMCkgewotCQlzdXBlcmlvX2V4aXQoKTsKKwkvKiB3
ZSBoYXZlIGtub3duIGNoaXAgZmluZCB0aGUgSFdNT04gYmFzZSAqLworCisJc3VwZXJpb19zZWxl
Y3QoZGF0YS0+c2lvcmVnLCBXODM2MjdFSEZfTERfSFdNKTsKKwl2YWwgPSAoc3VwZXJpb19pbmIo
ZGF0YS0+c2lvcmVnLCBTSU9fUkVHX0FERFIpIDw8IDgpCisJICAgIHwgc3VwZXJpb19pbmIoZGF0
YS0+c2lvcmVnLCBTSU9fUkVHX0FERFIgKyAxKTsKKwlkYXRhLT5hZGRyID0gdmFsICYgUkVHSU9O
X0FMSUdOTUVOVDsKKwlpZiAoZGF0YS0+YWRkciA9PSAwKSB7CisJCXN1cGVyaW9fZXhpdChkYXRh
LT5zaW9yZWcpOwogCQlyZXR1cm4gLUVOT0RFVjsKIAl9CiAKIAkvKiBBY3RpdmF0ZSBsb2dpY2Fs
IGRldmljZSBpZiBuZWVkZWQgKi8KLQl2YWwgPSBzdXBlcmlvX2luYihTSU9fUkVHX0VOQUJMRSk7
CisJdmFsID0gc3VwZXJpb19pbmIoZGF0YS0+c2lvcmVnLCBTSU9fUkVHX0VOQUJMRSk7CiAJaWYg
KCEodmFsICYgMHgwMSkpCi0JCXN1cGVyaW9fb3V0YihTSU9fUkVHX0VOQUJMRSwgdmFsIHwgMHgw
MSk7CisJCXN1cGVyaW9fb3V0YihkYXRhLT5zaW9yZWcsIFNJT19SRUdfRU5BQkxFLCB2YWwgfCAw
eDAxKTsKIAotCXN1cGVyaW9fZXhpdCgpOworCXN1cGVyaW9fZXhpdChkYXRhLT5zaW9yZWcpOwor
CXByX2luZm8oRFJWTkFNRSAiOiBGb3VuZCAlcyBjaGlwIGF0ICUjeFxuIiwKKwkJc2lvX25hbWUs
IGRhdGEtPmFkZHIpOwogCXJldHVybiAwOwogfQogCisvKiB3aGVuIFN1cGVyLUkvTyBmdW5jdGlv
bnMgbW92ZSB0byBhIHNlcGFyYXRlIGZpbGUsIHRoZSBTdXBlci1JL08KKyAqIGJ1cyB3aWxsIG1h
bmFnZSB0aGUgbGlmZXRpbWUgb2YgdGhlIGRldmljZSBhbmQgdGhpcyBtb2R1bGUgd2lsbCBvbmx5
IGtlZXAKKyAqIHRyYWNrIG9mIHRoZSB3ODM2MjdlaGYgZHJpdmVyLiBCdXQgc2luY2Ugd2UgcGxh
dGZvcm1fZGV2aWNlX2FsbG9jKCksIHdlCisgKiBtdXN0IGtlZXAgdHJhY2sgb2YgdGhlIGRldmlj
ZSAqLworc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7CisKIHN0YXRpYyBpbnQg
X19pbml0IHNlbnNvcnNfdzgzNjI3ZWhmX2luaXQodm9pZCkKIHsKLQlpZiAodzgzNjI3ZWhmX2Zp
bmQoMHgyZSwgJmFkZHJlc3MpCi0JICYmIHc4MzYyN2VoZl9maW5kKDB4NGUsICZhZGRyZXNzKSkK
LQkJcmV0dXJuIC1FTk9ERVY7CisJaW50IGVycjsKKwlzdHJ1Y3QgcmVzb3VyY2UgcmVzOworCXN0
cnVjdCB3ODM2MjdlaGZfZGF0YSAqZGF0YTsKKworCWlmICghKGRhdGEgPSBremFsbG9jKHNpemVv
ZihzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEpLCBHRlBfS0VSTkVMKSkpIHsKKwkJZXJyID0gLUVOT01F
TTsKKwkJZ290byBleGl0OworCX0KKworCS8qIGluaXRpYWxpemUgZGF0YS0+a2luZCwgZGF0YS0+
c2lvcmVnLCBhbmQgZGF0YS0+YWRkci4KKwkgKgorCSAqIHdoZW4gU3VwZXItSS9PIGZ1bmN0aW9u
cyBtb3ZlIHRvIGEgc2VwYXJhdGUgZmlsZSwgdGhlIFN1cGVyLUkvTworCSAqIGRyaXZlciB3aWxs
IHByb2JlIDB4MmUgYW5kIDB4NGUgYW5kIGF1dG8tZGV0ZWN0IHRoZSBwcmVzZW5jZSBvZiBhCisJ
ICogdzgzNjI3ZWhmIGhhcmR3YXJlIG1vbml0b3IsIGFuZCBjYWxsIHByb2JlKCkgKi8KKwlpZiAo
dzgzNjI3ZWhmX3N1cGVyaW9fcHJvYmUoMHgyZSwgZGF0YSkgJiYKKwkgICAgdzgzNjI3ZWhmX3N1
cGVyaW9fcHJvYmUoMHg0ZSwgZGF0YSkpIHsKKwkJZXJyID0gLUVOT0RFVjsKKwkJZ290byBleGl0
X2ZyZWU7CisJfQogCi0JcmV0dXJuIGkyY19pc2FfYWRkX2RyaXZlcigmdzgzNjI3ZWhmX2RyaXZl
cik7CisJLyogIT0wIHRvIHN1cHByZXNzIHdhcm5pbmc6CisJICogc3VnZ2VzdCBwYXJlbnRoZXNl
cyBhcm91bmQgYXNzaWdubWVudCB1c2VkIGFzIHRydXRoIHZhbHVlICovCisJaWYgKChlcnIgPSBw
bGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJnc4MzYyN2VoZl9kcml2ZXIpKSE9MCkKKwkJZ290byBl
eGl0X2ZyZWU7CisKKwlpZiAoIShwZGV2ID0gcGxhdGZvcm1fZGV2aWNlX2FsbG9jKERSVk5BTUUs
IGRhdGEtPmFkZHIpKSkgeworCQllcnIgPSAtRU5PTUVNOworCQlwcmludGsoS0VSTl9FUlIgRFJW
TkFNRSAiOiBEZXZpY2UgYWxsb2NhdGlvbiBmYWlsZWRcbiIpOworCQlnb3RvIGV4aXRfdW5yZWdp
c3RlcjsKKwl9CisKKwlwZGV2LT5kZXYucGxhdGZvcm1fZGF0YSA9IGRhdGE7CisKKwltZW1zZXQo
JnJlcywgMCwgc2l6ZW9mKHJlcykpOworCWRhdGEtPm5hbWUgPSB3ODM2MjdlaGZfZGV2aWNlX25h
bWVzW2RhdGEtPmtpbmRdOworCXJlcy5uYW1lID0gZGF0YS0+bmFtZTsKKwlyZXMuc3RhcnQgPSBk
YXRhLT5hZGRyICsgUkVHSU9OX09GRlNFVDsKKwlyZXMuZW5kID0gZGF0YS0+YWRkciArIFJFR0lP
Tl9PRkZTRVQgKyBSRUdJT05fTEVOR1RIIC0gMTsKKwlyZXMuZmxhZ3MgPSBJT1JFU09VUkNFX0lP
OworCWVyciA9IHBsYXRmb3JtX2RldmljZV9hZGRfcmVzb3VyY2VzKHBkZXYsICZyZXMsIDEpOwor
CWlmIChlcnIpIHsKKwkJcHJpbnRrKEtFUk5fRVJSIERSVk5BTUUgIjogRGV2aWNlIHJlc291cmNl
IGFkZGl0aW9uIGZhaWxlZCAiCisJCSAgICAgICAiKCVkKVxuIiwgZXJyKTsKKwkJZ290byBleGl0
X2RldmljZV9wdXQ7CisJfQorCisJLyogcGxhdGZvcm1fZGV2aWNlX2FkZCBjYWxscyBwcm9iZSgp
ICovCisJZXJyID0gcGxhdGZvcm1fZGV2aWNlX2FkZChwZGV2KTsKKwlpZiAoZXJyKSB7CisJCXBy
aW50ayhLRVJOX0VSUiBEUlZOQU1FICI6IERldmljZSBhZGRpdGlvbiBmYWlsZWQgKCVkKVxuIiwK
KwkJICAgICAgIGVycik7CisJCWdvdG8gZXhpdF9kZXZpY2VfcHV0OworCX0KKworCXJldHVybiAw
OworCitleGl0X2RldmljZV9wdXQ6CisJcGRldi0+ZGV2LnBsYXRmb3JtX2RhdGEgPSBOVUxMOwor
CXBsYXRmb3JtX2RldmljZV9wdXQocGRldik7CitleGl0X3VucmVnaXN0ZXI6CisJcGxhdGZvcm1f
ZHJpdmVyX3VucmVnaXN0ZXIoJnc4MzYyN2VoZl9kcml2ZXIpOworZXhpdF9mcmVlOgorCWtmcmVl
KGRhdGEpOworZXhpdDoKKwlyZXR1cm4gZXJyOwogfQogCiBzdGF0aWMgdm9pZCBfX2V4aXQgc2Vu
c29yc193ODM2MjdlaGZfZXhpdCh2b2lkKQogewotCWkyY19pc2FfZGVsX2RyaXZlcigmdzgzNjI3
ZWhmX2RyaXZlcik7CisJLyogd2hlbiBTdXBlci1JL08gZnVuY3Rpb25zIG1vdmUgdG8gYSBzZXBh
cmF0ZSBmaWxlLCBkZXZpY2VzCisJICogd2lsbCBiZSB1bnJlZ2lzdGVyZWQgYmVmb3JlIHVubG9h
ZGluZyB0aGUgbW9kdWxlLgorCSAqCisJICogZm9yIG5vdywgb25seSBvbmUgZGV2aWNlIGlzIGFk
ZGVkIGluIHNlbnNvcnNfdzgzNjI3ZWhmX2luaXQgKi8KKwlwbGF0Zm9ybV9kZXZpY2VfdW5yZWdp
c3RlcihwZGV2KTsKKwlwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3RlcigmdzgzNjI3ZWhmX2RyaXZl
cik7CiB9CiAKIE1PRFVMRV9BVVRIT1IoIkplYW4gRGVsdmFyZSA8a2hhbGlAbGludXgtZnIub3Jn
PiIpOwotLS0gbGludXgtMi42LjIyLXJjMi9kcml2ZXJzL2h3bW9uL0tjb25maWcJMjAwNy0wNS0x
NyAxMToyMDo1Mi4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNi4yMi1yYzIvZHJpdmVycy9o
d21vbi9LY29uZmlnCTIwMDctMDUtMTcgMTE6MjA6NTAuMDAwMDAwMDAwIC0wNzAwCkBAIC01ODUs
OCArNTg1LDcgQEAKIAogY29uZmlnIFNFTlNPUlNfVzgzNjI3RUhGCiAJdHJpc3RhdGUgIldpbmJv
bmQgVzgzNjI3RUhGL0RIRyIKLQlkZXBlbmRzIG9uIEkyQyAmJiBFWFBFUklNRU5UQUwKLQlzZWxl
Y3QgSTJDX0lTQQorCWRlcGVuZHMgb24gSFdNT04gJiYgRVhQRVJJTUVOVEFMCiAJaGVscAogCSAg
SWYgeW91IHNheSB5ZXMgaGVyZSB5b3UgZ2V0IHN1cHBvcnQgZm9yIHRoZSBoYXJkd2FyZQogCSAg
bW9uaXRvcmluZyBmdW5jdGlvbmFsaXR5IG9mIHRoZSBXaW5ib25kIFc4MzYyN0VIRi9ESEcgU3Vw
ZXItSS9PIGNoaXAuCg==
------=_Part_65819_21859819.1179622658900
Content-Type: text/plain; 
	name=03-w83627ehf-msg-enabling-superio-or-address-zero.patch.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1wu7sq0
Content-Disposition: attachment;
	filename="03-w83627ehf-msg-enabling-superio-or-address-zero.patch.txt"

VGhpcyBwYXRjaCBhZGRzIG1vcmUgdXNlZnVsIGVycm9yIG1lc3NhZ2VzIGZvciB0d28gZXJyb3Ig
Y2FzZXMuCklmIHRoZSBTdXBlci1JL08gZGV2aWNlIGlzIGRpc2FibGVkLCBpdCBpcyBsaWtlbHkg
dGhlIEJJT1MgaGFzIGEgZ29vZCByZWFzb24KZm9yIGxlYXZpbmcgaXQgZGlzYWJsZWQsIHNvIGdp
dmUgYSB3YXJuaW5nIHdoZW4gZW5hYmxpbmcgaXQgLS0gaXQncyBub3QgbGlrZWx5CnRvIGJlIHdp
cmVkIGNvcnJlY3RseSBvciBiZSBhYmxlIHRvIGdpdmUgZ29vZCBkYXRhLgoKQWxzbywgaWYgdGhl
IFN1cGVyLUkvTyBkZXZpY2UgaXMgY29uZmlndXJlZCB3aXRoIGFuIGFkZHJlc3Mgb2YgMCwgdGhl
IGRyaXZlcgpyZWZ1c2VzIHRvIGluaXRpYWxpemUgaXQuCgpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBI
dWJiYXJkIDxkYXZpZC5jLmh1YmJhcmRAZ21haWwuY29tPgoKSW5kZXg6IGxpbnV4LTIuNi4yMi1y
YzIvZHJpdmVycy9od21vbi93ODM2MjdlaGYuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYuMjIt
cmMyL2RyaXZlcnMvaHdtb24vdzgzNjI3ZWhmLmMJMjAwNy0wNS0xOSAxNzoyOToyMS4wMDAwMDAw
MDAgLTA3MDAKKysrIGxpbnV4LTIuNi4yMi1yYzIvZHJpdmVycy9od21vbi93ODM2MjdlaGYuYwky
MDA3LTA1LTE5IDE3OjM4OjUzLjAwMDAwMDAwMCAtMDcwMApAQCAtMTM4MywxNCArMTM4MywxOSBA
QAogCSAgICB8IHN1cGVyaW9faW5iKGRhdGEtPnNpb3JlZywgU0lPX1JFR19BRERSICsgMSk7CiAJ
ZGF0YS0+YWRkciA9IHZhbCAmIFJFR0lPTl9BTElHTk1FTlQ7CiAJaWYgKGRhdGEtPmFkZHIgPT0g
MCkgeworCQlwcmludGsoS0VSTl9FUlIgRFJWTkFNRSAiOiByZWZ1c2luZyB0byBlbmFibGUgYSBT
dXBlci1JL08gIgorCQkJImRldmljZSB3aXRoIGEgYmFzZSBJL08gcG9ydCAwLlxuIik7CiAJCXN1
cGVyaW9fZXhpdChkYXRhLT5zaW9yZWcpOwogCQlyZXR1cm4gLUVOT0RFVjsKIAl9CiAKIAkvKiBB
Y3RpdmF0ZSBsb2dpY2FsIGRldmljZSBpZiBuZWVkZWQgKi8KIAl2YWwgPSBzdXBlcmlvX2luYihk
YXRhLT5zaW9yZWcsIFNJT19SRUdfRU5BQkxFKTsKLQlpZiAoISh2YWwgJiAweDAxKSkKKwlpZiAo
ISh2YWwgJiAweDAxKSkgeworCQlwcmludGsoS0VSTl9XQVJOSU5HIERSVk5BTUUgIjogRm9yY2li
bHkgZW5hYmxpbmcgU3VwZXItSS9PLiAiCisJCQkiU2Vuc29yIGlzIHByb2JhYmx5IHVudXNhYmxl
LlxuIik7CiAJCXN1cGVyaW9fb3V0YihkYXRhLT5zaW9yZWcsIFNJT19SRUdfRU5BQkxFLCB2YWwg
fCAweDAxKTsKKwl9CiAKIAlzdXBlcmlvX2V4aXQoZGF0YS0+c2lvcmVnKTsKIAlwcl9pbmZvKERS
Vk5BTUUgIjogRm91bmQgJXMgY2hpcCBhdCAlI3hcbiIsCg==
------=_Part_65819_21859819.1179622658900
Content-Type: text/plain; 
	name=04-w83627ehf-fan4-clock-divider-warning.patch.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1wu85cc
Content-Disposition: attachment;
	filename="04-w83627ehf-fan4-clock-divider-warning.patch.txt"

VGhpcyBwYXRjaCBmaXhlcyBhIGJ1ZyB3aGVyZSB0aGUgZHJpdmVyIG91dHB1dHMKIkluY3JlYXNp
bmcgZmFuIDQgY2xvY2sgZGl2aWRlciBmcm9tIDQgdG8gOCIgYW5kIGZpbGxzIHVwIHRoZSBrZXJu
ZWwgbWVzc2FnZQpsb2cuCgpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIdWJiYXJkIDxkYXZpZC5jLmh1
YmJhcmRAZ21haWwuY29tPgoKSW5kZXg6IGxpbnV4LTIuNi4yMi1yYzIvZHJpdmVycy9od21vbi93
ODM2MjdlaGYuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYuMjItcmMyL2RyaXZlcnMvaHdtb24v
dzgzNjI3ZWhmLmMJMjAwNy0wNS0xOSAxNzozODo1My4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4
LTIuNi4yMi1yYzIvZHJpdmVycy9od21vbi93ODM2MjdlaGYuYwkyMDA3LTA1LTE5IDE4OjEyOjIz
LjAwMDAwMDAwMCAtMDcwMApAQCAtNDAzLDcgKzQwMyw3IEBACiAJCWJyZWFrOwogCWNhc2UgNDoK
IAkJcmVnID0gKHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGRhdGEsIFc4MzYyN0VIRl9SRUdfRElPREUp
ICYgMHg3MykKLQkJICAgIHwgKChkYXRhLT5mYW5fZGl2WzRdICYgMHgwMykgPDwgMykKKwkJICAg
IHwgKChkYXRhLT5mYW5fZGl2WzRdICYgMHgwMykgPDwgMikKIAkJICAgIHwgKChkYXRhLT5mYW5f
ZGl2WzRdICYgMHgwNCkgPDwgNSk7CiAJCXc4MzYyN2VoZl93cml0ZV92YWx1ZShkYXRhLCBXODM2
MjdFSEZfUkVHX0RJT0RFLCByZWcpOwogCQlicmVhazsKQEAgLTQ2OCw3ICs0NjgsNyBAQAogCQkJ
ICYmIGRhdGEtPmZhbl9kaXZbaV0gPCAweDA3KSB7CiAJCQkgCWRldl9kYmcoZGV2LCAiSW5jcmVh
c2luZyBmYW4gJWQgIgogCQkJCQkiY2xvY2sgZGl2aWRlciBmcm9tICV1IHRvICV1XG4iLAotCQkJ
CQlpLCBkaXZfZnJvbV9yZWcoZGF0YS0+ZmFuX2RpdltpXSksCisJCQkJCWkrMSwgZGl2X2Zyb21f
cmVnKGRhdGEtPmZhbl9kaXZbaV0pLAogCQkJCQlkaXZfZnJvbV9yZWcoZGF0YS0+ZmFuX2Rpdltp
XSArIDEpKTsKIAkJCQlkYXRhLT5mYW5fZGl2W2ldKys7CiAJCQkJdzgzNjI3ZWhmX3dyaXRlX2Zh
bl9kaXYoZGF0YSwgaSk7CkBAIC0xMjQzLDExICsxMjQzLDEwIEBACiAKIAkvKiBpZiBmYW40IGlz
IGVuYWJsZWQgY3JlYXRlIHRoZSBzZjMgZmlsZXMgZm9yIGl0ICovCiAJaWYgKGRhdGEtPmhhc19m
YW4gJiAoMSA8PCAzKSkKLQkJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoc2RhX3NmM19hcnJh
eXNfZmFuNCk7IGkrKykgeworCQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShzZGFfc2YzX2Fy
cmF5c19mYW40KTsgaSsrKQogCQkJaWYgKChlcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoZGV2LAot
CQkJCSZzZGFfc2YzX2FycmF5c19mYW40W2ldLmRldl9hdHRyKSkpCisJCQkJCSZzZGFfc2YzX2Fy
cmF5c19mYW40W2ldLmRldl9hdHRyKSkpCiAJCQkJZ290byBleGl0X3JlbW92ZTsKLQkJfQogCiAJ
Zm9yIChpID0gMDsgaSA8IGRhdGEtPmluX251bTsgaSsrKQogCQlpZiAoKGVyciA9IGRldmljZV9j
cmVhdGVfZmlsZShkZXYsICZzZGFfaW5faW5wdXRbaV0uZGV2X2F0dHIpKQo=
------=_Part_65819_21859819.1179622658900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_65819_21859819.1179622658900--
