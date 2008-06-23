From: Rene Herman <rene.herman@keyaccess.nl>
Date: Mon, 23 Jun 2008 10:24:06 +0000
Subject: Re: [lm-sensors] LMSENSORS: 2.6.26-rc,
Message-Id: <485F79C6.20507@keyaccess.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <485DA11C.7050906@keyaccess.nl>	<485DFF35.6080008@hhs.nl>	<485E505F.8010306@keyaccess.nl>	<485E61DE.6020202@hhs.nl> <20080623120844.5f722aa6@hyperion.delvare>
In-Reply-To: <20080623120844.5f722aa6@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On 23-06-08 12:08, Jean Delvare wrote:

> No, the kernel does the right thing and does not need to be modified
> at all.

No Jean, this is totally unacceptable. No matter how you want to call 
things, 2.6.26 is going to break important functionality on millions of 
systems and you simply do not get to do that. Can you comment on the 
last patch posted? It's trivial:

http://lkml.org/lkml/2008/6/22/243

Rene.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
