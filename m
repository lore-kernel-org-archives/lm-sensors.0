From: dave.antliff@paradise.net.nz (David Antliff)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Temp Sensor on Asus A7V8X - Ticket 1358
Message-Id: <Pine.LNX.4.55.0310291645560.11719@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I too have an A7V8X (and no it's not a deluxe or -X variant) and my BIOS
reports a CPU temp of 22C and a M/B temp of 24C. I have watercooling so
these temperatures, although very low, are possible. I am unable to check
them precisely as I write this since I am accessing the machine remotely,
but I have observed them for the past year so I am confident that the BIOS
reports the CPU temp as approx 22C.

Anyway, none of those formulae on the readticket site
(http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket58) get anywhere
close:

compute temp2 @*2.0, @/2.0  :
  M/B Temp:    +23?C
  CPU Temp:  +52.0?C

compute temp2 (@*30/43)+25, (@-25)*43/30  :
  M/B Temp:    +23?C
  CPU Temp:  +43.1?C

compute temp2 (@*22/43)+25, (@-25)*43/22  :
  M/B Temp:    +23?C
  CPU Temp:  +38.3?C

I'm using:
as99127f-i2c-0-2d
dapter: SMBus Via Pro adapter at e800
Algorithm: Non-I2C SMBus adapter
lm_sensors-2.8.1
i2c-2.8.1

Another thing, in the BIOS, the M/B temp is consistently approx. 2C higher
than the CPU - are these around the wrong way in the BIOS?


Thanks,
David.

