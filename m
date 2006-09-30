From: r.marek@assembler.cz (Rudolf Marek)
Date: Sat, 30 Sep 2006 18:05:29 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel
Message-Id: <451EB1E9.2080809@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Matthias,

> I'm running a C2D (E6600) system here and would be happy to be of
> assistance.

Good thanks. What motherboard is it. Is it the desktop/laptop?

> I've downloaded and compiled your latest version (I think heh) but the
> resulting temperature is a bit off I think.
> 
> The CPU temp as reported by the SuperIO chip is 23.5 degrees,
> you driver reports about 37000 (37 degrees? and which core? or is that
> supposed to be the m/b diode?)

This is even better than the diode, it is the value from special build-in
digital temperature sensor. The value from superio could be

1) from thermistor bellow the CPU socket
2) thermal diode value

Can you paste the output of "sensors" command please?

> a little c program to read the coretemp from the CPU I have found
> elsewhere on the net reports ~51 degrees for both cores on the same idle
> system (the little program is attached, it's header says it's GPL).

Well it there is a bit problem. To calculate the temperature, you need to know
so called "TjMax" which that program sets fixed to 100C, however my
implementation detect this TjMax and set it to 100C or 85C.

85C should have systems for other than LGA socket.

Toutput = TjMax - registerValue

So If the TjMax is wrong, output temperature is also wrong (offset 15C)

> If you need any testing done let me know. A hwmon sysfs interface to
> both(!) coretemps would be most welcome =)

I think it very good to have such driver so I "donated" my time for this driver
development ;)

Well it should be for both cores. Have you used this version?
http://assembler.cz/download/coretemp/

There is a patch for lm-sensors so you just need to run "sensors" and it should
show the temps for both cores. Please can you cut&paste the output of sensors
command to the mail?

>     return 100 - data[2];
It uses fixed 100 value.

Please can you provide output of following files:
cat /sys/class/hwmon/hwmon0/device/temp1_input
cat /sys/class/hwmon/hwmon0/device/temp1_crit

cat /sys/class/hwmon/hwmon1/device/temp1_input
cat /sys/class/hwmon/hwmon1/device/temp1_crit

cat /sys/class/hwmon/hwmon2/device/temp1_input
cat /sys/class/hwmon/hwmon2/device/temp1_crit

I think we will see the crit temperature as 85000 (so it is 85C).

Question is what is correct. Please can you try to reboot and check the BIOS?
Also how much the temperature grows when you run in linux when running following
command:
dd if=/dev/zero of=/dev/null bs=1M count@00

I'm also on IRC irc.freenode.net #linux-sensors

Thank you for help,
Regards
Rudolf

