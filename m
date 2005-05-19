From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: w83781d and alarms for temp2 and temp3
Message-Id: <20040507223708.4dab211e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040501224829.GA13732@pc.aurel32.lan>
In-Reply-To: <20040501224829.GA13732@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Yes, I hope the new patch attached is better.

Better but still not perfect:

 static const char *
-fmtTemps_W83781D
+fmtTemps_AS99127F_W83781D
 (const double values[], int alarm, int beep) {

Please don't rename that function. It adds noise to the patch with no
benefit. What's more, the AS99127F is admittedly an undocumented clone
of the Winbond chips. It doesn't deserve additional attention or credit.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
