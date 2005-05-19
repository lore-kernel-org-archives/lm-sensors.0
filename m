From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Sensor module hangs in 2.8.1, works fine with 2.6.1
Message-Id: <20031120132338.GB1061@ip68-0-152-218.tc.ph.cox.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
In-Reply-To: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Nov 19, 2003 at 09:56:56PM +0100, Jean Delvare wrote:
> 
> > > > 5. Doing a 'modprobe i2c-piix4' generates the following kernel log
> > > > messages:
> > > >    i2c-core.o: i2c core module version 2.8.1 (20031005)
> > > >    i2c-piix4.o version 2.8.1 (20031005)
> > > >    Found ServerWorks OSB4 South Bridge device
> > > >    dmi_scan.o version 2.8.1 (20031005)
> > > >    dmi_scan.o: SM BIOS found
> > > >    Worked around buggy BIOS (I2C)
> > >
> > > That last message looks interesting. I would edit i2c-piix4.c in
> > > your 2.8.1 sources and disable that workaround. Could be that on
> > > your system, the workaround does more harm than help. Or it might be
> > > worse, I dunno;)
> > 
> > I disabled that workaround and everything works fine now. Thanks a
> > lot! I am not sure if you would like to investigate this further. I
> > assume you got better things to do :-)
> > If you are interested in investigating this and I can provide any
> > additional data, do not hesitate to contact me again, so I will do
> > what I can to help improve lm_sensors.
> 
> That workaround was suggested by Tom Rini and the patch was applied in
> August 2003. It was supposed to fix a problem on the Force CPCI-735.
> After testing it on "normal" systems, we thought it was safe for
> everyone, and applied the change. Looks like we were wrong.
> 
> Could it be that it is safe for Intel PIIX4 chips but *not* for
> ServerWorks ones?

Unfortunatly, the Force CPCI-735 has a ServerWorks chipset.  I'm double
checking what rev the board has (perhaps this is fixed in newer
revisions of the chipset).

-- 
Tom Rini
http://gate.crashing.org/~trini/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031120/09bd80a2/attachment.bin
