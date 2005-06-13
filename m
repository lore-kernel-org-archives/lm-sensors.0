From: BlueWater@webhop.dyndns.org (Kevin)
Date: Mon, 13 Jun 2005 18:47:10 +0000
Subject: [lm-sensors] re: sensors, proc, and tellerstats problem
Message-Id: <200506131216.15798.BlueWater@sandbox.is.dreaming.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
 sensors version 2.9.1
 previous sensor version 2.8.8
 kernel version 2.6.11
 possible ticket reference : 1899

 I cannot get tellerstats to set up on the above 
configuration. My chip is detected (an it87) and the sensors 
program works fine. I had been using version 2.8.8 and first 
noticed there that the /proc entries had disappeared. I had 
thought that this was a bug in the version, but the same 
problem still exists in 2.9.1. Looking through the ticket 
database I found the reference #1899 where you said 
that /proc entries are gone in the 2.6 kernel. Is this true? 
If so, how and what could I use to track some historical 
data? 

 I have been using the sensors package on 2 machines now for 
some time, both soyo mb, a 2.4 and a 2.6 kernel, and have 
always accepted that tweaking the formulas was a must to 
obtain sensible numbers, but I don't have a clue as to how to 
get information out of the /sys entries as they appear in 
binary form, at least in part. For me, running sensors with 
some charting ability is a reliable way to reveal changes, 
trends, and upcoming problems. 

 I had looked at rdstats, but I cannot get the missing cgilib 
to install and be recognised, so this tool is not an option 
for me. 

 Any help on this is much appreciated.
-- 
????????????????????????????????????????????????

 Kevin
 kclarke@pb.net
 http://SandBox.Is.Dreaming.Org

????????????????????????????????????????????????

Reply-To will not work with this e-mail, 
kindly use signature above.

????????????????????????????????????????????????
????????????????????????????????????????????????

