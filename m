From: Chris Verges <kg4ysn@gmail.com>
Date: Sat, 22 Dec 2012 01:37:38 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] lm73: detect i2c bus errors before scnprintf()
Message-Id: <CAG4_upQDg=nzEof0GO7rAu+CbSrRtUbYBaGC1SdmHjFD-Z6tjQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356083914-17579-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356083914-17579-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 21, 2012 at 5:30 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Just wondering - how comes the detect function did not report the error ?
>

Excellent question.  I didn't debug into this any further, but it is a good
area for additional investigation.

Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
