From: <JGong@winbond.com>
Date: Thu, 05 Jul 2007 11:27:40 +0000
Subject: Re: [lm-sensors] Help wanted: individual alarm files
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE01A31748@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070701220005.1dda9d8f@hyperion.delvare>
In-Reply-To: <20070701220005.1dda9d8f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

>The future libsensors assumes that all hardware monitoring drivers
>follow the standard sysfs interface defined in
>Documentation/hwmon/sysfs-interface. They all mostly do already, except
>for one thing: alarms. Most drivers are still only exposing a single
>file with all alarms in a bit-vector, in chip-dependent order. In order
>to let the new libsenors display the alarms properly, we must add
>individual alarm files to these drivers. For some drivers, fault and/or
>beep files need to be added too.

I'd like to take care of w83792d chip's converting work. It will be
finished in the next week.

And could you please give me some information about the ASUS motherboard
with w83791d chip using for hardware monitor function? 

Any help will be welcome.

Best regards,
Gong Jun


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
