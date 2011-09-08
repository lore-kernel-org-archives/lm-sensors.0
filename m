From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Sep 2011 20:35:36 +0000
Subject: Re: [lm-sensors] Fintek F71862FG Super IO Sensors only shows
Message-Id: <20110908223536.30676e48@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
In-Reply-To: <CAPtvKsNGD2fY1Fo7BSLRqVVU+92Rh0YyfMbdD2FBFpu=bHhCng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 08 Sep 2011 22:32:22 +0200, Hans de Goede wrote:
> Now back to the problem, which is:
> [  216.012580] f71882fg f71882fg.656: Invalid (reserved) pwm settings: 0x01
> 
> Reading the data sheet, this means that the pwm settings for
> fan 2 and 3 are: 00 and 00, where as fan 1 has 01. The data sheet gives
> the following table for these:
> 
> 00: Reserved
> 01: Auto fan speed control, fan speed will follow different temperature by
> different duty cycle (voltage) that define in 0xB6-0xBE.
> 10: Reserved
> 11: Manual mode fan control, user can write expect duty cycle (PWM fan
> type) or voltage(linear fan type) to 0xC3, and F71883FG will output this
> value duty or voltage to control fan speed.
> 
> Never mind the F71883FG in there, this really if from the F71862FG datasheet
> (copy paste error in the data sheet), see:
> http://www.fintek.com.tw/eng/products.asp?BID=1&SID
> 
> So the driver bails because something, likely the BIOS on your board has
> written an illegal value to the Fan mode Select Register.
> 
> I guess the BIOS only setups fan 1 and the *cough* brilliant *cough* BIOS
> developers decided to just write 00 as value for the other fans, sigh.
> 
> There are really 2 things we can do here:
> 1) Overwrite the BIOS settings, tricky, could do this with a module option
> 2) Instead of not binding the driver at all, allow the driver initialization
> to continue normally, but don't register the pwm interface. This requires
> some thinking wrt modifying the code a bit though.
> 
> 1 is a really bad idea IMHO, so I'll think a bit about doing 2.

And of course option 0, to start with, is to check for a BIOS update
for the board in question, and report to the vendor if no BIOS fix is
available yet.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
