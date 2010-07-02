From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 02 Jul 2010 08:11:28 +0000
Subject: Re: [lm-sensors] [PATCH/RFC] hwmon: Add support for W83667HG-B
Message-Id: <20100702081128.GB12911@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1278021735-21188-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1278021735-21188-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, Jul 02, 2010 at 02:55:38AM -0400, 宾西蒙 wrote:
> 在 2010-07-01四的 15:02 -0700，Guenter Roeck写道：
> > This patch adds support for W83667HG-B to the w83627ehf driver.
> 
> Hi, thanks a lot for your work! Since I'm on the CC, which is probably
> to the Devices list on sensors';
> 
> they have gobbled the HG-B (which you've gratefully tackled) and the
> HG-I (with id 0xb470) into one row. Unfortunately, I seem to be the only
> one with the latter chip, so I'm unable to help here.
> 

v2 of the patch will also detect HG-I. Would be great if you could test it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
