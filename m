From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 20 May 2006 14:24:17 +0000
Subject: [lm-sensors] new chip request: SMSC DME1737
Message-Id: <446F2691.5050602@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1147884805.12397.145.camel@starfire>
In-Reply-To: <1147884805.12397.145.camel@starfire>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alex Izvorski wrote:
> Hello,
> 
> I have a board with an unsupported chip, any chance to add it?

Hardly without a datasheet.

> The board is Tyan Tomcat K8E-SLI S2866 (Tyan S2865 has the same chip).
> The chip is the SMSC DME1737 (according to Tyan).  It shows up at i2c
> bus 1, address 0x2e.  Using  "modprobe lm85 force_emc6d102=1,0x2e" most
> data may be read from it - voltages, fans and temperatures - I'm not
> sure it is scaled correctly and the limits are definitely not set
> correctly, but aside from that it's there.  It almost seems that we can
> treat this as a emc6d102 clone, if only we could auto-detect it?


Lets wait for the datasheet.


> http://pdf1.alldatasheet.com/datasheet-pdf/view/86009/SMSC/DME1737/datasheet.pdf
> 
> I am trying to obtain a more complete datasheet from SMSC.

Any news on that?

Regards
Rudolf

