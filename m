From: MillTek <mill.tek@verizon.net>
Date: Tue, 12 Feb 2008 17:39:35 +0000
Subject: [lm-sensors] Kernel 2.6.24 and the F1882G chip
Message-Id: <47B1D9D7.2010200@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <47B1C83C.2050703@verizon.net>
In-Reply-To: <47B1C83C.2050703@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've just been told that I've screwed up by using the 'reply' button.  
Apparently this caused my initial posts to become threaded into other 
topics instead of starting a new on which can cause confusion. I 
apologize for that.

Anyway, here's my problem;

Kernel 2.6.24 for my distro (Arch Linux) came out in the last few days.
My board has a Fintek F1882g chip. It means that I can finally get
voltage and fan speeds for the board, so thanks for that.  I am
wondering how I correctly calculate the correct offset and factors for
the voltage numbers? This is what GKrellm says;

Vcor1  1.66  factor 1 offset 0
Vcor2  1.24  factor 1 offset 0
+3.3v   2.83  factor 3  offset 0
+5v      4.82  factor 4.98 offset 0
+12v    3.84 factor 4.0  offset 0
-12v    -4.35  factor -4.0 offset 0
-5v      -1.51  factor -1.667 offset 0
in7      1.66    factor 1  offset 0
in8       1.54   factor 1 offset 0

If there's a website that I should visit can anyone supply a link??


Jim



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
