From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Jun 2006 14:51:55 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <20060618165155.8da3862d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brian,

> > > The bios for temps: MB = 31 and CPU = 52.  Both are pretty consistent in the
> > > bios.
> > > 
> > > The CPU temperature in lm_sensors fluctuates between -5 and 50.  I have
> > > tried using the diode for both temp1 and temp2 and ignoring different
> > > combinations with no success.  If the temperature was consistent I would
> > > feel better like a correction factor was needed but it is all over the
> > > place.
> 
> I have the same problem with my ECS RX-480A motherboard that uses the
> IT8712 super I/O chip. The temperature sensor 2 fluctuates. I'm guessing
> that sensors_detect will only detect 1 super I/O chip, and only one
> sensor chip in the computer.

Wrong guess. Sensors-detect with detect all hardware monitoring chips
in the system, as long as it knows about them, and in the case of
I2C/SMBus chips, that it has drivers for the busses.

That being said, I still have to see a systems with two Super-I/O chips.

>                               I too would like to know how to get my
> email subject is "IT8712F-A and ECS-RX480A mainboard has erradic CPU
> temp." How do we get these ECS boards to behave with the CPU temp?

Well, maybe you would have received more help if you had been following
my instructions when I tried to help you.

>                                                                     temp3
> didn't seem correctly because it's temperature didn't change to the work
> load on the CPU. That will probably be the same for yours.

Maybe, maybe not. Motherboards, even by the same manufacturer, can be
very different in that matter.

-- 
Jean Delvare

