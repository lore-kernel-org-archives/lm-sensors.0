From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: [Fwd: Smbus transaction issues using the i2c-algo-bit
Message-Id: <3D1BC040.F16C3800@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D1A21EF.61701061@paradyne.com>
In-Reply-To: <3D1A21EF.61701061@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well first of all let me apologize to Dori, who is a "he", not a "she".
Talk about a bad assumption...

Next let me get the discussion rolling by
agreeing with his suggestion on "dynamic read length".
I think it's a good idea and fairly easy to implement.

mds




Mark Studebaker wrote:
> 
> As you know I've been working closely with Dori Eldar of Intel on adding ICH4 support
> to i2c-i801 and SMBus 2.0 support to I2C.
> 
> She has implemented a full SMBus 2.0 implementation (for bit-banging interfaces)
> that is similar to, and a replacement of,
> i2c-algo-bit. She had some specific issues with our smbus/i2c implementation that
> caused her to do so. I asked her to document those issues for us so that
> we could investigate fixing/enhancing our existing implementation to resolve those issues,
> where possible.
> 
> Dori obviously has taken the time to study our code and carefully document
> her issues. She also was instrumental in the
> donation of a system to us. So let's discuss these issues.
> 
> I'll add some comments of my own at a later date.
> 
> mds
> 
> 
> 
> Subject: Smbus transaction issues using the i2c-algo-bit implementation
> Date: Wed, 26 Jun 2002 10:29:58 +0300
> From: "Eldar, Dori" <dori.eldar@intel.com>
> To: "Mark Studebaker (E-mail)" <mds@paradyne.com>
> CC: "Kupermann, Eli" <eli.kupermann@intel.com>
> 
> Hi Mark,
> as promised, I'm sending you a detailed list describing the reasons why we
> had to implement our own "bit-banging" code dedicated for Smbus transactions
> rather then using the native I2C bit-banging code (i2c-algo-bit.h).
> 
> I'd also like to inform you that I will be leaving my current position at
> Intel, shifting to another project, starting next week. Eli Kupermann will
> be replacing me and will continue working with you and the Lm-Sensors
> community. Eli has extensive knowledge on the Linux kernel, as he drove the
> kernel inclusion of the e100 driver into the 2.5 kernel.
> Eli is also aware of all the code fragments I've sent you so far...
> Please feel free to keep me in the loop if you'd like that.
> 
> Best Regards
> Dori
> 
> ----------------------------------------------------------------------------
> ----------------------------------------------------------------------------
> ---------------------------------------------
> Before going into the little details I'd like to point out  that the main
> reason for using a somewhat different code was necessary due to the
> differences between the i2c & Smbus specifications.
> 
> timing considerations:
> The Smbus defines a minimum frequency of 10 KHZ for driving the bus, while
> the I2C does not define any minimum frequency.
> furthermore the maximum time a master is allowed to keep the CLK line high
> is 50 usec. this is required so masters can detect an idle bus
> (the CLK line is high for at least 50 usec), again the I2C does not impose
> this restriction.
> It's crucial that masters will obey the last timing consideration, since:
> 1. Slaves may otherwise hang the transaction.
> 2. Other masters will assume the bus is idle, initiate there own Smbus
> transaction, which will lead to corruption of data
> carried over the Smbus. Note that a correct arbitration procedure can take
> place only if masters are "synchronized" meaning, they initiate the
> transaction at the _same_ time.
> 
> Now when implementing the Smbus protocol in SW one has to make sure that in
> the critical sections in which the CLK is held high, SW is not preempted.
> Or more simply: SW must disable interrupts at this period of time.
> This critical periods are:
> a. Waiting for an idle bus before starting the transaction until the CLK is
> driven low after generating the START signal.
> b. For each clock cycle in the transaction: before the CLK is set to HIGH
> till after the CLK is set LOW.
> 
> Looking at the i2c-algo-bit.c it's very problematic to add the interrupt
> disabling code since the code may sleep in the critical period at the
> "sclhi" function.
> you would also need to add a "wait for idle bus " before the driving the
> START signal.
> 
> Arbitration:
> Although the I2C disallows arbitration between masters while one is sending
> a restart signal & another sending a data signal, this situation is
> theoretically possible
> on an Smbus.
> So you would need to check for arbitration  when driving the restart signal
> to.
> BTW why is the arbitration check code disabled in the i2c_outb?
> 
> Dynamic data length read on BlockRead & BlockProcess calls:
> these 2 Smbus commands digest the read data in-order to decide on the fly
> how many data bytes to read.
> Such a requirement is not described by the I2C protocol and is not
> implemented in the i2c-algo-bit.c
> Perhaps you could add a flag which will turn on some digesting code in
> "readbytes" routine which will mimic the Smbus behavior.
> 
> Pre-Post routines:
> this is not related to Smbus protocol, but rather to our HW requirement.
> Before & after driving an Smbus transaction, our HW must be accessed, such
> access is not possible with current algo-bit design. It's possible to allow
> such access by doing
> an EXPORT_SYMBOL(i2c_bit_xfer) therefore making the algo-bit available as a
> library function only. Or by adding a post & pre function pointers to the
> algo-bit structure.
> 
> Regards Dori
>
