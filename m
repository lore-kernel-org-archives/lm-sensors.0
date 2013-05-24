From: Santi Villalba <sdvillal@gmail.com>
Date: Fri, 24 May 2013 09:47:55 +0000
Subject: [lm-sensors] ITE IT8518E supported in coreboot, helpful?
Message-Id: <519F374B.3070101@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This controller is giving people some trouble, as it is shipped in more 
and more laptops [1] and the fans can become quite annoying in these 
systems.

In the past it was said that the main problem was the lack of a 
datasheet from ITE [2]. Recently there has been progress from the 
coreboot projects getting the info for quanta firmware on IT8518 [3]. 
Can this particular file help with the lack of specs or it depends on 
other factors?
http://review.coreboot.org/gitweb?p=coreboot.git;a=blob;f=src/ec/quanta/it8518/acpi/ec.asl;hu49fa283da69b9b1fca8589b1fc7f59fd30f7a4;hb~568559634199668859b7c662aea7f6b41f3920

In my particular case, I have a noisy clevo p150em. I can help providing 
testing and perhaps developing - just looking at the code of other 
modules, it87, it seems to me I could give a hand beyond testing.

Thanks

[1] https://bbs.archlinux.org/viewtopic.php?id4462
      http://forums.debian.net/viewtopic.php?f=7&tv146
http://forums.opensuse.org/english/get-technical-help-here/laptop/486412-cpu-cooler-runs-almost-constantly.html
http://www.linuxmint-fr.org/forum/systeme/145143-ventilateur-qui-tournent-a-fond-no-pwm-capable-sensor-modules.html

[2] 
http://lists.lm-sensors.org/pipermail/lm-sensors/2012-February/035486.html

[3] 
http://review.coreboot.org/gitweb?p=coreboot.git;a=commitdiff;h~568559634199668859b7c662aea7f6b41f3920


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
