From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Feb 2009 12:57:19 +0000
Subject: Re: [lm-sensors] Intel DQ45CB motherboard and weird sensors output
Message-Id: <20090219135719.7ced43f6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <499372A3.6080803@frugalware.org>
In-Reply-To: <499372A3.6080803@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gabriel,

On Wed, 18 Feb 2009 00:53:35 +0100, Gabriel C wrote:
> I've found the following Super-I/O chip on the mobo :
> 
> Winbond WPCD377IAUFG
> 
> So it seems you are right.

OK, thanks for reporting. I have just committed a fix to sensors-detect
so that it will differentiate between LM96000/PC8374L (have sensors)
and WPCD377I (no sensors) on the SMBus. Please give it a try:
http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect

The next step would be to differentiate between PC8374L and WPCD377I on
the LPC bus. I don't know how do to that though, as I don't have any
datasheet for the WPCD377I. I'll ask my contact at Nuvoton. In the
meantime, can you please provide the output of the following command:

isadump 0x2e 0x2f 8

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
