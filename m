From: Alan A <aaa@bright.net>
Date: Wed, 25 Mar 2009 13:17:56 +0000
Subject: Re: [lm-sensors] help with lmsensors and intel atom
Message-Id: <loom.20090325T131445-816@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20090324T161504-153@post.gmane.org>
In-Reply-To: <loom.20090324T161504-153@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali <at> linux-fr.org> writes:

> Try temp3_input instead of temp_input3 maybe. Another suspicious thing
> is the lack of reference to a specific monitoring chip (you have 2
> chips so how can LCD4Linux know which one you're talking about?), and
> also the name "i2c_sensors" while we made the hardware monitoring
> subsystem independent from i2c years ago. Could be that the LCD4Linux
> code is old and doesn't properly interface with the current hwmon or
> libsensors API.
> 
> But anyway, at this point there's not so much we can do for you. Your
> sensors are OK, your problem is with LCD4Linux, so you should ask for
> help people who know about LCD4Linux.
> 

Thank you for your input Jean. I tried the temp3_input and it started
registering as it should. Now I can read all sensors.

Thank you all for your help.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
