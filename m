From: drstorm@data.pl (Marcin DrStorm Sliwinski)
Date: Sat, 10 Mar 2007 17:16:50 +0000
Subject: [lm-sensors] PC8374L SuperIO chip
Message-Id: <20070310181650.33ed8ef7@beast>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey
Are there any chances for support for Winbond PC8374L chip ?
I have it on my Intel D965G mainboard (name on chip: 8347lf2-c/l1). 
It's SuperIO without internal sensors but with fan RPM measure and PWM
It has also Sensorpath interface (single-wire sensors interface).
Basic info can be found here:
http://www.winbond-usa.com/mambo/content/view/305/528/
http://www.national.com/nationaledge/jan04/article.html
In attachment i've put sensors-detect log (lm-sensors-2.10.2)
I was looking for some docs over the net but found only electric characteristics and pinout
without any data about internal registers.
I hope anyone will be able to code driver for this ;)

Best regards
DrStorm

