From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Nov 2008 09:06:47 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] k8temp warn about errata
Message-Id: <20081118100647.00be2a4b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F505.40401@assembler.cz>
In-Reply-To: <48E3F505.40401@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andreas,

On Tue, 18 Nov 2008 09:55:29 +0100, Andreas Herrmann wrote:
> your git tree is at git://jdelvare.pck.nerim.net/jdelvare-2.6, correct?
> At least that's what you have used in your pull requests.

No this is incorrect. This git tree is a temporary thing I use to let
Linus pull my patches, but the actual work is done in a quilt tree at:

http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/

That being said, please keep in mind that this is as unofficial as you
can get, given that I am not the maintainer of the hwmon subsystem.

> Did you apply Rudolf's patch to this git tree?
> 
> I just want to know against which tree I need to create patches when adapting
> k8temp.

For now I applied:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-k8temp-01-warn-about-errata.patch

But everyone involved seems to agree that it isn't sufficient and we
should prevent the driver from binding to broken devices if possible,
using either a revision-based blacklist, or a temperature value-based
heuristic. I didn't yet have the time to work on this though, nor did
anyone else apparently.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
