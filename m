From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Tyan S2895 Dumps and Info
Message-Id: <5kMWJJYV.1113388505.2428080.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200504130106.j3D16N519857@integratedsolutions.org>
In-Reply-To: <200504130106.j3D16N519857@integratedsolutions.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Seth,

> Second, I wanted to try and help so.... I installed i2c and lmsensors
> (2.9.1 rev for both) on a brand new Tyan S2895A2NRF with Dual Opteron
> 248's, 4 x 512M DDR-400 RECC OCZ DIMMs (they show up in 4 of the dumps -
> I'm guessing these dumps show the SPD info) 40GB IDE disk and an IDE
> CDROM
>
> The OS installed is CentOS 3.4 x86_64 SMP version RHEL 3 Update 4 clone.
>
> Everything compiles but sensors-detect does not detect any temperature
> sensors.

That's right. However, it found an SMSC Super-I/O chip (LPC47B397-NC),
which is known to have a temperature and fan monitoring unit. We have a
preliminary linux 2.6 driver for it. The bad news is that there is no
datasheet for it. It's not even listed om SMSC's site. The rumor says
that it was a custom command from HP/Compaq.

Could you please try to locate the chip on the board, and confirm the
part number?

> The manual states that the temperature monitoring chip is a LM95221
> connected to the LPC Super I/O Chip. I could not find this on the MB.

There is no trace of it in your logs. However, what we support on your
board are the SMBus of the nForce chips. The Tyan docs would suggest
that the
LM95221 is connected to the Super-I/O directly, supposedly through a
different SMBus (or possibly Access.bus, but that's the same).

The LM95221 is a really small thing. 8 pins only. You could have missed
it easily.

> If there is anything else I can run to give you more information let me
> know.

Output of lspci, please. Just in case.

Note that, even with the SMSC Super-I/O chip and the LM95221, you'd only
have temperatures and fans monitored. The Tyan docs mention voltage
monitoring, so there has to be yet another chip somewhere. This could
explain why the hardware monitoring unit of your SMSC Super-I/O chip is
disabled.

--
Jean Delvare
