From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Thermal fan on PIIIDME
Message-Id: <20020618173811.C1893@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020618234918.44766.qmail@web13106.mail.yahoo.com>
In-Reply-To: <20020618234918.44766.qmail@web13106.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Try to find out what chip you have.  You can sometimes look on the
mobo and/or manual to see.  You can see which chips are supported from
our web site.  Some fans can be controlled, and others can't. 
Sometimes using an lm_sensors driver can override the setting set in
Bios, so be careful. 


Phil

On Wed, Jun 19, 2002 at 12:49:18AM +0100, Chris Rankin wrote:
> Dear Supermicro representative,
> 
> I have installed a thermal fan on my Supermicro
> PIIIDME, but am not convinced that it is being
> activated when the CPUs reach their threshold
> temperature, as configured in the BIOS. Does the fan
> need a driver for the operating system before it will
> work? If so, then can you please provide me with
> sufficient information about the motherboard to write
> such a driver? I am running Linux 2.4.18, which
> already provides a driver for the SMBus functionality
> (should that be relevant).
> 
> Please note that I am *not* asking Supermicro to
> provide a driver, should one be required. I am merely
> asking for sufficient hardware specifications for the
> PIIIDME to allow me to write me own driver, which I
> would then be able to release freely to the Linux
> community. For example, would the driver need to do
> much more than write values to a particular port to
> turn the fan on and off? If so then could you tell me
> which values and which port, please?
> 
> Thank you,
> Chris Rankin
> 
> (I don't think that Linux relies upon the BIOS to a
> great extent, and so I doubt whether any thermal-fan
> controlling code in the BIOS would have a chance to
> run. Unless this functionality is handled using
> hard-wired circuitry on the motherboard itself? I
> really hve no idea, here. Can you advise, please?)
> 
> http://www2.lm-sensors.nu/~lm78/author.html
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
