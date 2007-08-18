From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sat, 18 Aug 2007 21:07:49 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: Support more bus types,
Message-Id: <20070818210749.GA20485@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817171414.5a61ab6a@hyperion.delvare>
In-Reply-To: <20070817171414.5a61ab6a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 17 Aug 2007, Jean Delvare wrote:
> Support more bus types (part 1 of 2). Originally libsensors was very
> i2c-centric. Make it more neutral so that we can cleanly support
> additional bus types such as SPI or One-Wire.
...

> +#define SENSORS_BUS_TYPE_ANY	(-1)
> +#define SENSORS_BUS_TYPE_I2C	0
> +#define SENSORS_BUS_TYPE_ISA	1
> +#define SENSORS_BUS_TYPE_PCI	2
> +#define SENSORS_BUS_NR_ANY	(-1)

What about BUS_HOST, for drivers doing a firmware<->hwmon bridge, like
thinkpad-acpi, asus-acpi, sonypi... ?   They usually attach to the device
tree through one or more platform devices, and we are now trying to export
fan control and thermal monitoring using the hwmon class...

Or am I in the wrong track here?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
