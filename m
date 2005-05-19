From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: DS1621 support for kernel 2.6
Message-Id: <20040303231619.0e8ddda6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040303211301.GA19859@pc.aurel32.private>
In-Reply-To: <20040303211301.GA19859@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aurelien :)

> I have ported the ds1621 driver from lm-sensors 2.8.4 to kernel 2.6.3.

Good news :)

Have you been following the porting-chips and sysfs-interface documents?

> I have such a chip at home and I have made some tests, everything
> works fine. Please find attached a patch against kernel 2.6.3 (it
> should also works with 2.6.4-rc* kernels, I suppose).

Yes it should. 2.6.3 and 2.6.4 will be mostly similar, i2c-wise.

> What it the way to get it merge? Should I send the patch directly to
> Linus?

No. You send it to us (you got it right :)) and we'll discuss it on the
list. Once ready we'll send it to Greg, who'll merge it into his trees.
Then it'll move into Andrew Morton's tree for testing. Once tested it
goes to Linus'. Quite a long trip, isn't it? ;)

> I also plan to port the pcf8574 and pcf8591 drivers over the
> week-end.

Probably not the most wanted chips ;) but it you have a particular
interest for these, do not hesitate.

I'll review your code over the week-end if nodoby has done so before.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
