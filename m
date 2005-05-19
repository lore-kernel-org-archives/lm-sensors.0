From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: IBM Question
Message-Id: <20040112231811.1378762d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Is there a "Use at your own risk" version of sensors-detect I have
> IBM servers that do not have the suspect Eeprom, and the modules
> refuse to load saying that the machine is a laptop.
>  
> the i2c-piix4 module will not modprobe either.
>  
> Any help would be great.

There is no such version nor options to disable the locks.

It is assumed that someone skilled enough to decide it is safe to use
that stuff would also have the skill to disable the checks. There is one
check in sensors-detect, and one in i2c-piix4. Both are really easy to
find and disable.

We plan to disable at least the sensors-detect lock for non-laptop IBM
systems, but this hasn't been done yet, since a significant amount of
work is required to do this correctly.

Please report if you can do anything useful with our package on your
systems.

Good luck ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
