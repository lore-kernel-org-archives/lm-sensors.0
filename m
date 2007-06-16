From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sat, 16 Jun 2007 03:35:58 +0000
Subject: Re: [lm-sensors] VT8231 patch to convert to platform driver
Message-Id: <20070616033558.GB3257@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c7ac72$9c6c7030$8001a8c0@wolverine>
In-Reply-To: <000f01c7ac72$9c6c7030$8001a8c0@wolverine>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-06-12 21:04:08 +0200]:
> Hi Roger,
> 
> On Mon, 11 Jun 2007 22:51:05 +0100, Roger Lucas wrote:
> > Attached is the vt8231 patch against the latest stable kernel (2.6.21.5).
> > 
> > It works on my VIA Epia motherboard under the 2.6.16.20 kernel.  It
> > has the release resource problem mentioned in the earlier mail but this
> > should be resolved with your patch (although I haven't updated to the
> > latest kernel and applied your patch to explicitly test this).
> 
> Excellent work, it was almost perfect! I simply updated the dependencies
> in Kconfig, fixed one use of s_bridge before it was defined, and fixed
> indentation at places to make the patch smaller. Here is the version I
> came up with. Mark, please apply. Roger, please test again just in case
> - but I changed so little from your patch that I could hardly have
> broken anything.
> 
> * * * * *
> 
> From: Roger Lucas <roger@planbit.co.uk>
> Subject: hwmon/vt8231: Convert to a platform driver
> 
> Convert the vt8231 driver from the nonsensical i2c-isa hack to a
> regular platform driver.
> 
> Signed-off-by: Roger Lucas <roger@planbit.co.uk>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Applied to testing.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
