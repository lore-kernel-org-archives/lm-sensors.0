From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [nikkne@hotpop.com: I2C proc support for 2.5.xx]
Message-Id: <20030623134854.GB8233@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030623114446.GB20361@frodo.local>
In-Reply-To: <20030623114446.GB20361@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi, I've noticed that the linux-kernel Documentation says there is i2c
> proc/ support, but there is none. kernel tree is missing i2c-proc.[h|c]
> files.

For 2.5, yes, sensor information does not show up in /proc anymore.

> If those files shouldn't exist in kernel-tree, then the documentation
> and help for CONFIG_I2C should be fixed. Otherwise, those files should
> be added.

True, want to send a patch to fix this?

> I've tried to build kernel 2.5.72, with turned on support for i2c (as
> module) and /proc but there was no i2c-proc, which made sensors tool
> (from working 2.4.21 instalation) totaly useless.

Yup, lmsensors will need to be changed for 2.5/2.6 kernels due to the
change to sysfs.  Want to help out?

thanks,

greg k-h
