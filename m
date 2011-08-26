From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 26 Aug 2011 15:30:59 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (pmbus/adm1275) Add support for
Message-Id: <20110826173059.40030657@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314324755-18514-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1314324755-18514-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 26 Aug 2011 06:51:39 -0700, Guenter Roeck wrote:
> On Fri, Aug 26, 2011 at 07:15:52AM -0400, Jean Delvare wrote:
> > I am not familiar with the pmbus layer (is it documented anywhere?), is
> > it possible for these errors to happen at all? I am a little surprised
> > that you return errors here and not in adm1275_write_word_data below.
> > But maybe it's OK.
> > 
> > If you really have to return these errors, then why do you return
> > -EINVAL when other unsupported features get -ENODATA?
>
> Guess I'll need to document the logic here.
> 
> EINVAL:
> 	The calling code does not try to access the real register and returns the error
> 	to the caller. Not sure about EINVAL here; maybe I should return EIO.
> ENODATA:
> 	There is no chip specific register to return this data, but there may be
> 	a standard register. The calling code tries to access the standard register.

Yes, better documentation would help me (and maybe others) offer better
reviews of patches touching pmbus drivers. Even with your explanation
above, I'm still unsure if your patch is doing the right thing or not,
because I don't know who will be calling the function, when and with
what values. Well I could read the code, obviously, but... a short
document explaining the calling conditions and conventions would
certainly be good to have.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
