From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: [PATCH 2.6] I2C sysfs interface documentation
Message-Id: <20031204214055.GC2239@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031116203250.4bce6b7e.khali@linux-fr.org>
In-Reply-To: <20031116203250.4bce6b7e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 16, 2003 at 08:32:50PM +0100, Jean Delvare wrote:
> 
> > > --- linux-2.6.0-test9/Documentation/i2c/sysfs-interface
> > > +++ linux-2.6.0-test9/Documentation/i2c/sysfs-interface.lm83
> > 
> > Should I still apply this patch?
> 
> Actually, no, don't apply it. The new patch to sysfs-interface (below)
> includes it. I did it that way because both sets of changes modify a
> common part of the file and the second patch might have been rejected
> because of that.
> 
> Summary of what the patch does:
> 1* No more current hysteresis value. I don't think we ever saw a chip
>    which monitors current, and if we ever do, I would be very, very
>    surprised if it would have an hysteresis value.
> 2* Temperature input and max can have 4 values. [from the previous
>    patch]
> 3* Split temperature min and hysteresis into two separate files.
> 4* New file temp_crit. [from previous patch]
> 
> The new file temp_crit is subject to change later as we decide more
> precisely how we want to handle values that are common to more than one
> temperature channels.
> 
> A patch to chipset drivers follows.

Applied, thanks.

greg k-h
