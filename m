From: Vince Herried <vince@planetvince.info>
Date: Wed, 04 Feb 2009 03:16:46 +0000
Subject: [lm-sensors] how to set max temp for module coretemp?
Message-Id: <1233717406.13045.2.camel@lap2.vince>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In my /etc/sensors3.conf file I have
chip "coretemp-*"

 label temp1 "cpu0"
 label temp2 "cpu1"
 set temp1_max      40
 set temp1_max_hyst 37
 set temp2_max      52
 set temp2_max_hyst 47

[root@lap2 bin]# sensors -s
Error: Line 2455: Failed to set value
Error: Line 2456: Unknown feature name
Error: Line 2457: Unknown feature name
Error: Line 2458: Unknown feature name
coretemp-isa-0000: No such subfeature known
Error: Line 2455: Failed to set value
Error: Line 2456: Unknown feature name
Error: Line 2457: Unknown feature name
Error: Line 2458: Unknown feature name
coretemp-isa-0001: No such subfeature known
[root@lap2 bin]# 

I would like to be able to set the max temps
but apparently the coretemp driver doesn't allow it?

???
Vince

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
