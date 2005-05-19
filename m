From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [gstewart@spamcop.net: Linux kernel / i2c_adapter structure]
Message-Id: <20031219120846.GA655@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Godwin Stewart <gstewart@spamcop.net> -----

From: Godwin Stewart <gstewart@spamcop.net>
To: Frodo Looijaard <frodol@dds.nl>
Subject: Linux kernel / i2c_adapter structure
Organization: Nope, none here, it's a mess ;o)
X-Face: #T;eJks=B[`71qrwp`l6BW8xI&hP8S*4Kd%e?8o"rL02ZYf"rWa41l83a)L,*;S).Ukq$U%
 II{-z#5%i&X8"%{$)ZWmE7WBDF)?wK1^7]u9T;@jqdZo?IT!d-L`!@&vW)F_1
X-Curious: You couldn't resist looking at these headers, could you!
X-MS_SUCKS: But we knew that :)
X-Operating-System: Slackware 9.0 (2.4.20)
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 

Hi there,

I noticed a change in the definition of the i2c_adapter structure in
$SRC/include/linux/i2c.h between the 2.4.x and 2.6.0 kernels. More
precisely, the following members are no longer present:

/* --- These may be NULL, but should increase the module use count */
        void (*inc_use)(struct i2c_adapter *);
        void (*dec_use)(struct i2c_adapter *);

        void *data;     /* private data for the adapter                 */
                        /* some data fields that are used by all types  */
                        /* these data fields are readonly to the public */
                        /* and can be set via the i2c_ioctl call        */


The problem is that the em8300 drivers for DXR3/Hollywood+ MPEG2 decoder
boards (see http://dxr3.sourceforge.net) use these members in their source.

My question is therefore, with what has their functionality been replaced?

For example :

static int em8300_i2c_reg(struct i2c_client *client)
{
        struct em8300_s *em = client->adapter->data;

        switch (client->driver->id) {
        case I2C_DRIVERID_ADV717X:
                if (!strncmp(client->name, "ADV7175", 7)) {
                        em->encoder_type = ENCODER_ADV7175;
                }
                if (!strncmp(client->name, "ADV7170", 7)) {
                        em->encoder_type = ENCODER_ADV7170;
                }
                em->encoder = client;
                break;
        case  I2C_DRIVERID_BT865:
                em->encoder_type = ENCODER_BT865;
                em->encoder = client;
                break;
        default:
                printk(KERN_ERR "em8300_i2c: unknown client id\n");
                return -ENODEV;
        }

        return 0;
}

In the above code, client->adapter is a struct i2c_adapter*, and the data
field is definitely used in order to identify the encoder chip used on the
board. I therefore need some way of working around the problem in order to
have a go at patching the em8300 drivers.

Many thanks in advance, and Season's Greetings if we don't "speak" until
after the festivities.

-- 
G. Stewart   --   gstewart@bonivet.net -- gstewart@spamcop.net
Registered Linux user #284683 (Slackware 9.0)
---------------------------------------------------------------
"I once had a rose named after me and I was very flattered. 
 But I was not pleased to read the description in the catalogue: 
 No good in a bed, but fine up against a wall."  
                  -- Eleanor Roosevelt 

----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
