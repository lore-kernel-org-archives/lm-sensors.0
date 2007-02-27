From: pinkel@gmail.com (Ivo Manca)
Date: Tue, 27 Feb 2007 12:24:24 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <008201c75a6a$38a9bdf0$0901a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean

> Late response? You replied within 2 hours, it took me four days ;)
True; this response was quite fast. I was actually thinking about the first 
post of yours and my first response in general ;)

> In this case the correct term would be "local", not "internal".
How obvious; you're right.

> I think it is. There's nothing wrong with fetching data file updates
> from the net. New motherboard models are released so frequently that
> it's very likely that the user won't find his model in the local
> database (provided by his distribution, so including a 6 to 9-month old
> version of lm_sensors.) A remote repository makes sense IMHO.
>
> But of course having a local cache can be good too. Not everyone has a
> permanent access to Internet, and our server might be temporarily
> unresponsive or be moved to a different location.
>
> So both options are really open. It's up to you. Either option will be
> better than what we currently have anyway :)
The local cache is something we wanted to use no matter what. It can be very 
annoying if software doesn't work, simply because you don't have an internet 
connection at that moment. But, the cache can get out-dated.

I agree that it should be able to update this cache but I'm not sure yet 
how. Should the sensors_detect script try and find a new data file every 
time it's executed with DMI support, or should it get a parameter for either 
enabling or disabling this feature? That's something we've got to give a 
thought.

> I'm not sure it makes sense to have command line switches for the
> interactive mode itself. You can simply propose the user to check the
> DMI table (default Y), then propose to probe the hardware (default N if
> the system was found in the database.)
>
> The command line options would be most valuable for the non-interactive
> mode: one option to only use the DMI database, one option to only use
> probing, one option to try DMI first then fallback to probing.

That actually sums up every sensible option, doesn't it? ;). Right now, I 
can't find a reason not to do it that way.

> True. That being said, in non-interactive mode, it might make sense to
> backup the old config file and write the new one (by default or with an
> option.)
Agree.

> If you meant "most important" and "less important" then "primary" and
> "secondary" are correct. But my understanding is that the first
> objective is a required prerequisite to implement the second one, too.

It is.
However, we are not sure yet if we're going to completely implement the 
first objective first, before starting on the second. If we make a good 
design for both objectives we are able to script this webinterface in 
relatively little time. This can be a big advantage since we only got a 
fixed amount of weeks to finish this assignment for school ("if we fix 
things afterwards, they don't count for the project anymore"). After this 
website is "live" we can easily gather information from various users and 
configurations, which makes it easier to find (and fix) bugs in an early 
stage.

After the detection script seems to be more than capable of doing the job, 
we we can expand the webinterface to make it more user friendly, depending 
on progress being made.

I hope this clarifies it a bit. I'm not sure whether or not "Primary" and 
"Secondary" are the correct terms to use, but it seems to cause confusion so 
it obviously isn't. We should modify that chapter and add some explanation 
there ;)

Ivo 


