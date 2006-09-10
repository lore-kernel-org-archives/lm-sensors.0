From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 10 Sep 2006 21:31:26 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems w/
Message-Id: <4504842E.7050603@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1157458671.18988.34.camel@mhcln03>
In-Reply-To: <1157458671.18988.34.camel@mhcln03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all

I checked the ACPI DSDT and they set the bit0 of 0x47... in every change of the
the 47reg.

               And (FDR1, 0x3F, Local3)

                Or (Local2, Local3, Local3)

                Or (Local3, 0x01, Local3)

                Store (Local3, FDR1)

(FDR1 is 0x47)

I did not find out how they force the bit to be R/W. I remember I asked already
at Winbond how to know when fan5 is enabled, and they told me that the serial
flash interface should be disabled (ENROM cr24) And then FAN5 (AUXFANIN1) works.
This way it is implemented in newer EHF patches.

Well in my case is the bit0/47 is RO too (I own the EHF chip) - so writing 0xf5
fails same as in Matthias case... even if the serial flash is disabled,
monitoring stopped...

I'm out of ideas... but ;)

Yuan, please can you ask someone:

How is it possible that the bit0/of reg 47 in hardware monitor is read only (1
cannot be written) even when serial flash interface is disabled and CR24 bit 1
in sio (ENROM strap says 0)?

In other words:
What should I do to enable the AUXFANIN1 or why is the bit0 at 47 readonly.

I have ID 88 63  so it seems it is version C


Thank you very much.
Regards
Rudolf

