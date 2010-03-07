From: Paul Thomas <pthomas8589@gmail.com>
Date: Sun, 07 Mar 2010 16:43:30 +0000
Subject: Re: [lm-sensors] [PATCH] V2 Driver for Texas Instruments ads7871
Message-Id: <c785bba31003070843g40f743c3l2a58aacb88c65387@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1267563932-31930-1-git-send-email-pthomas8589@gmail.com>
In-Reply-To: <1267563932-31930-1-git-send-email-pthomas8589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 2, 2010 at 2:12 PM, Paul Thomas <pthomas8589@gmail.com> wrote:
> OK, here's the new patch. It has most of the comments incorporated.
> The section I'm most unsure of is the error handling in ads7871_probe.
> In ads7871_probe, I do check that one register is written correctly
> this ensures that there is really a chip there, but I just set err to
> -1, is that OK? What should the error be for a chip that's not
> actually on the bus?
>
> thanks,
> Paul
>

I haven't heard anything in a few days. I was wondering if you guys
had seen this? Do I need to do anything else?

thanks,
Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
