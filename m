From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: gl520sm bug
Message-Id: <1073896762.40025d3a8d993@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> hi
> i think theres a big bug in your driver
> when i load it and run sensors my cpu fan stops
> and it doesn't start again (tested up to 66 degree)
> 
> or am i just too stupid to set it up correctly ?

This sometimes happens with various drivers. Our initialization process
might be a little aggressive.

First, if you are using lm_sensors < 2.8.2, try upgrading to 2.8.2,
since it has limits initialization removed.

If it still doesn't work, you'll have to dive into the code of the
driver and find which initialization command triggers the problem. The
suspects are in function gl520_init_client. First thing to try is the
first command, which resets the chipset to default power-on state.
Comment this one out, recompile and give it a try. If it still doesn't
work, do the same with all gl520_write_value(...) lines (individually)
until the fan doesn't stop anymore.

Then please report to us so that we can fix the driver accordingly on
our side.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
