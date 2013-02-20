From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 20 Feb 2013 16:42:31 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (ltc2978) Add support for LTC2974 and LTC3883
Message-Id: <20130220164231.GA9568@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360079815-15187-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1360079815-15187-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 19, 2013 at 01:28:28PM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> On Tue,  5 Feb 2013 07:56:55 -0800, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  Documentation/hwmon/ltc2978   |   26 +++++---
> >  drivers/hwmon/pmbus/Kconfig   |    4 +-
> >  drivers/hwmon/pmbus/ltc2978.c |  136 +++++++++++++++++++++++++++++++++++++----
> >  3 files changed, 143 insertions(+), 23 deletions(-)
> 
> Not being familiar with pmbus, my review may be incomplete, but I did
> my best.
> 
Hi Jean,

Excellent review anyway, as always ...

> > 
> > diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
> > index 8a5e791..8db0b61 100644
> > --- a/Documentation/hwmon/ltc2978
> > +++ b/Documentation/hwmon/ltc2978
> > @@ -2,6 +2,10 @@ Kernel driver ltc2978
> >  ==========> >  
> >  Supported chips:
> > +  * Linear Technology LTC2974
> > +    Prefix: 'ltc2974'
> > +    Addresses scanned: -
> > +    Datasheet: http://cds.linear.com/docs/en/datasheet/2974f.pdf
> >    * Linear Technology LTC2978
> >      Prefix: 'ltc2978'
> >      Addresses scanned: -
> > @@ -10,6 +14,10 @@ Supported chips:
> >      Prefix: 'ltc3880'
> >      Addresses scanned: -
> >      Datasheet: http://cds.linear.com/docs/en/datasheet/3880fa.pdf
> > +  * Linear Technology LTC3883
> > +    Prefix: 'ltc3883'
> > +    Addresses scanned: -
> > +    Datasheet: http://cds.linear.com/docs/en/datasheet/3883f.pdf
> >  
> >  Author: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> You might want to update this e-mail address. This might be better done
> as a tree-wide patch though.
> 
> >  
> > @@ -17,9 +25,9 @@ Author: Guenter Roeck <guenter.roeck@ericsson.com>
> >  Description
> >  -----------
> >  
> > -The LTC2978 is an octal power supply monitor, supervisor, sequencer and
> > -margin controller. The LTC3880 is a dual, PolyPhase DC/DC synchronous
> > -step-down switching regulator controller.
> > +LTC2974 is a quad digital power supply manager. LTC2978 is an octal power supply
> > +monitor. LTC3880 is a dual output poly-phase step-down DC/DC controller. LTC3883
> > +is a single phase step-down DC/DC controller.
> >  
> >  
> >  Usage Notes
> > @@ -48,7 +56,7 @@ in1_min_alarm		Input voltage low alarm.
> >  in1_max_alarm		Input voltage high alarm.
> >  in1_lcrit_alarm		Input voltage critical low alarm.
> >  in1_crit_alarm		Input voltage critical high alarm.
> > -in1_lowest		Lowest input voltage. LTC2978 only.
> > +in1_lowest		Lowest input voltage. LTC2974 and LTC2978 only.
> >  in1_highest		Highest input voltage.
> >  in1_reset_history	Reset history. Writing into this attribute will reset
> >  			history for all attributes.
> > @@ -63,7 +71,7 @@ in[2-9]_min_alarm	Output voltage low alarm.
> 
> in[2-9]_label says "Channels 3 to 9 on LTC2978 only" but I suppose
> channels 3 to 5 are also available on LTC2974?
> 
> >  in[2-9]_max_alarm	Output voltage high alarm.
> >  in[2-9]_lcrit_alarm	Output voltage critical low alarm.
> >  in[2-9]_crit_alarm	Output voltage critical high alarm.
> > -in[2-9]_lowest		Lowest output voltage. LTC2978 only.
> > +in[2-9]_lowest		Lowest output voltage. LTC2974 and LTC2978 only.
> >  in[2-9]_highest		Lowest output voltage.
> >  in[2-9]_reset_history	Reset history. Writing into this attribute will reset
> >  			history for all attributes.
> > @@ -82,20 +90,20 @@ temp[1-3]_min_alarm	Chip temperature low alarm.
> 
> temp[1-3]_input has a detailed description of the input mappings for
> the LTC2978 and LTC3880, it would seem desirable to have a similar
> description for the two new chips LTC2974 and LTC3883.
> 
> >  temp[1-3]_max_alarm	Chip temperature high alarm.
> >  temp[1-3]_lcrit_alarm	Chip temperature critical low alarm.
> >  temp[1-3]_crit_alarm	Chip temperature critical high alarm.
> > -temp[1-3]_lowest	Lowest measured temperature. LTC2978 only.
> > +temp[1-3]_lowest	Lowest measured temperature. LTC2974 and LTC2978 only.
> >  temp[1-3]_highest	Highest measured temperature.
> >  temp[1-3]_reset_history	Reset history. Writing into this attribute will reset
> >  			history for all attributes.
> >  
> > -power[1-2]_label	"pout[1-2]". LTC3880 only.
> > +power[1-2]_label	"pout[1-2]". LTC2974, LTC3880, LTC3883 only.
> 
> I am under the impression that LTC2974 has pout[3-4] as well?
> 
> >  power[1-2]_input	Measured power.
> >  
> > -curr1_label		"iin". LTC3880 only.
> > +curr1_label		"iin". LTC3880 and LTC3883 only.
> >  curr1_input		Measured input current.
> >  curr1_max		Maximum input current.
> >  curr1_max_alarm		Input current high alarm.
> >  
> > -curr[2-3]_label		"iout[1-2]". LTC3880 only.
> > +curr[2-3]_label		"iout[1-2]". LTC3880 and LTC3883 only.
> 
> What about LTC2974? It has PMBUS_HAVE_IOUT on all 4 pages, doesn't this
> translate to curr[2-5]_* files? This would correlate with the size
> increase of data->iout_min/max from 2 to 4 elements.
> 

I have been wondering if I should create per device attribute lists. Things are
getting confusing. Do you think that would make sense / be better ?

Other comments are all valid ... I pulled the code from 3.9 and will have another
look. Especially regarding the peak values - yes, I noticed at some point that
something is wrong with the initialization, but then forgot to follow up on it.
Oh well :(.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
