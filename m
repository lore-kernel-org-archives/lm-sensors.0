From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Thanks and setup problem
Message-Id: <20041219185603.3ef62cf1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41AE99A2.8050402@swbell.net>
In-Reply-To: <41AE99A2.8050402@swbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chris,

> As you can see the first CPU jumps 14 Degrees in one second.  And the 
> other drops 7 degrees in the same second.  This makes no sense.  The 
> jumps are too far on a second by second basis and they go up and down.

This isn't surprising. Thermal diode react very fast to temperature
changes, and CPU core temperature changes very, very fast. Most probably
one "sensors" command  ran on one CPU, the second happened to be on the
other one. This explains the asymmetry, and shows that the adm1021 chips
do in fact provide very accurate, real-time temperature readings (these
chips are built into your Xeon CPUs).

> Now over a long period of time (minutes) you can see that as the 
> temperatures go up and down they do seem to rise on the average.  So 
> they are not completely bogus.  The temperatures rising, bring me to
> the  second issue.  Within 5 minutes (and this is reproducible) my 
> motherboard alarm sounds.  I think it happens when the CPU temp shows
> a  reading of 61C (remember this reading is probably invalid) which is
> across the max of 60 that is displayed.   This is interesting since
> the  log does not show any indication an alarm has sounded.  And I

Well this is all OK, the alarm is expected to fire up in these
conditions (providing the chips are wired to do this). I agree that the
output of sensors should reflect that. That said, maybe Intel's ADM1021
clones do simply not have that feature (alarm bits).

> have  change the ADM chips configuration to shut off the beep. But I
> don't  even think it is an option for this module.  I can stress the 
> CPU for a  long time without this module loaded and never trigger the
> MB alarm.   But less than 5 minutes with this in and it triggers all
> the time.

The version of lm_sensors you use (2.8.1) is a bit old. Back then, our
drivers would reset/reprogram chips arbitrarily. This might be the
difference. Try with a newer version and loading the module should not
make any difference anymore.

At any rate, your setup is almost perfect, there's not much more you can
hope. Temperatures, voltages and fan speeds are all OK as far as I can
see.

-- 
Jean Delvare
http://khali.linux-fr.org/
