From: jthiessen@penguincomputing.com (Justin Thiessen)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: adm1026 driver port for kernel 2.6.10-rc2  [RE-REVISED DRIVER]
Message-Id: <20041122193538.GA4698@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041102221745.GB18020@penguincomputing.com>
 <NN38qQl1.1099468908.1237810.khali@gcu.info>
 <20041103164354.GB20465@penguincomputing.com>
 <20041118185612.GA20728@penguincomputing.com>
 <20041120105740.1a238842.khali@linux-fr.org>
In-Reply-To: <20041120105740.1a238842.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@Stimpy.netroedge.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 10:57:40AM +0100, Jean Delvare wrote:
> Hi Justin,
> 
> > Ok, let's try this (yet) again:
> 
> I'm sorry to insist be we really want this as a patch against
> 2.6.10-rc2. That's what Greg needs. As said earlier, the patch would
> include the new adm1026.c file (obviously) as well as the necessary
> changes to Kconfig and Makefile.

Ack.  Sorry for forgetting the Kconfig and Makefile changes. 

The driver itself is actually a patch against 2.6.10-rc2.

I'll post the driver once the issues Arjan raised have been resolved.

Justin Thiessen
---------------
jthiessen@penguincomputing.com

