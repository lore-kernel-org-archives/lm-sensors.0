From: jk <lm_sensors@kosowsky.org>
Date: Fri, 06 Apr 2007 18:10:02 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <m2abxlbchx.fsf@consult.pretender>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Perhaps there is another way of looking at.
How does the program 'sensors' know what <busnumber>-<busaddress>
combination to use?

Maybe this could be used to rewrite the script sens_update_rrd to
automatically find and read the right sensor data?

Alternatively, maybe sens_update_rrd should be rewritten to call
'sensors' and parse the resulting output rather than querying directly
the /sys/bus/i2c/devices/<busnumber>-<busaddress> sensor values?

Or maybe I should just be using sensord instead which would avoid
having to specify the sensor or to edit the /etc/crontab file?
(however, I like the other cgi scripts better)

I guess in summary it seems to me that the primary problem is that the
crontab script sens_update_rrd is written in a non-robust fashion...



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
