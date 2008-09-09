From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Sep 2008 16:21:50 +0000
Subject: [lm-sensors] pwmconfig improvements
Message-Id: <20080909182150.7ae38086@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I have done a number of usability improvements to pwmconfig. I would
welcome testers. The latest version of pwmconfig can be downloaded
there:
http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/prog/pwm/pwmconfig?format=raw

Changes are as follows:
  pwmconfig: Tell the user about gnuplot if isn't installed
             Fix MINSTOP and MINSTART test functions
             Test MINSTOP before MINSTART
             Use better step values for MINSTOP test
             Print the revision and date at start-up
             Detect and report obviously incorrect fan speeds
             Determine MINSTOP automatically
             Skip MINSTOP and MINSTART tests if fan can't stop
             Change default for MINTEMP from 0 to 20 degrees C

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
