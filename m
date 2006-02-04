From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Feb 2006 11:03:38 +0000
Subject: [lm-sensors] ASUS P5P800 and winbond chip w83627hf - suggestion
Message-Id: <20060204120338.3e3b395d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

(Moved to the lm-sensors list.)

> I have a mother board ASUS P5P800 with a winbond chip w83627hf.
> if i want that the sensors working (using lm-sensors), i must
> change a part of the file "w83627hf.c".
> In particular, i must change the line
>
> #define W627THF_DEVID 0x82
>
> to
> 
> #define W627THF_DEVID 0x88
>
> and all work!
>
> I've found this "trick" in some forums, in particular i've found
> this suggestion in this site:
> http://archives.andrew.net.au/lm-sensors/msg28603.html

The archive of this mailing list ;)

The chip you have on your board is a Winbond W83627EHF. It is not
supported by the w83627hf driver. The suggestion you found in the post
mentioned above was a simple first approximation trick. However, it
turned out that the W83627EHF is too different from the chips supported
by the w83627hf driver.

We have started a dedicated driver for your chip, named (surpsise)
w83627ehf. It was merged in Linux 2.6.13. It's still imcomplete for now
(only temperatures and fans are monitored) but there is some
development going on (thanks to Winbond themselves, among others) so
the driver should be completed soon.

-- 
Jean Delvare

