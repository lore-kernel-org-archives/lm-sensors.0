From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: [Fwd: Tellerstats, Computer Hardware Statistics]
Message-Id: <20050213114712.7ff77f78.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42095E95.9000307@edgedesign.us>
In-Reply-To: <42095E95.9000307@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Morgan,

> I'm a bit of a novice, but I've got your tellerstats giving me some
> nice pic's for my temps (mc1066 chip).
> 
> Can you give me a quick pointer to where I need to make changes to get
> tellerstats to give me plots updated every few seconds instead of
> 5mins, and over perhaps a 1hr period rather than 48hrs?

[Preliminary note: I didn't write tellerstats, I don't even use it.
Replying on Phil's request because he is busy at work these days. So my
reply is solely based on my understanding of how the thing is supposed
to work after a quick look at the code.]

The data gathering being cron-based, you will not be able cannot update
it every few seconds. The best you can do is every 1 minute. This would
mean replacing this crontab line:

*/5 * * * * root /usr/local/install/tellerstats/gather.sh

by this one:

*/1 * * * * root /usr/local/install/tellerstats/gather.sh

That said I think it isn't recommended to run cron jobs with such a
"high" frequency. Cron isn't exactly meant for this. You might
experience problems (such as an increased server load or updates being
missed). If you do, try lowering the frequency to */2 or */3.

The 48 hours period is determined by the number of points. In
tellerstats.sh, you'll find this:

for this in $files
do
   tail $this -n576 > ${this}.tmp
   mv ${this}.tmp $this
done

576 * 5 minutes = 48 hours.

So if you want a 1 hour period with 1 minute update, that would become
-n60. You might then want to edit the image size (CONVERT_OPTS_A and
CONVERT_OPTS_B at the bottom of tellerstats.sh, and in index.html).

Hope that helps,
-- 
Jean Delvare
