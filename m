From: Dmitry Gromov <gromovd@gmail.com>
Date: Thu, 29 Apr 2010 05:34:29 +0000
Subject: Re: [lm-sensors] Simple fan question
Message-Id: <y2ie21d97a51004282234lca2f3274wf65183deb3278ad8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1272518506.24542.163.camel@pasglop>
In-Reply-To: <1272518506.24542.163.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

On Thu, Apr 29, 2010 at 01:21, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Hi folks !
>
> I'm writing some support for d-link dns323 rev C1 NAS. It has a fan that
> is controlled by some non-programmable PWM circuit. Basically, all I can
> do is tweak to GPIOs that controls the feed into the circuitry for the
> fans to be off, slow or fast.
>
> I don't know what the actual PWM values are for "slow" or "fast". I
> -might- be able to do some measurements but I can't promise it.
>

Are you doing it for debian installation on DNS-323? I know, it
existed, but surprised it did not have fan control...
Have you looked at fan control for standard firmware included in
funplug? I think dns323-fan source is available and can set exact fan
RPM...


--
DG
NJ

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
