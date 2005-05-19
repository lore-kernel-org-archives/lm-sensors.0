From: reg@dwf.com (Reg Clemens)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: 2.8.7 doesnt see sensors on my machine.
Message-Id: <200406190250.i5J2oDgJ005370@orion.dwf.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry if there is a mailing list where this should be discussed, but
I didnt see any reference on one on the WEB page.

On my machine, with a 2.4.x kernel I saw minimal information from LM-SENSORS
(voltages, temperatures).

on the same machine with a 2.6.7 (and some previous,- probably all) kernel,
prog/detect/sensors-detect says 'no sensors detected' as does running sensors.

However, if I load the two modules that I used to (in my 
/etc/sysconfig/lm_sensors), namely i2c-viapro and w83781d, then 'sensors'
gives output equivalent to running under 2.4.x

In any case thought you would like the report, if I can provide any additional
useful information, let me know.


-- 
                                        Reg.Clemens
                                        reg@dwf.com

