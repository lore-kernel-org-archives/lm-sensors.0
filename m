From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Thermal fan on PIIIDME
Message-Id: <20020619134434.N1893@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020618234918.44766.qmail@web13106.mail.yahoo.com>
In-Reply-To: <20020618234918.44766.qmail@web13106.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Ah, well, you're making progress.  The analog_out was intended for
controlling fans, so I wouldn't be surprised if you can tie an alarm
or something to the analog_out?  Take a peek at the datasheet for the
most accurate and detailed info:

http://www.national.com/pf/LM/LM87.html#Datasheet

It's possible that the initialization function in the LM87 driver in
lm-sensors is overriding the settings that the Bios does.


Phil


On Wed, Jun 19, 2002 at 09:30:39PM +0100, Chris Rankin wrote:
>  --- phil@netroedge.com wrote: > 
> > OK, now take a look in /proc/sys/dev/sensors/lm87*
> > 
> > In those directories (one for each of your chips
> > below) there is an
> > analog-out file (called 'analog_out').  Try writing
> > some values to
> > both of those to see if that's how you fan is
> > controlled.  E.g. 'echo
> > "255" > /proc/dev/sensors/lm87-i2c-0-2d/analog_out'
> 
> According to Supermicro, I shouldn't need a driver for
> the thermal fan... But I have discovered that I can
> turn my CPU fans off by writing 0 to bits 6 and 7 of
> lm87-i2c-0-2e/analog_out. Ooeerr!!
> 
> I shall have to test their "no driver" statement -
> I've SEEN and HEARD the fan come on before Linux
> boots, but never while Linux is running... and it's
> not as if I've never seen this baby get slightly warm
> either...
> 
> Chris
> 
> 
> Chris
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Everything you'll ever need on one web page
> from News and Sport to Email and Music Charts
> http://uk.my.yahoo.com

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
