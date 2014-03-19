From: Robert Coulson <rob.coulson@gmail.com>
Date: Wed, 19 Mar 2014 22:57:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus/ltc2978) Add support for LTM4676
Message-Id: <CAEZKy8+9Gg0+F9zqgRxPHdV0i3psJzxkaKYbU_timiBLQxfCfQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1394851200-25605-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1394851200-25605-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 19, 2014 at 12:43 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, Mar 18, 2014 at 07:27:09AM -0700, Robert Coulson wrote:
> > On Fri, Mar 14, 2014 at 7:40 PM, Guenter Roeck <linux@roeck-us.net>
> wrote:
> >
> > > The chip's programming interface is quite similar to LTC3880
> > > and supports the same set of sensors.
> > >
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  Documentation/hwmon/ltc2978   |   17 +++++++++++------
> > >  drivers/hwmon/pmbus/ltc2978.c |   20 +++++++++++---------
> > >  2 files changed, 22 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
> > > index a0546fc..686c078 100644
> > > --- a/Documentation/hwmon/ltc2978
> > > +++ b/Documentation/hwmon/ltc2978
> > > @@ -23,6 +23,10 @@ Supported chips:
> > >      Prefix: 'ltc3883'
> > >      Addresses scanned: -
> > >      Datasheet: http://www.linear.com/product/ltc3883
> > > +  * Linear Technology LTM4676
> > > +    Prefix: 'ltm4676'
> > > +    Addresses scanned: -
> > > +    Datasheet: http://www.linear.com/product/ltm4676
> > >
> > >  Author: Guenter Roeck <linux@roeck-us.net>
> > >
> > > @@ -33,7 +37,8 @@ Description
> > >  LTC2974 is a quad digital power supply manager. LTC2978 is an octal
> power
> > > supply
> > >  monitor. LTC2977 is a pin compatible replacement for LTC2978. LTC3880
> is
> > > a dual
> > >  output poly-phase step-down DC/DC controller. LTC3883 is a single
> phase
> > > -step-down DC/DC controller.
> > > +step-down DC/DC controller. LTM4676 is a dual 13A or single 26A
> uModule
> > > +regulator.
> > >
> > >
> > >  Usage Notes
> > > @@ -75,7 +80,7 @@ in[N]_label           "vout[1-8]".
> > >                         LTC2974: N=2-5
> > >                         LTC2977: N=2-9
> > >                         LTC2978: N=2-9
> > > -                       LTC3880: N=2-3
> > > +                       LTC3880, LTM4676: N=2-3
> > >                         LTC3883: N=2
> > >  in[N]_input            Measured output voltage.
> > >  in[N]_min              Minimum output voltage.
> > > @@ -95,7 +100,7 @@ temp[N]_input                Measured temperature.
> > >                         and temp5 reports the chip temperature.
> > >                         On LTC2977 and LTC2978, only one temperature
> > > measurement
> > >                         is supported and reports the chip temperature.
> > > -                       On LTC3880, temp1 and temp2 report external
> > > +                       On LTC3880 and LTM4676, temp1 and temp2 report
> > > external
> > >                         temperatures, and temp3 reports the chip
> > > temperature.
> > >                         On LTC3883, temp1 reports an external
> temperature,
> > >                         and temp2 reports the chip temperature.
> > > @@ -123,11 +128,11 @@ power[N]_label            "pout[1-4]".
> > >                         LTC2974: N=1-4
> > >                         LTC2977: Not supported
> > >                         LTC2978: Not supported
> > > -                       LTC3880: N=1-2
> > > +                       LTC3880, LTM4676: N=1-2
> > >                         LTC3883: N=2
> > >  power[N]_input         Measured output power.
> > >
> > > -curr1_label            "iin". LTC3880 and LTC3883 only.
> > > +curr1_label            "iin". LTC3880, LTC3883, and LTM4676 only.
> > >  curr1_input            Measured input current.
> > >  curr1_max              Maximum input current.
> > >  curr1_max_alarm                Input current high alarm.
> > > @@ -138,7 +143,7 @@ curr[N]_label               "iout[1-4]".
> > >                         LTC2974: N=1-4
> > >                         LTC2977: not supported
> > >                         LTC2978: not supported
> > > -                       LTC3880: N=2-3
> > > +                       LTC3880, LTM4676: N=2-3
> > >                         LTC3883: N=2
> > >  curr[N]_input          Measured output current.
> > >  curr[N]_max            Maximum output current.
> > > diff --git a/drivers/hwmon/pmbus/ltc2978.c
> b/drivers/hwmon/pmbus/ltc2978.c
> > > index 629bfe0..e24ed52 100644
> > > --- a/drivers/hwmon/pmbus/ltc2978.c
> > > +++ b/drivers/hwmon/pmbus/ltc2978.c
> > > @@ -1,9 +1,9 @@
> > >  /*
> > >   * Hardware monitoring driver for LTC2974, LTC2977, LTC2978, LTC3880,
> > > - * and LTC3883
> > > + * LTC3883, and LTM4676
> > >   *
> > >   * Copyright (c) 2011 Ericsson AB.
> > > - * Copyright (c) 2013 Guenter Roeck
> > > + * Copyright (c) 2013, 2014 Guenter Roeck
> > >   *
> > >   * This program is free software; you can redistribute it and/or
> modify
> > >   * it under the terms of the GNU General Public License as published
> by
> > > @@ -14,10 +14,6 @@
> > >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > >   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > >   * GNU General Public License for more details.
> > > - *
> > > - * You should have received a copy of the GNU General Public License
> > > - * along with this program; if not, write to the Free Software
> > > - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> > >   */
> > >
> > >  #include <linux/kernel.h>
> > > @@ -28,7 +24,7 @@
> > >  #include <linux/i2c.h>
> > >  #include "pmbus.h"
> > >
> > > -enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3883 };
> > > +enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3883, ltm4676 };
> > >
> > >  /* Common for all chips */
> > >  #define LTC2978_MFR_VOUT_PEAK          0xdd
> > > @@ -45,7 +41,7 @@ enum chips { ltc2974, ltc2977, ltc2978, ltc3880,
> ltc3883
> > > };
> > >  #define LTC2974_MFR_IOUT_PEAK          0xd7
> > >  #define LTC2974_MFR_IOUT_MIN           0xd8
> > >
> > > -/* LTC3880 and LTC3883 */
> > > +/* LTC3880, LTC3883, and LTM4676 */
> > >  #define LTC3880_MFR_IOUT_PEAK          0xd7
> > >  #define LTC3880_MFR_CLEAR_PEAKS                0xe3
> > >  #define LTC3880_MFR_TEMPERATURE2_PEAK  0xf4
> > > @@ -63,6 +59,8 @@ enum chips { ltc2974, ltc2977, ltc2978, ltc3880,
> ltc3883
> > > };
> > >  #define LTC3880_ID_MASK                        0xff00
> > >  #define LTC3883_ID                     0x4300
> > >  #define LTC3883_ID_MASK                        0xff00
> > > +#define LTM4676_ID                     0x4480  /* datasheet claims
> 0x440X
> > > */
> > > +#define LTM4676_ID_MASK                        0xfff0
> > >
> > >  #define LTC2974_NUM_PAGES              4
> > >  #define LTC2978_NUM_PAGES              8
> > > @@ -371,6 +369,7 @@ static const struct i2c_device_id ltc2978_id[] = {
> > >         {"ltc2978", ltc2978},
> > >         {"ltc3880", ltc3880},
> > >         {"ltc3883", ltc3883},
> > > +       {"ltm4676", ltm4676},
> > >         {}
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, ltc2978_id);
> > > @@ -406,6 +405,8 @@ static int ltc2978_probe(struct i2c_client *client,
> > >                 data->id = ltc3880;
> > >         } else if ((chip_id & LTC3883_ID_MASK) = LTC3883_ID) {
> > >                 data->id = ltc3883;
> > > +       } else if ((chip_id & LTM4676_ID_MASK) = LTM4676_ID) {
> > > +               data->id = ltm4676;
> > >         } else {
> > >                 dev_err(&client->dev, "Unsupported chip ID 0x%x\n",
> > > chip_id);
> > >                 return -ENODEV;
> > > @@ -459,6 +460,7 @@ static int ltc2978_probe(struct i2c_client *client,
> > >                 }
> > >                 break;
> > >         case ltc3880:
> > > +       case ltm4676:
> > >                 info->read_word_data = ltc3880_read_word_data;
> > >                 info->pages = LTC3880_NUM_PAGES;
> > >                 info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
> > > @@ -501,5 +503,5 @@ static struct i2c_driver ltc2978_driver = {
> > >  module_i2c_driver(ltc2978_driver);
> > >
> > >  MODULE_AUTHOR("Guenter Roeck");
> > > -MODULE_DESCRIPTION("PMBus driver for LTC2974, LTC2978, LTC3880, and
> > > LTC3883");
> > > +MODULE_DESCRIPTION("PMBus driver for LTC2974, LTC2978, LTC3880,
> LTC3883,
> > > and LTM4676");
> > >  MODULE_LICENSE("GPL");
> > > --
> > > 1.7.9.7
> > >
> > >
> > > _______________________________________________
> > > lm-sensors mailing list
> > > lm-sensors@lm-sensors.org
> > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> > >
> >
> >
> > Hello Guenter,
> >
> > the changes look fine to me; the chip ID difference between the datasheet
> > and value read is odd, but the comment helps. Did you inform the
> > manufacturer of the difference?
> >
> Linear came back. This is an error in the datasheet. They said they'll ECN
> the datasheet immediately, so I might even remove the comment.
>
> Guenter
>

Thank you for checking, I appreciate it. I have no problem if you remove the
comment, given the ECN, and my 'Reviewed-by' stands for either version.

*** Rob.
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
