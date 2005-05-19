From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] restore correct vaio handling in eeprom driver
Message-Id: <20040117194036.447f5207.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111205346.6182c330.khali@linux-fr.org>
In-Reply-To: <20040111205346.6182c330.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The only other programs I know of that will access the eeprom file are
> our (four) Perl eeprom decoding scripts. They are not converted to the
> sysfs interface yet, but as they will be, they will take benefit of
> the optimization.

For information, I converted one of them (decode-vaio.pl) to sysfs
today. Works great, and the driver optimization serves its purpose:

decode-vaio
2.4.24      : 0m1.990s
2.6.1       : 0m0.550s
2.6.1+patch : 0m0.440s

The benefit is less impressive because the script gathers more
information than "sensors" does, so it reads 6 out of the 8 slices
("sensors" needs only 2). The three other scripts should take more
benefit of the optimization (I'd expect a 4:1 speedup for
decode-dimms.pl for example).

Another thing I forgot to mention in my previous posts: the speed
improvement applies only to the first time you run sensors or the
scripts, or after 5 minutes have passed. Consecutive reads do not
refresh the data so the speedup doesn't apply here. Still I think it's
great because the first run is what most users will remember of,
especially if they find it slow ;) and the buffer wears of after 5
minutes anyway.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
