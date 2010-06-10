From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Jun 2010 08:29:03 +0000
Subject: Re: [lm-sensors] Fintek F71889ED is unsupported (hack patch
Message-Id: <20100610102903.2cadb116@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTikzgi3flngEea2GeiEtAwdfRDdPaMtDq_zb6jD7@mail.gmail.com>
In-Reply-To: <AANLkTikzgi3flngEea2GeiEtAwdfRDdPaMtDq_zb6jD7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

On Thu, 10 Jun 2010 10:24:12 +0200, Hans de Goede wrote:
> Well first fo all we will need a datasheet, yes really. The fintek
> chips are quite complex when it comes to there fan control parts
> and there then to be subtile differences between all the different
> versions, see all the special handling for various revisions already
> present in the driver.
> 
> Luckily Fintek usually provides datasheet to the public. But they tend
> to lag a bit between devices showing up in the market and actually
> publishing a datasheet. They don't want to put the sheet up till it
> is "final" (or so I think), where as products are already being sold
> in the market with the chip in them (presumably made with the use of
> non final datasheets).
> 
> So the thing to do is to keep an eye on:
> http://www.fintek.com.tw/eng/products.asp?BID=1&SID
> 
> And when a datasheet shows up there drop me a mail and I'll extend
> the driver and then ask you to test it.

Hans, you may also try asking our Fintek contact directly. They have
always been very kind to me, providing datasheet previews without
signing a formal NDA, under my promise to not share the document (which
I have always honored of course.)

Meanwhile, I would appreciate if you could update wiki/Devices with the
information we have for now (chip exists and we received one support
request.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
