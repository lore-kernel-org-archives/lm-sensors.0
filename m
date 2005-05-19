From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: no FAN3 available
Message-Id: <20030907185428.788d6a7f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309011224.08300.martin@martin-fernau.de>
In-Reply-To: <200309011224.08300.martin@martin-fernau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> I just have a problem with one fan in my system. The processor fan
> works correctly. But I recently added a system-fan which I connected
> to FAN3 connector on my board. But when I type 'sensors' I get only
> fan-output for FAN1 (CPU) and FAN2 (no fan connected so its every time
> 0) but no data for FAN3 where my system-fan is conneced to. I hope,
> you can help me to get it working :)
> Winbond chip: W83697HF
> Mainboard: Epox EP-8KHA+
> Sensors ver: 2.7.0-r1
> Kernel: 2.4.20

The W83697HF has only two fans inputs. Three possibilities:

1* You don't really have a W83697HF, but some similar chip (w83627hf,
w83627thf...) with three fan inputs.

2* You really have a W83697HF, and the third fan cannot be monitored.

3* You really have a W83697HF, and there's a secondary chip for
monitoring the third fan. The sensors-detect script should tell you.

The manual of your motherboad could help choosing between these
possibilities. Or you could provide the output of sensors-detect (after
unloading *all* i2c chip drivers; when asked for undetectable adapters,
say no). Using the CVS version of the script would be better:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect
since we've improved it much since 2.7.0 was released.

> Random witze fortune:
> (...)

Please avoid that next time.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
