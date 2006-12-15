From: ukessler@uni-bonn.de (=?ISO-8859-1?Q?Ulrich_Ke=DFler?=)
Date: Fri, 15 Dec 2006 17:13:21 +0000
Subject: [lm-sensors] CPU temperature(s) of Conroe
Message-Id: <4582D7B1.5080903@uni-bonn.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20061123T125301-366@post.gmane.org>
In-Reply-To: <loom.20061123T125301-366@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Rudolf and Christian

>
> So now I need help to figure out where the compile problems come from. 
> The error messages are things like "initializer element is not 
> constant" or "... undeclared her (not in a function)" or "missing 
> braces around initializer" (this is only a warning).
> I took a look at the include list at the beginning of w83627ehf.c. In 
> the new version there are two additional files to be included: 
> hwmon-sysfs.h and mutex.h. They can be found in the directory 
> /usr/src/linux/include/linux. Do I have to tell the compiler something 
> about that e. g. in a Makefile?
>
I think I found a way to check if this is a problem. I inserted two 
lines in the old w83627ehf.c file:
#include <linux/mutex.h>
#include <linux/hwmon-sysfs.h>
and recompiled. It worked without problems. So there must be something else.

Uli

