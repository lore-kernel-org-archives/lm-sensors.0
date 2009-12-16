From: comsublant@gmx.net
Date: Wed, 16 Dec 2009 15:23:18 +0000
Subject: Re: [lm-sensors] ATK0110 breaks keyboard and mouse on asus p7p55d -
Message-Id: <20091216152318.GA16967@vampire>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
In-Reply-To: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Dec 16, 2009 at 03:05:16PM +0100, Luca Tettamanti wrote:
> 
> I have a report of a working P7P55D (plain) with BIOS 0711; the DSDT
> of the working board is very different from yours. Can you try and
> upgrade the BIOS?
> 
> Luca

My board was already shipped with 1102, and really don't want to
downgrade.

-r--r--r-- 1 ftp ftp         994530 Aug 27  2009 P7P55D-ASUS-0501.zip
-r--r--r-- 1 ftp ftp        1001476 Sep 08  2009 P7P55D-ASUS-0606.zip
-r--r--r-- 1 ftp ftp        1014992 Sep 30  2009 P7P55D-ASUS-0711.zip
-r--r--r-- 1 ftp ftp        1021356 Nov 05  2009 P7P55D-ASUS-0911.zip
-r--r--r-- 1 ftp ftp        1021410 Nov 12 17:01 P7P55D-ASUS-0915.zip
-r--r--r-- 1 ftp ftp        1022785 Nov 20 17:05 P7P55D-ASUS-1002.zip
-r--r--r-- 1 ftp ftp        1023694 Nov 28 01:00 P7P55D-ASUS-1102.zip
-r--r--r-- 1 ftp ftp        1025919 Dec 14 17:01 P7P55D-ASUS-1207.zip

i'll might give 1207 a try, which is just 2 days old, can't tell if
this is fixing anything, from what they say.
Although it might help with my speedstepping/turboboost problem, which
i have deactivated atm.

[ 1207 ]
----------------------
1.Update JMicron 361 Option ROM
2.Update EZ-flash 2 function
3.Fix some PCIEx1 LAN card can't be detected at PCH PCIEx1 slot.
4.Update CPU Level Up function.
5.Fix CPU power always show 2.5W in EPU software.

-cteg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
