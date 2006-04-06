From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 06 Apr 2006 12:03:34 +0000
Subject: [lm-sensors] ali1563 problems
Message-Id: <20060406140334.8f475a32.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c657ef$bd81d2c0$937ba8c0@genesis>
In-Reply-To: <000001c657ef$bd81d2c0$937ba8c0@genesis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jo,

> Thank you very much!
> That was indeed the problem.
> I upgraded to the unstable hardened kernel (2.6.16-hardened) and the problem
> was solved.

Great :)

> regawebdev jo # sensors
> w83627hf-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.46 V  (min =  +0.00 V, max =  +0.00 V)       ALARM
> VCore 2:   +1.49 V  (min =  +0.00 V, max =  +0.00 V)       ALARM

Limits were set to 0 because your VID reads 0 (most probably the pins
aren't wired). You can fix that by changing the configuration lines
in /etc/sensors.conf (section w83627hf-*) not to reference vid anymore:

    set in0_min 1.45 * 0.95
    set in0_max 1.45 * 1.05
    set in1_min 1.5 * 0.95
    set in1_max 1.5 * 1.05

Assuming that your CPU core voltage is 1.45V. in1 is most certainly not
a CPU voltage but rather the AGP voltage (nominal value 1.5V), but
you'll need to compare with what the BIOS or documentation lists to
make sure.

> -12V:      +1.46 V  (min = -13.18 V, max = -10.80 V)       ALARM
> -5V:       +2.34 V  (min =  -5.25 V, max =  -4.75 V)       ALARM

These lines are probably not wired to -12V and -5V. You should comment
out the compute lines for them (in5 and in6) and see if you get
reasonable readings (changing a bit, but not too much). Then, once
again you have to look at what the BIOS or documentation says is
monitored. Once you know, you'll have to adjust the compute lines and
limits accordingly.

> V5SB:      +5.64 V  (min =  +4.76 V, max =  +5.24 V)       ALARM

It's a bit high... Not sure about this one.

> vid:      +0.000 V  (VRM Version 2.4)

Probably not wired, so you could add "ignore vid" to your configuration
file.

The rest looks all OK.

-- 
Jean Delvare

