From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 08 Apr 2013 20:32:25 +0000
Subject: Re: [lm-sensors] sensor configuration file for Supermicro C7H61
Message-Id: <20130408203224.GA23151@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130406072132.GA28618@roeck-us.net>
In-Reply-To: <20130406072132.GA28618@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 08, 2013 at 09:06:32PM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sat, 6 Apr 2013 00:21:32 -0700, Guenter Roeck wrote:
> > 
> > chip "nct6776-isa-0a30"
> > 
> >     label in0 "Vcore"
> >     label in1 "12V"
> >     label in2 "AVCC"
> >     label in3 "+3.3V"
> >     label in4 "VDIMM"
> >     label in5 "5VCC"
> >     label in6 "VTT_CPU"
> >     label in7 "3VSB"
> >     label in8 "Vbat"
> 
> "12V", "+3.3V" and "5VCC" are somewhat inconsistent, I'd go with
> "+12V", "+3.3V" and "+5V".
> 
> > 
> >     compute in1   @*6.6, @/6.6
> >     compute in5   @*4, @/4
> > 
> >     # min/max values are set by the BIOS
> > 
> >     ignore fan1
> >     label fan2 "System FAN4"
> >     label fan3 "CPU Fan"
> >     label fan4 "System FAN2"
> >     label fan5 "System FAN3"
> 
> Other than this, this looks good, so just add this to the wiki.
> 
Done. I also added information about the second super-io chip (nct6106)
on C7H61-O and a note saying that it is not (and should not be) enabled
for hw monitoring.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
