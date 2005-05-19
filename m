From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: adm1026 driver port for kernel 2.6.10-rc2 (patch includes
Message-Id: <20041123185022.54f6e069.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041102221745.GB18020@penguincomputing.com>
	<NN38qQl1.1099468908.1237810.khali@gcu.info>
	<20041103164354.GB20465@penguincomputing.com>
	<20041118185612.GA20728@penguincomputing.com>
	<20041123165236.GA4936@penguincomputing.com>
In-Reply-To: <20041123165236.GA4936@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>

> Taking into account Arjan's comments, I have fixed the awkward
> locking constructs.  I have also switched from using MODULE_PARM()
> to module_param_array().  As Jean requested (and as I muttonheadedly
> ignored) on the last submission, the diff now includes the patches to 
> 
> .../drivers/i2c/chips/Makefile
> .../drivers/i2c/chips/Kconfig

Great, looks good enough to me. I'd like to see this patch applied to
the kernel. Any further change can be done through incremental patches,
which are so easier to review.

Thanks Justin for the good work :)

-- 
Jean Delvare
http://khali.linux-fr.org/
