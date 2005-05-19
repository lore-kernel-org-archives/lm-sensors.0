From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <4u7081l50aikn5qgrv3fte0pgmjgnap7o9@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Mon, 9 May 2005 15:35:36 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>Your code makes sense for external resistors, but not for internal
>scaling as far as I can see, so it won't be of any help in the drivers.
>And libsensors mostly works the way you describe already, just not in as
>formal a way (because compute lines were meant for all values, not just
>voltages).

>So all in all I think that you are trying to fix a problem that doesn't
>exist in the first place, sorry.

Just reviewed /etc/sensors.conf again, negative voltage calculation 
is totally bogus as it does not account for reference voltage driving 
top of resistor divider.  The proof is that you do not have correct 
Winbond resistor values in the sample calculations.  They're fudged.

+12V: compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)  uses Winbond values

Fudged negative calculations:

-12V: compute in5 -(210/60.4)*@  ,  -@/(210/60.4)  210/60.4 = 3.47
	versus datasheet: 232/56 = 4.14

-5V: compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4) 90.9/60.4 = 1.5
	versus datasheet: 120/56 = 2.14

Parameter based calculation does not have these issues, doesn't 
need floating point either.  I think this is the background thing 
bugging me for weeks since I looked at sensors.conf

What do you need for further proof?  My interest is correctness.

Numbers traceable to datasheet is easy way.  My last reply 
detailed calibration to mobo use of other than sensor chip 
suggested values.

Another section of my shell script (fixed point math):

Vref600 # mV reference driving top of Vminus voltage divider

function scale_voltage # nr, scale type: none, plus, minus
{
        local r1=${R1spec[${1}]}
        local r2=${R2spec[${1}]}
        local in=${Vread[${1}]}
        case $2 in
                0 ) Vshow[${1}]=$in;;
                1 ) Vshow[${1}]=$(((in * (r1 + r2) + r1 / 2) / r1));;
                2 ) Vshow[${1}]=$(((((in - Vref) * r2 + r1 / 2) / r1) + in));;
                * ) Vshow[${1}]=0;;
        esac
}

--Grant.
