From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: [gerhard@brue.net: Reading from SMBus]
Message-Id: <20030613160900.GA1725@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Gerhard Strangar <gerhard@brue.net> -----

From: Gerhard Strangar <gerhard@brue.net>
X-No-Archive: yes
To: frodol@dds.nl
Subject: Reading from SMBus
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 

High,

I found your email address in the sources of the lm_sensors project and
wodered, if you could help me. I want to read the CPU temperature from
the W83782D on my mainboard, but unfortunately it's not connected to the
ISA bus, thus I have to use SMBus, but can't figure out how to select
different registers on the slave. Do I have to write to that slave
first, telling it which register I want to read from?
Let's assume I want to read out register 4Fh of slave 2Dh, is it correct
to write 2Dh to this slave and then read from it?

-- 
 * Origin: (2:2480/8057.2)


----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
