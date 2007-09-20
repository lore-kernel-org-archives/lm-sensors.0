From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 Sep 2007 11:20:11 +0000
Subject: Re: [lm-sensors] "sensord --rrd-file" cant't find a sensor
Message-Id: <20070920132011.3bc80c0b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46DE9261.8030900@sthias.de>
In-Reply-To: <46DE9261.8030900@sthias.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sebastian,

On Thu, 20 Sep 2007 10:28:11 +0200, Sebastian Thias, ATEBIS GmbH wrote:
> I applied the patch and recompiled lm_sensors.
> 
> Trying sensord with your patch yielded:
> 
> 	sensord: Error getting sensor validity: w83793/#10
> 
> Sensord even gives this error-message if I add ignore statements for all
> sensor-features in sensors.conf.
> 
> It works, though, if I comment out the element
> 	SENSORS_W83793_IN(10)
> in chips.c

Oops, yes, you're correct. The W83793 has no in10. I've fixed my patch
and applied it to SVN now.

> Thanks a lot!

You're welcome. Thanks for your testing and report.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
