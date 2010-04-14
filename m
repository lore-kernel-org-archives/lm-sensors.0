From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Apr 2010 06:51:31 +0000
Subject: Re: [lm-sensors] [PATCH 0/2]: hwmon: allow setting update rate from
Message-Id: <20100414085131.0bc6e64e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1270671720-1575-1-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1270671720-1575-1-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Tue, 13 Apr 2010 15:54:26 -0700, Ira W. Snyder wrote:
> This is an experimental patch to set the update rate from userspace. An
> example implementation is provided for the adm1031 driver.
> 
> I think the modifications to the adm1031 driver turned out pretty ugly. I'd
> be happy to drop the first patch and the userspace support from the second
> patch.  I would keep just the parts that read the update rate from the chip
> and use that during chip updates.
> 
> I can make my bootloader responsible for setting the update rate
> appropriately in this case. The adm1031 driver will then use the programmed
> update rate. The side effect to this is that a user cannot use i2cset to
> change the update rate after the kernel has booted, if the driver is
> built-in.
> 
> If you can suggest a way to make the adm1031 code easier to follow while
> preserving this change, please speak up!

I think it should be possible to improve the patch in question. I'll
reply with a proposal, let's see if we can make it look good enough.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
