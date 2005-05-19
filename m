From: anthony@mindmedia.com.sg (P.V.Anthony)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Works great first. After restart do not work.
Message-Id: <002d01c2e4c2$b5ccc740$c6307dcb@home>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030306174822.7ff7d994.khali@linux-fr.org>
In-Reply-To: <20030306174822.7ff7d994.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean,

Sorry about sending only to you. Thanks for the reply

If anyone has any idea to solve this, it would be great. 

P.V.Anthony

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "P.V.Anthony" <anthony@mindmedia.com.sg>
Cc: "LM Sensors" <sensors@stimpy.netroedge.com>
Sent: Friday, March 07, 2003 5:16 PM
Subject: Re: Works great first. After restart do not work.


> 
> *** PLEASE REPLY TO THE LIST, NOT TO ME ONLY ***
> 
> > Dear Jean,
> > 
> > Thank you for the reply.
> > 
> > I have tried "sensors -s" it still do not work. I get the same output.
> > 
> > As for the modules, these are the ones I have added in file  "/etc/rc"
> > 
> > #----cut here----
> > # I2C adapter drivers
> > modprobe i2c-piix4
> > # I2C chip drivers
> > modprobe adm1024
> > modprobe lm75
> > modprobe eeprom
> > #----cut here----
> > 
> > Have I added them in the right file? If it is wrong please recommend a
> > right file.
> 
> Well, it actually depends on your distribution, but if it sometimes
> works, then it must be the good location for your system.
> 
> > The strange thing is that if I do a complete shutdown with shuting
> > down the power, then start with turning on the power, it works great.
> > If I do a restart without shuting down the power, I get this problem.
> 
> That's a really valueable information. This would mean that the bus
> isn't correctly reset or initialized. It is then beyond my personnal
> knowledge, though. Maybe someone else on the list has an idea?

