From: Dominik Geyer <dominik.geyer@gmx.de>
Date: Wed, 28 May 2008 16:43:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627hf) Drop reset module
Message-Id: <200805281843.19033.dominik.geyer@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080528173918.6e7e9da4@hyperion.delvare>
In-Reply-To: <20080528173918.6e7e9da4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wednesday 28 May 2008 17:39, Jean Delvare wrote:
> Drop the reset parameter of the w83627hf driver. It seems it wasn't
> that useful. It was dropped from the Linux 2.4 version of this driver
> back in July 2004.
> 
> The only users who have reported that they were still using this
> parameter, needed it to switch the chip from automatic fan speed
> control back to manual mode. Now that the driver creates pwmN_enable
> sysfs files, users will be able to use these files instead, which is
> way less agressive.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Note: this goes on top of Dominik Geyer's patch:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023189.html
> 
> Dominik, would you be so kind to review, test and ack this patch?
> Thanks.

The patch looks fine to me and applied successfully (with hunk offsets of -1 lines
in file w83627hf.c). If there are only users who needed this quirk for switching
PWM to manual mode, then I think it is safe to drop this code now.

I did a short test on a W83697HF and it is working as expected.

Acked-by: Dominik Geyer <dominik.geyer@gmx.de>

--
Dominik Geyer

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
