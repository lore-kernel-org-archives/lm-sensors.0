From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: lm_sensors && bt869
Message-Id: <20040111172253.1a4969dd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031228153744.49065c91.khali@linux-fr.org>
In-Reply-To: <20031228153744.49065c91.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for the late answer, I have been busy these last days.

> I tried this (kernel 2.6.0), but I can't figure out the reason for the
> following two problems:
> 
> 1.  For text-output, the new functions like dev_info, dev_dbg and so
> on should be used as I read. However a line like
> dev_info(&client->dev, "probing address %d .\n", address);
> always produces the error that "client" is undeclared. A also tried
> "adapter" instead of "client" but with the similar result. In the
> lm83.c it's used the same way, but there, the problem does not exist.
> Do you have any idea on that?

Well, you must use the right variable accoring to your own code, be it
of type i2c_client or i2c_adapter, whichever it applies to at that time.
It's hard to tell you without seeing your actual code.

You made me notice that I have an error in my lm83 driver. I call
"dev_dbg(&client->dev, ..." instead of "dev_dbg(&adapter->dev, ..."
once. I did not notice it before because dev_dbg resolves to nothing
unless DEBUG is set. Thanks :)

> 2. When I get to the device creation I also get problems with
> undeclared variables. However, this line
> device_create_file(&new_client->dev, &dev_attr_output_norm);
> sounds right for me.

Again it's hard to tell you without seeing your code. If you still
couldn't get it to work, please send my your code and I'll take a look.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
