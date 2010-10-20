From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 20 Oct 2010 16:59:33 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: add generic GPIO fan driver
Message-Id: <20101020165933.GC22572@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287592646-18109-1-git-send-email-sguinot@lacie.com>
	<1287592646-18109-2-git-send-email-sguinot@lacie.com>
In-Reply-To: <1287592646-18109-2-git-send-email-sguinot@lacie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 20, 2010 at 12:37:26PM -0400, Simon Guinot wrote:
> This patch adds hwmon support for the GPIO connected fan.
> 
> Platform specific informations as GPIO pinout and speed conversion array
> (rpm from/to GPIO value) are passed to the driver via platform_data.
> 
> Signed-off-by: Simon Guinot <sguinot@lacie.com>

MicroSomething makes it really easy to be annoyed with them (folks, are you reading this ?).
Mailer screwed up the patch again. We are making some noise to get this fixed,
but that will take a while - the affected mail servers are hiding somewhere in Europe.

Unfortunately, none of the hwmon and linux-arm archives I am aware of makes
patches available on the web (like patchwork does), so I can not get it from there
either. Can you resend it to me as attachment, or give me a pointer where I can
pick it up ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
