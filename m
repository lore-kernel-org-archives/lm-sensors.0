From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Jun 2011 09:32:27 +0000
Subject: Re: [lm-sensors] sensors doesn't show my fans,
Message-Id: <20110621113227.1bc8a378@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110621102050.59dbd8dc@endymion.delvare>
In-Reply-To: <20110621102050.59dbd8dc@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

Please always keep discussions on the mailing list. Others may be
interested and/or have ideas.

On Tue, 21 Jun 2011 12:15:18 +0300, Mark Bloch wrote:
> I'll try to email HP, I don't think they'll help much.

You're probably right, but sometimes we have good surprises, and the
sole fact of asking may help them realize that there is a need. This
may pay over time, if not now.

> I think the Super-I/O chip is :
> http://www.plxtech.com/products/expresslane/pex8518

This would be surprising, as in general Super-I/O chips have nothing to
do with PCI. But maybe that chip is simply following the LPC
specification (which almost all Super-I/O chips follow) and is thus
seen by sensors-detect as a Super-I/O chips even if it is not actually
a Super-I/O chip.

Anyway, if it's really a PEX8518 then this is of no interest to us.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
