From: gawrysz@camk.edu.pl (Artur Gawryszczak)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: [as99127f] - a note about measuring CPU temperature on Asus CUV4X - continued ...
Message-Id: <200302240127.54189@phoenix.camk.edu.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302112308.19507@phoenix.camk.edu.pl>
In-Reply-To: <200302112308.19507@phoenix.camk.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Some days ago, I've stated, that the formula "temp2 (@*30/43)+25, 
(@-25)*43/30" works better than "temp2 @*2, @/2". Today I continued 
experiments with my machine, and I found that still there are 
systematical discrepancies between CPU temperature measured from the 
Celeron diode, and temperature of thermistor probe put near the CPU 
core, under the heatsink - especially for idle state (temperatures 
around 30?C). To maximize temperature changes between idle and 
full-load states I overclocked my iCII 600 to 900 MHz, and raised 
V_core to 2.0 Volts (well, I know ... but these CPU's are quite cheap 
nowadays :-) ). The chassis was closed and the temperature inside was 
about 29?C. Full load was done by using burnP6 from CPUburn suite, 
half-load was done with same tool, but with the help of the following 
script:

delP000
while [ true ] ; do 
	kill -SIGSTOP `pidof burnP6` ; usleep $del
	kill -SIGCONT `pidof burnP6` ; usleep $del
done 2> /dev/null

I found, that the best formula for temp3, which makes agreement between 
it and temp3 is "temp2 @+19, @-19". Here you can see the results:
http://www.camk.edu.pl/~gawrysz/cuv4x.png

Disclaimer ;-), and some comments
I tried to put the thermistor as close to the CPU die as possible, but 
I'm not sure how close it is. It can introduce errors proportional to 
(T_CPU-T_ambient), so It's still possible that proper temp2 scaling 
needs a multiplier slightly greater than 1, but I'm sure, that offset 
as large as 25?C isn't good, but the "round" value of 20?C is very 
probable. 
The readouts from the CPU diode are very noisy. I observed them in BIOS 
- they were noisy too (up to 7?C). This is strange; I haven't seen such 
behavior on my mother's machine build of Soyo SY 6BA+III (BX, w83782d) 
and iCII 566@810MHz. But the voltage readouts are very noisy too, and 
I've checked this power supply powering another computer, and got much 
cleaner picture, so I suppose that the noise comes from as99127f and 
its interface.
Validity of the formula "temp2 @+19, @-19" can be supported by some 
(rather "hardcore") tests witch CPU fan slowed down or even unplugged, 
but this needs to find FSB and V_core at which this CPU can run stable 
at equilibrium temperature about 70?C or a little bit more but 
currently I don't have time for such educational games ;-) I'd better 
check validity of temperature measurements for some another machines 
I'm administrating (A900 on Asus A7V, A1333 on A7V133, and Athlons MP 
on Tyan Tiger MP and MPX (fortunately Tyan uses Winbond's sensor 
chips)), and ensure that daemons can shutdown them quick enough in case 
of CPU fan failure ...

-- 
Regards,
Artur Gawryszczak
