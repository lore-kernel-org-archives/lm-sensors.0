From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Tue, 18 Nov 2008 08:41:35 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081118084135.GC12095@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 02, 2008 at 12:09:09AM +0200, Rudolf Marek wrote:

Hi Rudolf,

Sorry for the late reply. But up to now, I didn't find time for review
and test.  Now I've done that. I've two patches that I'd like to add
on top of your patches.

BTW, Tctl_max is inadvertently missing in the power and thermal data
sheet for family 0x11. It should be published with one of the next versions
of that document. For currently available family 0x11 CPUs it's 100degC.

I've tested your code with my patches on top of it on
various family 0x10 models and family 0x11 revB1.


Thanks.


Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
