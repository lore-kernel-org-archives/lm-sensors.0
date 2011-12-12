From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 12 Dec 2011 16:40:37 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (f75375s) Use standard sysfs
Message-Id: <20111212164037.GA10447@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1323369069-26203-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1323369069-26203-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Dec 10, 2011 at 02:50:17PM -0500, Bj=F6rn Gerhart wrote:
> 2011/12/8 Guenter Roeck <guenter.roeck@ericsson.com>:
> > The driver uses non-standard sysfs attribute names for maximum and targ=
et fan
> > speeds, even though standard attibute names for the same values do exis=
t.
> > Replace non-standard attribute names with standard attribute names.
> >=20
> > Cc: Riku Voipio <riku.voipio@iki.fi>
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Reviewed-by: Bjoern Gerhart <oss@extracloud.de>

Hi Bjoern,

thanks a lot for the review of this and the other patches. I applied the se=
ries
to my -next tree.

I should add that this patch is special, since it changes sysfs attribute n=
ames.
I chose the direct method of changing the attribute names over providing bo=
th
the old and new names for a couple of releases, for a couple of reasons.
First, the "old" names are non-standard and thus not really useful for gene=
ric
applications, and second I did not find a reference that any of the non-sta=
ndard
attributes is actually used. We'll find out if this will cause trouble.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
