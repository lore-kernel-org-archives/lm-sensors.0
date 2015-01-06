From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 06 Jan 2015 17:53:10 +0000
Subject: Re: [lm-sensors] hwmon: nct7802: Constify struct regmap_config
Message-Id: <20150106175310.GA32181@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420448275-8154-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1420448275-8154-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, Jan 05, 2015 at 09:57:55AM +0100, Krzysztof Kozlowski wrote:
> The regmap_config struct may be const because it is not modified by the
> driver and regmap_init() accepts pointer to const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
