From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Aug 2013 09:19:23 +0000
Subject: Re: [lm-sensors] Taking action based upon sensors
Message-Id: <20130829111923.4aa036b1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU173-W194E5678B7B93E08C63033A4480@phx.gbl>
In-Reply-To: <BLU173-W194E5678B7B93E08C63033A4480@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 25 Aug 2013 11:51:25 -0400, PHP Nut wrote:
> Is there any explicitly supported method to execute specified actions based upon the value of a sensor output exceeding a threshold or equaling a certain state?
> 
> What I'm looking for is a way to use sensord or a similar daemon based on lm-sensors to execute a command when a condition is met, such as the temperature exceeding a certain threshold. This could be done with a separate daemonized or scheduled log monitor, however that is a bit clunky, another item to debug, a waste of resources, and another undocumented interop to fail upon a package upgrade.

I'm afraid we don't have anything like that. I think people use 3rd
party monitoring tools for this. 

> If there isn't, what's the best method for doing this and are there existing log watching/parsing scripts which have been thoroughly debugged? I'd like to avoid anything homebrew if at all possible.

The only thing we have in lm-sensors
is the healthd.sh daemon:
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/daemon/healthd.sh

But it's very old and simple and not packaged by distributions in
general. It has its limitations too: it relies on perfect behavior of
the hardware and its driver and prefect libsensors configuration as
well, otherwise you can get false positive ALARMs or missing ALARMS and
the script won't work.

You may look for something better on Freecode:
http://freecode.com/
I'm sure people have written what you're looking for already.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
