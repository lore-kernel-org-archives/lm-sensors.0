From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Apr 2012 12:36:47 +0000
Subject: Re: [lm-sensors] Graphic cards, heatsink and linux
Message-Id: <20120418143647.4758a949@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F8EA9A8.9010803@gmail.com>
In-Reply-To: <4F8EA9A8.9010803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 18 Apr 2012 13:46:48 +0200, David Kremer wrote:
> Hi. I am considering buy a graphic card such as this one :
> http://193.164.197.40/images/388/3886417563.jpg
> 
> The person that want to sell me this card is saying that the fan makes 
> too much noise into linux.
> 
> What should I expect ? Do you think this is lm-sensors and guys working 
> about thermal monitoring in the kernel that are concerned by this kind 
> of issue, or rather the guys working on the radeon driver ?

This would rather be a task for the radeon driver maintainers. An easy
test is to check if the card is quieter when using the binary fglrx
driver. If it is, then odds are that this isn't a problem of monitoring
nor even a problem of fan speed control, but thermal management being
suboptimal by default in the radeon driver.

First thing I do on my systems with Radeon cards is to change the
thermal profile from "default" to "high" ("auto" would be even better
on recent kernels) to let the card cool down when I'm not using the
machine. But a more dynamic thermal management would be even better.

For reference, here is my udev rule:

SUBSYSTEM="pci", ACTION="add", ATTR{vendor}="0x1002", ATTR{class}="0x030000", ATTR{power_profile}="high"

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
