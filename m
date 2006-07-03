From: dtor@insightbb.com (Dmitry Torokhov)
Date: Mon, 03 Jul 2006 13:44:40 +0000
Subject: [lm-sensors] [RFC] Apple Motion Sensor driver
Message-Id: <200607030944.41330.dtor@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060702222649.GA13411@hansmi.ch>
In-Reply-To: <20060702222649.GA13411@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch, benh@kernel.crashing.org, johannes@sipsolutions.net, stelian@popies.net, chainsaw@gentoo.org

On Sunday 02 July 2006 18:26, Michael Hanselmann wrote:
> +???????set_bit(EV_ABS, ams.idev->evbit);
> +???????set_bit(EV_KEY, ams.idev->evbit);
> +???????set_bit(BTN_TOUCH, ams.idev->keybit);

BTW, what is BTN_TOUCH doing here? I don't see it being reported anywhere...

Just drop it off and have ams be a "joystick" instead of a "mouse" ;)
Joystick interface is probably better suited anyway.

-- 
Dmitry

