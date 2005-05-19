From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Ticket 1751
Message-Id: <20040812212123.57af362d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
In-Reply-To: <200408121858.i7CIw0KW013198@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> When everything is fine, CPU and MB temps move up and down with load
> as expected (and as confirmed by the BIOS).
> The only required action to break the values appears to be installing
> lm-sensors by apt-get install (which I'd guess runs sensors-detect) -
> removing lm-sensors, and running only the w83627hf kernel module (ie
> without lm_sensors) provides the "correct" (in the sense of more valid
> anyway) values. When broken, the CPU temp locks itself at 85.0?C, and
> doesn't shift whatsoever.
> Sensors -s doesn't help anything.

Just asked the debian maintainer about it, and he told me that
installing the package will actually run "sensors -s", not
sensors-detect. So "sensors -s" is somehow messing with your chip. I
can't remember of a similar report so far.

The configuration file doesn't seem to do anything with temperatures, it
only sets voltages. Maybe what you see is a side effect of some bug in
the driver.

Please provide the output of "sensors" with and without the problem. I
want to see if other values have changed or not. If for example some
voltage limits have not properly changed to what the configuration file
has, we would know where to look.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
