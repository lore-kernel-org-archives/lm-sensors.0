From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Mon, 12 Feb 2007 17:36:58 +0000
Subject: [lm-sensors] VIA Epia EN12000 (w83697hf)
Message-Id: <45D0A5BA.4000902@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Anybody here using a VIA Epia EN12000?
I am looking for confirmation that the conversion in sensors.conf for
w83697hf on VIA EN12000 is accurate.
Currently I have FC6 with lm-sensors 2.10.1.
The conversion config does:

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)


Is this OK for w83697hf on EN12000?

Please confirm or advise.

Thanks,
Udo

