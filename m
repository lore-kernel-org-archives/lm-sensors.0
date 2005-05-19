From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: what exactly does DISCONNECT mean?
Message-Id: <20041228180531.67c0d5d2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041227070416.GA7771@raw-sewage.net>
In-Reply-To: <20041227070416.GA7771@raw-sewage.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

> The output of "sensors" looks like this:
> 
> lm90-i2c-2-4c
> Adapter: SMBus nForce2 adapter at 5100
> M/B Temp:    +28 C  (low  =    +0 C, high =   +70 C)   
> CPU Temp: +127.0 C  (low  =  +0.0 C, high = +70.0 C)   DISCONNECT
> M/B Crit:    +85 C  (hyst =   +75 C)                   
> CPU Crit:    +85 C  (hyst =   +75 C)                   
> 
> I'm not sure what "DISCONNECT" means, exactly... my guess is that
> lm-sensors is not getting any kind of meaningful response from the
> hardware.

DISCONNECT means that no thermal diode is connected to the pins of the
LM90 chip. For some other drivers, the same fact is notified with the
word "OPEN" instead.

> But if a sensor is truly "not connected", do you happen to know
> where I can "connect" the sensor, i.e. remedy this problem?  Can
> this kind of thing be fixed in software, the BIOS or on the board
> itself, or is this sensor just broken?  ...or does it all depend on
> my particular hardware?
>
> If it helps, the board is a brand-new Chaintech 7NIF2 "Summit".
> Everything else appears to be working correctly.

It definitely depends on your hardware. The question is: what is this
thermal diode supposed to measure?

Possible scenarii:

1* The pins are simply not connected and were never meant to be.

2* The pins are connected to your CPU socket where they should lead to a
thermal diode inside the CPU, but either the connection is not correct
or your CPU lacks the thermal diode.

3* The pins are connected to some header on your motherboard and you
have to connect a thermal sensor yourself if you want a reading. I do
have such a thermal sensor, which I got with one of my motherboards
(although I can't remember which one, and don't know what kind of sensor
it is exactly).

The manual of your motherboard specifies that the board reports only one
CPU temperature. Not sure whether they refer to the LM90 internal sensor
(the chip would be located in the CPU socket, under the CPU) or to the
remote diode which doesn't work for you. Since the BIOS tells you 127
(as opposed to 28 which is the lm90 internal temperature) I'd guess that
the diode should be connected but for some reason isn't. The manual also
doesn't mention any header on the board for an external sensor. Thus I
think we are in case #2 above.

Unfortunately this has to be a hardware issue: damaged motherboard or
incompatible CPU. If you have the possibility, try another CPU and see
what happens. You could additionally report the problem to Chaintech
and/or the motherboard and CPU vendor(s), in case they are aware of the
problem.

-- 
Jean Delvare
http://khali.linux-fr.org/
