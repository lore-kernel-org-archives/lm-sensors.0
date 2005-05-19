From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: gs10
Message-Id: <20041004134221.M81210@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041003231641.M43741@palei.com>
In-Reply-To: <20041003231641.M43741@palei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 4 Oct 2004 09:31:19 -0400, Paul Aviles wrote
> I read that there is a way to programatically control the speed of 
> the fans with some type of command if the temperature for example is 
> lower than x, is that so?

Some chips can be programmed to automatically adjust the fan speed according
to the value of one or more temperature measurements. The PC87360 family
doesn't, as far as I remember. It does however allow manual speed control over
the fans, providing that your motherboard is adequately wired. This is done
through the files /proc/sys/dev/sensors/pc87366-isa-*/pwm* (which you should
get once the pc87360 driver loads succesfully). See in our prog/pwm directory,
there are a couple scripts if you are interested in fan speed control.

-- 
Jean Delvare
http://khali.linux-fr.org/
