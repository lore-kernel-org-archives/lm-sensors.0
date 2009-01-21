From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Jan 2009 09:18:09 +0000
Subject: Re: [lm-sensors] Problems with f71882fg and NVIDIA graphics card
Message-Id: <20090121101809.08b91567@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1232481045.6371.77.camel@malcolm>
In-Reply-To: <1232481045.6371.77.camel@malcolm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Malcolm,

On Wed, 21 Jan 2009 00:40:28 -0800, Malcolm Lalkaka wrote:
> On Wed, 2009-01-21 at 08:58 +0100, Jean Delvare wrote:
> > You appear to have a recent nVidia SMBus controller which we do not
> > support yet (MCP79). If it is compatible with previous nVidia south
> > bridges then the i2c-nforce2 driver should work. Can you please provide
> > the output of lspci -d 10de:0aa2 -vxxx?
> 
> The output from "sudo lspci -d 10de:0aa2 -vxxx":
> 00:03.2 SMBus: nVidia Corporation MCP79 SMBus (rev b1)
> 	Subsystem: eVga.com. Corp. Device 1006
> 	Flags: 66MHz, fast devsel, IRQ 5
> 	I/O ports at ff00 [sized]
> 	I/O ports at 1c00 [sized]
> 	I/O ports at 1c80 [sized]
> 	Capabilities: [44] Power Management version 2
> 00: de 10 a2 0a 01 00 b0 00 b1 00 05 0c 00 00 80 00
> 10: 01 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 01 1c 00 00 81 1c 00 00 00 00 00 00 42 38 06 10
> 30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 00 00
> 40: 42 38 06 10 01 00 02 c0 00 00 00 00 6a 96 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 01 10 00 00 01 14 00 00 01 18 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 f0 ef 00 00 00 00 01 00 00 00
> 80: 00 10 fe fe 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: b1 02 00 00 07 00 00 84 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: d4 30 80 01 01 00 00 00 20 82 00 0a 0d 0d 19 19
> d0: c0 b0 c0 00 10 00 01 00 05 00 00 00 00 00 00 00
> e0: 88 10 01 10 60 40 00 4f 80 60 00 00 23 44 44 00
> f0: 7a ff 3d 67 b7 af 9b f8 90 00 80 80 00 00 00 00

Looks compatible. You may try loading the i2c-nforce2 driver and then
run the following command:

echo "10de 0aa2" > /sys/bus/pci/drivers/nForce2_smbus/new_id

If thinks go well, you should see the nForce2 SMBus (2 channels) in the
output of "i2cdetect -l" (after loading kernel module i2c-dev). Check
with "i2cdetect <n>" (where n is the bus number) that they behave OK.

> > What have you the idea to run i2cdump on all addresses? In general this
> > is a _very bad_ idea, as i2cdump can damage your system (as the warning
> > says.) If there is any documentation lying around that told you to do
> > this, it should be fixed quickly.
> 
> Assuming I understood it correctly, I was doing what it said on the "How
> to Ask for Help" section of the lm-sensors website:
> http://www.lm-sensors.org/wiki/FAQ/Chapter4.
>         Here's what you should send us:
>         ...
>         The output of (as root) prog/dump/i2cdump X 0xXX where XX = the
>         address of each chip you see in the output of i2cdetect. (run
>         once for each chip) (please send this only if it's not all ff)

OK, thanks. Very old FAQ entry... I've fixed that. Sometimes I wonder
if we shouldn't plain delete the FAQ and start a new one from scratch,
as is is sooo out-of-date :(

> I read the warning, but I guess I thought it would be alright. (It
> sounds foolish now, I know.) I hope I didn't do any damage; how can I
> check? Out of curiosity, how can dumping this information cause damage?
> Isn't dumping usually a read-only operation?

The problem is that I2C doesn't have clear semantics about what is a
read and what is a write. So i2cdump might actually write to I2C chips.

> > For the others: the problem is a PNP BIOS bug: region 0x295-0x314 is
> > reserved by PNP, which is clearly incorrect. This prevents the f71882fg
> > driver from declaring its I/O region (0x290-0x297).
> > 
> > Malcolm, did you try the pnp boot parameters I suggested on IRC?
> 
> Yes I tried the boot parameters you suggested; neither "pnpbios=off" nor
> "pnp_reserve_io=0x290,8" worked, unfortunately. This led me to believe
> the problem may be something different. (I don't know much about this
> stuff, though.)

See my other post: try pnpacpi=off.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
