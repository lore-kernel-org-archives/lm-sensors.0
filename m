From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 21 May 2013 00:46:24 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon (ds1621): Remove detection function
Message-Id: <20130521004624.GA9873@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1369096169-29321-1-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1369096169-29321-1-git-send-email-rob.coulson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 20, 2013 at 05:29:29PM -0700, Robert Coulson wrote:
> v2:
> - removed detect function references in ds1621 documentation
> - replaced deprecated with removed and fixed a spelling error
> 
> Due to a lack of device and vendor identification registers, the
> Dallas/Maxim DS16xx devices cannot be uniquely detected, sometimes
> resulting in false positives. Therefore, the detection function is
> being removed in favor of explicit device instantiation.
> 
> These changes are based on the 3.9 source base and intended for
> hwmon-next.
> 
> Signed-off-by: Robert Coulson <rob.coulson@gmail.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
