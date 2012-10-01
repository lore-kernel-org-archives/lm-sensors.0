From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 01 Oct 2012 17:19:25 +0000
Subject: Re: [lm-sensors] How to use SC18IS602 driver ?
Message-Id: <20121001171925.GA4430@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120928013559.GA14405@roeck-us.net>
In-Reply-To: <20120928013559.GA14405@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 01, 2012 at 09:03:15AM -0500, Bruce Parker wrote:

[ ... ]

> 
> Ok...got i2cdetect installed and below is result:
> # i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: UU UU UU UU UU UU UU UU UU -- -- -- -- -- -- --
> 30: -- 31 -- -- -- -- -- UU -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- UU -- -- --
> 50: UU UU UU UU UU UU UU -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> I2C-SPI bridge is at addr 28, so it appears to be detected. 
> 
> Below is my entry in device tree, but I do not see anything special in
> /dev/mtd*
>                                 spi: spi@28 {
>                                         compatible = "nxp,sc18is602";
>                                         #address-cells = <1>;
>                                         #size-cells = <0>;
>                                         reg = <0x28>;
>                                         m25p80@0 {
>                                                 #address-cells = <1>;
>                                                 #size-cells = <1>;
>                                                 compatible > "fsl,espi-flash";
>                                                 linux,modalias > "m25p80";
>                                                 spi-max-frequency > <25000000>;
>                                                 modal = "s25sl064a";
>                                                 reg = <0>;
>                                                 mode = <0>;
> 
>                                                 partition@0 {
>                                                     reg = <0x0
> 0x00080000>;
>                                                     label = "Test
> Image";
>                                                     read-only;
>                                                 };
>                                         };
>                                 };

I don't know much about devicetree instantiation, but the one example I found
for  m25p80 looks a bit different and much simpler.

	flash: m25p80@0 {
        	compatible = "sst,sst25vf016b";
		spi-max-frequency = <20000000>;
		reg = <0>;
	};

> 
> 
> # ls /dev/mtd*
> /dev/mtd0        /dev/mtd6        /dev/mtdblock2   /dev/mtdr12
> /dev/mtd1        /dev/mtd7        /dev/mtdblock3   /dev/mtdr13
> /dev/mtd10       /dev/mtd8        /dev/mtdblock4   /dev/mtdr14
> /dev/mtd11       /dev/mtd9        /dev/mtdblock5   /dev/mtdr15
> /dev/mtd12       /dev/mtdblock0   /dev/mtdblock6   /dev/mtdr2
> /dev/mtd13       /dev/mtdblock1   /dev/mtdblock7   /dev/mtdr3
> /dev/mtd14       /dev/mtdblock10  /dev/mtdblock8   /dev/mtdr4
> /dev/mtd15       /dev/mtdblock11  /dev/mtdblock9   /dev/mtdr5
> /dev/mtd2        /dev/mtdblock12  /dev/mtdr0       /dev/mtdr6
> /dev/mtd3        /dev/mtdblock13  /dev/mtdr1       /dev/mtdr7
> /dev/mtd4        /dev/mtdblock14  /dev/mtdr10      /dev/mtdr8
> /dev/mtd5        /dev/mtdblock15  /dev/mtdr11      /dev/mtdr9
> 
Since you do see a whole lot of mtd devices, did you try to access any of those ?

Also, what is the output of /proc/mtd ? That should give you a mapping from
the partition label to the actual mtd device if the partition was created.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
