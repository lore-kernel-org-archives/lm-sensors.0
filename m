From: "KoalaBR" <koala_br@users.sourceforge.net>
Date: Wed, 28 Mar 2007 09:10:03 +0000
Subject: [lm-sensors] Newbie questions regarding driver writing
Message-Id: <200703281110.03424.koala_br@users.sourceforge.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_rDjCGTrSgo49uZy"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_rDjCGTrSgo49uZy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all,

sorry to bother you, but I try to write an i2c chip driver for the nouveau=
=20
project. It is intended to offer an unified interface for all supported=20
Nvidia cards to read out GPU temp and fan speed (perhaps with an added user=
=20
space library).=20

Currently this is a test module aimed to work only with my nvidia card. It =
is=20
easier for me to learn the ropes that way. It will be later merged with the=
=20
nouveau kernel module, where better dectection routines are available.

I tried to follow the Device Driver Kit documentation, the documentation in=
=20
the kernel and of course the source in drivers/i2c/chips. Furthermore I=20
looked at lm-sensors.org. It is slow going, as this is my first foray into=
=20
kernel space.

And yes, the module is far(!) from finished, important functions are not=20
fleshed out but available only as a stub or totally missing.

What works:
=A0- Inserting and removing the module prints the init messages and the i2c=
 core=20
says that my module is registered / unregistered. (i2c-core: driver [nv]=20
registered)

What does not work:
=A0- I intended to check whether I got ioremap() right and expected nv_dete=
ct to=20
be called. But it isn't (which means in turn means nv_attach_adapter() is n=
ot=20
called). And I honestly have no idea why this is. Perhaps the=20
call to nv_detect() is delayed until the first access to the module happens=
=20
(which obviously can't work right now, as those functions are missing).

What I don't understand yet:
 - How do I export the values from the sensor driver to user=20
space? /dec/i2c* /proc or even sysfs?

Could you give me a hint? I have attached the current version to the mail.

If you have any additional docs to hint me at, just do it, but any help wou=
ld=20
be very appreciated.

Thanks a lot for your help

Sincerely
B.Rathmann


--Boundary-00=_rDjCGTrSgo49uZy
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="i2c-driver.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="i2c-driver.c"


#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>

#include <linux/i2c.h>
#include <linux/i2c-dev.h>
#include <asm/io.h>


#include <linux/slab.h>

#define I2C_DRIVERID_NV4x 2811    ///< This needs to be defined officially, only for testing


MODULE_DESCRIPTION("NV4x I2C module");
MODULE_AUTHOR("KoalBR (koala_br@users.sourceforge.net)");
MODULE_LICENSE("BSD");

/* This is the driver that will be inserted
static struct i2c_driver chip_driver = {
	.owner		= THIS_MODULE,
	.name		= "tiny_chip",
	.flags		= I2C_DF_NOTIFY,
	.attach_adapter	= NULL ; /// chip_attach_adapter,
	.detach_client	= NULL;  ///chip_detach_client,
};
*/

static int nv_attach_adapter(struct i2c_adapter *adapter);
static int nv_detect(struct i2c_adapter *adapter, int address,
                     unsigned short flags, int kind);
static int nv_detach_client(struct i2c_client *client);

static unsigned short normal_i2c[] = { 0x20, I2C_CLIENT_END };

I2C_CLIENT_INSMOD;

static struct i2c_driver nv_driver = {
        .driver = {
                .name   = "nv",
                .owner  = THIS_MODULE,
        },
        .id             = I2C_DRIVERID_NV4x,
        .attach_adapter = nv_attach_adapter, //i2cdev_attach_adapter,
        .detach_adapter = nv_detach_client, //i2cdev_detach_adapter,
        .detach_client  = NULL, //i2cdev_detach_client,
};

struct nv_data { int    nv_card;     // The type of card NV40, NV43 ...
                 char  *nv_baseaddr; // The base address from where to add the offsets
                 struct i2c_client client;

               };


static int i2c_init_module(void)
{
    int result;
	printk( KERN_DEBUG "Module i2c init\n" );
	result = i2c_add_driver(&nv_driver);
	printk( KERN_DEBUG "Module i2c init - done\n" );
	return result;
}

static void i2c_exit_module(void)
{
	printk( KERN_DEBUG "Module i2c exit\n" );
	i2c_del_driver(&nv_driver);
}

static int nv_attach_adapter(struct i2c_adapter *adapter)
{
  printk( KERN_DEBUG "I2C attach_adapter\n" );
  return i2c_probe(adapter, &addr_data, nv_detect);
}

static int nv_detect(struct i2c_adapter *adapter, int address,
                     unsigned short flags, int kind)
{
  struct i2c_client *new_client;
  struct nv_data    *data;
  int                err = 0;
  const char        *client_name = "";
  int                pwm_divider = 0;

  printk( KERN_DEBUG "I2C Detect #1\n" );

  if (!(data = kzalloc(sizeof(struct nv_data), GFP_KERNEL)))
  {
      err = -ENOMEM;
      return err;
  }
  printk( KERN_DEBUG "I2C Detect #2\n" );
  new_client = &data->client;
  new_client->addr = address;
  new_client->adapter = adapter;
  new_client->driver = &nv_driver;
  new_client->flags = 0;
  // This is totally nonsense on any other card than mine:
  // Better do it like in the DRM. Find the card, deduce the type
  //
  printk( KERN_DEBUG "I2C Detect #3 - IOremap\n" );
  data->nv_baseaddr = ioremap(0xd4000000, 1024*1024*16);
  // Let's try some outputMODULE_AUTHOR
  pwm_divider = *(data->nv_baseaddr + 0x15f8/4) & 0x3fff;
  printk( KERN_DEBUG "NV I2C: %d\n", pwm_divider);
  iounmap(data->nv_baseaddr);
  kfree(data);
  return 0;
}



static int nv_detach_client(struct i2c_client *client)
{
   int    err;

/* if registration is completed do this for the nv* structs

       i2c_deregister_entry(((struct pcf8574_data *) (client->data))->
                                 sysctl_id);

        if ((err = i2c_detach_client(client))) {
                printk("pcf8574.o: Client deregistration failed, "
                       "client not detached.\n");
                return err;
        }

        kfree(client->data);
*/
        return 0;
}

module_init(i2c_init_module);
module_exit(i2c_exit_module);

--Boundary-00=_rDjCGTrSgo49uZy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_rDjCGTrSgo49uZy--
