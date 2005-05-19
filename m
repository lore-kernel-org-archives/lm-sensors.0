From: mstuff@pl.net (Morgan Read)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: [Fwd: Tellerstats, Computer Hardware Statistics]
Message-Id: <421002F0.1040000@pl.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <42095E95.9000307@edgedesign.us>
In-Reply-To: <42095E95.9000307@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
Thanks very much for getting back.  I had begun to figure that I might 
not be using the right tool for the job, but what you suggest seems 
pretty straight forward so I'll give it ago.  Also, thought the round 
robin tool might be more useful/adaptable - but then again, may be using 
a sledge hammer to crack a nut?

Basically, I have a laptop with the mc1066 chip in that seems to be 
doing _very_ strange things at start up.  I've set up the mc1066 part of 
sensors.conf so:

    label temp 		"Board"
    label remote_temp	"CPU"
#   set temp_low		40
#   set temp_over		70
#   set remote_temp_low		40
#   set remote_temp_over	70
###Changed 7/2/05 by morgan
    set temp_low			40
    set temp_over		54
    set remote_temp_low		55
    set remote_temp_over		69

Boot starts; fan off; fan slow; fan off; boot ends.  I log in, sensors 
reports settings as above, cpu temp climbs to 69, fan cuts in, the 
values reset to: cpu high 127 (!!!); cpu low 55; board high 55; board 
low -55 (!!!).  Then, cpu temp drops to (perhaps) 54, fan stops, the 
values reset to: cpu high 70 (?); cpu low -55 (!!!); board high 55; 
board low -55 (!!!).

The cpu temp climbs to 70, the fan cuts in and then things seem to 
stabilise around cpu 57-62.

Or something like that!  Mad?

So, I'm trying to work out what on earth's going on?

Thanks again,
Regards,
Morgan.

Jean Delvare wrote:
> Hi Morgan,
> 
> 
>>I'm a bit of a novice, but I've got your tellerstats giving me some
>>nice pic's for my temps (mc1066 chip).
>>
>>Can you give me a quick pointer to where I need to make changes to get
>>tellerstats to give me plots updated every few seconds instead of
>>5mins, and over perhaps a 1hr period rather than 48hrs?
> 
> 
> [Preliminary note: I didn't write tellerstats, I don't even use it.
> Replying on Phil's request because he is busy at work these days. So my
> reply is solely based on my understanding of how the thing is supposed
> to work after a quick look at the code.]
> 
> The data gathering being cron-based, you will not be able cannot update
> it every few seconds. The best you can do is every 1 minute. This would
> mean replacing this crontab line:
> 
> */5 * * * * root /usr/local/install/tellerstats/gather.sh
> 
> by this one:
> 
> */1 * * * * root /usr/local/install/tellerstats/gather.sh
> 
> That said I think it isn't recommended to run cron jobs with such a
> "high" frequency. Cron isn't exactly meant for this. You might
> experience problems (such as an increased server load or updates being
> missed). If you do, try lowering the frequency to */2 or */3.
> 
> The 48 hours period is determined by the number of points. In
> tellerstats.sh, you'll find this:
> 
> for this in $files
> do
>    tail $this -n576 > ${this}.tmp
>    mv ${this}.tmp $this
> done
> 
> 576 * 5 minutes = 48 hours.
> 
> So if you want a 1 hour period with 1 minute update, that would become
> -n60. You might then want to edit the image size (CONVERT_OPTS_A and
> CONVERT_OPTS_B at the bottom of tellerstats.sh, and in index.html).
> 
> Hope that helps,

-- 
Morgan Read
<mailto:mstuffATplDOTnet>
