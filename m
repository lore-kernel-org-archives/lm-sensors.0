From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 10 Dec 2007 13:43:13 +0000
Subject: Re: [lm-sensors] Intel Core voltage monitoring
Message-Id: <475D4271.2050906@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <475BDA45.70400@googlemail.com>
In-Reply-To: <475BDA45.70400@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

IMHO the CPU-Z reads the VID code from CPU, so the voltage is not the real 
voltage, but the voltage that the CPU wants (not what it is actually getting).

The driver could be extended to show the voltage, but that would not be a real 
voltage, but just voltage it wants... Don't know if it is benefit for user?

What others think?

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
