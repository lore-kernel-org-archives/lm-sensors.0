From: linux-kernel@hansmi.ch (Michael Hanselmann)
Date: Fri, 04 Aug 2006 19:52:39 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060804195239.GA7982@hansmi.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Aug 04, 2006 at 11:11:31AM -0300, Aristeu Sergio Rozanski Filho wrote:
> what about the attached patch?

>  	ams_i2c_write(AMS_COMMAND, cmd);
> -	for (i = 0; i < 10; i++) {
> -		mdelay(5);

This guarantees a minimum wait time of 5msec after writing the value.
Looking at the specs[1], this should be done. Your code doesn't do that:

> +	while (remaining) {
> +		remaining = schedule_timeout(remaining);
>  		result = ams_i2c_read(AMS_COMMAND);
>  		if (result = 0 || result & 0x80)
>  			return 0;

I'm not sure wether the 5msec delay is really required, but I would
insert it if it's in the specs.

So far, NACK until we got that right.

Next time, please insert the patch inline.

Thanks,
Michael

[1] http://johannes.sipsolutions.net/PowerBook/Apple_Motion_Sensor_Specification/#head-cc4be6b93ad9fcb8d373ad340b12891ed920a05f

