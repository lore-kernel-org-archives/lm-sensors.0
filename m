From: Clemens Ladisch <clemens@ladisch.de>
Date: Fri, 18 Feb 2011 12:29:06 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of AMD
Message-Id: <4D5E6612.3040503@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> [...]
> That being said, I'm a little curious about a couple things. Why
> PCI_DEVICE_ID_AMD_CNB17H_F3 and PCI device ID 0x1703 if the supported
> CPUs are family 12h and 14h (and not 17h)?

This is what AMD calls it: <http://git.kernel.org/linus/ca86828ccd31>.

There is no fixed relation between PCI IDs and family numbers.  I'd
guess this symbol is named differently because there is no single
family; "CNB" probably stands for "common northbridge".

> What about PCI_DEVICE_ID_AMD_15H_NB_MISC (PCI device ID 0x1603)? No
> thermal sensors here?

If I had to guess, I'd assume that it uses the same sensor.  However,
AMD hasn't yet published documentation for the Bulldozer family.

> How comes that PCI_DEVICE_ID_AMD_15H_NB_MISC is listed in
> arch/x86/kernel/amd_nb.c but PCI_DEVICE_ID_AMD_CNB17H_F3 is not?

The file name seems to be misleading; that code actually manages only
the L3 cache and the GART, and family 12h/14h CPUs have neither.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
