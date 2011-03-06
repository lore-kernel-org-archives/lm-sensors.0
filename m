From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 06 Mar 2011 20:05:45 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan RPM
Message-Id: <20110306200545.GA10820@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ian,

On Sun, Mar 06, 2011 at 02:40:30PM -0500, Ian Dobson wrote:
[ ... ]
> 
> I've put out a request to the other people I know of who are using your 
> standalone driver (with my de-bounce patch) to test it and let me know how 
> they get along.
> 
Great!

> I'd rather wait abit with my de-bounce patch, I'd rather get the driver into 
> .39 and then look at adding changes. You've done alot of work on this driver 
> and it would be a shame if it doesn't make it into the next merge window.
> 
That is not really a problem. If you submit it, I'll be happy to review it and
sign it off. I could theoretically just push the rest of the patches as well,
but I don't like to do that without someone else at having a look.
Not that I don't trust my code, but I know that I am not perfect, and something
might have slipped by. Better safe than sorry.

> I'll do a full code review tomorrow but as you've already covered the 
> comments I've had I don't think I'll find anything new, you already have my 
> tested-by:
> 
Sounds good.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
