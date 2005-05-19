From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: Query on apparently 'disconnected' sysfs interfaces
Message-Id: <20050318223348.048e3b48.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
In-Reply-To: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> These items do not appear in doc/i2c/sysfs-interface, yet to 
> check source context, ad hoc grep & cut in drivers/i2c/chips:
> 
> alarm_mask	< beep_mask?  I'd like to have alarm_mask

Beep mask and alarm mask are different things. Alarm mask lets you
ignore an alarm completely. Beep mask preserves the alarm but masks the
associated beeping.

If alarm_mask isn't documented, it should - except that it should be
alarms_mask.

> alarms_in
> alarms_temp

Variants of alarms, where you have separate files instead of one single
one. Could be documented.

> analog_out
> aout_output	< analog_out ?
> out0_output

This is the same thing. If we follow the naming convention for the other
channels, the correct one would be out0_output. Should be documented,
and drivers using analog_out and aout_output should be fixed.

> die_code

Should probably be dropped (useless), but see below.

> in1_ref
> vid		< cpu0_vid?

Both should cpu0_vid, drivers need to be fixed.

> fan1_auto
> gpio
> gpio_mask
> out0_enable
> temp1_crit_enable
> temp1_hyst
> temp1_min_hyst

I see nothing wrong with these. Remember that sysfs-interface documents
the names for standard interface files. When a drivers has additional
needs, it is free to use additional names. These might be standardized
and documented later if other drivers also need the same.

The rule is that undocumented file names can be arbitrarily changed
afterwards when a standard is established and documented. Documented
file names should not change.

> At this point in time I'm quite happy to document and cross-reference 
> current practice, but I don't want to duplicate a work-in-progress.

Nobody is working on this at the moment. We'd welcome patches fixing
drivers that use incorrect file names, and documentation updates.

Thanks,
-- 
Jean Delvare
