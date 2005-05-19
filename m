From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Temps on S755MAX IT8705F
Message-Id: <200407150822.i6F8MRQS034614@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40F5A42D.9070301@verizon.net>
In-Reply-To: <40F5A42D.9070301@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Wes,

>I've got a Jetway S755MAX (SIS755 chipset) with an AMD 64 3000+. The
>board uses an IT8705F and I've got the it87 driver loaded. LM_Sensors
>version 2.8.4 (MDK10.0). Everything works fine except I can't get the
>CPU temp working. Of the 3 temp sensors on the chip the only thing I've
>figured out is that temp2 is the MB temp. I've located the thermistor
>for this and everything is fine with it. I have no clue what temp1 is
>for. It stays at 70C most of the time. the only way I can get it to
>change is to run a a few  sessions of glxgears. It will then go up to
>72C max. Now temp3 is wild. It flucuates from 13C to about 54C and
>anyplace in between. I've gone as far to to disconnect my cpu fan to try
>and see a rise on these sensors, but I see none. Temp1 stayed at 70C,
>and temp3 acted the same and actually went from 54C to 13C once during
>this test. For the record, the bios cpu temps are stable around 41C, and
>using Smartguardian in win works fine. I've contacted Jetway, but I
>don't think they understand english very well, as I can't get a an
>answer as to which sensor is for the CPU. Anyway, with the sensors set
>to anything but thermistor, I get an invalid with sensirs output. Here's
>what I'm getting now using no temp computes.

We're quite used to motherboard manufacturers "support" not to know
anything about hardware monitoring chips they use (except at Tyan, it
seems).

Various hints, questions and pointers in no particular order:

* What do you mean with "with the sensors set to anything but
thermistor, I get an invalid with sensors output"? Which values did you
try? The it87 driver (and chip) only supports types 2 (thermistor) and 3
(diode). What are you getting exactly with diodes?

* CPU temp could come from a secondary chip. Doesn't sensors-detect find
any or at least find something it fails to identify?

* A conversion formula may be needed. You should find some in the default
sensors.conf file. Your board may need a different one. BIOS disassembly
may reveal it.

* You may want to upgrade to 2.8.7. The it87 driver has had several fixes
since 2.8.4. The "sensors" program has a fix as well, precisely about
temperature sensor types in it87 (since 2.8.5). Testing a recent
verstion of sensors would be easy (you don't even need to install it),
you should look into that.

That's about it for now.

Jean Delvare
