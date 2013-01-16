From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 16 Jan 2013 16:35:39 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Driver for Maxim MAX6697 and compatibles
Message-Id: <20130116163539.GA27120@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1358289387-996-1-git-send-email-linux@roeck-us.net>
 <20130116095331.2e3769f0@endymion.delvare>
In-Reply-To: <20130116095331.2e3769f0@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org

On Wed, Jan 16, 2013 at 09:53:31AM +0100, Jean Delvare wrote:
> On Tue, 15 Jan 2013 14:36:27 -0800, Guenter Roeck wrote:
> > Add support for MAX6581, MAX6602, MAX6622, MAX6636, MAX6689, MAX6693,
> > MAX6694, MAX6697, MAX6698, and MAX6699 temperature sensors
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > (...)
> > v4:
> > - s/beta/Beta at beginning of sentence in device tree description file
> > - Optimize temperature calculation in show_temp_input
> > - Accept temperatures up to 255 degrees C (191 degrees C in extended
> >   temperature mode) for MAX6581
> > - Define reg as int in max6697_init_chip to be able to catch error cases
> > - Optimize assignment to data->temp_offset in max6697_init_chip
> > - smbus->SMBus in platform_data/max6697.h
> > 
> >  Documentation/devicetree/bindings/i2c/max6697.txt |   64 ++
> >  Documentation/hwmon/max6697                       |   58 ++
> >  drivers/hwmon/Kconfig                             |   11 +
> >  drivers/hwmon/Makefile                            |    1 +
> >  drivers/hwmon/max6697.c                           |  726 +++++++++++++++++++++
> >  include/linux/platform_data/max6697.h             |   36 +
> >  6 files changed, 896 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/max6697.txt
> >  create mode 100644 Documentation/hwmon/max6697
> >  create mode 100644 drivers/hwmon/max6697.c
> >  create mode 100644 include/linux/platform_data/max6697.h
> 
> Reviewed-by: Jean Delvare <khali@linux-fr.org>
> 
> Please update lm-sensors' wiki to mention this driver.
> 
Done. Thanks a lot for the review!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
