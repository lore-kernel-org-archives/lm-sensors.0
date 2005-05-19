From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: Fwd: Fwd: [PATCH 2.6] bmcsensors
Message-Id: <253818670503310843459fc191@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705033012523d671b5f@mail.gmail.com>
In-Reply-To: <2538186705033012523d671b5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Oops, there was a signed off line in the first e-mail to the mailing
list and I'd just assumed it was still in the forward. I will port the
patch to the latest mm-series tonight and repost.

We should write all this stuff down somewhere :-) (cc Greg, post
in-line even over 40k, patch against latest mm etc) for newbies like
me, unless I'm missing some existing documentation somewhere (I read
the kernel documentation, Documentation/SubmittingPatches, and the
lm_sensors porting_clients documentation, etc).

Thanks,
Yani


On Thu, 31 Mar 2005 10:37:48 +0200 (CEST), Jean Delvare
<khali@linux-fr.org> wrote:
> 
> Hi Yani,
> 
> > Greg has asked me to send it in-line to the list, so here it is :).
> > I'd appreciate any comments on the patch, please read the previous
> > threads on the sysfs callback problem first though.
> 
> Please provide your patch against the latest -mm tree. This is where the
> latest i2c developments are. Your current patch doesn't apply against
> 2.6.12-rc1-mm3 (fails on drivers/i2c/chips/Makefile).
> 
> Note that i2c_client.id is no more, so this won't work:
> 
> +struct i2c_client bmc_client = {
> +       .name = "bmc",
> +       .id = 1,                /* fake should be 0 */
> +       .flags = 0,
> +       .addr = 0,
> +       .adapter = NULL,        /* adapter */
> +       .driver = &bmcsensors_driver,
> +       .usage_count = 0
> +};
> 
> And this won't work either, of course:
> 
> +       bmc_client.id = 0;
> 
> Why is bmc_client no declared static?
> 
> Could you please explain to us what i2c-ipmi does? I understand it acts
> as an interface between the bmcsensors driver and something else, but I
> yet have to learn what that other thing is, and why an interface is
> needed at all. As I understand it, i2c-ipmi is no I2C or SMBus master
> driver, but a kind of hack much like the i2c-isa driver is. I don't
> exactly enjoy the way i2c-isa works, and I plan to get rid of it at some
> point in time (hopefully in a near future), so let's not do something
> equally ugly here.
> 
> Thanks,
> --
> Jean Delvare
>
