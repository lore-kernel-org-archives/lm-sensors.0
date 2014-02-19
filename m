From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 19 Feb 2014 08:53:17 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <20140219095317.5b96e7f2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 18 Feb 2014 20:11:40 -0800, Guenter Roeck wrote:
> On 02/18/2014 07:18 PM, ianp wrote:
> > I though about it too at first, that Voltage X corresponds to inX in lm-sensors. The problem is, if you look at the default configuration lm-sensors provide at /etc/sensors3.conf:
> >
> > chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*"
> >
> >      label in0 "Vcore"
> >      label in2 "AVCC"
> >      label in3 "+3.3V"
> >      label in7 "3VSB"
> >      label in8 "Vbat"
> >
> >      set in2_min  3.3 * 0.90
> >      set in2_max  3.3 * 1.10
> >      set in3_min  3.3 * 0.90
> >      set in3_max  3.3 * 1.10
> >      set in7_min  3.3 * 0.90
> >      set in7_max  3.3 * 1.10
> >      set in8_min  3.0 * 0.90
> >      set in8_max  3.0 * 1.10
> >
> > You can see that in3 is "+3.3V". Of course I tried modifying in3 in my configuration as follows:
>
> That is just a generic description for settings which are
> often seen for those SuperIO chips. That doesn't mean they
> apply in any way to your board.

No, this isn't correct. We stopped with this long ago. Today the file
installed as /etc/sensors3.conf only contains statements which are
always correct. The comment at the top of the file says exactly that:

# This default configuration file only includes statements which do not
# differ from one mainboard to the next. Only label, compute and set
# statements for internal voltage and temperature sensors are included.

If you look at the W83627DHG-P datasheet, you'll see that in2, in3, in7
and in8 monitor the chips's own power sources (AVCC, 3VCC, 3VSB and
Vbat in this order.) The chip can monitor only 5 external voltages,
with Vcore always being in0 and in1, in4, in5 and in6 being the generic
inputs which can be used to monitor any other voltage.

So there's no way +5V is in3, sorry. +5V and +12V can only be amongst
in1, in4, in5 and in6. From there it's really only a matter of finding
the right mapping and scaling factors. Please follow my guide here to
get this right:

http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling

Your chip's native voltage range is 2.04 V i.e. LSB = 8 mV.

-- 
Jean Delvare
Suse L3 Support
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
