From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 15 Jul 2009 18:31:11 +0000
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire
Message-Id: <4A5E206F.8000001@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>	 <4A5CB908.4060404@cam.ac.uk>	 <528f13590907141358w17869b6fq450bf223e4f54687@mail.gmail.com>	 <4A5D6C0A.7030903@gmx.de>	 <528f13590907150722q2a91139bve72d65cbd555b8e9@mail.gmail.com>	 <4A5DEB12.3020602@cam.ac.uk> <528f13590907151032y30ae62beo486d4e1056219983@mail.gmail.com>
In-Reply-To: <528f13590907151032y30ae62beo486d4e1056219983-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

alfred steele wrote:
> Hi
> 
>> On an embedded board this would typically be in the board config
>> file.  For example, see arch/arm/mach-pxa/imote2.c which has an sht15
>> attached.  The exact method of registration may be a bit architecture
>> specific but will look something like the relevant parts of that file.
> Was trying to look through the imote2.c but i did not get any exact
> match, i am not sure if you are talking about the traditional method
> of declaring the platform data/device and use sort of
> platform_register(). Are you talking about the following chunk?
> 
> [vcc_sensor_1_8] = {
> 248                 .constraints = { /* default 1.8V */
> 249                         .name = "vcc_sensor_1_8",
> 250                         .min_uV = 1800000,
> 251                         .max_uV = 1800000,
> 252                 },
> 253         },
> 

Sorry, my mistake, the board support didn't merge until post 2.6.30 as
the driver merge occured well after the merge window for 2.6.30

Take a look at what is in the current tree.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mach-pxa/imote2.c

relevant bits are:


#include <linux/sht15.h>
...
couple of mfp defines to enable the gpios. (how you do this is platform dependent)
...
(note you will probably want to add the supply voltage in here)

120 static struct sht15_platform_data platform_data_sht15 = {
121         .gpio_data =  100,
122         .gpio_sck  =  98,
123 };
124
125 static struct platform_device sht15 = {
126         .name = "sht15",
127         .id = -1,
128         .dev = {
129                 .platform_data = &platform_data_sht15,
130         },
131 };
132 

 538 static struct platform_device *imote2_devices[] = {
...
541         &sht15,
542 };
...
 560         platform_add_devices(imote2_devices, ARRAY_SIZE(imote2_devices));

If you do back port the regulator framework there are some bits and bobs related
to that in there as well.

Jonathan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
