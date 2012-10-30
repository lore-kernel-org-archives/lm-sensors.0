From: "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
Date: Tue, 30 Oct 2012 23:01:08 +0000
Subject: [lm-sensors] coretemp.ko -- Sandy Bridge: temperature readings "biased" based on power consumption?
Message-Id: <50905C34.31182.67732CA0@Frantisek.Rysanek.post.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear gentlemen,

I've just tried looking at the CPU temperature via coretemp.ko on 
some SandyBridge CPU's. I have a desktop-grade Core I3 at 3.3 GHz, 
and a mobile Core i5 at 2.5 GHz. When I flip the CPU from "pretty 
much idle" to "each core running a cpuburn instance", the temperature 
reported by coretemp *jumps* up in a second. On the desktop CPU, the 
jump is about 10*C. On the mobile CPU, the jump is about 25-30 *C !
It jumps up in a second after I launch the software load - and then 
it proceeds to gradually inch up, as the massive heatsink starts to 
warm up a bit (perhaps another degree C in twenty seconds to a 
minute).

Should I look for some thermal mischief in my system?
Or, do the SandyBridge CPU's indeed "precompensate" the temperature 
reading based on instantaneous power consumption?
I.e., is the "digital thermal sensor" more like a "fan control hint 
with a strong feed-forward component", rather than a half-decent 
thermometer?

I've noticed already on some recent 45nm Core2 CPU's (on a gigabyte 
motherboard) that the fan control feedback loop responds magically 
swiftly to me launching some software load.
I know that modern SuperIO chips (containing PWM fan control logic) 
can take the CPU temp value straight from the CPU (perhaps mediated 
by the south bridge), using a digital link called PECI. I also know a 
bit about the autonomous fan control algorithms implemented in chips 
by ITE and Winbond(Nuvoton) - I've played with these before.
If indeed the CPU's DTHERM sensor would "bump up the reading" in 
response to power consumption, that would explain the swift 
modulation of fan speed based on instantaneous CPU load...

Any comments are welcome :-)
And, thanks for the providing the blessed coretemp.ko in the Linux 
kernel.

Frank Rysanek


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
