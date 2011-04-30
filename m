From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 30 Apr 2011 10:17:53 +0000
Subject: Re: [lm-sensors] [RFC 3/5] serial: add support for Technologic
Message-Id: <20110430111753.69466ae5@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	<1304115712-5299-4-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1304115712-5299-4-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, lm-sensors@lm-sensors.org

> --- a/drivers/tty/serial/8250.c
> +++ b/drivers/tty/serial/8250.c
> @@ -109,6 +109,13 @@ static unsigned int skip_txen_test; /* force skip of txen test at init time */
>  #define CONFIG_HUB6 1
>  
>  #include <asm/serial.h>
> +
> +/* TS-5500 related stuff */
> +#ifdef CONFIG_SERIAL_8250_TS5500_485_TIMER
> +#define TS5500_TIMER2_SPEED_ADDR	0x42
> +#define TS5500_485_SERIAL_PORT		0x02
> +#endif
> +
>  /*
>   * SERIAL_PORT_DFNS tells us about built-in ports that have no
>   * standard enumeration mechanism.   Platforms that can find all
> @@ -437,6 +444,25 @@ static void au_serial_out(struct uart_port *p, int offset, int value)
>  	__raw_writel(value, p->membase + offset);
>  }
>  
> +#ifdef CONFIG_SERIAL_8250_TS5500_485_TIMER
> +void serial8250_ts5500_set_termios(struct uart_port *port,
> +				   struct ktermios *new,
> +				   struct ktermios *old)
> +{
> +	u16 speed;
> +
> +	if (new->c_ospeed >= 9600 && port->line = TS5500_485_SERIAL_PORT) {
> +		speed = ((115200 * 2) / new->c_ospeed);
> +
> +		/* This should be written by low byte followed by high byte */
> +		spin_lock_irq(&port->lock);
> +		outb((speed & 0x0F), TS5500_TIMER2_SPEED_ADDR);
> +		outb((speed >> 8), TS5500_TIMER2_SPEED_ADDR);
> +		spin_unlock_irq(&port->lock);
> +	}
> +}
> +#endif

Please don't put board specific magic in this file, we are desperately
trying to get rid of it.

> +
>  static unsigned int tsi_serial_in(struct uart_port *p, int offset)
>  {
>  	unsigned int tmp;
> @@ -2464,6 +2490,10 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>  	/* Don't rewrite B0 */
>  	if (tty_termios_baud_rate(termios))
>  		tty_termios_encode_baud_rate(termios, baud, baud);
> +
> +#ifdef CONFIG_SERIAL_8250_TS5500_485_TIMER
> +	serial8250_ts5500_set_termios(port, termios, old);
> +#endif
>  }
>  EXPORT_SYMBOL(serial8250_do_set_termios);

Provide your own set_termios method and then call into this one (which is
why it is exported)


> diff --git a/drivers/tty/serial/ts5500-auto485.c b/drivers/tty/serial/ts5500-auto485.c
> new file mode 100644
> index 0000000..fd01aa0
> --- /dev/null
> +++ b/drivers/tty/serial/ts5500-auto485.c
> @@ -0,0 +1,45 @@
> +/*
> + * ts5500-auto485.c - support for the TS-5500 auto485 feature

This needs documentation and description. Also we have runtime 485
switching ioctls so any code should really be using those and extending
them as needed.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
