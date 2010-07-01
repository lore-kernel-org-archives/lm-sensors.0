From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 Jul 2010 09:14:58 +0000
Subject: Re: [lm-sensors] [PATCH] Add driver for SMSC EMC2103 temperature
Message-Id: <20100701111458.6995ebc1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1274550843-3035-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1274550843-3035-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steve,

On Thu,  1 Jul 2010 10:00:07 +0100, Steve Glendinning wrote:
> SMSC's EMC2103 family of temperature/fan controllers have 1
> onboard and up to 3 external temperature sensors, and allow
> closed-loop control of one fan.  This patch adds support for
> them.
> 
> Changes since v4:
> - expose divider to userspace instead of multiplier
> - store fan_multiplier instead of range bits in private data
> (...)

Looks alright this time. Patch applied, thanks for your contribution
and patience.

Greg, please drop the old copy you had in your drivers tree.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
