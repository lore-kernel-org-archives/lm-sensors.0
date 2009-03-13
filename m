From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 13 Mar 2009 16:24:30 +0000
Subject: Re: [lm-sensors] Asus ATK0110 ACPI driver and Asus P6T Deluxe
Message-Id: <68676e00903130924h7e43349awb3d6f5c447aab6e3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200903101417.01449.clive@vacuumtube.org.uk>
In-Reply-To: <200903101417.01449.clive@vacuumtube.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 10, 2009 at 3:17 PM, Clive Messer <clive@vacuumtube.org.uk> wrote:
> I've seen several reports of it being used with 'older' Asus boards - P5B,
> P5K, P5Q, etc. etc. I've been using the driver with a P6T Deluxe (Core i7 /
> X58 chipset).

Thanks for testing :-)

> Not that it really matters - just a curiosity. The CPU temp reports +5 degC
> hotter with atk0110 driver and -5 degC cooler with native w83667hg, compared
> to coretemp driver. (Yes, coretemp is relative anyway.....)

It's possible that the DSDT and the native driver (via compute)
calculate the temperature in a different way. Hopefully BIOS writers
knew what they were doing ;-)

L

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
