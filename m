From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 03 Mar 2014 21:33:19 +0000
Subject: Re: [lm-sensors] How values are populated in sysfs enteries in LM73 sensor
Message-Id: <20140303223319.29513a8c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAi8uRzZizJk0Kk2zXhySG7zNdW6BwtPWJxhDJ9WnzK5xS0ThQ@mail.gmail.com>
In-Reply-To: <CAAi8uRzZizJk0Kk2zXhySG7zNdW6BwtPWJxhDJ9WnzK5xS0ThQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 3 Mar 2014 10:58:21 -0800, Romanic Dean wrote:
> Hi all
> 
> I am going through LM73 sensor implementation and wanted to know
> how different entries in sysfs is populated .
> 
> I can see max and min temp. values are hard coded in code itself
> 
>  #define LM73_TEMP_MIN           (-256000 / 250)
> #define LM73_TEMP_MAX           (255750 / 250)
> 
> But what about the current temp. values ,how it is populated?
> 
> Is it read from EEPROM and then populated into sysfs entry temp_input1?
> 
> Can anyone let me know these values are populated and what is role of
> EEPROM here?

What makes you think there is any EEPROM involved?

You keep asking vague questions, we can't really help you.

The datasheet is available:
http://www.ti.com/product/LM73

The source code is available:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/lm73.c

The driver documentation is available:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/hwmon/lm73

The sysfs interface documentation is available:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/hwmon/sysfs-interface

A brief introduction to user-space tools is available:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/hwmon/userspace-tools

So please read all of these. If you still have question, feel free to
ask, but in a clear way so that we can understand.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
