From: Mark Nienberg <gmane@tippingmar.com>
Date: Mon, 05 Jan 2009 22:10:26 +0000
Subject: Re: [lm-sensors] Asus KFN4-DRE board
Message-Id: <gju0gj$r3e$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <gjtlg7$htb$1@ger.gmane.org>
In-Reply-To: <gjtlg7$htb$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Luca Tettamanti wrote:

> I'd like to see whether the board supports the ATK ACPI interface or not.

I sent the DSDT to Luca off list but "unfortunately there's no trace of the ATK 
interface".

So I'm still looking for a temperature solution.  Is it safe to assume that since 
Temp2 and Temp3 have the same limits then they must be the two CPU temps?  I did not 
set any temperature limits in the "sensors.conf" file.

Thanks,

Mark


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
