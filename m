From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Aug 2010 21:32:19 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon/coretemp: Remove warnings of
Message-Id: <20100819233219.31cf694f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1282172027-640-1-git-send-email-fenghua.yu@intel.com>
	<1282172027-640-2-git-send-email-fenghua.yu@intel.com>
	<20100819092423.00f76256@hyperion.delvare>
	<4C6D8026.2060800@zytor.com>
	<20100819232655.4223e61f@hyperion.delvare>
	<4C6DA1EB.40600@zytor.com>
In-Reply-To: <4C6DA1EB.40600@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Rudolf Marek <r.marek@assembler.cz>, Huaxu Wan <huaxu.wan@intel.com>, Chen Gong <gong.chen@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Thu, 19 Aug 2010 14:28:11 -0700, H. Peter Anvin wrote:
> On 08/19/2010 02:26 PM, Jean Delvare wrote:
> > 
> > MAINTAINERS is correct. I do not have the time, nor the will, to be the
> > single official maintainer of the hwmon subsystem. I would be happy to
> > be a co-maintainer, but nobody stepped in to co-maintain with me.
> > 
> > Meanwhile, I'm doing my best to off-load some of the hwmon work from
> > Andrew, but that doesn't make me THE maintainer of hwmon.
> > 
> 
> OK.  I was simply wondering if Fenghua should push his coretemp tree
> through you rather than direct to Linus.

Well, it would certainly make sense for Fenghua to send the patches to
me (or better, to the lm-sensors list) and/or Andrew. I doubt Linus is
willing to review random driver patches on a regular basis, especially
when they don't fix anything critical.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
