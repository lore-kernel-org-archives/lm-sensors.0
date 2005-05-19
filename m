From: zorba@ds14.agh.edu.pl (Marcin Kielar)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: cpu temperature on abit bx133 (w83782d)
Message-Id: <20040103175546.GA560@zorba.ds14.agh.edu.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi

i've installed lm_sensors on my linux box
(2.4.22, abit bx133 raid, celeron 800)
and have problems with cpu temperature.

BIOS displays value around 49c, after downclocking
my cpu by 200mhz - 40c. sensors shows 24-27, no matter
of cpu speed (if there is a corelation - it's very weak)

sensors -u:
w83782d-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
..
temp1: 24.00 (temp1)
temp1_hyst: -108.00 (temp1_hyst)
temp1_over: 52.00 (temp1_over)
temp2: 26.50 (temp2)
temp2_hyst: 65.00 (temp2_hyst)
temp2_over: 70.00 (temp2_over)
temp3: 28.50 (temp3)
temp3_hyst: 65.00 (temp3_hyst)
temp3_over: 70.00 (temp3_over)
sensor1: 3435.00 (sensor1)
sensor2: 1.00 (sensor2)
sensor3: 3435.00 (sensor3)

sensors 1 and 3 seem to work fine.
I've tried other types for second one, but
it gived even worse results.

I wasn't able to find anyone with similar problems...

anyone could help???

-- 
greetings
Marcin Kielar
