From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 14 Sep 2005 01:24:33 +0000
Subject: [lm-sensors] [PATCH] updated hdaps driver.
Message-Id: <d120d50005091316235912bcf9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1126555518797@kroah.com>
In-Reply-To: <1126555518797@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 9/12/05, Greg KH <gregkh@suse.de> wrote:

> +static void hdaps_mousedev_enable(void)
> +{
> +       down(&hdaps_sem);
> +
> +       /* calibrate the device before enabling */
> +       hdaps_calibrate();
> +
> +       /* initialize the input class */
> +       init_input_dev(&hdaps_idev);
> +       hdaps_idev.dev = &pdev->dev;
> +       hdaps_idev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
> +       hdaps_idev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
> +       hdaps_idev.keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT);
> +       input_register_device(&hdaps_idev);
> +

I do not see the device ever reporting BTN_LEFT, why is its presence advertised?

> +
> +/*
> + * hdaps_mousedev_disable - disable the input class device.  Caller must hold
> + * hdaps_sem.
> + */
> +static void hdaps_mousedev_disable(void)
> +{
> +       down(&hdaps_sem);

Bad comment. The function itself holds the semaphore.

> +
> +       if (hdaps_mousedev)
> +               hdaps_mousedev_enable();
> +

Please consider converting the input device to an absolute device
(reporting ABS_X/ABS_Y). This way it will be bound to a joystick
interface (/dev/input/jsX) and won't mess your /dev/input/mice so you
won't have to fiddle with enabling/disabling and will be able to have
the device turned on unconditionally.

-- 
Dmitry
