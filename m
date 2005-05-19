From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: toshiba smbus
Message-Id: <20050207225828.71d2965a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4207E124.5050801@rit.edu>
In-Reply-To: <4207E124.5050801@rit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ryan,

> Hi I have a Toshiba Sattelite 5105-S901, and I noticed that the SMBus 
> does not show up when I look at the output of lspic. I created a
> little  half a$$ patch to the 2.6 kernel which plays off of the Asus
> quirk. I  didnt want to change a lot of code but I was wondering a
> permenent fix  could get its way into the kernel.
>
> 0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
> Subsystem: Toshiba America Info Systems: Unknown device 0001
> Flags: medium devsel, IRQ 255
> I/O ports at ef00 [size2]
> 
> --- quirks_orig.c 2005-01-18 12:38:23.094768000 -0500
> +++ quirks.c 2005-01-18 12:37:29.364768000 -0500
> @@ -759,6 +759,12 @@
> case 0x186a: /* M6Ne notebook */
> asus_hides_smbus = 1;
> }
> + } else if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_TOSHIBA)) {
> + if (dev->device = PCI_DEVICE_ID_INTEL_82845_HB)
> + switch (dev->subsystem_device) {
> + case 0x0001: /* Toshiba */
> + asus_hides_smbus = 1;
> + }
> } else if (unlikely(dev->subsystem_vendor = PCI_VENDOR_ID_HP)) {
> if (dev->device = PCI_DEVICE_ID_INTEL_82855PM_HB)
> switch(dev->subsystem_device) {

Looks fine to me. Let alone the fact that your e-mail client destroyed
the indentation, of course. I'm sure that Greg would enjoy such a patch,
were it sent with a nice descriptive header, a "Signed-off-by" line and
proper indentation.

Thanks,
-- 
Jean Delvare
