From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Dec 2013 11:31:24 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (s3c) Trivial cleanup in hwmon-s3c.h
Message-Id: <20131227113124.GA12382@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1388124613-22407-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1388124613-22407-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 27, 2013 at 11:40:13AM +0530, Sachin Kamat wrote:
> Commit 436d42c61c3e ("ARM: samsung: move platform_data definitions")
> moved the file to the current location but forgot to remove the pointer
> to its previous location. Clean it up. While at it also change the header
> file protection macros appropriately.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied to hwmon-next

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
