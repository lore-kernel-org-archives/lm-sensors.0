From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 21 Jul 2006 06:10:24 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44C06FD0.1050006@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sunil Kumar wrote:
> sent too soon. I wanted to mention that the frequency of messages has
> reduced by manyfolds after this patch.
> 

I've sightly reduced the ABIT_UGURU_READY_TIMEOUT because we are
sleeping now. You decreased it from 50 to 30, I went with 25. Can you
try the driver for a couple of days with this set back to 50 and then
see if it still happens?

Thanks & Regards,

Hans

