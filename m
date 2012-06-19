From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 19 Jun 2012 21:00:19 +0000
Subject: Re: [lm-sensors] No sensors detected PE600SC
Message-Id: <1340139619.2299.85.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALK30xCab=jL+AuL=_y3QV0deW9U5HtB_ZoEK0NDTVe0fSZLTg@mail.gmail.com>
In-Reply-To: <CALK30xCab=jL+AuL=_y3QV0deW9U5HtB_ZoEK0NDTVe0fSZLTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-06-19 at 16:47 -0400, Jean Delvare wrote:
> On Tue, 19 Jun 2012 15:46:48 -0400, Graham Medlin wrote:
> > Have a Dell PowerEdge 600sc running Ubuntu 12.04 Server. Hate to
> 
> Which kernel is that?
> 
Should be 3.2.

Guenter

> > retire the golden egg laying goose, its solid. The fan is running at
> > 100%, sounds like a 747, so I wanted to check it with lm_sensors...
> > 
> > Running "sensors-detect" yields no for everything except:
> >      ...
> >      Do you want to scan for Super I/O sensors? (YES/no): y
> >      Probing for Super-I/O at 0x2e/0x2f
> >      Trying family `National Semiconductor/ITE'...               Yes
> >      Found `Nat. Semi. PC8741x Super IO'
> >          (no hardware monitoring capabilities)
> >      ...
> >      ...
> >      Do you want to probe the I2C/SMBus adapters now? (YES/no): y
> >      Using driver `i2c-piix4' for device 0000:00:0f.0: ServerWorks
> > CSB6 South Bridge
> >      Sorry, no sensors were detected.
> >      ...
> > 
> > The CSB6 bus is listed as supported, but I haven't been able to track
> > down what the sensors are.
> 
> This chip is how you may be able to access sensor chips, it is not a
> sensor chip itself.
> 
> > Back when this was a Windows machine, I ran Everest Home, and it was
> > able to read everything, and claimed LM81	and MAX1617A chips for
> > whatever its worth...
> 
> Good news is that both are supported under Linux, so if that's really
> what your system has, there is hope.
> 
> > Googling found exactly one reference claiming this was possible on a
> > linux machine:
> >      http://lists.us.dell.com/pipermail/linux-poweredge/2005-July/021985.html
> 
> This is a pretty old post, not sure everything said there still applies.
> 
> > 
> > I tried with no luck:
> >      modprobe -r i2c-piix4
> >      modprobe i2c-piix4
> 
> The post said to pass force=1, but you did not.
> 
> > I'm not sure if its related, but "i2cdetect -l" returns nothing.
> 
> Do you have i2c-dev loaded? i2cdetect won't work without it. If you do
> and "i2cdetect -l" still doesn't list the SMBus, please check the
> kernel log when you try to (re)load i2c-piix4.
> 
> > Below is part of the output of "lspci -nn -vv"
> >      00:0f.0 Host bridge [0600]: Broadcom CSB6 South Bridge [1166:0203] (rev a0)
> >           Subsystem: Broadcom Device [1166:0201]
> >           Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr+ Stepping- SERR+ FastB2B- DisINTx-
> >           Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
> > >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
> >           Latency: 32
> >           Kernel modules: i2c-piix4, sworks-agp
> 
> Two drivers for the same device, looks wrong. You should try getting
> rid of (via blacklisting) sworks-agp and see if it helps any.
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
