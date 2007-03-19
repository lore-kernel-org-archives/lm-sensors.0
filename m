From: me@bobcopeland.com (Bob Copeland)
Date: Mon, 19 Mar 2007 21:43:38 +0000
Subject: [lm-sensors] [RFC][PATCH] Apple SMC driver (hardware monitoring
Message-Id: <b6c5339f0703191443l5f8c5271pf43ea62e0c79a614@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F7C083.7090504@boichat.ch>
In-Reply-To: <45F7C083.7090504@boichat.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Boichat <nicolas@boichat.ch>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, rlove@rlove.org, linux-kernel@hansmi.ch

On 3/14/07, Nicolas Boichat <nicolas at boichat.ch> wrote:
> Hello,
>
> I developed, a while ago, a driver the Apple System Management
> Controller, which provides an accelerometer (Apple Sudden Motion
> Sensor), light sensors, temperature sensors, keyboard backlight control
> and fan control on Intel-based Apple's computers (MacBook Pro, MacBook,
> MacMini).

Hi Nicolas,

I tried out an earlier version of this patch several months ago just to play
around with the joystick part of the accelerometer driver on my MacBook, and
found that it was backwards in the y-direction compared to what Neverball
seemed to want (of course, NB has no way to invert the joystick).  I think
I just did something like this in my own copy:

+       y = -y;
        input_report_abs(applesmc_idev, ABS_X, x - rest_x);
        input_report_abs(applesmc_idev, ABS_Y, y - rest_y);

I don't claim you necessarily want to change it, but thought I'd pass it
along.

Bob

