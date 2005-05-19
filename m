From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: request for drivers
Message-Id: <1079353976.4055a278710d2@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1079336501.25709.182679907@webmail.messagingengine.com>
In-Reply-To: <1079336501.25709.182679907@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting James A Hunsaker IV <james-hunsaker@uiowa.edu>:

> SMSC 47B27x Super IO Fan Sensors
>    -There was a support ticket about this, and it was to be added to
>     the new drivers page, but I cannot find it.

Correct, I plain forgot to add the new LPC Super-IO chips on the new
drivers page, will do that this evening. Thanks for reminding me.

From what I remember of my datasheets reading, the 47B27x should be
fully compatible with the 47M10x chips, so the smsc47m1 driver should
work. Please find attached a patch which adds the 47B27x device ID to
the smsc47m1 driver. After applying it, you should be able to load the
driver, and hopefully it will work out-of-the-box.

Please provide feedback so that I know if I should apply this patch to
our CVS repository.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-smsc-lpc47b27x.diff
Type: application/octet-stream
Size: 848 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040315/9ed2a00d/lm_sensors-smsc-lpc47b27x.obj
