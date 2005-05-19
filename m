From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: Error messages on ignored values
Message-Id: <20050204200943.62788999.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050204053725.34834.qmail@web60504.mail.yahoo.com>
In-Reply-To: <20050204053725.34834.qmail@web60504.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> > The approach you propose is slightly different, since the user would
> > have to put "ignore" lines in his/her configuration file in order to
> > dismiss the error message. So, while it looks cleaner, I am not sure
> > it is the way to go. If we do what you propose, we are likely to get
> > many reports about the errors, which aren't really errors.
> 
> But there may be an error. What I don't like about just dropping the
> error is that we don't know if the file doesn't exist because that
> sensor doesn't exist, or there is another error because of a larger
> problem brewing.

Agreed, this is really only a quick hack, and not a nice one. We might
hide errors. However, it is believed that if one possibly-missing value
would actually raise an error, the other values would return similar
errors, so it is unlikely that actual errors would go unnoticed. It's
not like we would hide all errors; typically we only ignore a few ones.

> I've attached a patch that does the above. After writing it, I'm
> thinking there may be a better way to do this. The patch now checks
> for SENSORS_ERR_PROC, which is a pretty generic error returned from
> the library.

True, I don't think there is much chance that you get a different error
at this point, so it probably doesn't make any difference with just
ignoring the error. But that's stil nice.

> I think a better way to do this is to keep the changes to
> print_vt1211 that skip the print if the channel is ignored, but
> instead of checking sensors_get_feature for a specific error code, a
> function is added to the library to determine if a channel exists, and
> factor the result of that call into sensors_get_label_and_valid, so
> that valid would be false that channel is ignore, or if the file for
> that channel doesn't exist.
> 
> If you think this is a good idea, let me know, and I'll take a stab at
> it.

I don't think it's worth the effort. Face it, libsensors is totally
procfs-centric, and won't ever properly deal with the new sysfs
interface. It needs to know everything about each chip to display
convenient results. With the new standardized sysfs interface it should
be possible to design a new library which doesn't need any knowledge
about the chips themselves, but would discover everything it needs from
the sysfs interface. If we are going to spend energy on making things
better for 2.6 kernels, we'd better start working on this library than
waste time on the old one, IMHO.

I'll apply your patch, thanks.

-- 
Jean Delvare
