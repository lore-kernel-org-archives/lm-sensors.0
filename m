From: Warrick Lacey <wlacey@salientsystems.com>
Date: Wed, 04 Jun 2008 15:33:16 +0000
Subject: [lm-sensors] adm1021 in 2.6.9 kernel not calling attach_adapter()
Message-Id: <4846B5BC.7050408@salientsystems.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040306050605090507040305"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040306050605090507040305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

I'm presently struggling to bring up the adm1021 driver under 2.6.9 in a 
VR7 device.

I see the i2c-piix4 driver attaching and then when the adm1021 is 
inserted, its attach function is not called, as if the kernel has no 
adapters to bind to the adm1021_driver.

int i2c_add_driver(struct i2c_driver *driver)
{
    struct list_head   *item;
    struct i2c_adapter *adapter;
    int res = 0;

    down(&core_lists);

    /* add the driver to the list of i2c drivers in the driver core */
    driver->driver.name = driver->name;
    driver->driver.bus = &i2c_bus_type;
    driver->driver.probe = i2c_device_probe;
    driver->driver.remove = i2c_device_remove;

    res = driver_register(&driver->driver);
    if (res)
        goto out_unlock;
   
    list_add_tail(&driver->list,&drivers);
    pr_debug("i2c-core: driver %s registered.\n", driver->name);

    /* now look for instances of driver on our adapters */
    if (driver->flags & I2C_DF_NOTIFY) {
        list_for_each(item,&adapters) {
            adapter = list_entry(item, struct i2c_adapter, list);
           /* driver->attach_adapter(adapter);  <-------------- */this 
_should_ call adm1021's attach_adapter() function but there is no 
iteration because presumably there are no adapters.
        }
    }

What do I need to do to get the kernel to see/detect my adm1021 device, 
it is hanging off an Intel piix4 device.

I'm probably doing something stupid but after three days what that 
stupid thing is eludes me.

thanks
Warrick


--------------040306050605090507040305
Content-Type: text/x-vcard; charset=utf-8;
 name="wlacey.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="wlacey.vcf"

begin:vcard
fn:Warrick Lacey
n:Lacey;Warrick
org:Salient Systems;Engineering
adr:Tuller Road;;4394 Suite K ;Dublin;Ohio;43017;U.S.A.
email;internet:wlacey@salientsystems.com
title:Software Developer
tel;work:(614) 792-5800
tel;cell:(614) 203-1323
x-mozilla-html:FALSE
url:http://www.salientsystems.com
version:2.1
end:vcard


--------------040306050605090507040305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040306050605090507040305--
