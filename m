From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Jul 2011 07:14:13 +0000
Subject: Re: [lm-sensors] sensor details for W83627HG-AW
Message-Id: <20110703091413.72a6662d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <838315.8004.qm@web95806.mail.in.yahoo.com>
In-Reply-To: <838315.8004.qm@web95806.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krunal,

On Sat, 2 Jul 2011 16:11:45 +0530 (IST), krunal patel wrote:
> --- On Thu, 30/6/11, Jean Delvare <khali@linux-fr.org> wrote:
> > Can you please report the messages in the kernel log when
> > you load both drivers?
>
> dmesg output:
> --------------
> Using 6-bit VID table for VIA C7-D CPU

Hmm, are you sure this is with the latest version of the drivers? The
above is what the previous version would have printed. The new version
should mention Eden instead of C7-D.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
