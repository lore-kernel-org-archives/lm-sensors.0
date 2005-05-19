From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <4282199F.1060503@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Grant Coady wrote:
> Hi Khali,
> On Tue, 10 May 2005 14:35:31 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:
> 
> Sorry for mixing the thread up.  Just got a working set of computes 
> for w83697hf chip using sensors.conf.
> 
> Its the comments up the top of file wrong, down further they mention 
> the 3.6 volt offset but unfortunately comment:
> "
> # The math is convoluted, so we hope that your motherboard
> # uses the recommended resistor values.
> "
> I'd have to agree with convoluted math :)
> 

IIRC the comment, and these original formulas, are mine.
    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14

If I made a mistake doing the formulas on the back of a napkin,
or they aren't correct for newer
Winbond chips (is the 697f the chip you've been referring to when you say
"Winbond"? - there are lots of separate sections for Winbond chips in
sensors.conf.eg), then let's fix them in sensors.conf.eg.
Or you suggested rewriting the formulas to be more transparent -
that's a good idea.

But just because the formula's wrong doesn't mean we should shove
the calculations into the driver. Let's fix the formulas and be done.

I think that's where you are now anyway? not sure...
Do you now think the formula  is wrong or just hard to understand?

mds


> 
>>and motherboards have a long history of not following the
>>recommendations anyway.
> 
> 
> This is the issue what I'm trying to redress by exposing resistor 
> values in the computes, and providing (planning?) a user-space 
> program for those with non-standard values on their mobo's.
> 
> I've changed Winbond datasheet values to E24 values as I suspect 
> that is what's on my mobo.  These work for me, CVS lm_sensors 
> (so I did compile that other patch, later :)
> 
> ignore in1
> compute in3 @ * (50 + 34) / 50,         @ * 50 / (50 + 34)
> compute in4 @ * (56 + 20) / 20,         @ * 20 / (56 + 20)
> compute in5 ((@ - 3.6) * 100 / 24) + @, 3.6 - ((3.6 - @) * 24 / (100 + 24))
> compute in6 ((@ - 3.6) * 120 / 56) + @, 3.6 - ((3.6 - @) * 56 / (120 + 56))
> compute in7 @ * (33 + 17) / 33,         @ * 33 / (33 + 17)
> 
> These can be simplified back, but then we lose traceability?  
> 
>>From a documentation point of view the verbose example may be 
> better?
