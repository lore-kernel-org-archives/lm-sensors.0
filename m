From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Fix fan speeds on ADM1026
Message-Id: <20030612104457.509e86a9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE7EEF7.1040803@penguincomputing.com>
In-Reply-To: <3EE7EEF7.1040803@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Jerome Hsiao @ Arima pointed out to me that the fan speeds from the 
> ADM1026 driver were not consistent with other drivers.
> 
> Seems that most (all?) drivers assume two pulses per rev from the
> fans. 
>   I expected that users would need to use a "compute" directive to 
> modify the fan speed for the number of pulses-per-rev of their fans. 
> (All the fans I use are 4 ppr so I'm always having to "compute" a 
> correct value.)
> 
> But it's not consistent with the other drives...
> 
> So here is a patch to fix the ADM1026 so it reports fan speeds 
> consistent with the other drivers...
> 
> This was done against CVS...

Well, that's what fanX_div is meant for. As far as I know, the number of
pulse/rotation depends mostly on the fan itself, not on the monitoring
chipset. That's why we let the users change the fanX_div value through
the config file.

Maybe there's actually something to be fixed in the adm1026 driver, but
maybe this is just a matter of setting the right fanX_div for unregular
fans.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
