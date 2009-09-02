From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Sep 2009 13:09:28 +0000
Subject: Re: [lm-sensors] How to Communicate with chips on the ISA bus/SMBus?
Message-Id: <20090902150928.25fe05f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 24 Aug 2009 16:59:50 -0500, Javier Andres Caceres Alvis wrote:
> Hi there,
> 
> 
> This is a low level (native development) question. A motherboard can contain
> sensors to read many values (voltage, fan speed, etc).
> I understand that many manufactures place this information at ISA-SM I/O
> ports.
> I have a Fintek F71882 "Super Hardware Monitor" datasheet which tells the
> memory addresses where bit registers are located, but I don't know how to
> access to such as memory blocks under Windows.
> 
> Here a list of some hw monitor/sensor manufacturers:
> http://www.almico.com/forumsensors.php
> Here an explanation on ISA/SMBus funtionality:
> http://www.lm-sensors.org/wiki/FAQ/Chapter1
> 
> Thanks a lot. unfortunally these topics lack of documentation under windows.

We are doing only Linux development here, so we simply can't help you.
You better find a Windows-oriented developer forum or mailing list for
your questions.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
