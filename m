From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 18 May 2006 17:18:58 +0000
Subject: [lm-sensors] [PATCH] OpenCores I2C bus driver
Message-Id: <87hd3n1cal.fsf@LKG7F3A44.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <874q0n1505.fsf@sleipner.barco.com>
In-Reply-To: <874q0n1505.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>>>> "Rudolf" = Rudolf Marek <r.marek at sh.cvut.cz> writes:

Hi,

 Rudolf> Sorry for delay we all had lot of other stuff to do. I
 Rudolf> checked your driver and it seems very good. Please check my
 Rudolf> comments in the code.

No problem, I've had a busy week as well..

Perhaps worth noticing: This is not the latest version of the
patch. Andrew added it to -mm after I posted it and a few small
fixes/cleanups were done. On the 27th of April it was forwarded to
Greg and dropped from -mm.

I'm afraid I've lost track of it since :/ I expect Greg to wait until
2.6.17 gets released before pushing it upstream, but I don't see it in
his git tree..

Greg, where are you hiding it? ;)

 >> +config I2C_OCORES
 >> +	tristate "OpenCores I2C Controller"
 >> +	depends on I2C

 Rudolf> Really no experimental? How long is driver used?

I've been using it for a month or two (on 2 different designs) and the
core logic is based on a eCos driver that I have been using for around
a year.

But we can mark it experimental if you want, I don't feel strongly
about it.

 >> obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
 >> obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 >> obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
 >> +obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o

 Rudolf> I think rest of files is alphabetic order

Ok, I'll fix that.

 >> + * Peter Korsgaard <jacmet at sunsite.dk>

 Rudolf> Should have (C) and year

Really? Isn't that just extra noise that's bound to get out of date?

 >> +	/* make sure the device is disabled */
 >> +	oc_setreg(i2c, OCI2C_CONTROL, 0);

 Rudolf> Well I started to read the driver from a flow and this is the
 Rudolf> first occurrence to write to some register :).

There's also regiser access in ocores_process.

 Rudolf> I think much better handling of reserved bits is to read them
 Rudolf> from device change bits I know and then write all back.

Yes, that could be done for CONTROL as it's r/w - I'll change that.

 Rudolf> I'm also surprised that the device has no ID/revision regs
 Rudolf> which might be handy for future extensions

Yeah, but as it's a quite simple device (implemented in FPGA) that was
probably considered overkill.

 >> +	prescale = (pdata->clock_khz / (5*100)) - 1;

 Rudolf> No checks for evil values?

Currently not. It would be a bit hard to define what a valid value
is. Do you think it's needed? This is data provided by the platform
code just like the base address and IRQ number (that we also don't
validate).

 >> +	oc_setreg(i2c, OCI2C_CMD,     OCI2C_CMD_IACK);
 >> +	oc_setreg(i2c, OCI2C_CONTROL, 0xc0);

 Rudolf> and here again

I'll add defines for the CONTROL bits and only change the needed bits.

Thanks for your comments!

-- 
Bye, Peter Korsgaard

