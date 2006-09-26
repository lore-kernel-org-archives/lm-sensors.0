From: david.c.hubbard@gmail.com (David Hubbard)
Date: Tue, 26 Sep 2006 04:33:49 +0000
Subject: [lm-sensors] [RFC-patch 3/3] SuperIO locks coordinator - use in
Message-Id: <4dfa50520609252133o257733c5h4272594c6d20cff8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <450902B8.6040407@gmail.com>
In-Reply-To: <450902B8.6040407@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

This is a question about the w83627ehf driver, but it's nice and
general, so I'm looking at the way you did the pc8736x_gpio driver.
There's this line:

static struct superio* gate;

And the driver uses the global 'gate' to access the Super-I/O. Right
now in the w83627ehf driver, there are several globals:

/* The actual ISA address is read from Super-I/O configuration space */
static unsigned short address;

/*
 * Super-I/O constants and functions
 */

static int REG;		/* The register to read/write */
static int VAL;		/* The value to read/write */


Later on in the file, there's another global:

static struct i2c_driver w83627ehf_driver;


Now, I'm not the most knowledgeable one about the I2C subsystem, but I
believe that w83627ehf_driver is redeclared a little later with this:

static struct i2c_driver w83627ehf_driver = {
	.driver = {
		.name	= "w83627ehf",
	},
	.attach_adapter	= w83627ehf_detect,
	.detach_client	= w83627ehf_detach_client,
};


Jean mentioned that it might be a good idea to define .name at
runtime, depending on whether a w83627ehf or a w83627dhg was detected.
But the global stays, as part of the driver.

In moving to a driver / device model, it's possible to put a struct
superio inside struct w83627ehf_data, inside struct device, which is
part of struct i2c_adapter. (If I understand the I2C structures...if
not, I think this is on the right track.) While I'm at it, I can put
unsigned short address in there too. Personally, I'd like to remove
all the global variables. (But not the struct i2c_driver
w83627ehf_driver, plus the sensor_device_attribute structs, because
they are more like constants such as function callbacks.)

So I'm sitting here thinking about it, and it seems it could be done
that way. There are some parts I haven't worked out yet. Especially
embedding struct superio inside struct device. Is that valid?

Hmmm,
David

