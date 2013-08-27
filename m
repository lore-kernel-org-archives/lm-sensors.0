From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Aug 2013 15:30:46 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (acpi_power_meter) Fix incorrect placement of __initdata
Message-Id: <20130827173046.1d0f3d36@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Aug 2013 08:25:01 -0700, Guenter Roeck wrote:
> On Tue, Aug 27, 2013 at 03:10:43PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Aug 27, 2013 at 03:57:53PM +0200, Jean Delvare wrote:
> > > Also note that the fix Sachin sent for acpi_power_meter is slightly
> > > different from what Russell complained about originally. Russell
> > > complained about:
> > > 
> > > struct __initdata foo bar;
> > > 
> > > While acpi_power_meter uses:
> > > 
> > > struct foo __initdata bar;
> > > 
> > > The former does indeed NOT work in my tests, so Russell was right
> > > complaining. The good news is that there are only a few dozen
> > > occurrences of this in the kernel tree.
> > 
> > Indeed - and these "don't work" ones are definitely worth fixing.
> > 
> > > The later OTOH works fine in my tests so I see no reason to change it -
> > > unless someone can find a gcc version and platform combination where it
> > > does not work. Hope this clarifies the whole situation...
> > 
> > Yes, better not to change what's already there if it works fine.
> 
> Since the patch discussed here is a working case and doesn't need to get fixed,
> I'll drop it from my queue.

Yes please. Same for:

[PATCH 1/1] hwmon: (asus_atk0110) Fix incorrect placement of __initconst

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
