From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 03 Nov 2010 13:48:33 +0000
Subject: Re: [lm-sensors] [PATCH 0/8] hwmon: applesmc: Dynamic configuration
Message-Id: <20101103134833.GA12700@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288511434-5662-1-git-send-email-rydberg@euromail.se>
In-Reply-To: <1288511434-5662-1-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Sun, Oct 31, 2010 at 03:50:26AM -0400, Henrik Rydberg wrote:
> The amount of machines supported by this driver has increased rapidly
> over the past years, and the detailed driver support of the many
> flavors is quickly becoming a problem.
> 
> This patchset introduces dynamic configuration by making the SMC
> register set efficiently searchable, and fixes a number of outstanding
> issues:
> 
> * Support for all new models since MacbookPro 6.
> * Support for variable number of cpu sensors in the MacPros.
> * Handles the odd temperature sensor types found on new models.
> * Fixes minor read problems on many intermediate models.
> 
> The first patch is preparatory. The second patch adds the register
> lookup cache. The third patch adds the dynamic temperature files, and
> the fourth implements a new temperature register format. The fifth
> patch makes the remaining features dynamically configured, and the
> sixth patch sets up the fans dynamically. The seventh patch is purely
> janitory, and the last patch updates the copyright.
> 
> As a side-effect, the file is reduced by almost five hundred lines.
> 
Henrik,

since you applied your changes on top of Joe's pr_fmt patch, I assume
that you Ack that patch. Is that a correct assumption ?

I know you sent an Ack earlier, but it was "except for comments already made",
so this is just for clarification.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
