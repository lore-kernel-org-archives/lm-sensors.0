From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Jul 2007 19:09:27 +0000
Subject: Re: [lm-sensors] kernel TODO 20070708
Message-Id: <46913667.5060404@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070708181411.GE3584@jupiter.solarsys.private>
In-Reply-To: <20070708181411.GE3584@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi all:
> 
> PATCH: hwmon-fscpos-individual-alarm-files-v2.patch
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020253.html
> status: wants reviewer
> 

Notice that this patch has issues (alarms which need to be reset by userspace), 
  since I lack the hardware to test an improved version, and fixing this cannot 
be done without testing, I hereby withdraw this patch.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
