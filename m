From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <3cwAVJtX.1108999958.8807990.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Christophe,

> If i run "sensord -i 1m -l 30m", i read this in /var/log/syslog :
> Error getting sensor data: adt7463/fan1_tach_mode: Can't access
> procfs/sysfs file

I would suggest that you do NOT run sensord. Most people don't need it
and since it is not being actively maintained, using it is usually
asking for more trouble than is worth.

sensord is a deamon which will poll the sensors repeatedly, and log
problems when they occur. While this is fine for servers, it is usually
easier for regular users on desktop/laptop systems to just run
"sensors" from times to times, or use graphical frontends (xsensors,
gkrellm, ksensors...).

At any rate, sensord is *not* required for fan control operations
(neither automatic nor manual). It is, in fact, totally unrelated
(sensord is about monitoring/reporting, not control).

--
Jean Delvare
