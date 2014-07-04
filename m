From: Leandro de Marco <leandromarco@gmail.com>
Date: Fri, 04 Jul 2014 15:22:31 +0000
Subject: [lm-sensors] Help with PMBus VOUT_COMMAND
Message-Id: <CAFO4QpCX7THAeyOyvzx7grmixaFKaVC4Eh2WmnyxV8-4FT94kg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi. I need to configure a BMR464 vout parameter.

For what I've read this is not supported and won't be supported as a
sysfs interface entry, as this is intended for monitoring purposes
only.

I found this message, from 1 year ago, that received no response:
http://lists.lm-sensors.org/pipermail/lm-sensors/2013-July/039441.html

Is the ioctl a better approach to set the output? Can't we set this
via sys-fs interface and allow only a privileged user to change it?

I would like to have some direction here about what is the best way to
implement this.

Thanks!

-- 
Leandro
--------------------------------------------------------------------------
My Mind is Not for Rent.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
