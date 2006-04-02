From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 02 Apr 2006 11:48:55 +0000
Subject: [lm-sensors] [PATCH] remove the fix_hstcfg from i2c-piix4
Message-Id: <442FBA27.3080005@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <442F00B8.6010507@sh.cvut.cz>
In-Reply-To: <442F00B8.6010507@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean
>>+If you have some rather strange SMBus problems, you may need to change the
>>+SMBus Interrupt Select register as it is known solution for Force CPCI735
>>+motherboard or other OSB4 based systems. Please contact us for further
>>+assistance (lm-sensors at lm-sensors.org).
> 
> 
> Oh, no. We don't want more support requests on this. Instead, please
> explain how to get the register value using lspci and how to write back
> the modified value using setpci.

Well I think there will be requests like same probability that you capture your
very own neutrino :)

Anyway I will prepare the DIY guide.

> 
> Besides, are you sure that other OSB4 based systems did need this? I've
> searched all my mails, and couldn't find anyone reporting success after
> using fix_hstcfg, except Tom.
> 

The old text suggest this. All I think is that the bios left the controller in
interrupt mode and I think our driver assumes always the SMI mode.


> 
>>-	if ((temp & 0x0E) = 8)
>>+	if (((temp & 0x0E) = 8) || ((temp & 0x0E) = 2))
> 
> 
> I think I understand that 8 is OK for non-Serverworks one and 2 is OK
> for Serverworks one, right? So maybe we can improve this check and do:
> 
> if ((temp & 0x0E) = (id->vendor = PCI_VENDOR_ID_SERVERWORKS ? 2 : 8))

I thought about this but for the reason that serverworks was bought by broadcom
and we have ATI and others there so best sounds to me to make it more global.

Regards
Rudolf



