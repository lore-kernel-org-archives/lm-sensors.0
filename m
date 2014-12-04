From: Patrick Titiano <ptitiano@baylibre.com>
Date: Thu, 04 Dec 2014 16:36:01 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: tmp401: add support for TI TMP435
Message-Id: <CANC07CSYa0UMfx_wEwpR_zUjtzeQEhB5o8mCVBZmrVE63Vkv9Q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417706574-1023-2-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1417706574-1023-2-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-12-04 17:23 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:

> On Thu, Dec 04, 2014 at 04:22:52PM +0100, Bartosz Golaszewski wrote:
> > From: Patrick Titiano <ptitiano@baylibre.com>
> >
> > Signed-off-by: Patrick Titiano <ptitiano@baylibre.com>
> > [Bartosz Golaszewski: prepared for submission, code review fixes]
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/hwmon/tmp401.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> > index 7fa6e7d..a5f0973 100644
> > --- a/drivers/hwmon/tmp401.c
> > +++ b/drivers/hwmon/tmp401.c
> > @@ -8,6 +8,9 @@
> >   * Cleanup and support for TMP431 and TMP432 by Guenter Roeck
> >   * Copyright (c) 2013 Guenter Roeck <linux@roeck-us.net>
> >   *
> > + * Support for TMP435 by Patrick Titiano
> > + * Copyright (c) 2014 Patrick Titiano <ptitiano@baylibre.com>
> > + *
>
> Really ?
>
> Adding a copyright for a couple of device detection lines is excessive
> and highly unusual. I'll have to think hard about this.
>
> Guenter
>
>
Hello Guenter,
No big deal. I just naively replicated what was done in the header for
previous chips.
We'll just remove it immediately.

Patrick


> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License as published by
> >   * the Free Software Foundation; either version 2 of the License, or
> > @@ -46,7 +49,7 @@
> >  /* Addresses to scan */
> >  static const unsigned short normal_i2c[] = { 0x4c, 0x4d, 0x4e,
> I2C_CLIENT_END };
> >
> > -enum chips { tmp401, tmp411, tmp431, tmp432 };
> > +enum chips { tmp401, tmp411, tmp431, tmp432, tmp435 };
> >
> >  /*
> >   * The TMP401 registers, note some registers have different addresses
> for
> > @@ -136,6 +139,7 @@ static const u8 TMP432_STATUS_REG[] = {
> >  #define TMP411C_DEVICE_ID                    0x10
> >  #define TMP431_DEVICE_ID                     0x31
> >  #define TMP432_DEVICE_ID                     0x32
> > +#define TMP435_DEVICE_ID                     0x35
> >
> >  /*
> >   * Driver data (common to all clients)
> > @@ -146,6 +150,7 @@ static const struct i2c_device_id tmp401_id[] = {
> >       { "tmp411", tmp411 },
> >       { "tmp431", tmp431 },
> >       { "tmp432", tmp432 },
> > +     { "tmp435", tmp435 },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, tmp401_id);
> > @@ -684,6 +689,11 @@ static int tmp401_detect(struct i2c_client *client,
> >                       return -ENODEV;
> >               kind = tmp432;
> >               break;
> > +     case TMP435_DEVICE_ID:
> > +             if (client->addr != 0x4c)
> > +                     return -ENODEV;
> > +             kind = tmp435;
> > +             break;
> >       default:
> >               return -ENODEV;
> >       }
> > @@ -705,7 +715,9 @@ static int tmp401_detect(struct i2c_client *client,
> >  static int tmp401_probe(struct i2c_client *client,
> >                       const struct i2c_device_id *id)
> >  {
> > -     const char *names[] = { "TMP401", "TMP411", "TMP431", "TMP432" };
> > +     static const char * const names[] = {
> > +             "TMP401", "TMP411", "TMP431", "TMP432", "TMP435"
> > +     };
> >       struct device *dev = &client->dev;
> >       struct device *hwmon_dev;
> >       struct tmp401_data *data;
> > --
> > 2.1.3
> >
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
