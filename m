From: juergh@gmail.com (Juerg Haefliger)
Date: Tue, 27 Jun 2006 17:48:22 +0000
Subject: [lm-sensors] #2073: VT1211 Driver review + docs
Message-Id: <191fb4ca0606271048g586a5aebvbf9e50b6c03afc62@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0606270754x29ac79ak194b509f9c9aac88@mail.gmail.com>
In-Reply-To: <191fb4ca0606270754x29ac79ak194b509f9c9aac88@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> your patch passes the leading, trailing whitespace tests (which you know):
>     cat -TE attachment-0001.obj | grep '^+ ' |more
>     cat -TE attachment-0001.obj | grep ' $' |more

good to know :-)


> 2 trivial notes:
>
> +       default:
> +               printk(KERN_ERR DRVNAME ": Unknown attr fetch\n");
>
>
> since these are in your callbacks, which have a struct device *dev,
> you could change them to
>
>         dev_err(dev, "Unknown attr.....
> +       }
>
>
> Also, just below here:
>
> +               /* pwm & temp auto point registers */
> +               data->pwm_auto_pwm[0][0] = 255; /* hard wired */
> +               data->pwm_auto_pwm[0][1] = vt1211_read8(data,
>
> you could have done those initializations in a loop.
> Im assuming this would shrink the object by a teeny amount.
>

Those issues are minor enough that I waive them at this point. Once
the patch is in the main line I'm happy to do increments. But I want
this thing in now :-)


> And one 'idle-curiosity' question:
> what happens when you rmmod  then modprobe ? any surprises ?

No prob, works fine.

Thanks
...juerg

