From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: Third auto-fan control interface proposal
Message-Id: <40E98631.7040406@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
In-Reply-To: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We also need a way to turn the whole thing on.
I propose we use a new value of 2 in fan[1-3]_pwm_enable to turn on auto-fan.

I like the second model. It's for adm1031, etc.

I don't understand the first model. what drivers is it for? 

Jean Delvare wrote:
> Hi all,
> 
> Here is my third proposal for an common auto-fan control interface.
> 
> See these previous threads for the first and second proposals and
> associated comments:
> http://archives.andrew.net.au/lm-sensors/msg07517.html
> http://archives.andrew.net.au/lm-sensors/msg08091.html
> 
> The interface is still made up of two parts: per fan temp channels
> selection, and trip points selection.
> 
> Temp channels selection
> ===========> 
> It looks like the possibility to select more than one temp channel for a
> given fan controler is needed (Philip Pokorny), so we wouldn't simplify
> this. As in the first proposal, the values would be bitfields, 1<<N =
> temp channel N matters to compute the considered fan's speed.
> 
> Files :
> 
> fan1_auto_channels
> fan2_auto_channels
> q
> Trip points
> =====> 
> Two distinct models exist: trip points set for a given fan, or trip
> points set for a given temperature channels. Looks like there is no easy
> conversion from one model to the other so this gives two possible sets
> of files (each driver picks the one matching the hardware
> implementation):
> 
> fan1_auto_temp_off
> fan1_auto_temp_min
> fan1_auto_temp_max
> fan1_auto_pwm_min
> fan1_auto_pwm_max
> fan2_auto_temp_off
> fan2_auto_temp_min
> fan2_auto_temp_max
> fan2_auto_pwm_min
> fan2_auto_pwm_max
> 
> OR
> 
> temp1_auto_temp_off
> temp1_auto_temp_min
> temp1_auto_temp_max
> temp1_auto_pwm_min
> temp1_auto_pwm_max
> temp2_auto_temp_off
> temp2_auto_temp_min
> temp2_auto_temp_max
> temp2_auto_pwm_min
> temp2_auto_pwm_max
> temp3_auto_temp_off
> temp3_auto_temp_min
> temp3_auto_temp_max
> temp3_auto_pwm_min
> temp3_auto_pwm_max
> 
> 3 trip points in any case, but only 5 values (pwm_off is implied as 0%).
> Rules are:
> if temp < off, fan is off
> if off < temp < min, fan speed is either 0 or pwm_min (allows for
> hysteresis)
> if min < temp < max, fan speed is between pwm_min and pwm_max. Exact
> value is left to the driver/hardware, but should be next to a weighted
> average if possible.
> if temp > max, fan goes to full speed (typically pwm = 100%).
> 
> Additional notes
> ========
> 
> 1* For some reason, the adm1031 driver had auto_ as a prefix instead of
> inside the names. I prefer my way because it clearly shows which element
> the values are attached to. OTOH I agree that "filtering" files with
> "ls" is somewhat easier with auto as the prefix (especially if you do
> *not* want to see the auto-fan files). No strong opinion actually.
> 
> 2* As Mark Hoffman and Mark Studebaker noticed, this interface will
> necessarily leave extra features or modes behind. Thus, this interface
> should be considered non-limitative and subject to further extensions as
> additional common patterns show among various chips. In particular,
> driver authors should be free to:
> - not implement this interface if the chip design is too different
> - implement a different interface if they think it's needed
> (additionally or exclusively)
> 
> The other interface (or additions to the standard interface) should be
> prefixed in such a way that it won't collide with a further extension
> of the standard interface (until the feature is actually discussed and
> standardized).
> 
> All in all, this interface is meant for chips those implementations
> roughly fit into it, and that's about it.
> 
> Comments, anyone?
> 
> Thanks,
> Jean Delvare
> 
> 
