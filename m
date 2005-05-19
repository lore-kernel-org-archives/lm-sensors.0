From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: as99127f pwm registers
Message-Id: <20030723095356.428fa640.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722093411.25d749c5.khali@linux-fr.org>
In-Reply-To: <20030722093411.25d749c5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > The register we are fighting with this time is 0x5B. In our current
> > driver implementation, this register is supposed to be PWM1 (fan
> > speed control) as for the w83781d, but I did some tests on my
> > motherboard(Asus A7V133-C, AS99127F) yesterday and it turned out
> > that this register behaves like a temperature sensor mode selector
> > (like the it87 has). What's your opinion about this register? Where
> > would PWM1 be if it's not there?
> 
> Remember this guy?
> 
> http://archives.andrew.net.au/lm-sensors/msg02580.html
> 
> The zipped sensors.conf file attached to that message says that 0x5b
> is a temp. mode selector.  That this is true for Asus BACH is further
> evidence that the same is probably true for as99127f.

Very interesting. What I could see on my as99127f (type 1) seems to be
different. The guy says:

  default 11011101
  bit 7,6 RW   type of TXD4 (LM78 extension)
  bit 5,4 RW   type of TXD3 (secondary LM75)
  bit 3,2 RW   type of TXD2 (primary LM75)
  bit 1,0 RW   type of TXD1 (LM78)
  all bits meaning:
  00 no sensor connection, Thermal sensor reading
      register (bank 0, 17h/87h) is writable
      HMI will not update the reading register
  01 Thermistor / 10k, B = 3435
  10 3904 transistor
  11 Intel thermal diode

while I think I have:

  default 00000000
  bit 5   type of temp3 (second LM75 clone)
  bit 3   type of temp2 (first LM75 clone)
  bit 1   type of temp1

I don't know the meaning of the bits being to 1 or 0, all I can say is
that I have correct readings with bits being at 0, and incorrect (and
constant) readings with bits being at 1.

Some additional information:

The readings with bits at 1 are:
  temp1: -45
  temp2: 217.4
  temp3: 211.4

I guess the .4 are really .375 rounded, so the binary readings must be:
  temp1: 11010011
  temp2: 11011001.011
  temp3: 11010011.011

I wouldn't call that noise. It has to be something real, although I
don't know what.

One last thing: the ALARM flags don't trigger when I set the bits to
one, although the readings are of course out of bounds.

Oh, and BTW. What are these "banks" the guy is talking about?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
