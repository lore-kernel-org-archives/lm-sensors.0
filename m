From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: module (modprobe w83781d) works static compile do not work!
Message-Id: <3C38BFD8.F1D73A96@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C3291D1.BBCAFA8F@unicef.org.yu>
In-Reply-To: <3C3291D1.BBCAFA8F@unicef.org.yu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I still can't reproduce this problem on my system.
Others haven't seen the registration messages in dmesg.
You have those messages so it should work!
What is the problem?
'sensors' doesn't have w83782d information?
There is no entry in /proc/sys/dev/sensors?

Zoran Davidovac wrote:
> 
> kernel 2.2.20 patched with i2c-2.6.2 & lm_sensors-2.6.2
> (also tested with lm_sensors-2.6.1 it is the same)
> 
> from dmesg
> 
> w83781d.o version 2.6.2 (20011118)
> i2c-core.o: driver W83781D sensor driver registered.
> i2c-core.o: client [W83782D chip] registered to adapter [ISA main
> adapter](pos. 0).
> 
> short report not spam :)
> 
> Happy New Year,
> 
>  Zoran
