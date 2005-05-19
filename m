From: fishor@gmx.net (Alexey Fisher)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: max1619
Message-Id: <200405271651.22592.fishor@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405211303.18083.fishor@gmx.net>
In-Reply-To: <200405211303.18083.fishor@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> +show_temp(temp_input1, TEMP_FROM_REG);
> +show_temp(temp_input2, TEMP_FROM_REG);
> +show_temp(temp_low2, TEMP_FROM_REG);
> +show_temp(temp_high2, TEMP_FROM_REG);
> +show_temp(temp_crit2, TEMP_FROM_REG);
> +show_temp(temp_hyst2, TEMP_FROM_REG);
>
> TEMP_FROM_REG doesn't have to be passed by parameter, since it's always
> the same.
>

Jaen, I'm not sure what you mean. If you about "temp_hyst2", in these driverer  
hyst is chenchebl, not always the same.

> Once you have fixed everything, and have tested the new version with
> lm_sensors CVS, you should be able to submit your new driver to Greg KH
> for inclusion into the main 2.6 tree. Briefly explain what the driver is
> for and how you wrote it (including the fact that I reviewed it). Don't
> forget to CC: the lm_sensors mailing list. Note that you have to send
> the patch *inline* (as opposed to in attachement) when sending patches
> to Greg. Make sure that your e-mail client won't break it (various
> e-mail clients would break long lines or replace tabs with spaces...).

Actioly i dont know who is Greg. Am i can finde his Email in documentation ?

> Thanks, and congratulations again :)

Thank you, without your halp i newer did it :-)
