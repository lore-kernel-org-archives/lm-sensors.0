From: pmarques@grupopie.com (Paulo Marques)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: [RFC] Dynamic fan clock divider changes (long)
Message-Id: <40AC947E.2050706@grupopie.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516222809.2c3d1ea2.khali@linux-fr.org>
In-Reply-To: <20040516222809.2c3d1ea2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

Jean Delvare wrote:
> The user still doesn't have to care, which is fine, but if the user has
> a fan speed between 2000 and 5000 RPM, with low limit set to 1500 RPM,
> he/she will have a "bad" accuracy at 5000 RPM (+/- 104 RPM). I see this
> as the low limit "nailing" the divider ;)

This doesn't sound so bad at all. And this seems to be the simplest approach.

> This is what I implemented in my new pc87360 driver (after trying #1). I
> use 85 and 224 as the arbitrary limits for changing dividers.

This confused me a bit. It seems that a direct consequence of implementation #2 
is that the divider will be set in a way that the low limit will be between 128 
and 255, and that there is no point in changing the divider, because it will 
only get worse. This leads directly to implementation #4. Am I missing something?

Anyway, if the user is really concerned about accuracy an average of several 
measurements should increase precision in this kind of problem. See the 
following ascii art:

clock:
     ___     ___     ___     ___     ___     ___     ___     ___
___|   |___|   |___|   |___|   |___|   |___|   |___|   |___|   |__

fan complete turn pulse:

____________________|_____________________|_____________________|

So the first measurement is 3 (assuming rising edge counting), but some of the 
period will slip into the second measurement giving a count of only 2, and so 
on. So the jitter on the counts is actually correlated with the fan speed.

Just my 2 cents,

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"
