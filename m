From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lm_sensors2/prog/dump i2cbusses.c
Message-Id: <20031204220136.GA2380@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC6898D.DF9ECF07@paradyne.com>
In-Reply-To: <3FC6898D.DF9ECF07@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 27, 2003 at 06:32:29PM -0500, Mark Studebaker wrote:
> The 2.6 i2c-dev bus numbers don't necessarily match i2c-adapter bus
> numbers.
> If you rmmod and re-insmod a bus driver, the driver seems to get its old
> i2c-dev bus number back. But the i2c-adapter number increments.
> Don't know why. It would be much better if they matched.

Follow the symlink in the i2c-dev sysfs directory to find the adapter it
is bound to.  That's much easier than trying to match up numbers :)

thanks,

greg k-h
