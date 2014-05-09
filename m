From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 09 May 2014 08:01:04 +0000
Subject: [lm-sensors] [PATCH 0/3] First shot at a hwmon device name mapper
Message-Id: <20140509100104.3dcdb46d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

As discussed lately on this list, here is a first shot at a helper
binary that resolves libsensors chip names to kernel device names and
back.

This is really a proof of concept at this point. Everything can still
be discussed and changed, just speak up if you see any problem or to
ask for improvements. Specifically I have no preference for the tool's
name or its command line interface, so if you can think of anything
better, just let me know.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
