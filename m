From: tyranix@gmail.com (tyranix)
Date: Sat, 18 Feb 2006 21:31:56 +0000
Subject: [lm-sensors] MSI KT4V - Strange sensors output.
Message-Id: <ec3d44da0602181331o6fdb43c7l47f822ea6dd594bb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ec3d44da0602161608r43dc6653mcc94099d41e3a3e@mail.gmail.com>
In-Reply-To: <ec3d44da0602161608r43dc6653mcc94099d41e3a3e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 2/18/06, Jean Delvare <khali at linux-fr.org> wrote:
> > > >       V5SB:      +5.56 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
> > +5V SB: 5.042V
>
> Aha, so the compute formula in sensors.conf must not be correct for
> your board. That's odd since this means you would have different
> resistors used for +5V and 5VSB. Or maybe the input order differs. Are
> the voltage values displayed in the same order in the BIOS and by
> "sensors"?

They are in a different order.  Also, I don't have anything labeled
+3.3V in the BIOS.  Here is the order from my BIOS:

Vcore
+5.0V
+12.0V
-12.0V
-5.0V
Battery
+5V SB

And this is from /etc/sensors.conf:

chip "w83697hf-*"
    label in0 "VCore"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label in7 "V5SB"
    label in8 "VBat"

So based on the names, it would appear that in7 and in8 are reversed. 
But if in7 and in8 were really reversed, wouldn't I see 5.xV for VBat
and 3.xV for V5SB?

> If the order is the same in BIOS and "sensors", you may try the
> following compute line, which should give yo roughly the same 5VSB
> value your BIOS does. Whether this matches physical reality or not, I
> don't know.
>
>     compute in7 ((5/10)+1)*@ ,  @/((5/10)+1)

That is closer to what my BIOS says.  If I use that computation, then
I can set the threshold back to +- 5% for 5VSB.

Sensors now reports this:

V5SB:      +4.97 V  (min =  +4.75 V, max =  +5.26 V)

and previously my BIOS said 5.042V (and would sometimes drop down to
4.993V for a second).

