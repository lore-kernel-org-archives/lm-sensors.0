From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 10 May 2011 15:50:33 +0000
Subject: Re: [lm-sensors] [PATCH] Document existing support for SMSC EMC2300
Message-Id: <1305042633.31666.513.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305037288-16695-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1305037288-16695-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-05-10 at 10:58 -0400, Jean Delvare wrote:
> Hi Steve,
> 
> On Tue, 10 May 2011 15:21:28 +0100, Steve Glendinning wrote:
> > The recently added support for EMC6D103S also supports EMC2300.
> > These two devices report exactly the same revision/stepping
> > register, so it's not possible to tell them apart.
> 
> Thanks for your contribution, this is very appreciated.
> 
> > EMC2300 doesn't have all the voltage inputs that EMC6D103S has,
> > so reports in0, in3 and in4 all as zero.
> 
> Wouldn't this be good way to differentiate between the parts? What
> values are returned by the EMC2300 for registers 0x20, 0x23, 0x24,
> 0x44, 0x45, 0x4a, 0x4b 0x4c and 0x4d?
> 
> BTW, if you could provide a register dump for the EMC2300 (using the
> i2c-dev kernel driver and i2cdump tool from the i2c-tools package) that
> would be appreciated.
> 
> > 
> > Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
> > ---
> >  Documentation/hwmon/lm85 |   10 +++++++++-
> >  drivers/hwmon/lm85.c     |    2 ++
> >  2 files changed, 11 insertions(+), 1 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/lm85 b/Documentation/hwmon/lm85
> > index 7c49fea..04cc342 100644
> > --- a/Documentation/hwmon/lm85
> > +++ b/Documentation/hwmon/lm85
> > @@ -34,6 +34,10 @@ Supported chips:
> >      Prefix: 'emc6d103s'
> >      Addresses scanned: I2C 0x2c, 0x2d, 0x2e
> >      Datasheet: http://www.smsc.com/main/catalog/emc6d103s.html
> > +  * SMSC EMC2300
> > +    Prefix: 'emc6d103s'
> > +    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
> > +    Datasheet: http://www.smsc.com/media/Downloads_Public/Data_Sheets/2300.pdf
> >  
> >  Authors:
> >          Philip Pokorny <ppokorny@penguincomputing.com>,
> > @@ -47,7 +51,7 @@ Description
> >  
> >  This driver implements support for the National Semiconductor LM85 and
> >  compatible chips including the Analog Devices ADM1027, ADT7463, ADT7468 and
> > -SMSC EMC6D10x chips family.
> > +SMSC EMC6D10x and EMC2300 chips family.
> >  
> >  The LM85 uses the 2-wire interface compatible with the SMBUS 2.0
> >  specification. Using an analog to digital converter it measures three (3)
> > @@ -136,6 +140,10 @@ of voltage and temperature channels.
> >  SMSC EMC6D103S is similar to EMC6D103, but does not support pwm#_auto_pwm_minctl
> >  and temp#_auto_temp_off.
> >  
> > +SMSC EMC2300 is similar to EMC6D103S, with fewer voltage inputs.
> > +Unfortunately it is not possible to distinguish between these two on a register
> > +level so EMC2300's voltage inputs in0, in3 and in4 will read zero.
> > +
> >  Hardware Configurations
> >  -----------------------
> >  
> > diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> > index da72dc1..4b89b70 100644
> > --- a/drivers/hwmon/lm85.c
> > +++ b/drivers/hwmon/lm85.c
> > @@ -1260,6 +1260,8 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
> >  			type_name = "emc6d103";
> >  			break;
> >  		case LM85_VERSTEP_EMC6D103S:
> > +			/* Note: this also matches EMC2300, we can't tell
> > +			 * the difference between the two */
> >  			type_name = "emc6d103s";
> >  			break;
> >  		}
> 
> This looks good, if there's really no way to differentiate between
> those two. We used a heuristic to differentiate between the LM96000
> (supported) and the WPCD377I (unsupported), see function lm85_is_fake
> in the driver source. Maybe we can do something similar for the EMC2300
> (although I agree it is less critical here, as both chips are supported
> by the driver.)
> 
Datasheet says that 0x20, 0x23, 0x24, 0x43..0x45, and 0x4a..0x4d are all
zero on the EMC2300. Most interesting would be 0x45, 0x4b, and 0x4d,
which are initialized with 0x00 on the EMC2300 but 0xff for the
EMC6D103S.

I don't mind if we accept the code as-is for now, though I would prefer
detection and correct handling of emc2300. But that can also be added
later on. 

I think the text above should not claim that it is not possible to
distinguish between the two chips, or it should be amended with "...
using the Manufacturer/Version registers".

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
