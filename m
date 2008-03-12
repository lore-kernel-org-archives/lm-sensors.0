From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Mar 2008 11:13:24 +0000
Subject: Re: [lm-sensors] serious w83627ehf problem stopping cpu fan
Message-Id: <20080312121324.401f643d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080312011430.GA20751@alf.mars>
In-Reply-To: <20080312011430.GA20751@alf.mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Helmut,

On Wed, 12 Mar 2008 11:52:18 +0100, Helmut Grohne wrote:
> Unfortunately there is no /proc/acpi/dsdt on my system. Can you tell me
> what is missing? A kernel option?

Recent kernel export it as /sys/firmware/acpi/tables/DSDT instead.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
