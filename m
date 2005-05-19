From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: Ticket #780, i2c-core sends output to console at reboot
Message-Id: <20020122093619.C876@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0201221623404.29636-100000@flow.fuw.edu.pl>
In-Reply-To: <Pine.LNX.4.33.0201221623404.29636-100000@flow.fuw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I'm pretty sure that we only use 'printk' to output messages.  You
kernel/system should know how to handle those.  On many systems, any
printk's get echoed to the console, but this may be kernel/distro
dependant. 


Phil

On Tue, Jan 22, 2002 at 04:25:10PM +0100, Jakub Narebski wrote:
> I have the following problem with the sensors service I send you. The
> lm_sensors modules sends information about registered and unregistered
> drivers to somewhere. At startup (kernel/system loggers start _after_
> sensors service) and during normal work the output is not send to
> console. It can be seen via dmesg.
> 
> At reboot however i2c-core sends information about unregistered drivers to
> the (only) console (sensors chip and bus drivers are removed using
> modprobe -r -q). Kernel/system loggers are stopped at the time of stopping
> sensors service.
> 
> It is a bug or did I make something wrong?
> 
> P.S. it should be rather prog/initscripts/sensors
> 
> -- 
> Jakub Narebski
>     Poland
> 
> 

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
