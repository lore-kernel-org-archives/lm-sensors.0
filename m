From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 14 Oct 2007 00:53:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627hf) don't assume bank 0
Message-Id: <20071014005312.GA9586@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071010163023.5b9f87e8@hyperion.delvare>
In-Reply-To: <20071010163023.5b9f87e8@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-10-10 16:30:23 +0200]:
> The bank switching code assumes that the bank selector is set to 0
> when the driver is loaded. This might not be the case. This is exactly
> the same bug as was fixed in the w83627ehf driver two months ago:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h	56895aa6f8dc6a33210967252fd7787652537d
> 
> In practice, this bug was causing the sensor thermal types to be
> improperly reported for my W83627THF the first time I was loading the
> w83627hf driver. From the driver history, I'd say that it has been
> broken since September 2005 (when we stopped resetting the chip by
> default at driver load.)
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/w83627hf.c |   44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
