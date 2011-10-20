From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 20 Oct 2011 14:30:18 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (w83627ehf) Better fix for
Message-Id: <1319121018.3720.273.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111020091331.798b0e04@endymion.delvare>
In-Reply-To: <20111020091331.798b0e04@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-10-20 at 03:13 -0400, Jean Delvare wrote:
> It is more efficient to left-align 8-bit temperature values, so that
> 8-bit and 9-bit temperature values can be handled exactly the same way
> in the rest of the code.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> Here's the bloat-o-meter report:
> add/remove: 2/0 grow/shrink: 0/5 up/down: 138/-380 (-242)
> function                                     old     new   delta
> w83627ehf_write_temp                           -      78     +78
> w83627ehf_read_temp                            -      60     +60
> show_temp_max_hyst                           119      77     -42
> show_temp_max                                119      77     -42
> show_temp                                    119      77     -42
> store_temp_max_hyst                          355     228    -127
> store_temp_max                               355     228    -127
> 
> Guenter, what do you think?

I like it. Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
