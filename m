From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Sun, 24 Oct 2010 15:05:33 +0000
Subject: Re: [lm-sensors] [PATCH 00/12] lis3 accelerator feature update
Message-Id: <4CC44B3D.5030404@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: khali@linux-fr.org, guenter.roeck@ericsson.com, jic23@cam.ac.uk, lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Op 22-10-10 13:57, Samu Onkalo schreef:
> Changes are tested only with I2C interface using 8bit sensor since I don't
> have other possibilities. Some features are not enabled
> by default since I can't test them with all possible configurations.
> Platform data contains field which controls new features.
Thanks Samu for persevering with the automatic power down feature. 
Hopefully I'll find also some time to activate it on the hp_accel side.

For now, I've reviewed the changes and everything looked fine, as well 
as tested them on my HP laptop (with a 12 bits sensor). Although most of 
the changes are not visible on this platform, at least there shouldn't 
be any regression.

Thanks,
Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
