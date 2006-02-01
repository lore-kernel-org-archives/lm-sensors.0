From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 01 Feb 2006 21:45:03 +0000
Subject: [lm-sensors] use of struct platform_device vs struct device in
Message-Id: <43E12BDF.1020805@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi Jean,

while LXR'g  (http://sosdg.org/~coywolf/lxr/)
for usage of struct platform_device, I found your code.


What were your reasons for using platform_device, what are the benefits ?

Were they special-case considerations, or is this something that
other hwmon drivers should consider moving towards ?

