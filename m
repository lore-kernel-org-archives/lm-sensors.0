From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Sep 2010 13:56:01 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <20100901155601.11879c43@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 1 Sep 2010 06:26:34 -0700, Guenter Roeck wrote:
> On Wed, Sep 01, 2010 at 04:16:41AM -0400, Mahmood Naderan wrote:
> > >sudo /etc/init.d/lm_sensors restart
> > 
> > mahmood@localhost:~$<mailto:mahmood@localhost:~$> sudo /etc/init.d/lm-sensors restart
> > .: 39: Can't open /etc/init.d/functions
> > 
> > Note there is no lm_sensors. I have lm-sensors
> > 
> 
> I tried /etc/init.d/lm-sensors on a lucid (10.04) system and it works for me. It looks like
> you overwrote the original version of /etc/init.d/lm-sensors with prog/init.d/lm_sensors.
> That won't work - prog/init.d/lm_sensors does not work with lucid. You'll need to reinstall
> the original version of /etc/init.d/lm-sensors and try again.

I proposed once to delete these initialization scripts from our
repository as they are quite distribution specific, but the few votes
were not in my favor.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
