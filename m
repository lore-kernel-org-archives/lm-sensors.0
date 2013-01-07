From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Mon, 07 Jan 2013 23:19:58 +0000
Subject: Re: [lm-sensors] ASUS M5A99X EVO R2.0
Message-Id: <201301072319.r07NJxT7021107@mx3.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201301050318.r053Ioa1022953@mx3.lsn.net>
In-Reply-To: <201301050318.r053Ioa1022953@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Leslie Rhorer [mailto:lrhorer@mygrande.net]
> Sent: Monday, January 07, 2013 3:43 PM
> To: 'Leslie Rhorer'; 'Jean Delvare'
> Cc: lm-sensors@lm-sensors.org
> Subject: RE: [lm-sensors] ASUS M5A99X EVO R2.0

> RAID-Server:/tmp# sensors
> it8721-isa-0290
> Adapter: ISA adapter
> in0:          +2.81 V  (min =  +1.04 V, max =  +1.99 V)  ALARM
> in1:          +2.81 V  (min =  +1.08 V, max =  +2.48 V)  ALARM
> in2:          +0.90 V  (min =  +2.34 V, max =  +0.72 V)  ALARM
> +3.3V:        +3.29 V  (min =  +2.33 V, max =  +1.87 V)  ALARM
> in4:          +1.54 V  (min =  +0.06 V, max =  +1.70 V)
> in5:          +2.51 V  (min =  +2.40 V, max =  +2.92 V)
> in6:          +1.54 V  (min =  +0.12 V, max =  +0.58 V)  ALARM
> 3VSB:         +3.46 V  (min =  +5.06 V, max =  +1.34 V)  ALARM
> Vbat:         +3.38 V
> fan1:           0 RPM  (min =   14 RPM)  ALARM
> fan2:        2213 RPM  (min =   32 RPM)
> fan3:        2191 RPM  (min =   11 RPM)

	OK, now this is really odd.  The MB has five 4 pin fan connectors on
it.  Three of the five fans I have attached have speed control lines, the
other two do not.  Here are the fan attachments:

MB		Device
CPU_OPT	PSU Fan		
CPU_FAN	Coolant Pump	
CHA_FAN1	Rear Fan #1
CHA_FAN2	Rear Fan #2
CHA_FAN3	Coolant Fan

	When I detached Rear Fan #2,`sensors` suddenly started reporting
non-zero values for fan1 and zero for fan2.  When I reconnected Rear Fan #2,
all three started reporting.  When I then disconnect Rear Fan #1, fan 2
stops reporting again.  If I remove the coolant pump lead, fan1 drops to
zero again, and does not come back when the coolant pump is reconnected.
Reconnecting it seems to have no effect, nor does pulling Rear Fan #1 at
this point.  Pulling both Rear Fan #1 and #2 winds up with fan1 and fan 2
being sero.  At this point, pulling the coolant fan causes all three to be
zero.  Now reconnecting Rear Fan #2 causes `sensors` to report fan3 is
spinning.  Adding Rear Fan #1 brings up fan2.  Reconnecting the Coolant fan
at this point has no obvious effect.  After reconnecting the coolant fan,
adding back Rear Fan #2 drops out fan2, and adding it back causes fan2 to
once again report, but this time fan1 remains zero.

	On a different note, disconnecting the coolant fan does seem to
cause the k10temp sensor to rise, which suggests it may be the CPU (the
fluid cooling system cools only the CPU).  OTOH, the readings are not
stable, which they surely should be.  Repeated calls will occasionally cause
the reported temperatures to jump from the low teens to the mid-to-high 20s.
This is very reminiscent of the behavior that caused me to get rid of the
old CPU and motherboard.  After the coolant failed one day, the temps of the
CPU soared to over 100C, and it was then I noticed erratic reporting of the
temperature.  The only other likely candidate I see for the report is the
VGA card.  It is the only PCI device plugged into an expansion slot.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
