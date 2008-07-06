From: Ben Hutchings <bhutchings@solarflare.com>
Date: Sun, 06 Jul 2008 12:21:56 +0000
Subject: Re: [lm-sensors] [PATCH 0/3] lm87 changes for Solarflare NICs [2nd
Message-Id: <20080706122155.GA28029@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080609110604.GX11300@solarflare.com>
In-Reply-To: <20080609110604.GX11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
[...]
> I have been delaying the review of these patches because I am working
> in parallel on a better way to handle both legacy i2c clients and
> new-style ones in the same driver. This would basically obsolete your
> first patch in this series. I'd rather get this ready in time to be
> merged in 2.6.26-rc1, for the lm87 driver and all other hwmon drivers
> alike, and then I will have more time to look into the other patches
> you sent.

OK, thanks.  How about max664x?

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
