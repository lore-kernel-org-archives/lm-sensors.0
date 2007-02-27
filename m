From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Feb 2007 11:43:32 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <20070227124332.0c169fd1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Tue, 27 Feb 2007 11:59:03 +0100, Ivo Manca wrote:
> Hey Jean,
> 
> First of all, sorry for my late response.

Late response? You replied within 2 hours, it took me four days ;)

> > My comments:
> >
> > * The primary objective mentions an "internal database". I'm not sure
> > what "internal" is supposed to mean here. Do you plan to embed a big
> > array of known motherboards inside the sensors-detect script itself?
> 
> In this case, internal means that the database is stored on the user's 
> computer. The reason we mentioned this is because we first considered an 

In this case the correct term would be "local", not "internal".

> option which makes the script connect to the corresponding website. This 
> however does not seem to be a very welcome "feature".

I think it is. There's nothing wrong with fetching data file updates
from the net. New motherboard models are released so frequently that
it's very likely that the user won't find his model in the local
database (provided by his distribution, so including a 6 to 9-month old
version of lm_sensors.) A remote repository makes sense IMHO.

But of course having a local cache can be good too. Not everyone has a
permanent access to Internet, and our server might be temporarily
unresponsive or be moved to a different location.

So both options are really open. It's up to you. Either option will be
better than what we currently have anyway :)

> 
> The actual place were the database will be stored is not yet decided.
> 
> > * I'm very much in favor of command line parameters being added to
> > sensors-detect so that for example a non-interactive mode can be
> > supported. I wanted to do that myself for some time but could never
> > find the time to actually do it. Another useful mode would be a "quiet"
> > mode, which would hide all the details and present the probing summary.
> > It would still be interactive in that it should not overwrite the
> > configuration file without the user's consent, so it would be somewhat
> > intermediate between the current mode and a fully automated mode.
> 
> It seems that this did not end up in the final version of the project plan 
> but this was also our view.
> The command line switches we were thinking of adding, include:
> * An automatic (or: non-interactive) mode, which will only use the DMI 
> information to detect the sensors.
> * A mode which first uses the DMI information and then asks whether or not 
> the user wants to probe afterwards.
> * A probing-only mode. For various reasons it might be welcome to keep this 
> mode, for example: if for some reason the DMI information is bogus.

I'm not sure it makes sense to have command line switches for the
interactive mode itself. You can simply propose the user to check the
DMI table (default Y), then propose to probe the hardware (default N if
the system was found in the database.)

The command line options would be most valuable for the non-interactive
mode: one option to only use the DMI database, one option to only use
probing, one option to try DMI first then fallback to probing.

> This automatic mode could also be very useful for newly installed 
> configurations. In this case the user will already have a configured 
> sensors.conf and is able to use the software "out-of-the-box". However, this 
> is just a thought.

Agreed.

> We've already figured out that the default option of sensors-detect should 
> not overwrite an existing configuration file without asking first. It might 
> give some frustration to the users..

True. That being said, in non-interactive mode, it might make sense to
backup the old config file and write the new one (by default or with an
option.)

> > BTW, I think you really mean "first objective" and "second objective",
> > not primary and secondary.
> 
> We meant: "Most important" and "Less important". I thought primary and 
> secondary was a correct translation for this. They both still need to (and 
> will) be completed though.

If you meant "most important" and "less important" then "primary" and
"secondary" are correct. But my understanding is that the first
objective is a required prerequisite to implement the second one, too.

-- 
Jean Delvare

