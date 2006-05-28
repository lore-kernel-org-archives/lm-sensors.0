From: fabien@wernli.eu (Fabien Wernli)
Date: Sun, 28 May 2006 11:45:23 +0000
Subject: [lm-sensors] vt1211 patch
Message-Id: <20060528114522.GA5944@mail.faxm0dem.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605250754y4ffe117fucd52fc2c5b37369a@mail.gmail.com>
In-Reply-To: <191fb4ca0605250754y4ffe117fucd52fc2c5b37369a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Fri, May 26, 2006 at 11:37:14AM +0200, Juerg Haefliger wrote:
> Just realized that the temps are in millicelcius so the last line
> should read something like:
> echo 300000 > pwmX_auto_point4_temp
> The value written just needs to be large enough to saturate the
> register at 255 (it gets divided by 1000 in the driver before being
> written to the reg).

I tried your instructions, but nothing seems to happen:

| # cat pwm?_enable
| 2
| 2
| 
| # cat pwm?_auto_point4_temp
| 255000
| 255000

BTW that value seems the max I can set it to

sensors shows:

| CPU:      3105 RPM  (min =    0 RPM, div = 2)


