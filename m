From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 02 Jul 2010 08:25:30 +0000
Subject: Re: [lm-sensors] [PATCH/RFC] hwmon: Add support for W83667HG-B
Message-Id: <20100702082530.GC12911@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1278021735-21188-1-git-send-email-guenter.roeck@ericsson.com>
 <20100702092011.0acd753f@hyperion.delvare>
In-Reply-To: <20100702092011.0acd753f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Jim Cromie <jim.cromie@gmail.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, Andrew Morton <akpm@linux-foundation.org>, Ethan Lawrence <e.law87@yahoo.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lars4910@hotmail.com" <lars4910@hotmail.com>, "birdie@permonline.ru" <birdie@permonline.ru>, "jadcock@cox.net" <jadcock@cox.net>

On Fri, Jul 02, 2010 at 03:20:11AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Thu, 1 Jul 2010 15:02:15 -0700, Guenter Roeck wrote:
> > This patch adds support for W83667HG-B to the w83627ehf driver.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > 
> > Key relevant difference between W83667HG and W83667HG-B are the Chip ID as well
> > as the fan output and step output register addresses. Those differences are
> > addressed with this patch.
> > 
> > There are other relevant changes in the mapping of input sensors to fan
> > control (W83667HG datasheet chapter 8.7, W83667HG-B datasheet chapter 8.5).
> > However, control of those mappings is not implemented in the driver, thus the
> > respective changes should not have an impact on driver operation.
> > 
> > Changes made in this patch are based on information from datasheets only. The
> > patch has not yet been tested with real hardware. The patch must be tested with
> > real hardware before it is integrated, and is thus submitted as RFC.
> 
> Thanks for doing this. Quick review:
> 
> > 
> > ---
> >  drivers/hwmon/w83627ehf.c |   44 +++++++++++++++++++++++++++++++++++++-------
> >  1 files changed, 37 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> > index 0dcaba9..074e15b 100644
> > --- a/drivers/hwmon/w83627ehf.c
> > +++ b/drivers/hwmon/w83627ehf.c
> > @@ -39,6 +39,7 @@
> >      w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
> >      w83627dhg-p  9      5       4       3      0xb070 0xc1    0x5ca3
> >      w83667hg     9      5       3       3      0xa510 0xc1    0x5ca3
> > +    w83667hg-b   9      5       3       3      0xb350 0xc1    0x5ca3
> >  */
> >  
> >  #include <linux/module.h>
> > @@ -55,7 +56,7 @@
> >  #include <linux/io.h>
> >  #include "lm75.h"
> >  
> > -enum kinds { w83627ehf, w83627dhg, w83627dhg_p, w83667hg };
> > +enum kinds { w83627ehf, w83627dhg, w83627dhg_p, w83667hg, w83667hg_b };
> >  
> >  /* used to set data->name = w83627ehf_device_names[data->sio_kind] */
> >  static const char * w83627ehf_device_names[] = {
> > @@ -63,6 +64,7 @@ static const char * w83627ehf_device_names[] = {
> >  	"w83627dhg",
> >  	"w83627dhg",
> >  	"w83667hg",
> > +	"w83667hg-b",
> 
> Dashes aren't allowed in hwmon device names. For consistency with what
> we did for the W83627DHG-Pg, you should simply drop the "-b". It's a small
> detail of little interest for the user anyway.
> 
> >  };
> >  
> >  static unsigned short force_id;
> > @@ -91,6 +93,7 @@ MODULE_PARM_DESC(force_id, "Override the detected device ID");
> >  #define SIO_W83627DHG_ID	0xa020
> >  #define SIO_W83627DHG_P_ID	0xb070
> >  #define SIO_W83667HG_ID 	0xa510
> > +#define SIO_W83667HG_B_ID	0xb350
> >  #define SIO_ID_MASK		0xFFF0
> >  
> >  static inline void
> > @@ -201,8 +204,17 @@ static const u8 W83627EHF_REG_TOLERANCE[] = { 0x07, 0x07, 0x14, 0x62 };
> >  static const u8 W83627EHF_REG_FAN_START_OUTPUT[] = { 0x0a, 0x0b, 0x16, 0x65 };
> >  static const u8 W83627EHF_REG_FAN_STOP_OUTPUT[] = { 0x08, 0x09, 0x15, 0x64 };
> >  static const u8 W83627EHF_REG_FAN_STOP_TIME[] = { 0x0c, 0x0d, 0x17, 0x66 };
> > -static const u8 W83627EHF_REG_FAN_MAX_OUTPUT[] = { 0xff, 0x67, 0xff, 0x69 };
> > -static const u8 W83627EHF_REG_FAN_STEP_OUTPUT[] = { 0xff, 0x68, 0xff, 0x6a };
> > +
> > +static const u8 *W83627EHF_REG_FAN_MAX_OUTPUT;
> > +static const u8 *W83627EHF_REG_FAN_STEP_OUTPUT;
> > +
> > +static const u8 W83627EHF_REG_FAN_MAX_OUTPUT_COMMON[]
> > +						= { 0xff, 0x67, 0xff, 0x69 };
> > +static const u8 W83627EHF_REG_FAN_STEP_OUTPUT_COMMON[]
> > +						= { 0xff, 0x68, 0xff, 0x6a };
> > +
> > +static const u8 W83627EHF_REG_FAN_MAX_OUTPUT_W83667_B[] = { 0x67, 0x69, 0x6b };
> > +static const u8 W83627EHF_REG_FAN_STEP_OUTPUT_W83667_B[] = { 0x68, 0x6a, 0x6c };
> 
> Is it just me or these arrays aren't used anywhere?
> 
> I think I would just drop them. The "0xff" are suspicious in the
> original arrays, and the size difference between the common and
> W83667HG-B cases is tricky. Anyone willing to add support for this
> feature will need to read the datasheets anyway, so you don't add any
> value by including the register addresses here.
> 
After removing the defines and trying to compile I remembered.
I _knew_ there was a reason for not removing them.
Guess it's too late (or early) here to do serious work.

The defines _are_ used, in:

fan_functions(fan_max_output, FAN_MAX_OUTPUT)
fan_functions(fan_step_output, FAN_STEP_OUTPUT)

which expands to W83627EHF_REG_FAN_MAX_OUTPUT and W83627EHF_REG_FAN_STEP_OUTPUT.

Tricky ... and that was also the reason why I retained the original 
global variables.

I'll move the pointers into per-device code as you suggested, but I'll
have to think about how to do that w/o having to change a lot of code.

As for the 0xff - that pretty much applies to all chips supported by this driver. 
I guess it is supposed to mean "not supported", and as a result the code will
write to a non-existing register. I don't really want to touch that.

The size difference (3 entries vs. 4) doesn't matter, since the chips are both 
configured to have only three pwm fan controllers (even though the W83667HG
is supposed to have four per its datasheet). So the 4th element of the arrays
will not be accessed by the code if W83667HG(-B) is detected.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
