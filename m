From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Question about it87 on an ECS K7S5A
Message-Id: <3DE2C786.36B1EE9F@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021119025118.GA3510@bach.as.arizona.edu>
In-Reply-To: <20021119025118.GA3510@bach.as.arizona.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

not familiar with the K7S5A-HOWTO, it's not from us.
Your best bet is to try and get the actual sensor connections,
and external resistor values, from the board manufacturer.
Much better than guessing.

Also, I skimmed through the driver and didn't see any reason
the -12V alarm should be stuck. Sorry.

good luck
mds



John Gruenenfelder wrote:
> 
> Hello.  I have an ECS K7S5A v3.0 motherboard.  Using the information in the
>  I have the sensors mostly set up correctly.  This board uses an
> it87 chip (loaded as 'modprobe it87 temp_type=0x31').
> 
> Anyway, I have the fan and temperature settings just fine, but am still having
> trouble with the voltage settings.
> 
> The HOWTO suggests:
> 
> label in0 "VCore"
> label in1 "Vcc2.5v"
> label in2 "Vcc5v"
> label in3 "+5V"
> label in4 "+12V"
> label in5 "-12V"
> label in6 "-5V"
> label in7 "SB 5V"
> label in8 "V battery"
> 
> The mobo BIOS, however, lists the voltages as (I assume in the same order):
> 
> Vcore
> Vcc2.5V
> Vcc3.3V
> Vcc5V
> +12V
> SB3.3V
> -12V
> SB5V
> VBat
> 
> The odd this about this arrangement is that there is only one negative
> voltage.  There is no -5V sensor.  Considering that one must be wrong in some
> way, I have settled on the follow list:
> 
>     label in0 "VCore 1"
>     label in1 "Vcc2.5V"
>     label in2 "Vcc3.3V"
>     label in3 "+5V"
>     label in4 "+12V"
>     label in5 "-12V"
>     label in6 "-5V"
>     label in7 "5V SB"
>     label in8 "VBat"
> 
> The lm_sensors supplied sensors.conf has a section:
> 
> # this much simpler version is reported to work for a
> # Eltite Group K7S5A board
> #
>    compute in5 -(36/10)*@, -@/(36/10)
>    compute in6 -(56/10)*@, -@/(56/10)
> 
> This works well to give me a -12V reading, but for the -5V reading (in6) my
> value is always around -5.60V.  Since I can't check this in the BIOS, I don't
> really know what the problem is.  Maybe it's simply a slightly wrong formula?
> 
> Finally, the -12V value reads at -12.02V on nearly every reading, yet
> 'sensors' shows an ALARM for it.  The min/max ranges are set properly (and set
> with sensors) and I've never seen the value stray outside the limits.  I
> suppose it's possible it varies a lot between readings, but shouldn't I see
> something eventually?  Even if the value just moves slightly from -12.02V?
> 
> If you can help me at all with these issues, I would be grateful.  I would
> also like to get the K7S5A-HOWTO updated if I can resolve these issues (and if
> the author is still around).  Many thanks.
> 
> --
> --John Gruenenfelder    Research Assistant, Steward Observatory, U of Arizona
> johng@as.arizona.edu
> "This is the most fun I've had without being drenched in the blood
> of my enemies!"
>         --Sam of Sam & Max
