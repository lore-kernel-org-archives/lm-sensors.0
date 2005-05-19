From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: scaling of loadavg in sensord
Message-Id: <20041026221419.6dee5aa5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <417CB2E3.3090007@aurel32.net>
In-Reply-To: <417CB2E3.3090007@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Currently sensord is logging load1 when used with the --load-average 
> option. It does not make much sense to do that for a 5 minutes RRD 
> update interval (the default one).

I think it does. The fact that the update interval is 5 minutes is
hardly relevant. The point is that sensord reports instant measurements
for everything (voltages, temperatures, etc...) and the 1 minute average
load is the nearest value from instant load.

> The best solution is to let the user to choose which load he wanted
> to log according to the update interval and other things.
> 
> That's the purpose of the attached patch. Using it, it possible to 
> select the load average to log. For example --load-average 1,5,15
> logs load1, load5 and load15.

I don't think this belongs to sensord. Sensord is not a system
monitoring daemon but a hardware monitoring daemon. The only reason why
load "average" is included is that several monitored values (CPU temp
first) may depend on the instant system load. Logging load5 or load15
doesn't make much sense IMHO.

The only think I would agree isn't really right is the name of the
option. --load-average should be --load instead (or maybe
--instant-load, although it could be even more misleading since that's
not exactly what load1 is). I don't think it's worth breaking the
interface though.

-- 
Jean Delvare
http://khali.linux-fr.org/
