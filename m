From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: pwmconfig
Message-Id: <20030721115123.11b859d1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

I gave a try to pwmconfig and there are two bugs I'd like to report:

1* The script hangs if the config file does not exist. It creates the
file /etc/fancontrol, and hangs right after, with the message "Loading
configuration from  ..." (it should display the file name, that is,
/etc/fancontrol, there). Patch attached, I'll commit it unless someone
objects.

2* After running pwmconfig, the temperatures reported by sensors are all
wrong (and not by a few degrees).

Before:
M/B Temp:    +31?C  (limit =  +42?C, hysteresis =  +40?C)
CPU Temp:  +51.4?C  (limit =  +60?C, hysteresis =  +56?C)
P/S Temp:  +31.4?C  (limit =  +42?C, hysteresis =  +40?C)

After:
M/B Temp:    -45?C  (limit =  +42?C, hysteresis =  +40?C)
CPU Temp: +217.4?C  (limit =  +60?C, hysteresis =  +56?C)
P/S Temp: +211.4?C  (limit =  +42?C, hysteresis =  +40?C)

Weird, isn't it? Running 'sensors -s' doesn't make them back to normal,
I have to reboot in order to do so.

My sensor chip is an a99127f.

Additionally, pwmconfig does not work for me, but maybe that's just my
system not supporting it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Index: pwmconfig
=================================RCS file: /home/cvs/lm_sensors2/prog/pwm/pwmconfig,v
retrieving revision 1.2
diff -u -r1.2 pwmconfig
--- pwmconfig	5 Jul 2003 16:00:20 -0000	1.2
+++ pwmconfig	21 Jul 2003 09:54:36 -0000
@@ -307,6 +307,7 @@
 			touch $X
 			chmod 0660 $X
 			chown root.root $X
+			FCCONFIG=$X
 		else
 			AskPath
 		fi
