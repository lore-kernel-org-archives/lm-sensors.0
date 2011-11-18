From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Fri, 18 Nov 2011 19:11:49 +0000
Subject: Re: [lm-sensors] wrong output with fam15h_power
Message-Id: <CAAek22GQLy2NCOwC7oKZz3oydyPZZTY+w2HJxBp8zs3heYoK7g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321642023.1644.12.camel@tellur>
In-Reply-To: <1321642023.1644.12.camel@tellur>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Nov 18, 2011 at 10:47 AM, Lucas Stach <dev@lynxeye.de> wrote:
> Hi,
>
> I'm trying to use the fam15h_power driver to measure my processors power
> consumption, but it gives me clearly wrong values. With a completely
> idle system the processor claims to be using 125261718=B5W, which would
> mean the processor operates at it's TDP limit. With all cores 100%
> loaded it claims to be using 130675781=B5W which I can't believe as this
> would mean the processor violates it's own spec.

You have to read the vendor documentation carefully...

TDP numbers are *not* necessarily the maximum power draw.  They are
the *design* point for a thermal solution.

Further confusion is created by Intel and AMD using similar terms to
refer to different concepts.

Phil P.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
