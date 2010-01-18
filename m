From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Jan 2010 08:03:56 +0000
Subject: Re: [lm-sensors] ATK0110 on older Asus board
Message-Id: <20100118090356.34ba7c2b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
In-Reply-To: <52ae42fa1001140656w17e9e219lad760a0687db6b20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 17 Jan 2010 22:58:02 +0100, Luca Tettamanti wrote:
> On Fri, Jan 15, 2010 at 6:30 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > Hi Luca,
> >
> > On Fri, 15 Jan 2010 18:11:53 +0100, Luca Tettamanti wrote:
> >> Ugh. The AKT0110 node is totally empty, nonetheless the hwmon methods
> >> are available.
> >> The driver is failing because the method used to identify the mobo
> >> (MBIF) is missing (and the printk isn't verbose enough).
> >> I suppose I could relax the check and probe the interface even if it's
> >> not possible to id the board.
> >> I'll prepare a patch.
> >
> > Isn't this similar to the problem (and patch!) reported by Juan RP 3
> > days ago?
> >
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027606.html
> 
> Yes, same problem. I haven't been able to decode MBIF data, so ATM it's unused.
> I'll send a patch in reply to this mail. Jean can you please push it
> to Linus for .34?

I'll push whatever patch is needed to 2.6._33_.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
