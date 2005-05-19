From: pete4abw@comcast.net (Peter Hyman)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: I2C crash - ADM1021
Message-Id: <1065743960.2954.9.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063901946.2937.27.camel@localhost>
In-Reply-To: <1063901946.2937.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just a quick FYI update.

Today, I updated all source for I2C and lmsensors from CVS.  When
running sensors-detect, it had slightly different settings for the
OPTIONS line in modules.conf for the adm1021 driver.

Previously, the line read
options adm1021 ignore=0,0x18,0,0x4c

Now, the instructions correctly show
options adm1021 ignore=0,0x4c,0,0x4e

The difference being that the driver was polling a port it had no
business doing and I believe this is what caused my system to crash!

Now, the irony is that the information from port 0x18 is totally useless
as it shows system and cpu temperature at -41C!

/sbin/modprobe adm1021 ignore=0,0x4c,0,0x4e

sensors
----------------
lm84-i2c-0-18
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
Board:       -41?C  (low =   -1?C, high =  -17?C)
CPU:         -41?C  (low =  +60?C, high =   -1?C)

But thank you anyway for making that minor correction!  I hope it was
only me that had the disk trashing trouble!

One interesting note is that when rebooting, I had to completely do a
cold start.

Let me know if I can provide you with any additional detail.

On Fri, 2003-10-03 at 07:22, Mark Studebaker wrote:
> this could simply be from chip reset or limit setting by the driver
> at initialization. This causes an ALERT output from the chip
> which the BIOS interprets as an overtemp and shuts the
> system down immediately.
> 
> (another reason for init=0 being the default)
> 
> But if the option line prevents the driver from accessing
> the chip at all, then this isn't the problem...
> 
> Peter Hyman wrote:
> > 
> > On Fri, 2003-09-19 at 14:00, Jean Delvare wrote:
> > > > > Now, for the adm1021 problems, I'm puzzled. The option line in
> > > > > /etc/sensors.conf, as suggested by sensors-detect, prevents the
> > > > > driver from using any of the three addresses at which you have
> > > > > chipsets (0x18, 0x4c, 0x4e) so loading it shouldn't have had any
> > > > > effect.
> > >
> > > Now that I come to think of it again, one question: did you actually
> > > edit /etc/modules.conf as sensors-detect told you? Having failed to do
> > > so would explain (but not forgive) how adm1021 could cause trouble on
> > > your system.
> > >
> > Yes, I edited modules.conf exactly as suggested with the exclusions for
> > adm1021 listed.
> > 
> > > > The only possible thing I was thinking was that in my
> > > > kernel config file, while no modules are loaded, there is one line
> > > > that is strange.
> > > >
> > > > CONFIG_I2C_MAINBOARD=y
> > >
> > > I never saw that option anywhere. Grep'ing linux 2.4.22 sources for it
> > > did not return anything. Could it be some Mandrake add-on?
> > >
> > > > is the only thing checked off.
> > >
> > > You mean checked *on*?
> > Yes, sorry.Selected.  As I said, I think that is for a submenu to allow
> > for selecting modules for compilation or to be built in the kernel.
> > Saying N above would skip all the choices if using xconfig or menuconfig
> > to edit .config.  I don't think it's a driver, but simply a group
> > selector.
> > 
> > As I said, I am happy it works, but the failure of adm1021 remains a
> > mystery!
> > 
> > Cheers!
> > --
> > Peter Hyman
> > Home:(609)395-1211 Office: (609)655-1184, Fax:(609)655-0285
> > Stop Telemarketers.  Sign up for Do Not Call at http://donotcall.gov
> > 
> > 
> >                        Name: signature.asc
> >    signature.asc       Type: application/pgp-signature
> >                 Description: This is a digitally signed message part
-- 
Peter Hyman
Home:(609)395-1211 Office: (609)655-1184, Fax:(609)655-0285
Stop Telemarketers.  Sign up for Do Not Call at http://donotcall.gov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 193 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031009/482965b1/attachment.bin
