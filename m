From: Arseny Klimovsky <arseny.klimovsky@gmail.com>
Date: Fri, 27 May 2011 09:43:23 +0000
Subject: [lm-sensors] Coretemp CPU support documentation
Message-Id: <4DDF723B.5060008@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, list

There is incorrect information about required kernel version for 
coretemp to work on the page http://www.lm-sensors.org/wiki/Devices

For example I have Core i3 550, but it doesn't work with 2.6.32 
(coretemp: Unknown CPU model 25), a newer kernel is required (I tested 
2.6.38).

So, I suppose it's better to use CPU model (0x25) or other stable 
information, but not marketing name (Core i3) for this table.

-- 
Arseny Klimovsky


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
