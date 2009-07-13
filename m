From: Martyn Welch <martyn.welch@gefanuc.com>
Date: Mon, 13 Jul 2009 10:52:44 +0000
Subject: Re: [lm-sensors] Can someone give me some help? thanks
Message-Id: <4A5B11FC.4030206@gefanuc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c98b13f80907101313g76b337batfe028da5046fcd00@mail.gmail.com>
In-Reply-To: <c98b13f80907101313g76b337batfe028da5046fcd00@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

he liang wrote:
>
> Just press ENTER to continue:
>
> I will now generate the commands needed to load the required modules.
>
> To load everything that is needed, add this to /etc/modules:
>
> #----cut here----
> # Chip drivers
> w83627ehf
> coretemp
> #----cut here----
>
> Do you want to add these lines automatically? (yes/NO)yes
> psy@psy-desktop:~$ <mailto:psy@psy-desktop:%7E$> sudo sensors
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
>
Have you tried rebooting? Adding those lines to "/etc/modules" should 
take effect after a reboot.

Try rebooting or issuing the following commands to load the modules:

  sudo modprobe w83627ehf
  sudo modprobe coretemp

Hope that helps,

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 927559189

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
