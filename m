From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: cpu temperature on abit bx133 (w83782d)
Message-Id: <20040213210629.389097a1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040103175546.GA560@zorba.ds14.agh.edu.pl>
In-Reply-To: <20040103175546.GA560@zorba.ds14.agh.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> i've installed lm_sensors on my linux box
> (2.4.22, abit bx133 raid, celeron 800)
> and have problems with cpu temperature.
> 
> BIOS displays value around 49c, after downclocking
> my cpu by 200mhz - 40c. sensors shows 24-27, no matter
> of cpu speed (if there is a corelation - it's very weak)
> 
> sensors -u:
> w83782d-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> ..
> temp1: 24.00 (temp1)
> temp1_hyst: -108.00 (temp1_hyst)
> temp1_over: 52.00 (temp1_over)
> temp2: 26.50 (temp2)
> temp2_hyst: 65.00 (temp2_hyst)
> temp2_over: 70.00 (temp2_over)
> temp3: 28.50 (temp3)
> temp3_hyst: 65.00 (temp3_hyst)
> temp3_over: 70.00 (temp3_over)
> sensor1: 3435.00 (sensor1)
> sensor2: 1.00 (sensor2)
> sensor3: 3435.00 (sensor3)
> 
> sensors 1 and 3 seem to work fine.

Except temp1_hyst which seems to be plain broken.

> I've tried other types for second one, but
> it gived even worse results.

Correct, type 1 is what I'd expect to work for temp2.

> I wasn't able to find anyone with similar problems...

I browse our mailing-list archive and tickets database and couldn't
either.

> anyone could help???

Not really. The only thing I could suggest is loading the w83781d module
with the "init=0" parameter (after a reboot, preferably) so that it
keeps as much as possible from how the BIOS configured it. Then run
"sensors -u" without running "sensors -s" first, and see if it is any
better.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
