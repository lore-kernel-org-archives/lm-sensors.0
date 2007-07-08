From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Jul 2007 19:02:40 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-f71882fg-new-driver.patch
Message-Id: <469134D0.90109@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <468E48BA.4060005@hhs.nl>
In-Reply-To: <468E48BA.4060005@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 06 Jul 2007 15:50:50 +0200, Hans de Goede wrote:
>> This is a new driver for the hardware monitoring features of the Fintek
>> F71882FG and F71883FG Super-I/O chips.
>>
>> This version of the driver does not support the pwm part of these chips (yet).
>> I'll first design a sysfs api for this and post that for discussion, and then
>> implement pwm support as an incremental patch over this one.
> 
> Can you please update the F71882FG entry in wiki/Devices?
> 

Done.

>> This driver supports all sensors of this chip, except for the vid inputs. The
>> vid inputs are somewhat documented in the datasheet, but I know nothing about
>> vid/vrm stuff. Help with this would be much appreciated.
> 
> This isn't very difficult. Did you read doc/vid (in the lm-sensors
> source tree) already? That would be a good starting point. Then if you
> have specific questions, just ask and I'll try to help.
> 

Thanks for the pointer, I'll take a look.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
