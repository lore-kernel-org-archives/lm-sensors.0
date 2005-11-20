From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sun, 20 Nov 2005 22:40:09 +0000
Subject: [lm-sensors] Re: [PATCH] hwmon : Fix W83627THF VID reading
Message-Id: <20051120213957.GA4539@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEAF7CB7@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEAF7CB7@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2005-11-15 12:16:52 +0200]:
> While checking the W83627THF datasheet, I noticed that there is an
> additional GPIO configuration register, CRF5, named "inversion
> register". Wouldn't it make sense to check the value of this register
> and make sure all pins supposedly used as VID inputs are not inverted?
> Mark, can you please confirm that your system which does use GPIO5 for
> VID would pass that test? Proposed patch attached, comments and testers
> welcome.

Your patch does work on my system, but... no, I don't think it means anything
if the inputs are inverted or not.  The BIOS might set the inputs to inverted
if the VID signals are inverted by hardware... which I would not consider to
be unusual or unexpected.

Of course, it might just as well leave them *not* inverted *despite* that
they are inverted in hardware... which suggests a new module option if anyone
ever discovers such a board.

BTW: I tested by applying your current quilt stack (up to and including the
improve-gpio5-test patch) to 2.6.15-rc2.  

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

