From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <p9o481t6beo0aeek30gr02r6v0aob9eb4k@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,
On Wed, 11 May 2005 10:41:35 -0400, Mark Studebaker <mds@mds.gotdns.com> wrote:

>IIRC the comment, and these original formulas, are mine.
>    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
>    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
>
>If I made a mistake doing the formulas on the back of a napkin,
>or they aren't correct for newer
>Winbond chips (is the 697f the chip you've been referring to when you say
>"Winbond"? - there are lots of separate sections for Winbond chips in
>sensors.conf.eg), then let's fix them in sensors.conf.eg.

I can not tell by inspection whether those computes are correct 
or not, but taking my mobo 624mV through the in5 produces -11.7V
which corresponds to Winbond 56/232 datasheet values.  What had 
me upset was a reference up near top of file saying Winbond values 
better, and was totally bogus formulas as no offset present.

That's what got me 'snippy', not see your formula further down 
until yesterday, I didn't get past the top bit :)  

Again, if I had more patience... but a friend of mine been using 
sensors for years and he had problems always with sensors.conf 
so I started with a negative attitude.

>Or you suggested rewriting the formulas to be more transparent -
>that's a good idea.

That is now what I'm aiming for, transparency in the computes, 
relating back to datasheet where appropriate.

>But just because the formula's wrong doesn't mean we should shove
>the calculations into the driver.

What set me off in that direction was seeing lm87 has inX_scale 
in private memory but without accessors, so close?  So yes, why 
not put entire transform into driver?  I know, wont happen :)

>Let's fix the formulas and be done.

Then we come to practical reality, this is where they'll go, now 
that I can describe traceable computes that _work_ into sensors.conf 
I am much happier with it.

If you had an 'include' command in sensors so that various 
chips can be documented in a modular fashion.  Much less 
intimidating to this new user than one enormous file that 
grew some, over the years.

Couple months ago I'd dismissed sensors.conf as totally stupid, 
like spaghetti code, just too much in one file.

Was only yesterday I find it can work with more transparent 
computes and Jean Delvare told me it can use other input values, 
which is needed for adm9240 as it doesn't have reference to drive 
top of divider for minus voltages, so one uses measured 5V, my 
mobo was 5.14V and nothing worked out until I took that 5V 
variation into account.

My work on fixed point math was in solving a particular problem, 
discovery of mobo resistor ratios, and can be applied to the 
driver or sensors.  
>
>I think that's where you are now anyway? not sure...

That is where I am now, reconciling my experience with yours and 
lmsensors team.  Because I lost trust in sensors early, I've come 
in now with fresh review from datasheets right through system. 
But still a sample, not all the drivers yet.

And now I integrate this review back to lmsensors, as it makes 
sense to me now.

>Do you now think the formula  is wrong or just hard to understand?

Hard to understand.  When I first looked, I couldn't see what '@' 
was, and then the duplication of each formula to get the reciprocal?
Computers can do that.  The response to my query about the unnecessary 
duplication was: 'how else would you do it?'  And, at one point the 
whole shebang looked hopeless to me, yes, very difficult to understand.

So I have provided the 'how else' alternative by going back to the 
parameters.  The dual formula entry is silly as it describes get/set 
via the same transform in two ways, the machine can perform the 
reverse transform all by itself.

This is wrong[1], sensors.conf line 144:
# On almost any mainboard we have seen, the Winbond compute values lead to
# much better results, though.
#
#             Vs     R1,Rin   R2,Rf    Vin
#       in4  +12.0     28      10     +3.00
#       in5  -12.0    210      60.4   +3.00
#       in6   -5.0     90.9    60.4   +3.00
#
# These leads to these declarations:
#       compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
#       compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
#       compute in5 -(210/60.4)*@  ,  -@/(210/60.4)
#       compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)
#

No offsets for Winbond negative values, yet the +12V uses datasheet 
10/28 -- this is what kicked me into the 'totally bogus' response.

Not until line 439 do I read about an offset:

# Same as above for w83781d except that in5 and in6 are computed differently.
# Rather than an internal inverting op amp, the 82d/83s use standard positive
# inputs and the negative voltages are level shifted by a 3.6V reference.
# The math is convoluted, so we hope that your motherboard
# uses the recommended resistor values.

And that paragraph is hopelessly user unfriendly, "so we hope that 
your motherboard...".  Because what it leads to is end-users just 
fudging their numbers to get something that looks okay.  And some 
drivers too.

[1]It is not wrong, in context that Winbond put inverters in some 
chips, it is wrong, when I'm looking for the offset positive 
measurement :)

When I reviewed winbond, I was checking for variations in 5V 
measurement because drivers not scaling it as per guidelines 
of presenting internally scaled pin voltage to sysfs, not looking 
at negative voltage handling as that was outside driver space, 
done in user space, so I missed the inverters in some winbond 
chips.

For that misunderstanding, my apologies.

I take an instant dislike to R1, R2 formulas with a +1 in them.  
There is no reason to 'simplify' formulas when writing software, 
that's the computer's job.  

The compute lines should be traceable to datasheet and/or real world 
values, computers don't mind computing :)

--Grant.
