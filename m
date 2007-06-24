From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 10:06:38 +0000
Subject: Re: [lm-sensors] read/write access to SMBus on a PCIe slot
Message-Id: <20070624120638.61b707f2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <467BCC5A.1000905@gsi.de>
In-Reply-To: <467BCC5A.1000905@gsi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Walter,

On Fri, 22 Jun 2007 15:19:22 +0200, Walter F.J. Mueller wrote:
> we are currently developing a custom PCIe card, based on Virtex-4 FX FPGA's.
> Since PCIe slots have a SMBus connection, it would be very convenient to use
> the SMBus as auxiliary connectivity, e.g. for firmware updates. This would
> require the ability to read from and well write to such a SMBus target
> implemented on a PCIe card.
> 
> That goes clearly beyond reading sensors, thus the question: is such
> a functionality implementable based on what the i2c and lm-sensor
> framework provides ? Any hint is very welcome.

This is so beyond reading sensors, that it's not exactly the right list
to ask your question. Please post your question to the i2c list instead:
http://lists.lm-sensors.org/mailman/listinfo/i2c

Don't forget to mention which kernel you'll be using.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
