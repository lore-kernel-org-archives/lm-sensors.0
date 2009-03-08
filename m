From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Mar 2009 09:21:16 +0000
Subject: Re: [lm-sensors] no lines in rrd graphs from sensord
Message-Id: <20090308102116.34036e8a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090305164626.58YK4.419625.imail@fed1rmwml30>
In-Reply-To: <20090305164626.58YK4.419625.imail@fed1rmwml30>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steve,

On Thu, 5 Mar 2009 13:57:34 -0800, linuxjagnut@cox.net wrote:
> Also even though I am running sensord with the option
> 
> --log-interval 0
> 
> I am still getting sensor info being logged to syslog
> which is not what I intended to do.

There are two kinds of information being logged by sensord: full sensor
data (similar to the output of "sensors") and alarms. The former can be
disabled with --log-interval 0. In order to disable the latter you must
additionally specify --interval 0.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
