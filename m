From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 23 Sep 2007 21:18:49 +0000
Subject: Re: [lm-sensors] libsensors API changes
Message-Id: <20070923231849.6321afbb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070919234452.4896c76d@hyperion.delvare>
In-Reply-To: <20070919234452.4896c76d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 21 Sep 2007 09:24:00 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Looking at the code of several user-space applications using
> > libsensors, this interface is not very convenient. Except for "sensors
> > -u", which makes some sense as I think it is the reason why this
> > interface exists in the first place. Here is a list of things I found
> > the applications would take benefit of if libsensors would propose a
> > suitable interface:
> > 
> > * Separate lists for main features and subfeatures of each main feature.
> > 
> 
> +1

Implemented in r4831. We now have:

/* This returns all main features of a specific chip. nr is an internally
   used variable. Set it to zero to start at the begin of the list. If no
   more features are found NULL is returned.
   Do not try to change the returned structure; you will corrupt internal
   data structures. */
const sensors_feature *
sensors_get_features(const sensors_chip_name *name, int *nr);

/* This returns all subfeatures of a given main feature. nr is an internally
   used variable. Set it to zero to start at the begin of the list. If no
   more features are found NULL is returned.
   Do not try to change the returned structure; you will corrupt internal
   data structures. */
const sensors_subfeature *
sensors_get_all_subfeatures(const sensors_chip_name *name,
			    const sensors_feature *feature, int *nr);


> > * Subfeature existence information (does feature F of chip C have
> > subfeature X?)
> > 
> 
> +1
> 
> > * Direct subfeature value lookup (what's the value of subfeature X of
> > feature F of chip C?)
> > 
> 
> +1

Both implemented in r4846:

/* This returns the subfeature of the given type for a given main feature,
   if it exists, NULL otherwise.
   Do not try to change the returned structure; you will corrupt internal
   data structures. */
const sensors_subfeature *
sensors_get_subfeature(const sensors_chip_name *name,
		       const sensors_feature *feature,
		       sensors_subfeature_type type);

> (...)
> > I am working on some patches implementing these API changes, I hope to
> > be able to post them for comments and review at the end of the week.
> > Until then, I would also welcome comments on the general ideas I just
> > exposed.
> 
> The basic ideas I'm vary much in favor off, as for the under the hood 
> implementation, I haven't given much thought to that, I trust you will come up 
> with something good.

I've committed all my patches now, so that we don't lose too much time.
Still, if you or anyone else has objections to what I did, please speak
up and we'll address them.

I'm done with the libsensors API review. I've done my best to make it
more convenient to use. I've also made quite a lot of performance
improvements. I sincerely hope that this new library will work for as
long as its predecessor did.

This basically means that we are next to the point where we can release
lm-sensors 3.0.0! My plan is to release a RC1 next week, and give
application authors some time to port their application to the new API
and comment on it. Or we can try porting them on our own and see how it
goes. I've ported xsensors already. It would be good to have all
popular sensor apps ported quickly so as to make sure that the new API
fits the needs. If you need help with a port, just ask me.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
