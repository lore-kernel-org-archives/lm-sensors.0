From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Fri, 11 Dec 2009 12:57:52 +0000
Subject: Re: [lm-sensors] Duplicated driver for LIS302-like device.
Message-Id: <4B2241D0.3050504@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B21B40B.2010007@0xlab.org>
In-Reply-To: <4B21B40B.2010007@0xlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matt Hsu <matt@0xlab.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Samu Onkalo <samu.p.onkalo@nokia.com>, Eric Piel <eric.piel@tremplin-utc.net>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Matt
> 
> Recently I was managed to make LIS302DL device work on Beagleboard.
> It's almost done.
> 
> The last thing I would like to do is to commit the driver to upstream.
> Here comes a problem. I found there's a similar driver named lis3lv02d.c.
> which is located drivers/hwmon/. They are pretty much the same.
> Only registers mapping is different slightly.
Firstly that would make emailing lm-sensors more sensible than linux-input
but what the heck,  some of us read both. Also for queries like this copy
in the maintainer of the driver you are asking about.
> 
> Originally, I plan to use this driver directly instead of implementing
> another lis302dl-like driver.
> Unfortunately, this driver is dependent on ACPI subsystem.
> The target platform for this device is based on ARM.
> Therefore, I could not re-use this driver for my work
> and re-implement it based on I2C interface.
Gah, Not again!  So far we have had two patch sets implementing just
this.  Looking at the latest from Samu, Eric's patch has been sent on
to Andrew Morton for the current merge window (and is listed as being in
his mm tree).  May even have merged since I last pulled mainline.

You have my sympathies as the whole duplicating work thing happens to
us all from time to time.  The answer is as ever, post early and post
often to the relevant mailing lists. (though of course hardly anyone
actually keeps to this!)

I've cc'd in everyone I know has an interest in this driver for any
thing else they might want to add.

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
