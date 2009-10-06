From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Oct 2009 20:39:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp401/tmp421) Clean up detect
Message-Id: <20091006223942.75df932a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091006200919.4919a8e5@hyperion.delvare>
In-Reply-To: <20091006200919.4919a8e5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On Tue, 6 Oct 2009 22:27:09 +0200, Andre Prendel wrote:
> On Tue, Oct 06, 2009 at 08:09:19PM +0200, Jean Delvare wrote:
> > As kind is now hard-coded to -1, there is room for code clean-ups.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Andre Prendel <andre.prendel@gmx.de>
> 
> Acked-by: Andre Prendel <andre.prendel@gmx.de>
> 
> Out of curiosity, could you please point me to the commit changing
> this in i2c-core?

No commit yet, but a patch pending:
http://marc.info/?l=linux-i2c&m5484528631847&w=2

And there's more to come, in particular patches killing the
I2C_CLIENT_INSMOD marcros. But I didn't post them yet: due to the
cross-subsystem changes, they don't fit in linux-next yet.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
