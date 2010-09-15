From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 15 Sep 2010 17:04:51 +0000
Subject: Re: [lm-sensors] [patch 01/36] hwmon: New driver for the
Message-Id: <20100915170451.GC10422@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100915163447.GB10422@ericsson.com>
In-Reply-To: <20100915163447.GB10422@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 15, 2010 at 12:43:23PM -0400, Jean Delvare wrote:
> On Wed, 15 Sep 2010 09:34:47 -0700, Guenter Roeck wrote:
> > Hi Jean,
> > 
> > On Wed, Sep 15, 2010 at 09:40:27AM -0400, Jean Delvare wrote:
> > [...]
> > > +module_init(sensors_w83795_init);
> > > +module_exit(sensors_w83795_exit);
> > > +
> > Nitpick but causes a whitespace error when integrating (empty last line),
> > which is then retained through the entire series.
> 
> Fixed, thanks for reporting. Not sure which tool pointed it out, but
> checkpatch didn't tell me.
> 
Yes, I know. Often happens to me with whitespace errors.

"git am" complains about it, unless you use -3.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
