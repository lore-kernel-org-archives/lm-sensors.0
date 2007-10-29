From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 29 Oct 2007 21:23:44 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <47264F60.5070100@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It depends what methods are called. Imho if you remove the "thermal" support 
> from the ACPI it should be ok. If someone gives me the table, I can take a look.

Also standard ACPI fan support driver should not be loaded.

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
