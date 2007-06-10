From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Jun 2007 12:51:00 +0000
Subject: [lm-sensors] Improvements to fancontrol
Message-Id: <20070610145100.73595707@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I made some improvements to our fancontrol script today. From the SVN logs:

* Use let for arithmetic evaluation. Patch taken from the Suse package.
* Kill old commented-out code.
* No longer depend on grep. We already depend on egrep so let's use it
  everywhere.
* Don't depend on awk to compute the target PWM value. Bash has an arithmetic
  expression evaluation engine which does the job just fine.
* Use read instead of cat to read the sensor values. read is built-in, so
  it's cheaper.
* When sysfs is used (2.6 kernel), do not postproces the sensor value reads
  with cut, as it is not needed.
* Update the dependency list.

Testers are welcome. I also plan to add support for defining minimum
and maximum PWM values other than 0 and 255 when the measured
temperature is out of the interpolation range.

One interesting thing is that fancontrol now only calls one external
program (sleep) for each iteration when using a 2.6 kernel. Beforehand,
it was calling up to 10 external programs (3 cat, 5 cut, 1 awk, 1
sleep) for each iteration. The number of external programs being called
was one of the reason for reimplementing fancontrol in perl. Now that
the bash script behaves better, my feeling is that the perl script is
no longer needed, and I'd like to get rid of it in lm-sensors 3.0.0, to
lower our maintenance workload. Does anyone have a strong opinion
against this decision?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
