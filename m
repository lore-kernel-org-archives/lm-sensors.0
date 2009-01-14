From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Jan 2009 10:32:23 +0000
Subject: Re: [lm-sensors] sensord with rrd
Message-Id: <20090114113223.268e0f64@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <gkimcg$46k$1@ger.gmane.org>
In-Reply-To: <gkimcg$46k$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Tue, 13 Jan 2009 10:26:23 -0800, Mark Nienberg wrote:
> I have lm_sensors running and "service lm_sensors status" gives
> correct results.
> 
> Now if I start sensord with
> 
> INTERVAL=0
> LOG_INTERVAL0m
> 
> then it works just fine and logs to syslog just like I want it to.
> 
> If I start it with
> 
> INTERVAL=0
> LOG_INTERVAL0m
> RRD_LOGFILE=/var/log/sensors.rrd
> 
> then i get
> 
> sensord: creating round robin database
> sensord: Error creating RRD: /var/log/sensors.rrd: No sensors detected
> 
> Is there something else I have to do to get the rrd part to work?

No, it should work. That being said, where do you put these values? We
do not have such an setup script for sensord. So please tell us:
* What version of lm-sensors you're using.
* Which distribution you are using.

And attach (or point us to) a copy of the initialization script which
is reading the variables you listed above.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
