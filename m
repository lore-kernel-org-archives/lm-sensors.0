From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 May 2008 15:43:16 +0000
Subject: Re: [lm-sensors] Supermicro C2SBE
Message-Id: <20080506174316.4304e842@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <482054DE.1070005@dolbeau.org>
In-Reply-To: <482054DE.1070005@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 06 May 2008 14:53:50 +0200, Romain Dolbeau wrote:
> As I have posted the dmidecode for this board, I'll mention it for the
> sake of completeness.
> 
> I don't have any configuration for the C2SBE, as the on board W83627DHG
> is seen on the ISA bus (not on i2c?) but doesn't display anything.

Can you include what this "nothing" looks like exactly? If that's all
zeroes, the chip is there but unused. If that's nothing at all, it
suggests that your version of libsensors is too old. Support for the
W83627DHG was added in lm-sensors 2.10.2.

> Here's what dmesg has to say:
> 
> w83627ehf: Found W83627DHG chip at 0x290
> w83627ehf w83627ehf.656: VID pins in output mode, CPU VID not available

Some boards don't use the integrated monitoring features of the
Super-I/O, if the manufacturer prefers to add a dedicated monitoring
chip on the SMBus. sensors-detect should tell. If that's a recent
board, you need a recent version of sensors-detect:

http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect?format=txt

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
