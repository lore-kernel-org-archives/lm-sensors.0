From: Rudolf Marek <r.marek@assembler.cz>
Date: Tue, 17 Apr 2007 16:24:57 +0000
Subject: Re: [lm-sensors] [PATCH] k8temp - Add the diode offset to reported
Message-Id: <4624F4D9.20908@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1176736441.14094.31.camel@ustr-shaha1-linux2.na.uis.unisys.com>
In-Reply-To: <1176736441.14094.31.camel@ustr-shaha1-linux2.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Amul Shah wrote:
> This patch adds support to include the CPU diode sensor offset when
> reporting CPU temperature.
> 
> Please see http://www.lm-sensors.org/ticket/2200 for the full problem
> description.

Well I dont think this is correct. I believe that diode offset register is
related to analog diode output not the digital sensor. Also I know that AMD is
using my driver and did not make any changes. This leads me to a conclusion that
the sensor simply does not work correctly and this error might be only
compensated for analog part and not the digital. IIRC in some errata AMD states
that the digital temperature sensor might be wrong and urges users to use the
analog output.

What do you think?

Thanks,

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
