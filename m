From: npfdd@gmx.ch (Daniel Schregenberger)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lmsensors-CVS on 2.6.0-test10
Message-Id: <1070363690.4269.10.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031126190459.724240ad.npfdd@gmx.net>
In-Reply-To: <20031126190459.724240ad.npfdd@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Replying to myself again, to have some context.

On Sat, 2003-11-29 at 23:01, Daniel Schregenberger wrote:
> > > Now I load the following modules:
> > > w83781d, i2c_sensor, i2c_dev, i2c_isa, i2c_i801, i2c_core

I could strip this down to: i2c-core, i2c-i801, i2c-isa, i2c-sensor and
w83781d.

> > > and get these results from sensors:
> [...]
> > > Now I'll have to find the proper settings in the conf file for my
> > > board.
> > 
> > That's the least to say. Looks like you don't have a config file at all.
> > Make sure you have /etc/sensors.conf. If not, copy it from
> > lm_sensors2/etc/sensors.conf.eg. It should be a lot better (both labels
> > and values).
> 
> You're right, I don't have one. :)
> I remember seeing a post on the web by someone with the same board as
> me. I think I'll search my history and use this as a starting
> configuration.

I did this and didn't had to make any changes. Temperatures and
Fan-Speeds seem ok and that's all I need.

[Source for my sensors.conf:
http://archives.andrew.net.au/lm-sensors/msg04948.html
]

Sidenote: integration with gkrellm2 is also working.


Thanks for your help and for a great piece of software!

-- Daniel
