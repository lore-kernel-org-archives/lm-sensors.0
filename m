From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Jun 2008 08:13:10 +0000
Subject: Re: [lm-sensors] [PATCH v3 0/2] hwmon: (lm90) Enhancements for
Message-Id: <20080625101310.58826d9a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1214340546-18208-1-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1214340546-18208-1-git-send-email-ncase@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nate,

On Tue, 24 Jun 2008 15:49:04 -0500, Nate Case wrote:
> This is the third revision of this patch which converts the conversion
> macros into functions and adds support for extended temperature ranges
> on the ADT7461.
> 
> Changes from v2:
> - Use int instead of long for tempX_from_* functions and use %d instead
>   of %ld for the relevant sprintf() statements to get rid of compiler
>   warning.

Very great, thanks for your work and patience going through the
iterations. I'm happy with your patches now. I'll adjust them so that
they apply cleanly on top of my own pending patches to the lm90 driver,
then I'll submit a new batch to the lm-sensors list for Mark to
consider. It would be great if you could take the time to test and/or
review my patches to speed up the process.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
