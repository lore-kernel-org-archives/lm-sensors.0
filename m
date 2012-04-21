From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 21 Apr 2012 16:19:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ad7314) Fix build warning
Message-Id: <20120421161941.GC15547@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1334936357-12432-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1334936357-12432-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 21, 2012 at 06:15:38AM -0400, Jean Delvare wrote:
> On Sat, 21 Apr 2012 09:18:35 +0200, Jean Delvare wrote:
> > The original code looks a little weird though. Some of the defined
> > constants aren't used, "offset" is used where "shift" should be.
> > Introducing function sign_extend16 would also make the code more
> > readable. I'll send a patch...
> 
> ... or not. My patch makes the binary larger, so it's pointless.
> 
And that after I saved an entire byte on x86_64 with my patch :).

Cleaning up the unused constants makes sense, though. I'll prepare a patch for -next.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
