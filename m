From: tderooy@optonline.net (Tonko de Rooy)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: PC87366 sensor driver?
Message-Id: <1082318920.24428.3.camel@tderooy>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082293815.2121.9.camel@tderooy>
In-Reply-To: <1082293815.2121.9.camel@tderooy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2004-04-18 at 09:34, Jean Delvare wrote:
> > I just got an Opteron board (http://www.rioworks.com/HDAMB.htm) which
> > uses the NS PC87366 for its sensors.
> > 
> > Running sensors-detect finds it on the ISA bus, and told me to ask for
> > the driver, so here I go ;-)
> > 
> > I am running kernel 2.6.5 with Fedora Core 2 test 2 and lm_sensors
> > 2.8.6
> 
> We have no driver for Linux 2.6 yet :(
> 
> If you upgrade to CVS:
>   http://secure.netroedge.com/~lm78/download.html#cvs
> sensor-detect should tell you which of the three logical devices (fans,
> voltages and temperatures) are activated on your system.

I guess this is what you meant

Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Success... found at address 0x0600
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Success... found at address 0x0620
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Success... found at address 0x0610

> That's about it, for now.
> 
> If sensors-detect confirms that one or more logical devices are used,
> you have three options:
> 
> 1* Try a 2.4 kernel + i2c patch + lm_sensors CVS.

I do not really want to step back to a 2.4 kernel

> 2* Try to port our preliminary driver by yourself. Instructions are
> found in Documentation/i2c/porting-clients in the 2.6 kernel tree.

That might be a bit beyond my skill, I will have a look though.

> 3* Wait for us or someone else to port and/or extend the existing
> driver. Nobody is working on it at the moment.
> 
> Note that our preliminary driver only supports fans (monitoring and
> control) at the moment, and has not been much tested. I do not plan to
> extend the driver unless I have at least one motivated tester for
> voltages and/or temperatures. And I do not plan to port the driver to
> 2.6 before it is reasonably tested and extended.
> 
> Good luck ;)
