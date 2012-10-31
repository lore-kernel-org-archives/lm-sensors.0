From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 31 Oct 2012 00:32:39 +0000
Subject: Re: [lm-sensors] coretemp.ko -- Sandy Bridge: temperature readings "biased" based on power consumpti
Message-Id: <20121031003239.GA25645@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50905C34.31182.67732CA0@Frantisek.Rysanek.post.cz>
In-Reply-To: <50905C34.31182.67732CA0@Frantisek.Rysanek.post.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frantisek,

On Wed, Oct 31, 2012 at 12:01:08AM +0100, Frantisek Rysanek wrote:
> Dear gentlemen,
> 
> I've just tried looking at the CPU temperature via coretemp.ko on 
> some SandyBridge CPU's. I have a desktop-grade Core I3 at 3.3 GHz, 
> and a mobile Core i5 at 2.5 GHz. When I flip the CPU from "pretty 
> much idle" to "each core running a cpuburn instance", the temperature 
> reported by coretemp *jumps* up in a second. On the desktop CPU, the 
> jump is about 10*C. On the mobile CPU, the jump is about 25-30 *C !
> It jumps up in a second after I launch the software load - and then 
> it proceeds to gradually inch up, as the massive heatsink starts to 
> warm up a bit (perhaps another degree C in twenty seconds to a 
> minute).
> 
I think that is pretty normal. Keep in mind this is the temperature within
the chip core, not at the external package.

I have systems with i7-2600 and i7-3770K. Both run at 30C or less when idle.
The core temperature jumps by at least 10C as soon as I add load. If the
load is at 100% for a minute or so on all cores, the temperature increases
to around 80C, and the CPU fan speed increases to keep it there.
Nothing to be concerned about unless your fan control is not working.

> Should I look for some thermal mischief in my system?
> Or, do the SandyBridge CPU's indeed "precompensate" the temperature 
> reading based on instantaneous power consumption?

Not really. It is just that with higher power consumption, the CPU temperature
can jump significantly within a few seconds. After all, the power translates 
into produced heat, which has to go somewhere. Since the sensors are directly
at the core, you see the impact immediately.

I think that may be a bit different to older CPUs, which probably tend to run a
bit hotter even when idle, resulting in less temperature increase under load.
Or, in other words, Intel probably did a good job conserving power when it
is not needed with recent CPUs.

> I.e., is the "digital thermal sensor" more like a "fan control hint 
> with a strong feed-forward component", rather than a half-decent 
> thermometer?
> 
> I've noticed already on some recent 45nm Core2 CPU's (on a gigabyte 
> motherboard) that the fan control feedback loop responds magically 
> swiftly to me launching some software load.
> I know that modern SuperIO chips (containing PWM fan control logic) 
> can take the CPU temp value straight from the CPU (perhaps mediated 
> by the south bridge), using a digital link called PECI. I also know a 
> bit about the autonomous fan control algorithms implemented in chips 
> by ITE and Winbond(Nuvoton) - I've played with these before.
> If indeed the CPU's DTHERM sensor would "bump up the reading" in 
> response to power consumption, that would explain the swift 
> modulation of fan speed based on instantaneous CPU load...
> 
power -> heat -> increased temperature ... no need to be too fancy.

Hope this helps,

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
