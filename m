From: Chris Verges <kg4ysn@gmail.com>
Date: Mon, 24 Dec 2012 08:13:48 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] lm73: added 'update_interval' attribute
Message-Id: <CAG4_upR+=Tvt1mfCnCtjzGXA+pP8hjXL+E5tL7wMCY6KfUbugg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356336669-18722-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356336669-18722-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 24, 2012 at 12:11 AM, Chris Verges <kg4ysn@gmail.com> wrote:
> The LM73 supports four A/D conversion resolutions.  The default used
> by the existing lm73 driver is the chip's default, 11-bit (0.25
> C/LSB).  This patch enables changing of this resolution from userspace
> via the temp1_update_interval attribute.

In fair warning, I've compiled this,  but have not yet tested it on a
live lm73.  My hope is to solicit feedback on the general strategy used
here before spending too much time fixing the details.

Thanks,
Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
