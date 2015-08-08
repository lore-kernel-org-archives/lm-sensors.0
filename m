From: Pavel Machek <pavel@ucw.cz>
Date: Sat, 08 Aug 2015 21:50:35 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] rtc: bq32k: move binding docs to proper place
Message-Id: <20150808215035.GB17085@amd>
List-Id: <lm-sensors.vger.kernel.org>
References: <1439058636-3082-1-git-send-email-wsa@the-dreams.de>
 <1439058636-3082-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439058636-3082-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jason Cooper <jason@lakedameon.net>

On Sat 2015-08-08 20:30:33, Wolfram Sang wrote:
> The I2C dir is not for I2C client devices! Move it to the proper folder.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Pavel Machek <pavel@denx.de>

> diff --git a/Documentation/devicetree/bindings/i2c/ti,bq32k.txt b/Documentation/devicetree/bindings/rtc/ti,bq32k.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/i2c/ti,bq32k.txt
> rename to Documentation/devicetree/bindings/rtc/ti,bq32k.txt

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
