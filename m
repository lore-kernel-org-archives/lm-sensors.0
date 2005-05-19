From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: ADM1031 and ADuC812 controller
Message-Id: <20020225131159.M471@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020225200035.33231.qmail@web12901.mail.yahoo.com>
In-Reply-To: <20020225200035.33231.qmail@web12901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


We're just beginning to get some ADM1031 chip driver development
started.  For your application, it might be simple to write a bus
driver for your specific system, and then the chip drivers should all
work w/o modification.  Lm_sensors is very modular to support busses
and sensor/device chips independantly.

I don't know how far the compiling will go on your system?  The code
should be fairly cross-platform (e.g. it works on PPC or Intel x86).


Phil


On Mon, Feb 25, 2002 at 12:00:35PM -0800, Naeem Afzal wrote:
> Hi,
> 
> We are planning to use ADuC812 to control ADM1031
> device on our board. We will be runnig Linux on it.
> How could we use lm_sensors drivers for this, or what
> sort of effort is needed to port this funcitonality.
> Seems like you guys dont use controller and program
> the devices directly.
> 
> thanks
> 
> naeem
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Sports - Coverage of the 2002 Olympic Games
> http://sports.yahoo.com

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
