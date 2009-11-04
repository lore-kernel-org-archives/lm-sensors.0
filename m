From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 04 Nov 2009 19:26:49 +0000
Subject: Re: [lm-sensors] [PATCH] sensord: Don't name our variables "alarm"
Message-Id: <20091104192649.GB4334@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091104102719.12f309cb@hyperion.delvare>
In-Reply-To: <20091104102719.12f309cb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Nov 04, 2009 at 10:27:19AM +0100, Jean Delvare wrote:
> "alarm" is a glibc function, don't use this identifier for our own
> variables to prevent any confusion.

Looks good. I see you made this patch on the top of my patch
series. Patch applies without conflicts.

Regards,
Andre

> ---
>  prog/sensord/chips.c   |   44 ++++++++++++++++++++++----------------------
>  prog/sensord/sense.c   |   14 +++++++-------
>  prog/sensord/sensord.h |    2 +-
>  3 files changed, 30 insertions(+), 30 deletions(-)
> 
> --- lm-sensors.orig/prog/sensord/chips.c	2009-11-04 10:18:07.000000000 +0100
> +++ lm-sensors/prog/sensord/chips.c	2009-11-04 10:19:09.000000000 +0100
> @@ -33,78 +33,78 @@
>  
>  static char buff[4096];
>  
> -static const char *fmtExtra(int alarm, int beep)
> +static const char *fmtExtra(int alrm, int beep)
>  {
> -	if (alarm)
> +	if (alrm)
>  		sprintf(buff + strlen(buff), " [ALARM]");
>  	if (beep)
>  		sprintf(buff + strlen(buff), " (beep)");
>  	return buff;
>  }
>  
> -static const char *fmtTemps_1(const double values[], int alarm, int beep)
> +static const char *fmtTemps_1(const double values[], int alrm, int beep)
>  {
>  	sprintf(buff, "%.1f C (limit = %.1f C, hysteresis = %.1f C)",
>  		values[0], values[1], values[2]);
> -	return fmtExtra(alarm, beep);
> +	return fmtExtra(alrm, beep);
>  }
>  
> -static const char *fmtTemps_minmax_1(const double values[], int alarm,
> +static const char *fmtTemps_minmax_1(const double values[], int alrm,
>  				     int beep) {
>  	sprintf(buff, "%.1f C (min = %.1f C, max = %.1f C)", values[0],
>  		values[1], values[2]);
> -	return fmtExtra(alarm, beep);
> +	return fmtExtra(alrm, beep);
>  }
>  
> -static const char *fmtTemp_only(const double values[], int alarm, int beep)
> +static const char *fmtTemp_only(const double values[], int alrm, int beep)
>  {
>  	sprintf(buff, "%.1f C", values[0]);
> -	return fmtExtra(alarm, beep);
> +	return fmtExtra(alrm, beep);
>  }
>  
> -static const char *fmtVolt_2(const double values[], int alarm, int beep)
> +static const char *fmtVolt_2(const double values[], int alrm, int beep)
>  {
>  	sprintf(buff, "%+.2f V", values[0]);
> -	return fmtExtra(alarm, beep);
> +	return fmtExtra(alrm, beep);
>  }
>  
> -static const char *fmtVolt_3(const double values[], int alarm, int beep)
> +static const char *fmtVolt_3(const double values[], int alrm, int beep)
>  {
>  	sprintf(buff, "%+.3f V", values[0]);
> -	return fmtExtra(alarm, beep);
> +	return fmtExtra(alrm, beep);
>  }
>  
> -static const char *fmtVolts_2(const double values[], int alarm, int beep)
> +static const char *fmtVolts_2(const double values[], int alrm, int beep)
>  {
>  	sprintf(buff, "%+.2f V (min = %+.2f V, max = %+.2f V)", values[0],
>  		values[1], values[2]);
> -	return fmtExtra(alarm, beep);
> +	return fmtExtra(alrm, beep);
>  }
>  
> -static const char *fmtFans_0(const double values[], int alarm, int beep)
> +static const char *fmtFans_0(const double values[], int alrm, int beep)
>  {
>  	sprintf(buff, "%.0f RPM (min = %.0f RPM, div = %.0f)", values[0],
>  		values[1], values[2]);
> -	return fmtExtra(alarm, beep);
> +	return fmtExtra(alrm, beep);
>  }
>  
> -static const char *fmtFans_nodiv_0(const double values[], int alarm, int beep)
> +static const char *fmtFans_nodiv_0(const double values[], int alrm, int beep)
>  {
>  	sprintf(buff, "%.0f RPM (min = %.0f RPM)", values[0], values[1]);
> -	return fmtExtra(alarm, beep);
> +	return fmtExtra(alrm, beep);
>  }
>  
> -static const char *fmtFan_only(const double values[], int alarm, int beep)
> +static const char *fmtFan_only(const double values[], int alrm, int beep)
>  {
>  	sprintf(buff, "%.0f RPM", values[0]);
> -	return fmtExtra(alarm, beep);
> +	return fmtExtra(alrm, beep);
>  }
>  
> -static const char *fmtSoundAlarm(const double values[], int alarm, int beep)
> +static const char *fmtSoundAlarm(const double values[], int alrm, int beep)
>  {
>  	sprintf(buff, "Sound alarm %s",
>  		(values[0] < 0.5) ? "disabled" : "enabled");
> -	return fmtExtra(alarm, beep);
> +	return fmtExtra(alrm, beep);
>  }
>  
>  static const char *rrdF0(const double values[])
> --- lm-sensors.orig/prog/sensord/sense.c	2009-11-04 10:18:13.000000000 +0100
> +++ lm-sensors/prog/sensord/sense.c	2009-11-04 10:18:23.000000000 +0100
> @@ -86,7 +86,7 @@ static int get_flag(const sensors_chip_n
>  
>  static int get_features(const sensors_chip_name *chip,
>  			const FeatureDescriptor *feature, int action,
> -			char *label, int alarm, int beep)
> +			char *label, int alrm, int beep)
>  {
>  	int i, ret;
>  	double val[MAX_DATA];
> @@ -113,7 +113,7 @@ static int get_features(const sensors_ch
>  			strcat(strcat (rrdBuff, ":"), rrded ? rrded : "U");
>  		}
>  	} else {
> -		const char *formatted = feature->format(val, alarm, beep);
> +		const char *formatted = feature->format(val, alrm, beep);
>  
>  		if (!formatted) {
>  			sensorLog(LOG_ERR, "Error formatting sensor data");
> @@ -134,7 +134,7 @@ static int do_features(const sensors_chi
>  		       const FeatureDescriptor *feature, int action)
>  {
>  	char *label;
> -	int alarm, beep;
> +	int alrm, beep;
>  
>  	label = sensors_get_label(chip, feature->feature);
>  	if (!label) {
> @@ -143,17 +143,17 @@ static int do_features(const sensors_chi
>  		return -1;
>  	}
>  
> -	alarm = get_flag(chip, feature->alarmNumber);
> -	if (alarm = -1)
> +	alrm = get_flag(chip, feature->alarmNumber);
> +	if (alrm = -1)
>  		return -1;
> -	else if (action = DO_SCAN && !alarm)
> +	else if (action = DO_SCAN && !alrm)
>  		return 0;
>  
>  	beep = get_flag(chip, feature->beepNumber);
>  	if (beep = -1)
>  		return -1;
>  
> -	return get_features(chip, feature, action, label, alarm, beep);
> +	return get_features(chip, feature, action, label, alrm, beep);
>  }
>  
>  static int doKnownChip(const sensors_chip_name *chip,
> --- lm-sensors.orig/prog/sensord/sensord.h	2009-11-04 10:18:10.000000000 +0100
> +++ lm-sensors/prog/sensord/sensord.h	2009-11-04 10:18:27.000000000 +0100
> @@ -57,7 +57,7 @@ extern int rrdCGI(void);
>  
>  #define MAX_DATA 5
>  
> -typedef const char *(*FormatterFN) (const double values[], int alarm,
> +typedef const char *(*FormatterFN) (const double values[], int alrm,
>  				     int beep);
>  
>  typedef const char *(*RRDFN) (const double values[]);
> 
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
