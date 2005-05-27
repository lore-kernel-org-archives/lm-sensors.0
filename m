From: grant_lkml@dodo.com.au (Grant Coady)
Date: Fri, 27 May 2005 03:47:15 +0000
Subject: [lm-sensors] Query: what chance to get scaled voltages into drivers?
Message-Id: <b6qc91dgk33k2ucv21du0aqsqbk3egj389@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

Couple months back I was terribly confused over vid being scaled 
within drivers, other voltages scaled in user-space, then discover 
that internally scaled values were in fact not being scaled as per 
sysfs documentation in driver but in user-space.

Seem too late to fix that, and lmsensors not only ppl to get it 
wrong, Windows SpeedFan reports 5.5V for 5VSB 'cos they not grok 
datasheet tell different dividers for each 5V.  

What I'm thinking of is inX_scale, read returns scaled value, write 
sets scale factor, driver will know how to do negative offset given 
negative scale factor.  

By making it a parallel option, we don't break existing user-space.

This idea worth trying or forget it?

Reason I ask is winbond series have three different internal scaling 
for 5V and 5VSB, which is driver knowledge, and drivers could default 
to manuf. recommended dividers, also driver knowledge.  Other chips 
also depend on user-space scaling what 'should' have been done in 
driver per documentation.

BTW: there are only 630 discrete resistor ratios from 1.2:1 to 10:1 
using E24 resistor series.  But that's a user-space thingy to generate 
'compute' lines for sensors.conf.  I can do that instead.  

Since something needs doing in documentation / drivers / sensors.conf.eg 
I'd like some idea of most acceptable path to follow, I've scratched my 
particular itch with voltage calibration, dunno if anyone else cares :)

--Grant.

