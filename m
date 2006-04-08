From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 08 Apr 2006 15:14:55 +0000
Subject: [lm-sensors] nForce 430 SMBus
Message-Id: <20060408171455.18193e65.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
In-Reply-To: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> I noticed that the lspci -v output looks like this:
> 
> 00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a2)
>         Subsystem: nVidia Corporation: Unknown device cb84
>         Flags: 66Mhz, fast devsel, IRQ 5
>         I/O ports at 0600 [sized]
>         I/O ports at 0700 [sized]
>         Capabilities: [44] Power Management version 2
> 
> The hacked i2c-nforce2 wasn't working because the call to
> pci_read_config_word() was returning 0x00 for the iobase .
> 
> I made another quick hack to i2c-nforce2 to hardcode iobase=0x600 for
> the first smbus interface and iobase=0x700 for the second smbus
> interface.
> 
> Now the modules load and decode-dimms.pl is working.
> 
> I'm not much of a kernel hacker, so tell me if you need any more information.

Hey, good work. lease provide the output of (as root):
  lspci -s 00:0a.1 -xxx

Thanks,
-- 
Jean Delvare

