From: hunold@convergence.de (Michael Hunold)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <4083DDCE.2010704@convergence.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,


On 04/19/04 16:13, Gerd Knorr wrote:
>>I have been testing with the following ranges in sensors-detect:
>>0x30-0x37, 0x3C-0x3F, 0x50-0x57 and 0x5C-0x5F on my two systems (which
>>include EEPROMs on-board and over DDC, and other chips) and it worked
>>OK. This set of ranges is only a proposal, I have no strong objection
>>against a more extended range set (0x30-0x3F and 0x50-0x5F for example)
>>or a shorter one (as long as at least all five addresses of the AT24RF08
>>are included).
>>
>>Objections, comments, anyone?
> 
> 
> Just a side note as you are talking about address ranges and the like
> here:  Please keep in mind that there is a world outside smbus which
> also uses i2c and where your assumtions are not nessesarely correct even
> if they are for smbus.
> 
> I've added the .class bitfield during 2.5 to help avoid probing problems.
> The basic idea is to classify the busses be able to limit probing to
> busses where it makes sense to do that.  The tuner.o module for example
> will simply ignore any i2c adapter which hasn't the
> I2C_ADAP_CLASS_TV_ANALOG bit set in .class because it doesn't make much
> sense to look for a tv card tuner somewhere else.  It also doesn't make
> much sense to check for sensor chips on a TV card ;)
> 
> Don't know how widely this new .class bitfield is used outsite the v4l
> world, but it is a good idea to use it.  Reportly some DVB card
> frontends are reacting very sensitive to the lm_sensor probes.  Right
> now dvb uses a separate i2c system so it isn't a big issue right now,
> but very likely the dvb will switch over to the kernel's i2c subsystem
> soon.

Correct. I recently presented a patch which added a .class member to the 
client struct and a new flag to the adapter, so the i2c-core can check 
for matching .class fields (if the .class field has been set in the 
client) if that flag is present.

This solves the problem, where the i2c client doesn't check the .class 
field of the adapter (most non-v4l clients out there), without affecting 
backward compatibility.

The DVB system will switch to kernel i2c soon, and we need this 
behaviour to make sure we have an isolated i2c adapter with only DVB i2c 
clients.

Later it was discussed to clear this issue once and for all and make a 
.class entry mandatory for i2c clients (this breaking compability).

Although I agree that this makes really sense, I still vote for the 
simple "extent client structure + add a new flag" solution to get things 
going.

I'm going to present this patch once more and start the discussion again.

>   Gerd

CU
Michael.
