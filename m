From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Sat, 11 Aug 2007 02:30:19 +0000
Subject: Re: [lm-sensors] 2.6.23-rc1 regression: hwmon/w83627ehf: wrong fan
Message-Id: <4dfa50520708101930h156354c8t492677dd45e2be62@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B5B290.4040907@s5r6.in-berlin.de>
	 <20070805162141.GI6221@jupiter.solarsys.private>
	 <46B6053E.2050708@s5r6.in-berlin.de>
	 <20070810230831.59cbc50f@hyperion.delvare>
	 <46BCE6D0.7060300@s5r6.in-berlin.de>
	 <46BCE929.5070902@s5r6.in-berlin.de>
In-Reply-To: <46BCE929.5070902@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Richter <stefanr@s5r6.in-berlin.de>, Jean Delvare <khali@linux-fr.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Stefan, (Replying to everyone on the list, sorry!)

On 8/10/07, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Should I hardwire correct dividers or pulse per rev in sensors.conf or
> is the driver supposed to work the correct dividers out --- like it did
> before 2.6.23-rc?

The dividers are read-only in userspace. The driver manages the
dividers automatically. The dividers are needed because the w83627ehf
chip only has an 8 bit register to count pulses for each fan. So if
the fan is moving slowly, you want the divider to be 128 so that every
pulse gets counted. If the fan is moving fast, you want the divider to
be 1 so that the register doesn't overflow. Once the register is read
in by the driver, the effect of the divider is cancelled out in
software so that you get an RPM reading from the fan. One side effect
of this is that a fast moving fan reports the RPM more quickly than a
slow moving fan.

If you turn on HWMON debugging, the driver will report when it is
changing the divider in dmesg.

Hope that helps,
David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
