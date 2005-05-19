From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: problem with it87.o
Message-Id: <20030920105637.23057c10.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
In-Reply-To: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I still haven't been able to resolve my problem with the fan spinup,
> you asked for the value in 'alarms':
> 
> cat /proc/sys/dev/sensors/it87-i2c-1-2d/alarms returns:
> 26130
> 
> Do you think this problem can be resolved by means of a specific
> config, or is it really a driver problem?

First, I'd like to appologize for the slow answer. I've been very busy
these days (moved in to a new place for a new job). If you're still
interested in solving your fan problem, here we go.

It looks like one of the steps taken by the it87 module while
initializing your chipset doesnt please it. We simply have to find out
which one. For that, we'd need to see the configuration register(s)
state(s) before the module is loaded (which means the module should not
be loaded automatically at boot time).

Run the following command (as root) before loading the module:
i2cdump 1 0x2d b > ~/it87-before-init.out

Then, load the module, then unload it, and run the command again:
i2cdump 1 0x2d b > ~/it87-after-init.out

And send us the two files so that we can analyze them.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
