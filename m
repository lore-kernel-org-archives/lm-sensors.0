From: Charles <c@catcons.co.uk>
Date: Sat, 03 Dec 2011 13:56:10 +0000
Subject: [lm-sensors] Kernel module asus_atk0110
Message-Id: <4EDA27AA.7030203@catcons.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello :-)

According to http://hansdegoede.livejournal.com/7932.html and
http://pavelshub.com/blog/2010/12/fatal-error-inserting-w83627ehf/, the
proper module to use on ASUS motherboards equipped with the Nuvoton
NCT6776F is asus_atk0110, not w83627ehf, but there is an open lm_sensors
ticket (http://www.lm-sensors.org/ticket/2374) about sensors-detect not
supporting is asus_atk0110.

Running Slackware64 13.1 with a 2.6.38.7 kernel on an ASUS P8H67-V
motherboard with an NCT6776F and asus_atk0110 modeprobed, sensors-detect
3.3.1 was not successful.  Digging deeper, looking for directories under
/sys/bus/acpi/drivers/ATK0110 found nothing:

root@CW8:~# ls -l /sys/bus/acpi/drivers/ATK0110
total 0
--w------- 1 root root 4.0K 2011-12-02 18:49 bind
--w------- 1 root root 4.0K 2011-12-02 18:49 uevent
--w------- 1 root root 4.0K 2011-12-02 18:49 unbind

Others have been able to use asus_atk0110 with lm_sensors (examples:
http://pastebin.com/8gREkwXZ,
http://comments.gmane.org/gmane.comp.gnome.apps.gkrellm/1556,
http://forums.opensuse.org/english/get-technical-help-here/pre-release-beta/423075-does-your-pwmconfig-find-modules-run.html;
there are many more).

The issue was worked around by using kernel option
acpi_enforce_resources=lax but I understand this will not work with
later kernels.

What to do for best?

Best

Charles

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
