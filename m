From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: IBM hardware
Message-Id: <20040317223448.7e44da65.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200403161623.00418.rafael.espindola@ic.unicamp.br>
In-Reply-To: <200403161623.00418.rafael.espindola@ic.unicamp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have edited the sensors-detect script. I have also executed the
> programs from the dmidecode CVS. The results are in the attached file.
> 
> The machine is up and running with no problems. :)

Nice, although it didn't provide anything very interesting (only memory
module EEPROMs, not really sensors-related). Still, good to know that we
can whitelist these machines.

The output of sensors-detect suggests that you have a Super IO chip
on-board, but not one we support. If you can find documentation about
what it is, maybe it has some hardware monitoring or fan control
features.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
