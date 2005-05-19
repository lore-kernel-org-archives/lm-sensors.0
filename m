From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: Query: Intel SE440BX-2 negative voltage?
Message-Id: <q4r0619qmanpl3sm8jk3nh61a6bc7frk27@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c5g0615rejeqqrtp08i56nj8b62vnq2rfn@4ax.com>
In-Reply-To: <c5g0615rejeqqrtp08i56nj8b62vnq2rfn@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 16 Apr 2005 08:45:22 +1000, Grant Coady <grant_lkml@dodo.com.au> wrote:

>Hi Gang,
>
>The Intel SE440BX-2 measures -5V and -12V, however I can find 
>no reference as to which input measures what negative rail.

Found it -- wrote a script to describe possible resistor dividers 
for measured voltages and one interpretation wins hands down over 
the other -- me happy.  Computer as calculator, what a novel idea :)

	-5V to Vccp1	-12V to Vccp2
R1, R2	1200, 2700	1500, 8200

Assume R1 to +5V as Vref, R2 to Vminus.  Self calibrate by using 
measured +5V to calculate Vminus, dunno if sensors does that, works 
for me.  Match is within measurement resolution.

Cheers,
Grant.
