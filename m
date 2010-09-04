From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 04 Sep 2010 13:49:42 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <20100904154942.323dc468@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter,

On Wed, 1 Sep 2010 07:32:25 -0700, Guenter Roeck wrote:
> On Wed, Sep 01, 2010 at 09:56:01AM -0400, Jean Delvare wrote:
> > On Wed, 1 Sep 2010 06:26:34 -0700, Guenter Roeck wrote:
> > > On Wed, Sep 01, 2010 at 04:16:41AM -0400, Mahmood Naderan wrote:
> > > > >sudo /etc/init.d/lm_sensors restart
> > > > 
> > > > mahmood@localhost:~$<mailto:mahmood@localhost:~$> sudo /etc/init.d/lm-sensors restart
> > > > .: 39: Can't open /etc/init.d/functions
> > > > 
> > > > Note there is no lm_sensors. I have lm-sensors
> > > > 
> > > 
> > > I tried /etc/init.d/lm-sensors on a lucid (10.04) system and it works for me. It looks like
> > > you overwrote the original version of /etc/init.d/lm-sensors with prog/init.d/lm_sensors.
> > > That won't work - prog/init.d/lm_sensors does not work with lucid. You'll need to reinstall
> > > the original version of /etc/init.d/lm-sensors and try again.
> > 
> > I proposed once to delete these initialization scripts from our
> > repository as they are quite distribution specific, but the few votes
> > were not in my favor.
> > 
> How about some kind of warning, or at least use different wording in sensors-detect ?
> 
> The current text is quite absolute ("Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors")
> and really invites users to overwrite the distribution specific scripts.

Actually it doesn't:

		print "Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors\n".
		      "for initialization at boot time.\n"
			unless -f "/etc/init.d/lm_sensors";

So the message isn't printed if there is already a script there.

In Mahmood's case, the script is named /etc/init.d/lm-sensors instead,
so the message would be printed, but running the suggested command
would _not_ overwrite the file. Not sure what happens where both
scripts are present though...

So I would suggest that we simply extend the test to:

			unless -f "/etc/init.d/lm_sensors"
			    or -f "/etc/init.d/lm-sensors";

Would that be OK with you?

If you have a better proposal, I'm listening. The only alternative I
have in mind is to get rid of the message altogether and delete the
init script from our repository, leaving integration up to each
distribution (which at least openSUSE and derivatives already do.)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
