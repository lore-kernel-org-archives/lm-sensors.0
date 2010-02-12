From: <samu.p.onkalo@nokia.com>
Date: Fri, 12 Feb 2010 09:56:14 +0000
Subject: Re: [lm-sensors] [PATCH 0/6] lis3lv02d: Power management,
Message-Id: <62697B07E9803846BC582181BD6FB6B82661C50472@NOK-EUMSG-02.mgdnok.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1265271848-26559-1-git-send-email-samu.p.onkalo@nokia.com>
	<4B7457D0.4080507@tremplin-utc.net>
 <62697B07E9803846BC582181BD6FB6B82661C5029E@NOK-EUMSG-02.mgdnok.nokia.com>
In-Reply-To: <62697B07E9803846BC582181BD6FB6B82661C5029E@NOK-EUMSG-02.mgdnok.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel@tremplin-utc.net
Cc: linux-kernel@vger.kernel.org, daniel@caiaq.de, pavel@ucw.cz, lm-sensors@lm-sensors.org


>>Hello,
>>Sorry, I haven't had time to fully review the patches. Nevertheless,
>>I've tested them on my HP laptop with a 12bit device, and can confirm
>>it's all fine.
>>
>>The only hiccup is in patch 6: it declares the joystick with 3 buttons,
>>although on this hardware it's impossible to have this feature. So, it
>>would be nice if input_set_capability() could be conditionned.
>
>I'll add configuration option to platform data or do you prefer some
>other
>way to enable this?
>

You obviously meant that enable those only for 8 bit device, since
12 bit doesn't have click detection. I can do that.

-Samu



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
