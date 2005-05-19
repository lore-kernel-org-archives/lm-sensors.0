From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: LM93 vccp_limit_type "relative" does not work
Message-Id: <20041015025818.GD4035@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <416EDF3D.7090307@earthlink.net>
In-Reply-To: <416EDF3D.7090307@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David:

* David Knierim <david_knierim@earthlink.net> [2004-10-14 16:19:09 -0400]:
> I've been trying to get the "relative" mode of the LM93 to work.   I 
> have used i2cdump, i2cset and the spec sheet to get an idea how this 
> feature works.  However, what it will take to get the LM93 to do it is 
> beyond my abilities, I am afraid.
> 
> I'm using the CVS version from Oct. 12, which has all current LM93 fixes 
> integrated.
> 
> In order to use the feature the following steps need to be done:
>  1. set thresholds in register 0xb2 and 0xb3 (pg 60 of spec sheet)
>  2. unmask alarms in register 0xed (pg 84 of the spec sheet)
>  3. read alarms in register 0x4B (pg 48 of the spec sheet)
>  4. dynamically update the thresholds for libsensors based on VID input 
> and settings in #1
> 
> I have tried to use the vccp_limit_type load-time parameter.  It should 
> do this, but I get lost trying to figure out what it is actually doing.
> 
> It definately does work on item #4 and if I change the thresholds in 
> registers 0xb2 and/or 0xb3, the thresholds displayed by sensors(1) 
> change.  However, they do not match what is documented in the spec sheet.
> 
> On my box, registers 0xb2 and 0xb3 are 00 on startup.  Loading the 
> driver makes no difference, so step #1 does not appear to be being done.

We don't initialize limits at driver init anymore... the idea is that
the hardware defaults (BIOS or otherwise) are safer than whatever defaults
we would use.  So, these will remain as we found them until you explicitly
change them by e.g. using 'sensors -s' or writing the /proc files.

> On my box, the register 0xed has the dynamic vccp limit masked out when 
> the box boots up.  Loading the driver makes no difference, so step #2 
> does not appear to be being done.

Oops, that's a bug.

> No matter what state is used for the vccp_limit_type load-time 
> parameter, the alarms as displayes by sensors(1) are from the IN_7 and 
> IN_8 voltage error bits.

That's also a bug.

> Have I missed something??

Nope, looks like I did though. :)  I'll work up a patch soon, if not tonight.

> Thanks for any input.

Thanks again for your very thorough testing.  I wish all bug reports were
like yours.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
