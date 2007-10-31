From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Oct 2007 15:19:37 +0000
Subject: Re: [lm-sensors] hwmon/f75375s.c: buggy if()
Message-Id: <20071031161937.2f905875@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071017195439.GD3778@stusta.de>
In-Reply-To: <20071017195439.GD3778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 27 Oct 2007 01:35:28 +0300, Riku Voipio wrote:
> Sure. I reviewed just a obvious one. I'll look at reviewing something
> more complicated on monday. Apart from the fintek, I have currently it87
> and k8temp sensors to test, so any patches agains against those would
> be preferred.

Well, the it87 driver needs to be modified to create individual alarm
files. You could work on this if you want, that would be pretty helpful.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
