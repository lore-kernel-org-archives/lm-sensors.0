From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 20 Mar 2007 10:08:18 +0000
Subject: [lm-sensors] [RFC][PATCH] Apple SMC driver (hardware monitoring
Message-Id: <20070320110818.1b11c406.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F7C083.7090504@boichat.ch>
	<b6c5339f0703191443l5f8c5271pf43ea62e0c79a614@mail.gmail.com>
In-Reply-To: <b6c5339f0703191443l5f8c5271pf43ea62e0c79a614@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bob Copeland <me@bobcopeland.com>
Cc: Nicolas Boichat <nicolas@boichat.ch>, linux-kernel@hansmi.ch, rlove@rlove.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, 19 Mar 2007 17:43:38 -0400, Bob Copeland wrote:
> I tried out an earlier version of this patch several months ago just to play
> around with the joystick part of the accelerometer driver on my MacBook, and
> found that it was backwards in the y-direction compared to what Neverball
> seemed to want (of course, NB has no way to invert the joystick).  I think
> I just did something like this in my own copy:
> 
> +       y = -y;
>         input_report_abs(applesmc_idev, ABS_X, x - rest_x);
>         input_report_abs(applesmc_idev, ABS_Y, y - rest_y);
> 
> I don't claim you necessarily want to change it, but thought I'd pass it
> along.

This appears to be a common problem with these devices, the hdaps driver
(IBM) needs to invert the axis on some models too, and I seem to
remember something similar for the (not yet merged) HP laptops
accelerometer driver.

-- 
Jean Delvare

