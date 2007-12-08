From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 08 Dec 2007 11:19:11 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Fix typo for NSC
Message-Id: <20071208121911.768dec08@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0712081041290.32213@elfpc10.elmagn.chalmers.se>
In-Reply-To: <Pine.LNX.4.63.0712081041290.32213@elfpc10.elmagn.chalmers.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ulf,

On Sat, 8 Dec 2007 11:00:19 +0100 (CET), Ulf Jordan wrote:
> In the Super IO detection section of sensors-detect, devid = 0xd0 is 
> identifed as PC87371 and 0xdf as PC97371. According to National's 
> datasheets these SIDs correspond to PC87317 and PC97317, respectively. 
> PC87371 and PC97371 do not seem to exist.

Correct.

> Some further discussion is available on the LinuxBIOS mailing list in 
> the thread starting at 
> http://www.linuxbios.org/pipermail/linuxbios/2007-December/027954.html

I guess that LinuxBIOS copied the mistake from us, don't blame them ;)

> Attached is a patch that fixes the typo.

Patch applied, thank you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
