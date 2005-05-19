From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <20030924211041.33e90064.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Actually, the 'reset_it87' parameter did only disable the chip reset
> in an early version. But it turned out that some of the init settings
> also affected something of the BIOS's pwm setup. I then extended the
> scope of the if(reset) to all/most of the initialization code. I never
> investigated exactly which register(-value) was responsible, thought.
> But of course, you are right the way it is currently used it should be
> renamed to 'init'.

I'd really like you to investigate and find out which other settings
were affecting the PWM setup. I don't want to remove all initialization
code because we don't know which part of it causes problems.

> > [...] Also, did you checked
> > your fan3_div code? Looks buggy.
> 
> It might look like that, but its doing exactly what I wanted it to do.

C'mon, you can't be serious. Quoting your patch:

+	   This sets fan-divs to 2, among others.

Where does it do that? Can't find it.

+	data->fan_div[2] = 1;

Why does fan_div[2] need special init the other fan_div[] don't require?

-		data->fan_div[2] = 1;
+		data->fan_div[2] = data->fan_div[2];

No comment.

+		if (*nrels_mag >= 3) {
+			data->fan_div[1] = DIV_TO_REG(results[2]);
+		}

This must be fan_div[2] there.

So this just can't work the way you want, unless you wanted it broken
from the start ;) Understand me, I don't want to blame you, I'm
particularly happy that you wrote that patch. But it obviously requires
more reviewing and testing before we can commit it to our CVS
repository.

> ;-) The reason: 
> While the tech docu of the it87xx chips says that the fan divisor 3 is
> fixed to 2, it seems that the CPU fan connected as fan3 needs a 8 as
> divider to report the correct speed as reported by the BIOS Setup and
> MBM on my Windows dual install. The BIOS obviously should know how to
> calculate the fan speed from the register value, I don't know how MBM
> gets the same value, thought. When I use the default divisor of 2 on
> the register value I get the unreasonable high fan speed of ~8000rpm
> when it is running in low speed mode and >~140000rpm on full speed!
> Thus, I made this divisor changeable, too. There might be a better,
> cleaner way to do this, thought. Suggestions are welcome.

The datasheet actually says that fan_div3 can be set to either 2 or 8.
It's controled by bit 6 of register 0x0b. It differs from the other two
divisors in that it is coded on a single bit while the others have
three, which let them chose between 8 different divisors from 1 to 128.
You could as well consider that the bit 6 of register 0x0b controls the
*second* bit of fan_div3, which MSB and LSB are fixed to 0 and 1,
respectively. This make div3 look more like div1 and 2 (to me at least,
and should help in the code too).

BTW,

-#define DIV_TO_REG(val) ((val)=8?3:(val)=4?2:(val)=1?0:1)
+extern inline u8 DIV_TO_REG(long val)
+{
+	if( val = 1 )
+		return 0;
+	u8 i;
+	for( i = 1; i < 7; i++ )
+	{
+		if( val = 1<<i )
+			return i;
+	}
+	return 7;
+}

(BTW, does this really compile? I thought you couldn't declare a
variable after real code in a given block.)

You don't need a special case for 1, unless I'm missing something. And
you definitely want to return 1 as the default value, as it was the case
before, because fan_div = 2 is a reasonable default. I also believe that
we should try to find out the nearest divisor from what the user
entered. Setting the divisor to 128, or either 2 , when the user asked
for 31, is poor. We can do better than that. What about that:

extern inline u8 DIV_TO_REG(long val)
{
	u8 i;
	for( i = 0; i < 7; i++ )
		if( val>>i = 1 )
			return i;
	return 2;
}

This considers the highest weighted bit, whatever the lower bits are set
to.

> It could be made default not to reset the chip but as there might be
> a BIOS/motherboard out there that does not correctly initialize the
> chip, there should be a way to reset the chip on module load.

So far, the BIOS seems to have been more clever than we were ;)

I want the chip reset (0x80 at 0x00) gone, and everything else that
causes trouble with it. The rest will be kept, inside an init=1
conditional. Is it OK?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
