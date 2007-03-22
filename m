From: dtor@insightbb.com (Dmitry Torokhov)
Date: Thu, 22 Mar 2007 15:37:34 +0000
Subject: [lm-sensors] [PATCH] Apple SMC driver (hardware monitoring and
Message-Id: <200703221137.35906.dtor@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F7C083.7090504@boichat.ch> <45FE1D44.8000805@boichat.ch>
In-Reply-To: <45FE1D44.8000805@boichat.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Boichat <nicolas@boichat.ch>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, rlove@rlove.org, linux-kernel@hansmi.ch

Hi Nicolas,

On Monday 19 March 2007 01:19, Nicolas Boichat wrote:
> +???????/* initialize the input class */
> +???????applesmc_idev->name = "applesmc";

You may want to set applesmc_idev->id.bus = BUS_HOST;

> +???????applesmc_idev->cdev.dev = &pdev->dev;
> +???????applesmc_idev->evbit[0] = BIT(EV_ABS);
> +???????input_set_abs_params(applesmc_idev, ABS_X,
> +???????????????????????-256, 256, APPLESMC_INPUT_FUZZ, APPLESMC_INPUT_FLAT);
> +???????input_set_abs_params(applesmc_idev, ABS_Y,
> +???????????????????????-256, 256, APPLESMC_INPUT_FUZZ, APPLESMC_INPUT_FLAT);
> +
> +???????input_register_device(applesmc_idev);

Please add error hanling here.

> +
> +???????/* start up our timer for the input device */
> +???????init_timer(&applesmc_timer);
> +???????applesmc_timer.function = applesmc_mousedev_poll;
> +???????applesmc_timer.expires = jiffies + APPLESMC_POLL_PERIOD;
> +???????add_timer(&applesmc_timer);
> 

Please consider implemention open and close methods for the input
device and start/stop timer from there - there is no point of checking
hardware state if noone is listening to events. 

-- 
Dmitry

