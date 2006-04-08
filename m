From: markrages@gmail.com (Mark Rages)
Date: Sat, 08 Apr 2006 15:04:31 +0000
Subject: [lm-sensors] nForce 430 SMBus
Message-Id: <74ee72ca0604080804i2d697025h671d664d4b9402de@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
In-Reply-To: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 4/7/06, Mark Rages <markrages at gmail.com> wrote:
> I'm guessing I need to get this interface working:
>
> 00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a2)
>         Subsystem: nVidia Corporation: Unknown device cb84
>
> This has PCI ID 10de:0264.
>
> I tried hacking adding this ID to the nforce2 driver, but I still
> can't get anything from decode-dimms.pl.
>
> What do I need to do?

Replying to myself.

I noticed that the lspci -v output looks like this:

00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a2)
        Subsystem: nVidia Corporation: Unknown device cb84
        Flags: 66Mhz, fast devsel, IRQ 5
        I/O ports at 0600 [sized]
        I/O ports at 0700 [sized]
        Capabilities: [44] Power Management version 2

The hacked i2c-nforce2 wasn't working because the call to
pci_read_config_word() was returning 0x00 for the iobase .

I made another quick hack to i2c-nforce2 to hardcode iobase=0x600 for
the first smbus interface and iobase=0x700 for the second smbus
interface.

Now the modules load and decode-dimms.pl is working.

I'm not much of a kernel hacker, so tell me if you need any more information.

Regards,
Mark
markrages at gmail
--
You think that it is a secret, but it never has been one.
  - fortune cookie

