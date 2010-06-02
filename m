From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Jun 2010 07:21:33 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (k10temp) Do not blacklist known
Message-Id: <20100602092133.2ef3ed41@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100601184732.7a498112@hyperion.delvare>
In-Reply-To: <20100601184732.7a498112@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 02 Jun 2010 08:11:14 +0200, Clemens Ladisch wrote:
> Jean Delvare wrote:
> > When detecting AM2+ or AM3 socket with DDR2, only blacklist cores
> > which are known to exist in AM2+ format.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Clemens Ladisch <clemens@ladisch.de>
> > Cc: Andreas Herrmann <andreas.herrmann3@amd.com>
> 
> Acked-by: Clemens Ladisch <clemens@ladisch.de>
> 
> > +	return boot_cpu_data.x86_model < 4 ||
> > +	       (boot_cpu_data.x86_model = 4 && boot_cpu_data.x86_mask <= 2);
> > +
> 
> but that empty line is superfluous

Oh, good catch. Fixed, thank you!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
