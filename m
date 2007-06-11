From: Max Baker <max@warped.org>
Date: Mon, 11 Jun 2007 02:16:07 +0000
Subject: Re: [lm-sensors] Fintek F71805F on Jetway J7F4K1G5D - fancontrol?
Message-Id: <20070611021607.GC17337@warped.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070609191229.GB16891@warped.org>
In-Reply-To: <20070609191229.GB16891@warped.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 10, 2007 at 11:35:28AM +0100, Phil Endecott wrote:
> My 1.2GHz board is fanless, i.e. it has a passive CPU heatsink, and all 
> three of the fan connectors are non-controllable.  However the board 
> has unpopulated positions for control components for the CPU fan, and 
> my guess was that they are fitted on the 1.5GHz+ versions (which ship 
> with a CPU fan, as I presume yours does).  So you should be able to 
> control the speed of your CPU fan.

No Dice.   I set 0x60 to 0x22 (Fan #1 - Manual Mode) and 0x6b to 0x01
(lowest PWM setting) and did not see any change in the fan speed.


> I would be most interested to know whether you get reliable fan speed 
> readings when the CPU fan is not set to full speed, so if you could 
> possibly check this before you return your board I would be very grateful.

Since I can't affect any change, I can't test this one for you excpet by
dragging my finger on the fan :-)  Any other tests I'll be happy to try in
the next day or so before I return the board.

> One possibility would be to connect your case fan in parallel with the 
> CPU fan, allowing both to be controlled together.

Thought about this if fan control would work on #1 and if the motherboard
could source enough current.

> You could also use a quieter, lower-volumne fan, or reduce the voltage 
> to your existing one; one common idea is to wire it between +5 and +12 
> so that it runs at 7v.  You can even buy inline cables for voltage 
> reduction.

I'm not fond of using the +5 as a ground on the +12 leg.  I'ld rather have
the full control.

> But are you sure that you need a case fan?  I have built a number of 
> things with mini-ITX boards and none have had any fans at all, until my 
> present 1U project.  What sort of power supply are you using?

I have a 500G 3.5" SATA drive and a Win-TV (happauge) PVR-350 card in
there... both of which make a lot of heat.  Inside the mini-itx case it
just gets too hot to not have a fan -- I'm worried about the long-term
reliability of both items if they sit at 50-60C all the time.  the case
was physically hot to the touch w/out the case fan.

Does anyone have any success stories for another Mini-ITX motherboard
about having working fan control?  Epia?  MSI Fuzzy?

Cheers,
-m

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
