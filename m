From: Max Baker <max@warped.org>
Date: Wed, 13 Jun 2007 21:38:50 +0000
Subject: Re: [lm-sensors] Fintek F71805F on Jetway J7F4K1G5D - fancontrol?
Message-Id: <20070613213850.GA6629@warped.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070609191229.GB16891@warped.org>
In-Reply-To: <20070609191229.GB16891@warped.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Phil,

I will "see" your motherboard pictures and "raise" you a schematic :)

http://warped.org/linux/j7f4r30fan.pdf

The fine, fine folks at Jetway were nice enough to send me an actual
schematic for the J7F4 board -- well only the page w/ the fans on it.
They get an A+ for customer/Linux support, buy their products.

I have some follow-up questions with them to see if this is the same
circuit for their newer boards or if they have added fan control on the
other plugs.

Here's my review of that schematic :
    * CPUFAN has PWM control, implemented in just about the same way as
      the fintek data sheet sample 3-wire fan circuit.
    * SYSTEMFAN and CASEFAN do not have control, only monitoring
    * CPUFAN PWM control is optional : Either 
        A) R3 (0-ohms) is populated and there is no fan control, or 
        B) R3 is left open and the rest of the devices connected to CPUFAN
           Pin 2 (VCC) are populated.
      I will check my board when I get home.

You will see that there is more than one transistor that needs populating.
Without the schematic on other boards, I would be hesitant to go soldering
things onto the board.  There are two transistors, two resistors, and one
resistor removal in this case.

Fan control circuit analysis:
    Q2) P-channel BJT that is the 'on-off' switch for the fan
    Q3) N-channel FET that is used to isolate Q2 from the Fintek chip
        and provide logical inversion of active-high Fintek to Q2 (pnp).
        Probably a level-change going on here too.
    R3) "option" zero-ohm resistor that selects between fan control or 
        hardwired on. essentially a jumper
    R2) Limits current into the base of Q2 -- needed to bias the BJT
    R6) Pull-up on the base of Q2 for when Q3 is off and the base would
        be floating (not good)
    C3) Bypass cap for the power supply node of the fan?
   C10) Bypass cap, noise filter?

If I won the lottery and I have Q2,Q3,etc then I will probably swap my CPU
and SYSTEM fan connections and be happy.  If instead I have R3, then I
will not be pulling out the soldering iron and scope, but will be
returning the board and getting an EPIA board.

On Wed, Jun 13, 2007 at 01:15:32PM +0200, Jean Delvare wrote:
> Very interesting. This trick seems to work for other motherboard brands
> too. I have an Asus board here where I can't control the CPU fan and
> bingo! there's unpopulated room for a 3-leg component labelled Q12 next
> to the CPU fan header. So it seems that they designed the board with fan
> control in mind, and finally didn't solder the required components.
> Maybe because they share the same design between different models.

It's sad, but they probably didn't stuff this part of the board just to
save $0.50 on the bill of materials, but left it on the board just in case
there was a huge customer demand or special order.

Cheers,
-m

On Wed, Jun 13, 2007 at 01:15:32PM +0200, Jean Delvare wrote:
> Hi Phil,
> 
> On Mon, 11 Jun 2007 12:55:06 +0100, Phil Endecott wrote:
> > I've put a couple of photos of my J7F2 board here:
> > http://chezphil.org/tmp/j7f2_cpufan_top.jpeg
> > http://chezphil.org/tmp/j7f2_cpufan_bottom.jpeg
> > 
> > In the top photo, you can see an unpopulated position for a transistor 
> > ("Q1") next to the CPU fan connector.  In the bottom photo, you can see 
> > a "zero-ohm resistor" and some more unpopulated positions (the three 
> > pins on the left of this picture are the bottom of the fan connector).
> > 
> > If your board looks similar, you're right that you can't control the 
> > fan speed.  If you have a transistor and other components near the fan 
> > connector, then keep trying!
> 
> Very interesting. This trick seems to work for other motherboard brands
> too. I have an Asus board here where I can't control the CPU fan and
> bingo! there's unpopulated room for a 3-leg component labelled Q12 next
> to the CPU fan header. So it seems that they designed the board with fan
> control in mind, and finally didn't solder the required components.
> Maybe because they share the same design between different models.
> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
