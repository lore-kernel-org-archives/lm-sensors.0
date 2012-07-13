From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Jul 2012 14:34:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: s3c-hwmon: Use devm_kzalloc instead of kzalloc
Message-Id: <20120713143434.GA25264@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1342170388-5682-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1342170388-5682-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jul 13, 2012 at 04:43:12PM +0530, Sachin Kamat wrote:
> On 13/07/2012, Jean Delvare <khali@linux-fr.org> wrote:
> > On Fri, 13 Jul 2012 14:36:28 +0530, Sachin Kamat wrote:
> >> This makes the code simpler as explicit freeing is not needed.
> >>
> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> ---
> >>  drivers/hwmon/s3c-hwmon.c |    7 ++-----
> >>  1 files changed, 2 insertions(+), 5 deletions(-)
> >>
> >
> > I'm afraid Guenter was faster:
> >
> > http://git.kernel.org/?p=linux/kernel/git/groeck/linux-staging.git;a=commitdiff;ho66b055060eee17b4c0c18f2d5c1efa04682e11
> 
> Oops.. :)
> I did not find it in the linux-next tree.. hence was not aware..
> 
No problem.

I have around 50 or so of those patches still pending in my -staging tree,
because I did not get an Acked-by or Reviewed-by.

Given that, your patch is fine ... it gives me a second Signed-off, so I can
push it forward.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
