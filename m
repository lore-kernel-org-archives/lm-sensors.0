From: ed.tman@verizon.net (Ed Harrison)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: ASUS A7V333, ASB100(bach) must not be an as99127f
Message-Id: <1040258701.6614.45.camel@linux.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have an ASUS A7V333 which definitely has the ASB100 chip (on $2d:
$581, $4f), not to be confused with as99127f or the w83781d,
although some functionalities are the same.  Your NEW AND REQUESTED CHIP
DRIVERS - STATUS states that the asb100(bach) is recognized as an
as99127f.  The as99127f and the asb100(bach) have different ID's and
behave differently because using w83781d force_as99127f is not working 

I downloaded xmbmon from:
http://www.nt.phys.kyushu-u.ac.jp/shimizu/download/download.html

Also the link to FVCool, for anyone who wants to drop the CPU temp by
about 23 - 24 F in under 5 minutes.

Mbmon gives me numbers very consistent with CMOS Hardware Monitor, BUT
it is either command line or Ugly X, and the docs contain a warning that
it is probing the chips directly.  This can cause problems and make the
system unstable.  From the command line, mbmon -f, I even get the power
fan2 rpm = CMOS rpm, which I do not get with xmbmon, nor have ever
gotten from sensors.

If I modprobe the i2c and lm_sensors modules, mbmon and xmbmon start
giving me crazy numbers (for example CPU 5.1 F, up from 90.5 a few
moments before), as does sensors.

The only way to restore sensible numbers again is to reboot.  How Come?

I was going to try to hack w83781d.c into something useable, but alas I
am too dumb.  I offer what I know about this chip in hopes one of you
can do it, maybe as a force_asb100=0,0x2d option to w83781d.

AS99127F
location: SMBUS only, $2C or $2D
ID: $58 : $31
Sub ID:  $4F : $12 or $4F : $C3 = type 1  [negative voltages like
winbond
1D]
Sub ID:  $4F : $5C or $4F : $A3 = type 2  [negative voltages like
winbond
2D]

Temp sensor 1: $27 on AS99127F
Temp sensor 2: $00 on LM75-2 clone
Temp sensor 3: $00 on LM75-1 clone

Voltage: like winbond 1D
Fans: like winbond 1D


ASB100
location: SMBUS only, $2C or $2D
ID: $58 : $31
Sub ID:  $4F : $94 or $4F : $06

Temp sensor 1: $27 on ASB100
Temp sensor 2: $00 on LM75-2 clone
Temp sensor 3: $00 on LM75-1 clone
Temp sensor 4: $17 on ASB100 [AMD diode only it seems]

-- 
Ed Harrison <ed.tman@verizon.net>
