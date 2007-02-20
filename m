From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 20 Feb 2007 08:02:53 +0000
Subject: [lm-sensors] mcp61 sensors support
Message-Id: <20070220090253.215d8fea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9ef864c50702182307q4364770cj53c6dbab30fcd887@mail.gmail.com>
In-Reply-To: <9ef864c50702182307q4364770cj53c6dbab30fcd887@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

On Mon, 19 Feb 2007 16:36:25 -0500, Thomas Garner wrote:
> [root at ns ~]# lspci -v -s 00:01.1
> 00:01.1 SMBus: nVidia Corporation MCP61 SMBus (rev a2)
>         Subsystem: Elitegroup Computer Systems Unknown device 2602
>         Flags: 66MHz, fast devsel, IRQ 11
>         I/O ports at fc00 [sized]
>         I/O ports at 1c00 [sized]
>         I/O ports at f400 [sized]
>         Capabilities: [44] Power Management version 2

Hmmm, OK. If the MCP61 is similar to the previous models, the two SMBus
controllers correspond to the 2nd and 3rd I/O port ranges. However I am
surprised because these used to always live back-to-back. In your case
the two addresses are completely different, which makes me suspect that
something is different.

Either way, if you want to try, we can instruct the i2c-nforce2 driver
to handle your chip as a supported one and see what happens. Here's the
procedure (as root):

modprobe i2c-nforce2
modprobe i2c-dev
echo "10DE 03EB" /sys/bus/pci/drivers/nForce2_smbus/new_id
(check the logs)
i2cdetect -l
(you should see the two nVidia SMBus listed)
i2cdetect 0
i2cdetect 1
(assuming the nVidia SMBus are bus numbers 0 and 1)

Please report your results. Beware that bad things might happen if it
happens that the MCP61 is not actually compatible with the older chips.
Hopefully nothing a reboot won't fix, though.

-- 
Jean Delvare

