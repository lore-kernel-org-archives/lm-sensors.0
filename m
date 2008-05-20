From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 20 May 2008 19:00:36 +0000
Subject: Re: [lm-sensors] [PATCH] w83627hf: Add pwm_enable sysfs-interface
Message-Id: <20080520210036.443f8356@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805161836.42920.dominik.geyer@gmx.de>
In-Reply-To: <200805161836.42920.dominik.geyer@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dominik,

On Tue, 20 May 2008 18:56:29 +0200, Dominik Geyer wrote:
> Please find my new patch (inline & attached).
> 
> There are no checks for the presence of a PWM3 in functions show_pwm_enable() and
> store_pwm_enable(), I hope this is correct.

Yes it is, because the pwm3_enable sysfs file is only created for the
devices which have PWM3, and show_pwm_enable() and store_pwm_enable()
can only be called from sysfs files which have been created.

> I tested switching to manual pwm-mode and back to automatic pwm-mode on a 
> W83697HF.

This updated patch looks all OK to me.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
