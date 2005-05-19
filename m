From: siegs@hotmail.com (John Siegler)
Date: Thu, 19 May 2005 06:25:49 +0000
Subject: Raw sensor readings
Message-Id: <BAY101-F36EBF0A9799BF1039FC5FEA43E0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I apologize if this is the wrong place to ask, but I am simply wondering 
what is the best way to obtain the raw readings (low order bits) from the 
sensors, in order to calculate randomness. I read in the values from the 
/proc/sys/dev/sensors files (using 2.4 kernel), but the values did not seem 
to contain the low order bits since the fan speed and cpu temp did not 
change much. Is there an easy way to access this data using libsensors, or 
will that give me the same not-very-random data? Or is there a driver 
available?

Thank you for your time,
John

