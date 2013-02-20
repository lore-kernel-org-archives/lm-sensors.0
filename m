From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Feb 2013 20:47:21 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (ltc2978) Add support for LTC2974 and LTC3883
Message-Id: <20130220214721.1dd48208@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360079815-15187-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1360079815-15187-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 20 Feb 2013 08:42:31 -0800, Guenter Roeck wrote:
> On Tue, Feb 19, 2013 at 01:28:28PM +0100, Jean Delvare wrote:
> > On Tue,  5 Feb 2013 07:56:55 -0800, Guenter Roeck wrote:
> > > @@ -48,7 +56,7 @@ in1_min_alarm		Input voltage low alarm.
> > >  in1_max_alarm		Input voltage high alarm.
> > >  in1_lcrit_alarm		Input voltage critical low alarm.
> > >  in1_crit_alarm		Input voltage critical high alarm.
> > > -in1_lowest		Lowest input voltage. LTC2978 only.
> > > +in1_lowest		Lowest input voltage. LTC2974 and LTC2978 only.
> > >  in1_highest		Highest input voltage.
> > >  in1_reset_history	Reset history. Writing into this attribute will reset
> > >  			history for all attributes.
> > > @@ -63,7 +71,7 @@ in[2-9]_min_alarm	Output voltage low alarm.
> > 
> > in[2-9]_label says "Channels 3 to 9 on LTC2978 only" but I suppose
> > channels 3 to 5 are also available on LTC2974?
> > 
> > >  in[2-9]_max_alarm	Output voltage high alarm.
> > >  in[2-9]_lcrit_alarm	Output voltage critical low alarm.
> > >  in[2-9]_crit_alarm	Output voltage critical high alarm.
> > > -in[2-9]_lowest		Lowest output voltage. LTC2978 only.
> > > +in[2-9]_lowest		Lowest output voltage. LTC2974 and LTC2978 only.
> > >  in[2-9]_highest		Lowest output voltage.
> > >  in[2-9]_reset_history	Reset history. Writing into this attribute will reset
> > >  			history for all attributes.
> > > @@ -82,20 +90,20 @@ temp[1-3]_min_alarm	Chip temperature low alarm.
> > 
> > temp[1-3]_input has a detailed description of the input mappings for
> > the LTC2978 and LTC3880, it would seem desirable to have a similar
> > description for the two new chips LTC2974 and LTC3883.
> > 
> > >  temp[1-3]_max_alarm	Chip temperature high alarm.
> > >  temp[1-3]_lcrit_alarm	Chip temperature critical low alarm.
> > >  temp[1-3]_crit_alarm	Chip temperature critical high alarm.
> > > -temp[1-3]_lowest	Lowest measured temperature. LTC2978 only.
> > > +temp[1-3]_lowest	Lowest measured temperature. LTC2974 and LTC2978 only.
> > >  temp[1-3]_highest	Highest measured temperature.
> > >  temp[1-3]_reset_history	Reset history. Writing into this attribute will reset
> > >  			history for all attributes.
> > >  
> > > -power[1-2]_label	"pout[1-2]". LTC3880 only.
> > > +power[1-2]_label	"pout[1-2]". LTC2974, LTC3880, LTC3883 only.
> > 
> > I am under the impression that LTC2974 has pout[3-4] as well?
> > 
> > >  power[1-2]_input	Measured power.
> > >  
> > > -curr1_label		"iin". LTC3880 only.
> > > +curr1_label		"iin". LTC3880 and LTC3883 only.
> > >  curr1_input		Measured input current.
> > >  curr1_max		Maximum input current.
> > >  curr1_max_alarm		Input current high alarm.
> > >  
> > > -curr[2-3]_label		"iout[1-2]". LTC3880 only.
> > > +curr[2-3]_label		"iout[1-2]". LTC3880 and LTC3883 only.
> > 
> > What about LTC2974? It has PMBUS_HAVE_IOUT on all 4 pages, doesn't this
> > translate to curr[2-5]_* files? This would correlate with the size
> > increase of data->iout_min/max from 2 to 4 elements.
> 
> I have been wondering if I should create per device attribute lists. Things are
> getting confusing. Do you think that would make sense / be better ?

There are pros and cons each way, as you have already found out I'm
sure. I do not have a strong opinion. Maybe take the middle road, and
make one section for LTC297x and one for LTC388x?

> Other comments are all valid ... I pulled the code from 3.9 and will have another
> look. Especially regarding the peak values - yes, I noticed at some point that
> something is wrong with the initialization, but then forgot to follow up on it.
> Oh well :(.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
