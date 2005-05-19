From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: max1617a
Message-Id: <20040515135327.10fef10c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509133827.04734a7e.khali@linux-fr.org>
In-Reply-To: <20040509133827.04734a7e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>  I provide you dump of 0x4d and 0x1f.
> in a moment I try to fix sach a bagy DSDT for ACPI ... ACPI can't
> finde thermo-sensor too. 
>  Sanky werymatch , what you traing to help me :-)

What you have is not a MAX1617A, which is why sensors-detect wouldn't
detect is as such. It is a MAX1619.
http://www.maxim-ic.com/quick_view2.cfm?qv_pk 21

We don't have a driver for it yet. You may try to force the adm1021
driver, there are common registers between the MAX1617A and the MAX1619
so you may have some results (in particular temperature readings should
work).

I added support for the MAX1619 to sensors-detect, and would appreciate
if you could give it a try. It's available from our CVS repository.

If you want to write the driver yourself, the datasheet is here:
http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf
I'd suggest you start from a similar driver such as the lm90.

-- 
Jean Delvare http://khali.linux-fr.org/
