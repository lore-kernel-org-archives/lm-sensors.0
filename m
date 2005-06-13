From: per@computer.org (Per Jessen)
Date: Mon, 13 Jun 2005 11:09:16 +0000
Subject: [lm-sensors] My 333 DIMMs are only being recognised as 266 by the
Message-Id: <d8jidr$7rp$1@saturn.local.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I have a couple of new AOpen boards, each with a single Kingston PC2700 333MHz 256Mb DIMM stick. 
At start-up, both boards report the memory operating at 266MHz, in spite of the DIMMs being
specified as 333MHz. 
I was hoping decode-dimms would help me determine what the SPD says about this, but "Intel
Frequency Specification" comes out as "Undefined!" ...

This is the decode-dimms output (in HTML format):  http://jessen.ch/files/spd-decoded

Can someone help me point the finger at either Kingston or AOpen? 


-- 
/Per Jessen, Z?rich
http://www.spamchek.ch/freetrial - ?berzeugen Sie sich - 30 Tage kostenlos und unverbindlich!

