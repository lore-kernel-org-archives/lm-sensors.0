From: Rene Herman <rene.herman@keyaccess.nl>
Date: Mon, 23 Jun 2008 14:06:20 +0000
Subject: Re: [lm-sensors] LMSENSORS: 2.6.26-rc,
Message-Id: <485FADDC.4010108@keyaccess.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <485DA11C.7050906@keyaccess.nl>	<485DFF35.6080008@hhs.nl>	<485E505F.8010306@keyaccess.nl>	<485E61DE.6020202@hhs.nl>	<20080623120844.5f722aa6@hyperion.delvare>	<485F79C6.20507@keyaccess.nl>	<20080623135704.2980078c@hyperion.delvare>	<485F9877.1060902@keyaccess.nl> <20080623154715.3ac8e984@hyperion.delvare>
In-Reply-To: <20080623154715.3ac8e984@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On 23-06-08 15:47, Jean Delvare wrote:

>> This cannot be the reason, because it's not wrong. We just need a device 
>> backlink. Basically, any single one will do. It's just about keeping 
>> lm-sensors 2 happy.
> 
> Your patch _is_ wrong. You make the device link point to _one_ of the
> devices that belong to the thermal zone, arbitrarily. If the device is
> removed before the thermal zone itself is, what happens?

As Zhang Rui said, this cannot happen in reality. I'll stop talking to 
you. Kernel side, it's not your problem anyway, it's an ACPI Thermal 
Zone one. Guess I'll go ask the 2.6.26 release manager if he feels that 
breaking existing lm-sensors 2 userspace systems is acceptable. I myself 
obviously know how to fix things by now.

Admittedly I need to find another hobby because the regularity with 
which people on this list piss me off is definitely disturbing. I also 
have this depressing notion that it might just be people pissing me off 
with frightening regularity period, but oh well.

Gardening... maybe I'll do gardening now.

Rene.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
