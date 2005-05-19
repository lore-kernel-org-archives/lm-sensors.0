From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: How to activate the SMBus on P4B533E/ICH4?
Message-Id: <3D1387A3.1DD63B89@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.31.0206192315370.4147-100000@klaus.dns2go.com>
In-Reply-To: <Pine.LNX.4.31.0206192315370.4147-100000@klaus.dns2go.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well done.

If you would like to send the new p4b_smbus back to me, I can check it in
for ich4 users, unless you would like to modify the code so it
handles both in one module.

I'll look into the 40004 messages.
Congratulations, you're now using beta code...

Klaus Woltereck wrote:
> 
> On Fri, 21 Jun 2002, Mark Studebaker wrote:
> 
> > now you're back to needing p4b-smbus. That's how it gets into lspci.
> > Modify it to change the ICH4 PCI ID's (both the base 24C0 and the
> > smbus 24C3), then if nothing changed from ICH3 then it should work.
> > To be safe you probably want to compare datasheets but if you're
> > brave just give it a shot.
> 
> OK, I've changed 2440 to 24C0 and 2443 to 24C3....
> 
> ---------------------------------------------------------------------------
> Jun 21 21:09:58 test kernel: SMBus activated in LPC!
> Jun 21 21:09:58 test kernel: PCI: Assigned IRQ 9 for device 00:1f.3
> Jun 21 21:09:58 test kernel: i801smbus: Enabled
> ---------------------------------------------------------------------------
> 
> >lspci -v
> ...
> 00:1f.3 SMBus: Intel Corporation: Unknown device 24c3 (rev 01)
>         Subsystem: Asustek Computer, Inc.: Unknown device 8089
>         Flags: medium devsel
>         I/O ports at e800 [size2]
> ...
> 
> ---------------------------------------------------------------------------
> Jun 21 21:12:07 test kernel: i2c-dev.o: i2c /dev entries driver module
> Jun 21 21:12:07 test kernel: i2c-core.o: driver i2c-dev dummy driver
> registered.
> Jun 21 21:12:07 test kernel: i2c-dev.o: Registered 'saa7146(1)' as minor
> 0
> Jun 21 21:12:08 test kernel: i2c-proc.o version 2.6.1 (20010825)
> Jun 21 21:14:50 test kernel: i2c-i801.o version 2.6.3 (20020322)
> Jun 21 21:14:50 test kernel: i2c-core.o: I2C adapter 40004: I2C level
> transfers not supported
> Jun 21 21:14:50 test last message repeated 5 times
> Jun 21 21:14:50 test kernel: SP8870: no SP8870 found ...
> Jun 21 21:14:50 test kernel: i2c-core.o: I2C adapter 40004: I2C level
> transfers not supported
> Jun 21 21:14:50 test kernel: i2c-core.o: I2C adapter 40004: I2C level
> transfers not supported
> Jun 21 21:14:50 test kernel: i2c-dev.o: Registered 'SMBus I801 adapter at
> e800' as minor 1
> Jun 21 21:14:50 test kernel: i2c-core.o: adapter SMBus I801 adapter at
> e800 registered as adapter 1.
> Jun 21 21:14:50 test kernel: i2c-i801.o: I801 bus detected and
> initialized
> ---------------------------------------------------------------------------
> 
> Question: Do I have to worry about "I2C level
> transfers not supported" messages?
> 
> Bye,
> Klaus
