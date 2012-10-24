From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2012 06:17:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627hf) Add support for suspend
Message-Id: <20121024081726.57f4c2de@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121023175025.6d6e46a4@endymion.delvare>
In-Reply-To: <20121023175025.6d6e46a4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 23 Oct 2012 20:33:55 -0700, Guenter Roeck wrote:
> On Tue, Oct 23, 2012 at 05:50:25PM +0200, Jean Delvare wrote:
> > On suspend some register values are lost, most notably the Value RAM
> > areas but also other limits. Restore them on resume. On top of that,
> > some fixups are needed to work around BIOS bugs, in particular when
> > the BIOS omits running the same initialization sequence on resume
> > that it does after boot. In that case we have to carry initialization
> > over suspend.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Does the BIOS bug apply to all BIOSes, or just to some, or does it not matter ?

At least mine. But there is no downside on other systems, reading and
writing two extra registers over the LPC bus is pretty cheap. And I
would be very surprised if other BIOSes out there don't need the same
anyway.

> I have a system with w83627hf - want me to test the code with it ?

Would be great, yes. Dumping the registers before and after suspend
would be a good way to ensure it worked fine.

> Code itself looks good afaics, so
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks for the review.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
