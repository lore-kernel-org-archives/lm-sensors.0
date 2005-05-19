From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <425E71A7.3080108@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Rudolf
> 
> I'm sorry that I really can find the debug message on the boot step of the
> linux, I should not look for the debug message at the step of loading modules.

No problem.

Apr 14 18:15:05 CFLi kernel: ACPI: Subsystem revision 20050211
Apr 14 18:15:05 CFLi kernel: ACPI: Interpreter enabled
Apr 14 18:15:05 CFLi kernel: ACPI: Using PIC for interrupt routing
Apr 14 18:15:05 CFLi kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Apr 14 18:15:05 CFLi kernel: PCI: Probing PCI hardware (bus 00)
Apr 14 18:15:05 CFLi kernel: enter quirk_ich4_lpc_acpi() ...
Apr 14 18:15:05 CFLi kernel: In INTEL IO REGION QUIRK
Apr 14 18:15:05 CFLi kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Apr 14 18:15:05 CFLi kernel: PCI: Transparent bridge - 0000:00:1e.0
Apr 14 18:15:05 CFLi kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Apr 14 18:15:05 CFLi kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)

Hmm both quirks routines are called but in wrong order?!  Please someone else has some ideas what might went wrong?

The asus smb vendor check routine is fist and Intel LPC quirk is second. I made it same way as other "twoparters" quirks.
So now I really do not understand why is second called first.

Chunhao please can you just put:

DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB_4,	asus_hides_smbus_devices );
just "bellow" the DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_ESB_1,		quirk_ich4_lpc_acpi );
and see if it works?

Now when we know what went wrong please can you experiment with it?

We need the first routine to be called first. So log messages should look like this:
Apr 14 18:15:05 CFLi kernel: Value of asus_server_board_devices: 1
First in log and second Apr 14 18:15:05 CFLi kernel: enter quirk_ich4_lpc_acpi() ...
here the quirk fix will get activated

Thanks

Regards

Rudolf
