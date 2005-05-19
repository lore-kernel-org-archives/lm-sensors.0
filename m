From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: w83697hf -12v readings
Message-Id: <20041229125930.0e550e93.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D28D44.5080900@edeca.net>
In-Reply-To: <41D28D44.5080900@edeca.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> > Does the BIOS display values for -12V and -5V? If it does, what are 
> > they?
> 
> No, it does not, I hadn't noticed this.  It does display values for
> Vdimm and Vio though which aren't in sensors.

Don't you come to a conclusion at this point? ;)

What sensors think are -12V and -5V have to be Vdimm and Vio. Edit
/etc/sensors.conf:

    label in5 "Vdimm"
    label in6 "Vio"

Comment out the compute in5 and in6 lines.

    set in5_min 3.3 * 0.95
    set in5_max 3.3 * 1.05
    set in6_min 2.5 * 0.95
    set in6_max 2.6 * 1.05

Run sensors -s && sensors, see what it looks like. And adjust the limits
afterwards if needed.

Note that the sensors.conf.eg file has interesting comments about Epox
boards in the w83697hf-* section. You should read them, they seem to
apply to your board.

We may add specific notes for your board if you share your experience
once you get the correct configuration values.

-- 
Jean Delvare
http://khali.linux-fr.org/
