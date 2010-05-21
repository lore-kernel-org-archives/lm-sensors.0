From: "Larry Gagnon" <lggagnon@uniserve.com>
Date: Fri, 21 May 2010 01:26:29 +0000
Subject: [lm-sensors] k10temp module not working with AMD X2 240 and Zotac
Message-Id: <op.vc07mfswopt8b6@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Using the Zotac GF-8200-C-E motherboard with an Athlon II X2 240 CPU.  
'sensors-detect' finds the k10temp chip and I have modprobed the "k10temp"  
module successfully. I use the 2.6.33 kernel so k10temp is included.  
However, on running "sensors" an error is thrown that do not have the  
correct kernel modules loaded:

"No sensors found!
Make sure you loaded all the kernl drivers you need...".

Any ideas greatly appreciated.

Larry Gagnon

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
