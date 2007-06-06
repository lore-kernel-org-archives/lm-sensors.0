From: "Ivo Manca" <pinkel@gmail.com>
Date: Wed, 06 Jun 2007 13:25:16 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform
Message-Id: <00dd01c7a83e$2024a660$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070603174224.44353a33@hyperion.delvare>
In-Reply-To: <20070603174224.44353a33@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oops, sorry, I indeed forgot it!


> Ivo,
> 
> Please don't forget the mailing list!
> 
> No, that should be OK.
> 
> If should show in the output of "dmesg" to start with, and indeed also
> in /var/log/messages and/or /var/log/debug.

Attached messages and dmesg. Seems like quite some things are going wrong?
 
> 
> It shouldn't, but OTOH given that the sis5595 platform driver seemingly
> wasn't registered properly, I am not surprised.
> 
> My previous patch had some error paths which didn't display any error
> nor debug message. I guess that one of these error conditions occurred
> and this is why you don't see anything in the logs. So I attached a new
> version of the patch with messages on all the error paths. Please
> revert the previous patch and apply this one instead, leaving debugging
> enabled of course. Hopefully you'll have something in the log this
> time, and from there we'll see what needs to be fixed.

Will do, will report back in an hour or so 

> Thanks,
> -- 
> Jean Delvare

Anytime,

Ivo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
