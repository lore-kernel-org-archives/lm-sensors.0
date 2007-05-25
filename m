From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 25 May 2007 08:34:04 +0000
Subject: Re: [lm-sensors] dynamic chip support
Message-Id: <46569F7C.8000302@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <461B7F5C.5080409@hhs.nl>
In-Reply-To: <461B7F5C.5080409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
>> Some observations, in an ideal world this dyn chipsupport could replace most of 
>> the 5000 lines of code in prog/sensors/chips.c, however some chips seem to use 
>> non standard sysfs names <sigh> like remote_temp and zone_xxxxx, etc. I'm 
> 
> A Linux 2.6 driver creating a sysfs file named remote_temp? I can't
> believe that. Can you please double-check, and point me to it if it
> really exists? Some Linux 2.4 driver did that, I know, but the feature
> should have been renamed to temp2_input when the driver was ported to
> Linux 2.6.
> 

I might be getting / reading this wrong, but take a look at adm1021_features
in lib/chips.c there it still clearly states:
     { { SENSORS_ADM1021_REMOTE_TEMP, "remote_temp", NOMAP, NOMAP, R },
                                      ADM1021_SYSCTL_REMOTE_TEMP, VALUE(3), 0 },
     { { SENSORS_ADM1021_REMOTE_TEMP_HYST, "remote_temp_low",
...

I haven't looked at the actual 2.6 driver. If the 2.6 driver indeed calls it 
temp2_input, then how does libsensors know this??

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
