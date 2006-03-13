From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 13 Mar 2006 20:27:55 +0000
Subject: [lm-sensors] [PATCH] Add ATI smbus to PIIX4
Message-Id: <4415D5CB.1010506@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4413E4B5.7010202@sh.cvut.cz>
In-Reply-To: <4413E4B5.7010202@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Compiles fine, but I'd have the following comments:
Good.

> "N/A" usually stands for "not applicable", which isn't relevant here;
> "Not publicly available" would be better.

I always thought it is not avail...

> 
> 
>>--- c-fixhstcfg/drivers/i2c/busses/Kconfig	2006-03-11 21:33:37.000000000 +0100
>>+++ d-add-ati/drivers/i2c/busses/Kconfig	2006-03-11 22:18:39.728756000 +0100
>>(...)
>>-	tristate "Intel PIIX4"
>>+	tristate "Intel PIIX4/ATI/Serverworks/Broadcom"
> 
> 
> This formulation is a bit confusing, as it suggests that ATI,
> Serverwords and Broadcom are chips made by Intel ;) I'd go for "Intel
> PIIX4 and compatible".

Fixed

> 
> 
>> 	  If you say yes to this option, support will be included for the Intel
>> 	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
>>-	  versions of the chipset are supported (note that Serverworks is part
>>-	  of Broadcom):
>>+	  versions of the chipset are supported:
>> 	    Intel PIIX4
>> 	    Intel 440MX
>>+	    ATI IXP200
>>+	    ATI IXP300
>>+	    ATI IXP400
>>+	    Broadcom HT-1000
>> 	    Serverworks OSB4
>> 	    Serverworks CSB5
>> 	    Serverworks CSB6
>>-	    Serverworks HT-1000
>> 	    SMSC Victory66
> 
> 
> Please back out the Serverworks vs. Broadcom changes. Not only I don't
> see them as useful, but more importantly they don't belong to that
> patch.

OK, I thought bit tidy up can be done...

> Otherwise the patch has all I wanted, thanks, good job.

Tnx ;)

This patch adds the ATI IXP southbridges support to i2c-piix4,
as it turned out those chips are compatible with it.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>

Regards,
Rudolf
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: piix4_add_ati2
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060313/2f60ea06/piix4_add_ati2.pl
