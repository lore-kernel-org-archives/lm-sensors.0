From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: [PATCH 2.6] it87 Part2(reset option)
Message-Id: <1077887553.403f42419c810@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040225111219.1c117787.komoriya@paken.org>
In-Reply-To: <20040225111219.1c117787.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I commented out the code for initializing voltages and thachometers,
> and tested with reset=1, and I say yes though I have tested for 2.6
> but not for 2.4.  
> Sensor values stopped updating without these initializations.

OK, so the datasheets are correct, and I'll have to fix the 2.4 driver.

> I agree with you. I don't like to lose such information.
> Voltages and thachometers could be sensed without initialization
> even if I set "ignore this sensor" in BIOS settings. My assumption
> was not correct.

The "ignore" function of your BIOS setup screen must be similar to our
"ignore" statements in sensors.conf. It simply hides the value, nothing
more.

> I feel this is good idea. I added the code to check if all
> voltages (or tachometers) are disabled.

This make me think of something. You do not handle the temperatures at
all, because the user can configure them from user-space. Doesn't it
sound a bit strange though that upon reset, all inputs but temperatures
are forcibly enabled?

We could save the settings before reset (for temperatures only) and
restore them right after.

Or we could forcibly enable temperatures with what used to be the
default value in older versions of the driver (0x2a if my memory is
correct).

Or we could mix both (restore values for enabled channels, and use the
default values for disabled temperature channels).

What do you think? This is a true question, I don't have strong opinion
(although solution 2 is the more similar to what is done for voltages
and fan tachometers). Even doing nothing (the way it is) is OK for me if
you like it that way.

[...]

> I know such videos are called Japanimation:)

In France we often refer to them simply as "anime" and everyone
understands we speak about Japanese ones.

> I wonder why you know the word "dicho" (intestinum crassum?)...

Oh well, I must have been spelling it incorrectly. I only ever heard
it,
never seen it written. Maybe it's "disho" or "dijo"? The word I know is
supposed to mean "dictionary".

[...]

> Here's new version with your suggestions.

Perfect, except:

> +	/* Check if tachometers are reset manually or by some reason */
> +	if ((it87_read_value(client, IT87_REG_FAN_CTRL) & 0x70) = 0) {
> +		/* Enable all fan tachometers */
> +		it87_write_value(client, IT87_REG_FAN_CTRL,
> +	(it87_read_value(client, IT87_REG_FAN_CTRL) & 0x8f)

You can spare the second read by saving the value returned by the
previous read of the same register in a local variable. Remember that
register reads are relatively slow (especially on I2C busses) so we
want to spare them each time we can.

Aligato :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
