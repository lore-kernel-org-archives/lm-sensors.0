From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 07 Feb 2006 23:05:46 +0000
Subject: [lm-sensors] New abituguru driver using platform_device
Message-Id: <20060208000546.72b70494.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43E4ABF8.4010201@hhs.nl>
In-Reply-To: <43E4ABF8.4010201@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

Please answer to the list rather than just me.

> > Additionally, you must use dev_warn, dev_info and dev_dbg to print
> > messages whenever possible, not printk directly.
> 
> I did, but with a platform driver they make all the messages start with 
> "abituguru abituguru.240 :" which is rather convoluted imho, hence the 
> change to printk.

Hm, you're right. I didn't notice because I have very few device
messages in my own driver (f71805f). The repeated device/driver name is
due to the way the platform core builds the "bus_id" identifier when
you register a device. Maybe this can be improved (the hexadecimal
address would be a nice bus_id in our case), but I'm not sure, as the
identifier has to be unique to all platform devices, at least as I
understand it. I'll look into it eventually, or feel free to do so
yourself.

> 
> >> static int abituguru_wait(struct abituguru_data *data, u8 state)
> >> {
> >> 	int timeout = ABIT_UGURU_WAIT_TIMEOUT;
> >>
> >> 	while (inb_p(data->addr + ABIT_UGURU_DATA) != state) {
> >> 		timeout--;
> >> 		if (timeout = 0)
> >> 			return -EBUSY;
> >> 	}
> >> 	return 0;
> >> }
> > 
> > Hm, this is a busy waiting loop. Not recommended. Why don't you msleep()
> > between retries? Or at the very least yield()? In both cases, the
> > timeout should be a duration rather than a number of tries.
> > 
> 
> Usually this succeeds within 100 - 150 reads (max 250) which assuming 
> the isa bus is the bottleneck and tacking the _p into account translates 
> to 300 isa cycles which is 37.5 usec, since the timing can vary I could 
> complicate the code by first during a small usleep which will translate 
> to a busy wait 

No, by definition, this isn't a busy wait if you are sleeping.

> (...) and then do some isa bus busy waiting, but that 
> complicates stuff without winning anything.

What I don't get is why you need to do ISA bus waiting at all. Why
don't you just sleep-wait? 10 us sleeps shoud do. Please keep in mind
that your device isn't the only user of the ISA bus
(check /proc/ioports). Given that all uGuru registers are read at once
by design, if you saturate the ISA bus, other devices may experience
increased latency.

As a side note, I don't think the _p has any effect on modern systems,
does it?

> > >  while(inb_p(data->addr+ABIT_UGURU_DATA) != ABIT_UGURU_STATUS_INPUT){
> > 
> > Coding style: missing spaces.
> > 
> 
> 1) arround the '+' I assume. Will add I agree it makes things easier to
>     read but:

That, but more importanly after the "while" and before the opening
curly brace.

> 2) I'm getting rather tired of these spaces CodingStyle discussions I've
>     had them with Rudolf Marek too. This is not an upstream requirement
>     but interpretation by the lm_sensors of the CodingStyle document,
>     open CodingStyle in your text editor, search for the word space and
>     tell me where the _text_ says that spaces should be added around
>     operators?

It's absolutely not limited to the lm_sensors group, although I admit
it isn't mentioned in CodingStyle. The "spacing preferences" are
documented here, under the name "kernel guide to space":
  http://www.mellanox.com/mst/boring.txt
It probably should be merged into the kernel documentation so as to
make it look more official, as it seems that most developers agree with
most of the rules written here. I agree with 95% of them myself.

Spacing is just as important as coding style itself. We insist on both
for the same reason. Have you ever been maintaining 55000 lines of code
written by a few hundred different people?

