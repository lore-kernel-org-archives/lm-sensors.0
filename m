From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Mar 2007 15:51:47 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] lm-sensors: add dme1737 support
Message-Id: <20070327175147.ee6f7536.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703261746s586b6c85t2a6aa27423c74e6d@mail.gmail.com>
In-Reply-To: <191fb4ca0703261746s586b6c85t2a6aa27423c74e6d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Mar 2007 08:35:13 -0700, Juerg Haefliger wrote:
> Yes, 0x73 is the one I wanted. My datasheet is at rev 0.4

I have rev 0.2.

> If you don't feel comfortable with the new registers I don't have a
> problem going back to the original register set. I just thought
> something a little bit more unique and meaningful makes sense.

I don't care either way as long as you know what you're doing. We can
always change it in the future if problems arise. So I've applied your
patch.

About the Asus A8000, will it be detected as an SMSC DME1737 with the
current code in sensors-detect? Or do we need dedicated detection?

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012777.html

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
