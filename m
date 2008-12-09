From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Dec 2008 20:33:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Fix various typos
Message-Id: <20081209213349.09dfbf81@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081209163734.683475cf@hyperion.delvare>
In-Reply-To: <20081209163734.683475cf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Tue, 9 Dec 2008 13:01:03 -0700, David Hubbard wrote:
> ack both patches (ACPI resources and typo fixes)
> 
> Signed-off-by: David Hubbard <david.c.hubbard@gmail.com>

Actually these are Acked-by, as the patch didn't transit through you.
But thanks anyway :)

> P.S. I have found a bug in the way the init code in w83627ehf puts the
> base address into the data structure, so it ends up accessing the
> device at 0x290 when it should be 0x295. I'll send out a patch in a
> few days.

OK, I'll test and review it when you do.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
