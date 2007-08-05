From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sun, 05 Aug 2007 11:28:30 +0000
Subject: Re: [lm-sensors] 2.6.23-rc1 regression: hwmon/w83627ehf: wrong fan
Message-Id: <46B5B45E.3030208@s5r6.in-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B5B290.4040907@s5r6.in-berlin.de>
In-Reply-To: <46B5B290.4040907@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Jean Delvare <khali@linux-fr.org>

I wrote:
> Now that I booted from 2.6.22-rc5 to 2.6.23-rc2 I noticed that ksensors
> displayed 1/16 of the actual speed of the CPU fan (correct is ca. 1400
> RPM under light load) and 0 for the case fan (correct is ca. 480 RPM
> under light load).
> 
> I reverted patch
> 	hwmon/w83627ehf: No need to initialize fan_min
> and the behaviour changed as follows:  ksensors displays the correct CPU
> fan speed when loaded for the first time after the w83627ehf was loaded,
> then drops to 1/16th the next time it refreshes the display.  (I
> configured 30s update interval in ksensors.)  But the case fan's speed
> is now correctly displayed all the time.  Ksensors' fan speed
> multipliers are configured as 1.
...
> Booting back into 2.6.22-rc5 (which seems identical with 2.6.22 as far
> as w83627ehf is concerned) brings back the correct fan speeds.

PS:  The actual behavior under 2.6.22-rc5 is that the CPU fan speed is
displayed correctly from the start, while the case fan speed is
initially shown as 0 but jumps to the correct speed after ksensors'
first display update.
-- 
Stefan Richter
-===-=-== =--- --=-http://arcgraph.de/sr/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
