From: Rudolf Marek <r.marek@assembler.cz>
Date: Sun, 27 Apr 2008 12:35:34 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <48147316.4040209@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm CCing Trousers people maybe they can help.

Well it seems you have trusted platform module at 0x4e/0x4f. The manufacturer 
seems to be Infineon. Infineon 9635 TT. The sensors-detect script misdetect that 
as SMSC superio.

Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x0b00

http://www.tranzistoare.ro/datasheets/480/339084_DS.pdf

Question is what now? Quick search did not bring any docs. If someone here has 
more time to investigate if 0x4e/0x4f port is common for TPM modules...

Please can anyone point me to relevant docs where are the registers of TPM 
described? So we can fix this mis-detection.

Thanks,
Rudolf




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
