From: dsaxena@plexity.net (Deepak Saxena)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH 2.6] Add support for Intel IXP42x GPIO-based I2C
Message-Id: <20040215192217.GB13612@plexity.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040213235906.GA5551@plexity.net>
In-Reply-To: <20040213235906.GA5551@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Feb 14 2004, at 23:19, Mark Studebaker was caught saying:
> This is quite board-specific.
> By definition General Purpose I/O are General Purpose.
> Why should the kernel have a GPIO-based I2C driver?

Because the way you access the GPIO is dependent on the specific 
chipset underneath.  The registers you use to access GPIO on a IXP425 
CPU is different than how you do so on an IXP2000 CPU. The GPIO lines 
are being used to create a bit-bang interface, and the driver takes the 
bit-banging instructions for SDA and SCL and swizzles the appropriate GPIO 
lines for the given platform.  I don't see how you would not have
a driver to do this unless the algo-bit driver becomes aware of the 
low-level interface.

> Is separating the GPIO definitions into your_platform.c (please provide 
> example...)
> really provide much benefit compared to just writing a driver
> for each motherboard?

Yes. The IXP425 has 16 GPIO pins and platform vendors are free
to choose just about anyone.  My original driver in 2.4 has
ugly #IFDEF CONFIG_FOO stuff to force the GPIO numbers for the 
specific platform we're runing on. Since the access code for
GPIOs is the same across all IXP425 platforms and the only thing
that changes is the GPIO numbers, the device model seems like
a good way to do this. This also allows me to build a  single
kernel that I can boot on  multiple IXP425 platforms and configure
the driver at runtime dependent on what platform I am. Makes it
really nice for doing system testing.

Here's the relevant code for arch/arm/mach-ixp425/ixdp425.c:

static struct ixp425_i2c_pins ixdp425_i2c_pins = {
	.sda_pin	= IXP425_GPIO_PIN_7,
	.scl_pin	= IXP425_GPIO_PIN_6
};

static struct platform_device ixdp425_i2c_controller = {
	.name		= "IXP425-I2C",
	.id		= 0,
	.dev		= {
		.platform_data = &ixdp425_i2c_pins,
	},
	.num_resources	= 0
};

static int __init ixdp425_init(void)
{
	if (!machine_is_ixdp425() && !machine_is_ixcdp1100())
		return -ENODEV;

	platform_add_device(&ixdp425_flash_device);
	platform_add_device(&ixdp425_i2c_controller);

	return 0;
}

Basically we create a platform device and then add it to the system.
The i2c-ixp42x driver catches this and grabs the GPIO numbers.

I don't want to force the driver into having the GPIO numbers built
in staticly or using module paramters for the reason above of multiple
platform kernels.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
