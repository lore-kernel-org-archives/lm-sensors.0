From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 04 Jul 2007 06:55:48 +0000
Subject: [lm-sensors] Howto handle alarms which need to be reset?
Message-Id: <468B4474.5070309@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Anonymous has been so kind as to send me a datasheet for the fscpos sensor. 
Because of this I'm working on improved individual alarm file patches for the 
fscher (which is documented in Documentation/hwmon/fscher) and the fscpos as I 
now have a better understanding of these 2 chips.

Once an alarm condition has been signaled, it needs to be reset by software 
otherwise the alarm will stay present even if there no longer is a cause.

I see 2 solutions for this:
1) clear an alarm when it gets read by userspace, assuming the chip will set it
    again if the condition prevails (I need to test if this is true)
2) make the fooX_alarm file rw and make a write of 0 from userspace clear it

I prefer 1), asumming my assumption is true.

Suggestions, comments, advice?

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
