From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 31 Oct 2011 15:36:17 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (w83627ehf) Clean up probe
Message-Id: <20111031163617.6cd16539@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111031152004.28e9f7b8@endymion.delvare>
In-Reply-To: <20111031152004.28e9f7b8@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 31 Oct 2011 08:22:59 -0700, Guenter Roeck wrote:
> On Mon, 2011-10-31 at 10:20 -0400, Jean Delvare wrote:
> > The probe function has grown pretty large, I think it's time for some
> > cleanups, starting with these two simple ones:
> > * Move temp3/in6 check for the W83667HG later in the function, where
> >   it is done for all other chip types.
> > * Move temperature register setting to a separate function, to avoid
> >   code duplication.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Do you want to take this series, or should I take it ?

I'll take it, my setup to push things to Linus is operational again.

> > ---
> > Guenter, had you considered adding support for the NCT6775 and NCT6776
> > to a separate driver? The code starts being seriously bloated :(
> > 
> No thoughts so far. Might be an option, but I am not sure if/when I
> would have time to work on it. And I would have to get a board with
> NCT6776 on it. If there are any with SandyBridge CPU, I might actually
> get one ;).

Would be great.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
