From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <0aj481tn58ujge3jihupip7n1q87q6glve@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,
On Wed, 11 May 2005 10:23:50 -0400, Mark Studebaker <mds@mds.gotdns.com> wrote:

>                                But using 5% resistors in front of
>a sensor is just bad design. The Winbond datasheets  I've looked at
>have 1% resistors in the schematics. What's the basis for
>your 5% assumption?

1. Inventory = 24 values per decade rather than 96 on stock?  I 
think my local electronics shop only sells 1% now, but in E24 
series, so I framed a bad argument for the 5% E24 series.  My bad.

2. Empirical, I asked for and got no answer for a particular issue, 
coded up a test using E12 series and got a very unambiguous answer, 
I was quite surprised how 'accurate' this method is.  I try for 
different issue and go to E24 series, I did have to look up the 
E96 series :)

The method fails for E96 series as calculation resolution is below 
measurement resolution =>> no repeatability.  

Look at Winbond recommended 56/232 = .241, replace with 24/100 = .240
only ~1 bit error.  Seems to match my mobo BIOS vs sensors.  the 10/28 
translates to 20/56 E24 series -- so that 232k is only E96 value on 
winbond datasheet in functional terms.  The internal resistor values 
can be anything they want: 34/50, 34/51, 17/33 for various chips, 
and whether 5V or 5VSB

>You aren't the only EE around here, please don't give us a bad name by being
>snippy.

Mark, my apologies, I retired 12 years ago, burned out, completed 
a computing degree part time after a motorcycle accident and for 
the last several months been battling medication issues that have 
been very difficult for me, and have spilled over as bad attitude, 
particularly at times in last two months, including last week.

Sometimes I don't hit the delete button as often as I should when 
writing :)

This is what convinces me:
grant@sempro:~$ wq_discover_R1_R2-w83697hf

  Grant's voltage divider value finder, version 2005-05-11
  R1 is from E24 (5%) series, R2 from two decades E24 series

Sync measurement cycle... ... Done.

Working on:    12V
~~~~~~~~~~~~~~~~~~
    R1    R2    Error   100R2/R1
   ----  ----   ------     ---
    20    56    -0.03%     280
    43   120     0.29%     279

Working on:   -12V
~~~~~~~~~~~~~~~~~~
    R1    R2    Error   100R2/R1
   ----  ----   ------     ---
    18    75     0.06%     416
    24   100     0.06%     416
    36   150     0.06%     416

Working on:    -5V
~~~~~~~~~~~~~~~~~~
    R1    R2    Error   100R2/R1
   ----  ----   ------     ---
    56   120    -0.07%     214
    22    47     0.21%     213


   x     raw    BIOS   final   label   R1   R2  100R2/R1
   0    1552    1555    1552   Vcore    0    0
   2    3296    3295    3296     3.3    0    0
   3    3040    5135    5107   *   5   50   34     68
   4    3152   11975   11977      12   20   56     280
   5     624  -11785  -11776     -12   24  100     416
   6     848   -5045   -5049      -5   56  120     214
   7    3280    5075    4969   *5VSB   33   17     51
   8    3376    3375    3376   Vbatt    0    0

                               * internally scaled

Have I cheated?  I appended 5 instead of 0 to each BIOS voltage 
to get extra digit for whole mV value.  I think one could argue 
using 1/2 a digit is okay?

shell script at http://scatter.mine.nu/hwmon/voltage/

Using 100 * R2 / R1 for comparison ratio seems best for fixed 
point math, as R2 > R1.

I've set bailout on absolute error at 0.33%, I'm surprised, 
impressed by how well this method can pick values.  If I change 
the 24/100 for -12V to winbond 56/232:

    5     624  -11785  -11705     -12   56  232     414

That convinces me that my mobo uses 24/100 instead of 56/232.
We're looking at ~65mV resolution here.  Supporting your argument 
that mobo makers use 1% is the fact that this method works at 
as it uses current chip measurement to reconcile BIOS reading :)

I'm trying to make sense of a system that contradicts itself in 
intent and implementation.  The usual patchy documentation that 
GNU/Linux is famous for.  Well, we all plan to do documentation.

I see strangely implemented transforms and thus have a desire for 
audit trail back to datasheet values.  Particularly as I was firmly 
told all chips with internal scaling report pin voltage, and I 
find many do not, then I see quite weird transforms in drivers or 
sensors -- this needs fixing.

When I started this exercise it was not clear that sensors could 
use other inputs in a compute, required for adm9240.  Which I'll 
work on again soon to verify a sensors compute line for SE440BX-2 
mobo, though I'm a few years late for that one.

Besides, nothing beats evidence (as per research data collection 
terminology) to prove a point.  Being told datasheets are in error 
doesn't cut it for me.  

--Grant.
