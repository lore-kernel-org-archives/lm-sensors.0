From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 21 Aug 2006 11:19:26 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-timeout-fixes.patch
Message-Id: <20060821131926.620dae29.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44DB23B1.1060102@hhs.nl>
In-Reply-To: <44DB23B1.1060102@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

Sorry for the late answer.

> This patch contains 2 sets of fixes for the abituguru:
>  1) Much improved timeout handling, drasticly reducing the amount of
>     timeout errors on some motherboards
>  2) Fix the exit paths in the bank1 sensor type detect code to always
>     restore the original settings even on an error. Without this our
>     special test settings could remain seriously confusing the system
>     BIOS's setup menu.

In theory this should be two separate patches...

> Both are very much related and are must haves, to avoid messing up the
> uguru CMOS settings.
> 
> Since this patch fixes the CMOS settings corruption* reported to the
> list earlier by Sunil Kumar, it should be send upstream ASAP (to GKH who
> is replacing Linus while Linus is away for a couple of weeks).

The problem is that your patch doesn't apply to my tree. What is it
supposed to apply to?

khali at arrakis:~/src/linux-2.6.18-rc4> quilt push
Applying patch hwmon-abituguru-timeout-fixes.patch
patching file drivers/hwmon/abituguru.c
Hunk #10 FAILED at 418.
Hunk #16 FAILED at 1257.
Hunk #17 succeeded at 1330 (offset 2 lines).
2 out of 17 hunks FAILED -- rejects in file drivers/hwmon/abituguru.c
Patch hwmon-abituguru-timeout-fixes.patch does not apply (enforce with -f)
khali at arrakis:~/src/linux-2.6.18-rc4>

Minor comments on the patch itself:

> @@ -226,6 +227,10 @@
>  		timeout--;
>  		if (timeout = 0)
>  			return -EBUSY;
> +		/* sleep a bit before our last few tries, see the comment on
> +		   this where ABIT_UGURU_WAIT_TIMEOUT_SLEEP is defined. */
> +		if (timeout <= ABIT_UGURU_WAIT_TIMEOUT_SLEEP)
> +			msleep(0);
>  	}
>  	return 0;
>  }

I couldn't find any other use of msleep(0) in the whole kernel tree.
While I see your point and agree it should work, someone may complain
that it depends too much on the value of HZ.

> @@ -331,7 +338,8 @@
>  	/* And read the data */
>  	for (i = 0; i < count; i++) {
>  		if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
> -			ABIT_UGURU_DEBUG(1, "timeout exceeded waiting for "
> +			ABIT_UGURU_DEBUG(retries? 1:3,

Broken coding style.

> +				"timeout exceeded waiting for "
>  				"read state (bank: %d, sensor: %d)\n",
>  				(int)bank_addr, (int)sensor_addr);
>  			break;

> @@ -403,7 +418,7 @@
>  				   u8 sensor_addr)
>  {
>  	u8 val, buf[3];
> -	int ret = ABIT_UGURU_NC;
> +	int i, ret = -ENODEV; /* error is the most commen used retval :| */

Typo: common. Nothing to be worried about, BTW, it's common, although
suboptimal, to initialize the returned variable to an error value in
probe functions.

>  		if (buf[0] & ABIT_UGURU_TEMP_HIGH_ALARM_FLAG) {
> -			ret = ABIT_UGURU_TEMP_SENSOR;
>  			ABIT_UGURU_DEBUG(2, "  found temp sensor\n");
> +			ret = ABIT_UGURU_TEMP_SENSOR;

I see no benefit in swapping these lines.

> @@ -1303,7 +1328,7 @@
>  		data->update_timeouts = 0;
>  LEAVE_UPDATE:
>  		/* handle timeout condition */
> -		if (err = -EBUSY) {
> +		if (!success && (err = -EBUSY || err >= 0)) {
>  			/* No overflow please */
>  			if (data->update_timeouts < 255u)
>  				data->update_timeouts++;
> 

Can you explain the "err >= 0" part? I don't get it.

Also, unrelated to this patch, I wonder why you need a separate
"success" flag, can't you use !err or err < 0 instead?

Please provide a new patch, that will apply properly to 2.6.18-rc4,
rc4-git1 or rc4-mm2.

Thanks,
-- 
Jean Delvare

