From: akpm@osdl.org (Andrew Morton)
Date: Fri, 09 Dec 2005 23:26:25 +0000
Subject: [lm-sensors] [PATCH 2/3] i386: CS5535 chip support - GPIO
Message-Id: <20051209152625.130641bb.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512070933re472072x43f35d454be699f1@mail.gmail.com>
In-Reply-To: <808c8e9d0512070933re472072x43f35d454be699f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Gardner <gardner.ben@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Ben Gardner <gardner.ben at gmail.com> wrote:
>
> +/* These are defined in cs5535.c */
> +extern u32 cs5535_gpio_base;
> +extern u32 cs5535_gpio_mask;

And they should be declared in a header file, please.

Is there a reason for these being exported to non-GPL modules, or can they
be EXPORT_SYMBOL_GPL()?

