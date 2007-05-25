From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 May 2007 13:25:19 +0000
Subject: Re: [lm-sensors] dynamic chip support
Message-Id: <20070525152519.032dbd7c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <461B7F5C.5080409@hhs.nl>
In-Reply-To: <461B7F5C.5080409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 25 May 2007 10:34:04 +0200, Hans de Goede wrote:
> I might be getting / reading this wrong, but take a look at adm1021_features
> in lib/chips.c there it still clearly states:
>      { { SENSORS_ADM1021_REMOTE_TEMP, "remote_temp", NOMAP, NOMAP, R },
>                                       ADM1021_SYSCTL_REMOTE_TEMP, VALUE(3), 0 },
>      { { SENSORS_ADM1021_REMOTE_TEMP_HYST, "remote_temp_low",
> ...
> 
> I haven't looked at the actual 2.6 driver. If the 2.6 driver indeed calls it 
> temp2_input, then how does libsensors know this??

There is a translation table for common symbol names in lib/proc.c:

static const struct match matches[] = {
	{ "beeps", "beep_mask", 0 },
	{ "pwm", "pwm1", 0, "fan1_pwm" },
	{ "vid", "cpu0_vid", INMAG, "in0_ref" },
	{ "remote_temp", "temp2_input", TEMPMAG },
	{ "remote_temp_hyst", "temp2_max_hyst", TEMPMAG },
	{ "remote_temp_low", "temp2_min", TEMPMAG },
	{ "remote_temp_over", "temp2_max", TEMPMAG },
	{ "temp", "temp1_input", TEMPMAG },
	{ "temp_hyst", "temp1_max_hyst", TEMPMAG },
	{ "temp_low", "temp1_min", TEMPMAG },
	{ "temp_over", "temp1_max", TEMPMAG },
	{ "temp_high", "temp1_max", TEMPMAG },
	{ "temp_crit", "temp1_crit", TEMPMAG },
	{ NULL, NULL }
};

Once we are done with the generic code and get rid of the chip-specific
declarations, all this symbol name translation stuff will be deleted as
well.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
