From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: Error messages on ignored values
Message-Id: <20050204203738.7bcc9965.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050204053725.34834.qmail@web60504.mail.yahoo.com>
In-Reply-To: <20050204053725.34834.qmail@web60504.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

Quoting myself:
> I'll apply your patch, thanks.

On second thought, I think that the patch could be improved a bit:

1* You hide SENSORS_ERR_PROC errors for all channels, but I guess only
some of them can actually be missing with the 2.6 driver?

2* You return the exact same error message for the two possible causes
of failure (sensors_get_label_and_valid failing and sensors_get_feature
failing). Now that you separated the "if" statements, it would be better
to have different error messages.

Care to send an updated patch?

Thanks,
-- 
Jean Delvare
