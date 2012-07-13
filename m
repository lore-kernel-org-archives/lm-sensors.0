From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Jul 2012 15:01:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: s3c-hwmon: Use devm_kzalloc instead of kzalloc
Message-Id: <20120713150117.GA9833@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1342170388-5682-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1342170388-5682-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jul 13, 2012 at 02:36:28PM +0530, Sachin Kamat wrote:
> This makes the code simpler as explicit freeing is not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---

Applied to -next (and dropped my own patch).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
