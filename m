From: vz-sensors@zeitlins.org (Vadim Zeitlin)
Date: Thu, 11 Jan 2007 16:33:33 +0000
Subject: [lm-sensors] Tyan S2696 and ADT7470
Message-Id: <E1H52rt-0005V2-00@smtp.tt-solutions.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1H1lxZ-0002Zb-00@smtp.tt-solutions.com>
In-Reply-To: <E1H1lxZ-0002Zb-00@smtp.tt-solutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 05 Jan 2007 23:50:28 +0100 Rudolf Marek <r.marek at assembler.cz> wrote:

RM> You can use also following commands to reprogram the fans to manual mode:
RM> 
RM> http://www.analog.com/en/prod/0,2877,ADT7470,00.html
RM> 
RM> CHeck page 23 of datasheet.

 Before doing this I decided to try to read the speeds of the fans, as
explained on the page 21 of the above document:

	# i2cget -y 0 0x2e 0x2a
	0x80
	# i2cget -y 0 0x2e 0x2b
	0x0a
	# i2cget -y 0 0x2e 0x2c
	0xff
	# i2cget -y 0 0x2e 0x2d
	0xff
	# i2cget -y 0 0x2e 0x2e
	0x6a
	# i2cget -y 0 0x2e 0x2f
	0x0c
	# i2cget -y 0 0x2e 0x30
	0x0a
	# i2cget -y 0 0x2e 0x31
	0x0e

Using the rule

	Fan Speed (RPM) = (90,000 ? 60)/Fan Tach Reading

from the datasheet this corresponds to speeds 2000, 1700 and 1500 RPM and
the 2 last ones must correspond to the case fans (I've thrown away the old
ones and the new ones are spec'd at 1600 and 1400 RPMs respectively), As I
don't have any other case fans, I think the first one must be the CPU fan
(although no idea which one), it's not unreasonable for it to turn at 2000
RPMs. Just in case it can be useful to someone else, here is a script
showing the fans speeds:

	http://www.tt-solutions.com/vz/hardware/tyan2696/fanspeed

RM> Register 0x68 0x69 are controlling the manual/auto mode
RM> Registers 0x32-0x34 controls the duty cycle.
RM> 
RM> This sequence will put the chip into manual mode (first two lines)
RM> Last 4 lines set the duty cycle to 50%. This should shut up the fans.
RM> 
RM> i2cset -y 0 0x2e 0x68 0x0
RM> i2cset -y 0 0x2e 0x69 0x0
RM> i2cset -y 0 0x2e 0x32 0x80
RM> i2cset -y 0 0x2e 0x33 0x80
RM> i2cset -y 0 0x2e 0x34 0x80
RM> i2cset -y 0 0x2e 0x35 0x80
RM> 
RM> Inspect the fans to see if they are still spinning sufficiently after this!

 Changing 0x69 doesn't seem to do anything. Changing 0x68 clearly does
work, before 0x32 is written the fan 0 spins up to more than 4000 RPMs.
Interestingly enough setting 0x32 to low values, and even 0, doesn't
decrease the fan speed below 2000RPMs anyhow. But setting it to high values
does increase the speed. So it looks like there is indeed enough useful
functionality to write the driver, now the only question is to find time to
do it...

RM> Hope it helps for a start.

 In fact what *really* helped was to change the fans. The new ones are
silent enough even at max speed. Of course, now the question is whether
they're fast enough to cool the case sufficiently but I won't know this
until the summer.

 Thanks again for your help,
VZ


