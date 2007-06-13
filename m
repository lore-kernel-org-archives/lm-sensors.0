From: "Phil Endecott" <phil_ujlam_endecott@chezphil.org>
Date: Wed, 13 Jun 2007 22:17:34 +0000
Subject: Re: [lm-sensors] Fintek F71805F on Jetway J7F4K1G5D - fancontrol?
Message-Id: <1181773054626@dmwebmail.belize.chezphil.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070609191229.GB16891@warped.org>
In-Reply-To: <20070609191229.GB16891@warped.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Max Baker wrote:
> Phil,
>
> I will "see" your motherboard pictures and "raise" you a schematic :)
>
> http://warped.org/linux/j7f4r30fan.pdf
>
> The fine, fine folks at Jetway were nice enough to send me an actual
> schematic for the J7F4 board -- well only the page w/ the fans on it.
> They get an A+ for customer/Linux support, buy their products.

Absolutely!

I agree with your analysis, but note that the control components are 
all marked "NC", which I imagine means "not connected", while the 0-ohm 
link is not marked "NC".

>     C3) Bypass cap for the power supply node of the fan?

This is odd; the Fintek datasheet shows a capacitor in this position, 
but doesn't give a value.  Putting a largish capacitor here (this is 10 
uF I think) will rather screw up the PWM control in exactly the way 
that Jean and I have been discussing, i.e. even if the "on" period is 
quite short it will be enough to charge the capacitor for the whole 
cycle.  Having experimented I have not added a capacitor in that 
position on my hack.

They may be imagining that it has the effect of "smoothing" the PWM 
signal (e.g. 50% 12v smoothed to 6v).  To make this work you would need 
an inductor and a diode and you'd have built yourself a simple 
switch-mode supply.

> If I have R3, then I
> will not be pulling out the soldering iron and scope, but will be
> returning the board and getting an EPIA board.

Do you have any firm indication that the EPIA C7 board does have fan control?


Phil.





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
