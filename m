From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Jan 2010 13:29:06 +0000
Subject: Re: [lm-sensors] Troubleshooting SCH5127 / DME1737
Message-Id: <20100115142906.5da97a3e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <3647.66.169.133.216.1259294200.squirrel@webmail.myamigos.us>
In-Reply-To: <3647.66.169.133.216.1259294200.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Jan 2010 18:09:05 +0100, Jean Delvare wrote:
> On Wed, 6 Jan 2010 08:50:30 -0800, Juerg Haefliger wrote:
> > Yes and no. I have a patch but it doesn't work on 2.6.33-rc2. In fact,
> > even the vanilla dme1737 driver doesn't seem to work on 2.6.33-rc2 and
> > sensors-detect is unable to find the I2C part of the chip. Haven't
> > looked too closely yet but I must be missing something obvious. 2.6.28
> > works just fine.
> 
> Could be that your machine is affected by the ACPI vs. native driver
> resource conflict check that was added in kernel 2.6.32?
> 
> Try booting with acpi_enforce_resources=lax and see if it helps.

Juerg, anything new? I'd like to solve this issue quickly.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