> Quoting from my reply to the review done by Rudolf; "printf and friends 
> are vararg, thus no auto casting gets done and %d expects an int not u8. 
> It might be that gcc does the right thing when a function is marked as a 
> printf alike (there is a special attribute for this) but without the 
> cast it is not correct C, I'd rather not depend on a gcc "feature" when 
> I can write correct C instead."
> 
> Really this way it is correct C, of you have a vararg function the 
> compiler does not know what should be put on the stack and thus puts the 
> arguments with their uncasted type on the stack, at least that is what 
> ANSI-C says, thus the casts are needed otherwise only one byte gets put 
> on the stack where printf reads 4 as it expects an int which is 4 bytes.
> 
> The gcc team has decided to deviate from the ANSI standard for printf 
> alike functions and interprets the format string and casts the varargs 
> as needed. Which is unfortunate as this make code written for gcc break 
> on compilers which lack this "feature". (I guess I have written to much 
> code for uC's that I know this).

Thanks a lot for the clarification, I didn't know that. In fact I have
often wondered why/how it was working (e.g. using %u with an unsigned
char) but as it did work OK I never looked any further. I've almost
never worked with non-gcc compilers.

> > > return sprintf(buf,"%d\n",(data->bank1_settings[attr->index][attr->nr]*
> > > 	data->bank1_max_value[attr->index] + 128) / 255);
> > 
> > Coding style: missing spaces. Same in many other places.
> 
> This way it fits in 80 chars which is a hard CodingStyle requirement 
> unlike the spaces. I can spread it out over an extra line if you want.

I definitely want. If the 80 chars limit rule makes you compact your
code horizontally, it totally misses its objective. If you think it's
too long, just introduce an additional temporary variable. Once
optimized by the compiler, I guess the code will be pretty much the
same anyway.

> > > 		if ( (data->bank2_settings[i][0] != orig_val) &&
> > > 		     (abituguru_write(data, ABIT_UGURU_SENSOR_BANK2+2,
> > > 				i, data->bank2_settings[i], 2) < 1) ) {
> > 
> > Coding style: extra spaces. Same in a few other places.
> 
> Explain please you mean the spaces between ( ( and ) ) thats just to 
> make the grouping clearer, otherwise you drown in all the (())).

If you need extra spaces there, it means that your code is too complex
and you need to simplify it (e.g. by introducing additional local
variables) and/or you have unneeded parentheses (which is the case
here). This type of extra-spacing really never helped me read any code.
Good indentation (which is the case here) does.

> (...) I must 
> say you guys are a bit pedantic when it comes to this I understand a 
> unified codingstyle for tabs and indenting is important and I've tried 
> to follow this, you rightfully have pointed out a misplaced { and a case 
> where my editor decided to use 8 spaces instead of a tab, but we are all 
> humans so code will always have small differences.

Whenever I mention a coding style error in a review, it's only meant
for the author to consider fixing it. No more, no less. If your coding
style was really not correct, my review would have been "go read
Documentation/CodingStyle" and nothing more. Fortunately you're way
past this point, your coding style is, in average, pretty acceptable.

> Talking about this I have taken the "simple_strtoul(buf, NULL, 10)" code 
> fragment from other lm_sensors drivers, but shouldn't we pass in &(char 
> *) instead if null and checks it points to a '\0' char after the 
> conversion to make sure the user send us a valid decimal number, 
> currently we see garbage input as just 0.

We could do that, but this would make the code much more complex (and
large, binaey-wise) for very little benefit IMHO.

> > > 	data->bank1_attr[i*3   ].dev_attr.attr.mode  = 0444;
> > > 	data->bank1_attr[i*3   ].dev_attr.attr.owner = THIS_MODULE;
> > > 	data->bank1_attr[i*3   ].dev_attr.show  = show_bank1_value;
> > > 	data->bank1_attr[i*3   ].dev_attr.store = NULL;
> > > 	data->bank1_attr[i*3   ].index = probe_order[i];
> > > 	data->bank1_attr[i*3 +1].dev_attr.attr.mode  = 0644;
> > > 	data->bank1_attr[i*3 +1].dev_attr.attr.owner = THIS_MODULE;
> > > 	data->bank1_attr[i*3 +1].dev_attr.show  = show_bank1_setting;
> > > 	data->bank1_attr[i*3 +1].dev_attr.store = store_bank1_setting;
> > > 	data->bank1_attr[i*3 +1].index = probe_order[i];
> > > 	data->bank1_attr[i*3 +1].nr = 1;
> > > 	data->bank1_attr[i*3 +2].dev_attr.attr.mode  = 0644;
> > > 	data->bank1_attr[i*3 +2].dev_attr.attr.owner = THIS_MODULE;
> > > 	data->bank1_attr[i*3 +2].dev_attr.show  = show_bank1_setting;
> > > 	data->bank1_attr[i*3 +2].dev_attr.store = store_bank1_setting;
> > > 	data->bank1_attr[i*3 +2].index = probe_order[i];
> > > 	data->bank1_attr[i*3 +2].nr = 2;
> > 
> > Naaah, really, you don't make things clearer with all this alignment
> > masquerade. Rather the contrary.
> 
> And you suggest to fix this how (iow how should I make things clearer)?

Drop any additional space inside the square brackets and doubled spaces
before equal signs as well. In other words, write every line as you
would have if it were isolated. If it then looks a bit too compact,
feel free to insert a couple blank lines.

Thanks,
-- 
Jean Delvare

