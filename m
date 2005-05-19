From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <ei1281tmqecmd077djbvve7kg7cej29fjt@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Tue, 10 May 2005 14:35:31 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>
>Hi Grant,
>
>> Just reviewed /etc/sensors.conf again, negative voltage calculation
>> is totally bogus as it does not account for reference voltage driving
>> top of resistor divider.  The proof is that you do not have correct
>> Winbond resistor values in the sample calculations.  They're fudged.
>
>This is no proof. Winbond datasheet are not always accurate (*cough*),
>and motherboards have a long history of not following the
>recommendations anyway.

The trouble with these datasheets is people often confuse resolution 
with accuracy, these chips are accurate to a few percent, the 
resolution problem stops me using E96 (1%) resistor series as the 
signal ~ noise on a one bit change in reading (my 12V flips between 
two readings, a polling averager could smooth that into an intermediate 
value, adding partial bit resolution.

In the paragraph above the Winbond examples. the formula is wrong, 
it doesn't account for reference driving top of driver, if you look 
at raw vs indicated in my number table, you see winbond raw values 
are roughly 3V below reference: ~600mV and ~800 mV --> that's the 
documented error in sensors.conf as it states negative measurements 
are at about 3V at the chip pin.  The document is wrong.  

>
>That being said, I have found similar errors in the past (mostly broken
>rounding in the drivers) so I wouldn't be surprised if there are more.
Round in drivers with fixed point can be kept below 1/2 % easy, 
I'm talking about somebody fudging a non-traceable formula in the 
document.  It may be the expression can be fixed, I find it difficult 
to work with bad docs, it has taken me weeks to prove this part of 
the system.  
>
>> Parameter based calculation does not have these issues, doesn't
>> need floating point either.
>
>Just because the resistors value are integers doesn't mean you don't
>need floating point. Future resistors may not have integer values, and
>also libsensors currently provides the chip voltage values in Volts, as
>floats.
Floating point is convenient for user-space, my focus on fixed point 
was for driver use, if it was allowed.  Fixed point has that annoying 
step of removing the sign from the number to the right of the decimal 
point :)  

Future resistor values come in E96 series which is a noisy calculation, 
the other option is resnet's where you might get 10/20 ratio or 10/30 
ratio which is also covered in E24 series.  

I've already demonstrated that E24 resistor ratios are below the basic 
error of the sensor chip.  E24 series over two decades gives ratios to 
much better than 1/2%, point 2: is that mobo makers are likely to use 
cheap 5% resistors, point 3: with winbond you're looking at ~60mV 
measurement resolution for 12V, the adm9240 was about 90mV resolution 
for -12V.

>And mostly useless, unfortunately, for the reasons given above. Most
>datasheets are hints at best.

Sort of, datasheets can be poorly expressed, poorly understood when 
one doesn't have the hardware, sure.  The errors I'm finding are way 
beyond that.  You're trying to tell a former electronics design 
engineer who was working with 50000 count A/D converters 20 years 
ago how to read datasheets and where error terms come from?  

And here we are, using 256 count converters, this aint rocket science.  

I did fixed point so it could be used in drivers, float point is 
convenient for user-space, I'm not against float point per se, my 
working in fixed point was to find error terms for drivers, there 
is a dataloss -> div/0 problem I encountered, took ages to fix, 
'cos Ohm's Law was being violated :)  And silly me put in a skip 
if zero which masked the issue for some time.  

I prefer to see obvious data transforms, traceable to datasheet, 
so Winbond begs for resistor ratios.

And I haven't looked at temperature yet :)

--Grant.
