From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: pwm fan control with IT8705F I/O chip it87 module
Message-Id: <41B61C4F.3090405@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128203714.40067.qmail@web13425.mail.yahoo.com>
In-Reply-To: <20041128203714.40067.qmail@web13425.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

doc/chips/it87 explains how to configure PWM.

Troy Will wrote:
>                    Novmember 28, 2004
> Hello,
> I've been attempting to control the fan speed on a
> Biostar iDEQ 210V computer which has an IT8705F Super
> I/O chip. Does the it87 module ( which controls the
> IT8705F chip ) enable pwm motor fan control? I have
> read similar queries but haven't read any definitive
> answers.
> 
> The it87 documentaton says this: "The fan control
> features can be enabled by setting bits 0-2 of the
> fan_ctl register to 1." However, the documentation is
> silent on how to set this these bits. Can these
> register bits be set with isaset? Can they be set
> somehow in the /etc/sensors.conf file?
> 
> Similarly, the it87 documentation says this: "Bit 7 of
> the pwm[1-3] registers enables/disables the chips
> automatic temperature control mode for the specified
> fan." But again, it has no mention on how to set or
> read these registers.
> 
> Any help would be apprecitated. By the way, I can read
> the fan speed. Since I'm sure other people are trying
> to do the same thing I will set up the following web
> page if I come up with a solution:
>       biostar-linux.com/fancontrol.html
> 
> 
> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> The all-new My Yahoo! - Get yours free! 
> http://my.yahoo.com 
>  
> 
> 
