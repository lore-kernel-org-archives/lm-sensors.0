From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 30 Jun 2006 11:32:10 +0000
Subject: [lm-sensors] A better fan control program
Message-Id: <20060630133210.6c56a8d5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A2556C.7070205@lshift.net>
In-Reply-To: <44A2556C.7070205@lshift.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

> How can I find out the maximum safe operating temperature of my current 
> CPU?  Since my first priority is something that works on my current 
> system, the only reason for me to pick this up again and explore in more 
> detail is if I can afford to slow the fan even when the system is flat 
> out, which means I need to know how fast I can run it.

There's this this page I use as a reference for CPU characteristics:
http://users.erols.com/chare/elec.htm

You can also find the information the datasheet of your CPU. Both Intel
and AMD provide this information, if you search long enough.

Keep in mind that the temperature reported by lm_sensors (or any other
mean) is almost always an approximation, either because of the
temperature probe (lack of) accuracy, or because the probe is not
inside the CPU but just nearby, or because the the measurement noise,
or because the driver caches the data for a certain amount of time,
etc. So you should keep a good safety margin. Colder is always better
for the lifetime of your CPU, as you found out yourself.

-- 
Jean Delvare

