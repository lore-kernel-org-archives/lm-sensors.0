From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <jsc781t4m9ghh14hhkp915b0hu2hbiu6kr@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,
On Wed, 11 May 2005 10:41:35 -0400, Mark Studebaker <mds@mds.gotdns.com> wrote:

>Do you now think the formula  is wrong or just hard to understand?

Not wrong, hard to understand :)

What do you think of this approach to calibration?

set sensors to 1:1 for unknowns so we read sensor chip's values

ask user for +12V, -5V, -12V BIOS or meter readings

calculate 'y = mx + c' transforms for sensors.conf, based on 
discrete E24 resistor series: one decade for R1, two decades 
for R2:

#    ---o--> +12V
#       |
#       -
#      | | R2        ----------------------              -5V, -12V
#      | |          |                      |   ____       ____
#       -           |          3600mV Vref |--|____|--o--|____|-->
#       |      Vin  |                      |    R1    |    R2
#       o-----------| 0..4096mV            |          |
#       |           |            0..4096mV |----------
#       -           | W83697HF             | Vin
#      | | R1       |                      |
#      | |           ----------------------
#       -                      |
#       |      0V              |                               0V
#    ---o----------------------o--------------------------------->

The technique seems viable, and has accuracy better than chip 
A/D resolution.  For those cases where mobo uses datasheet values 
this technique has no use for end user, but when their voltages 
are messed up, this technique will give a better answer being 
based on a discrete set of viable transform 'x' ratios.

On reflection, end user doesn't want traceable transforms, that's 
for driver writers -- and since we scaling lower sensor voltages in 
user-space now, I doubt it worth changing unless I find errors in 
transforms.  And it is difficult to goof up on 16mV / bit :)

I think I now understand the 'datasheets not be trusted' related 
to their strange formulas, only one datasheet (lm81) had a decent 
transform, I've had to go back to basics to retrace path you guys 
already done. 

Is there a reason why sensors doesn't do the reverse transform for 
voltage set functions?  (rather than the explicit dual compute)

Thanks,
--Grant.
