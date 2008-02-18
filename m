From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Feb 2008 21:41:11 +0000
Subject: Re: [lm-sensors] Preparing patches for pca9552, ad5259, and bq27350
Message-Id: <20080218224111.2703ebbd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <FD2217BC-9A9C-4CFE-843F-15F1600B4CCE@codetastic.com>
In-Reply-To: <FD2217BC-9A9C-4CFE-843F-15F1600B4CCE@codetastic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matthew,

On Mon, 18 Feb 2008 13:26:10 -0800, Matthew Bosworth wrote:
>    The BQ27350 is a battery monitor for Li-ion batteries, does that  
> count?  I'll send mail to the i2c list about the other two.

Does it implement any part of the standard hwmon interface? If not,
then it can't be considered a hwmon driver. FWIW, we do not have any
battery monitor driver in drivers/hwmon yet, and I am under the
impression that your driver would rather belong to drivers/power.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
