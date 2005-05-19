From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Centrino (855PM, ICH4-M): 82801DBM w/o LPC Bridge/SMBus?
Message-Id: <20040413004645.GB12539@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040412152503.GD6820@neu.nirvana>
In-Reply-To: <20040412152503.GD6820@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 12, 2004 at 06:33:07PM +0200, Jean Delvare wrote:
> > The LPC I/C has moved from 24c0 (801DB) to 24cc
> > (82801DBM). I checked the specs at Intel and found that my SMBus is
> > disabled wrt to the PCI configuration space, but the I/O space is
> > accessible, e.g. the SMBus is there but hidden ...
> > 
> > What is the best way to proceed? I found a module that deals with a
> > similar problem for the DB on ASUS P4B. Should this be dealt with the
> > same way? Then I could add 82801DBM support into i2c-i801.c and
> > sensors-detect.
> 
> Step 1 is to check that the p4b_smbus trick works for you. Just change
> the relevant define and try (see my other post).

It does :)

> If step 1 is successfull, i2c-i801.c should work out of the box (it's
> the same SMBus device after all). So there is no step 2 ;) Ditto for
> sensors-detect, it should work out of the box (we just can chanhge the
> description string from "DB" to "DB/DBM").
> 
> If it works (whether or not you actually find something on the bus), we
> of course want to do update the files in our CVS repository.

There is an adm1032 chip on it, as well as RAM eeproms. I have also
found some bugs in the p4b_smbus (the bits were valid for ICH2, not
ICH4, as a sideeffect they enable USB UHCI #3 on ICH4).

I will prepare a diff to cvs and send it to you. Thanks!  (BTW cvs
diff -N ... does not work with new, but not cvs added files and cvs
add is not allowed with anonymous read-only access. How does one
prepare a diff -N type patch?)

# sensors
adm1032-i2c-0-4c
Adapter: SMBus I801 adapter at 1100
M/B Temp:    +45?C  (low  =   -65?C, high =  +127?C)   
CPU Temp:  +45.9?C  (low  = +42.0?C, high = +50.0?C)   
M/B Crit:   +127?C  (hyst =  +122?C)                   
CPU Crit:    +87?C  (hyst =   +82?C)                   

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 1100
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 1100
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040413/c4e3e94f/attachment.bin
