From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 26 May 2010 18:42:22 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (ltc4245) expose all GPIO pins
Message-Id: <20100526204222.5f0899f8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1271199569-3880-3-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1271199569-3880-3-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 26 May 2010 10:22:44 -0700, Ira W. Snyder wrote:
> On Wed, May 26, 2010 at 06:36:59PM +0200, Jean Delvare wrote:
> > Sorry for not being clear. I wasn't objecting to the stub's existence,
> > but to the fact that it was doing something. I expected it to do
> > nothing at all, and ltc4245_show_voltage() would be used for in9.
> 
> Oh, ok. The ltc4245_show_voltage() function reads the voltage register
> values directly from data->vregs[]. When the extra GPIO inputs are
> enabled, I have two choices:
> 
> 1) store them in the new data->gpios[] array
> 2) store them in data->vregs[]
> 
> For #1, ltc4245_show_voltage() doesn't work anymore, since it reads
> voltage register values from data->vregs[].
> 
> For #2, I would have to re-expand data->vregs[] to include all of the
> GPIO inputs, like it was before. Also, I would need to make
> ltc4245_get_voltage() handle the -EAGAIN error code.
> 
> I think the code is easier to understand if all the GPIOs are treated in
> the same way, and not completely special for GPIOADC1 vs GPIOADC[23].
> That's why I chose #1.
> 
> If I do a hybrid approach (store GPIOADC1 in data->vregs[] and
> GPIOADC[23] in data->gpios[]), then I have to make ltc4245_get_voltage()
> robust against errors too. Is this what you're suggesting?

No. But let's wait and see if you move to OF platform data, the whole
question will be moot. If you keep the config option approach, I'll
propose an iterative patch and we can discuss it then.

> (...)
> Any thoughts about the kernel config option vs. platform data, and how
> it relates to the OF bindings?

I would prefer platform-data-based. But I fear I don't know anything
about OF bindings. Better ask the embedded folks (e.g. Grant Likely),
they will know.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
