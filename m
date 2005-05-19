From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Centrino (855PM, ICH4-M): 82801DBM w/o LPC Bridge/SMBus?
Message-Id: <20040412160027.GE6820@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040412152503.GD6820@neu.nirvana>
In-Reply-To: <20040412152503.GD6820@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Mon, Apr 12, 2004 at 05:25:03PM +0200, Axel Thimm wrote:
> I've been trying to get the readings off a Centrino notebook (a
> Toshiba Satelite M30).
> 
> The sensor relevant pci entries (24c3/24c0) are missing:
> # lspci -n
> [...]
> 00:1f.0 Class 0601: 8086:24cc (rev 03)
> [...]
> # lspci
> [...]
> 00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
> [...]

OK, so I was blind. The LPC I/C has moved from 24c0 (801DB) to 24cc
(82801DBM). I checked the specs at Intel and found that my SMBus is
disabled wrt to the PCI configuration space, but the I/O space is
accessible, e.g. the SMBus is there but hidden ...

What is the best way to proceed? I found a module that deals with a
similar problem for the DB on ASUS P4B. Should this be dealt with the
same way? Then I could add 82801DBM support into i2c-i801.c and
sensors-detect.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040412/341d0138/attachment.bin
