From: Gabriel C <crazy@frugalware.org>
Date: Sun, 27 Apr 2008 16:25:46 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <4814A90A.6010502@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Hi,
> 
> I'm CCing Trousers people maybe they can help.
> 
> Well it seems you have trusted platform module at 0x4e/0x4f. The manufacturer 
> seems to be Infineon. Infineon 9635 TT. The sensors-detect script misdetect that 
> as SMSC superio.

Right , I have TPM chip.

> 
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x0b00
> 
> http://www.tranzistoare.ro/datasheets/480/339084_DS.pdf
> 
> Question is what now? Quick search did not bring any docs. If someone here has 
> more time to investigate if 0x4e/0x4f port is common for TPM modules...
> 
> Please can anyone point me to relevant docs where are the registers of TPM 
> described? So we can fix this mis-detection.

Also I've enabled TPM in BIOS and the kernel modules , here the output ( maybe it helps ) :


[    9.587609] tpm_inf_pnp 00:0e: TPM found: config base 0x4e, data base 0x4700, chip version 0x000b, vendor id 0x15d1 (Infineon), product id 0x000b (SLB 9635 TT 1.2)


> 
> Thanks,
> Rudolf
> 

Gabriel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
