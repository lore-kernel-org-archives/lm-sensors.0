From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 18 Feb 2007 22:43:58 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <45D8D6AE.3000204@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <45D6DDCE.5050803@assembler.cz> <45D7461A.2040808@redhat.com>
In-Reply-To: <45D7461A.2040808@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

Hello all,

I got the DSDT from chuck and it seems there is nothing interesting - no
declaration of PCI_config for the registers. If someone wants to check it I can
send him the DSDT.

_TMP looks like this:

 Store (\_SB.PCI0.LPC0.EC0.RTMP, Local0)
                    Store ("Current temp is: ", Debug)

                    Store (Local0, Debug)

                    Store (Local0, \_SB.CM25)

                    Return (Add (0x0AAC, Multiply (Local0, 0x0A)))

This looks quite OK LPC0.EC0 is embedded controller IO RAM at 0x62. Nothing
special. I guess some SMM interrupt is reading the the PCI regs and sends it to EC.


Chuck, please can you try to use your script which reads the temps from acpi
once a second and in other console run following command: (as root)

 watch -d -n 1 lspci -xxx -s 18.3

This will list the pci registers every second and marks the diff. You should see
changes at 0xe6 which is your temperature. However if you see 0xe4 changing and
the k8temp driver is NOT loaded - it means something else is doing that.
If you spot the 0xe4 changes, please stop your script and check if it is still
changing.


Maybe you will not be able to see any changes at all - then the SMM is doing
reads only. Also you did not say how many cores, or places temps you see using
the k8temp driver. You have dual core with two possible places?

Thanks
Rudolf

