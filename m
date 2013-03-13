From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Mar 2013 23:16:36 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: (lm75) Tune resolution and sample time per chip
Message-Id: <20130313231636.GA31809@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130312155108.054dd75e@endymion.delvare>
In-Reply-To: <20130312155108.054dd75e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 13, 2013 at 10:56:12PM +0100, Jean Delvare wrote:
> On Wed, 13 Mar 2013 14:50:40 -0700, Guenter Roeck wrote:
> > Does that mean I can now submit the 20-something patches I didn't bother
> > to submit due to lack of reviewers ? Just asking :-)
> 
> Nah, I'd rather review the patches you've already sent... starting with
> ltc2978 and coretemp.
> 
> Which doesn't prevent you from posting patches anyway. And even pushing
> them upstream if nobody has time to review them and you're confident
> they'll do more good than harm.
> 
I might actually do that at some point.

Key question right now though is what to do with the nct6775 driver ...
I would really like to get it off my back. It just seems impossible
to get anyone to review it. Not really surprising given its size.
On the other side there is real demand for it, to the point that
at least archlinux already provides it. I wonder if I should just
push it into 3.10 and wait for any fallout. Do you have an opinion ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
