From: Ben Hutchings <bhutchings@solarflare.com>
Date: Tue, 19 Aug 2008 18:12:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm87: Fix masking of config register
Message-Id: <20080819181238.GJ7908@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080819150156.GH7908@solarflare.com>
In-Reply-To: <20080819150156.GH7908@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
[...]
> I agree that the current code is incorrect, but I disagree with your
> analysis (I don't think the 0xF7 is a typo) and the proposed fix.
> 
> First of all, checking for bit 7 (Initialization) doesn't make sense.
> This bit self-clears, so we're never going to see it set.

Right.

> Secondly, clearing bit 3 (INT#_Clear) is a good idea. According to the
> datasheet, monitoring is stopped while this bit is set, and it is set
> by default. So we really want to clear it as part of the
> initialization. Meaning that we also want to check if it is set.
> 
> So I would change the code as follows:
> 
> 	if ((config & 0x09) != 0x01) {
> 		/* Start monitoring */
> 		lm87_write_value(client, LM87_REG_CONFIG,
> 				 (config & 0x77) | 0x01);
> 	}
> 
> What do you think?

That makes sense.  Perhaps the comment should also say that we're
clearing INT#_Clear.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
