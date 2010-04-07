From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 07 Apr 2010 20:20:48 +0000
Subject: Re: [lm-sensors] lm-sensors on Asus CUSL2 motherboard
Message-Id: <w2z68676e01004071320odf46899k39c2ec01432f423b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <638607.35479.qm@web55607.mail.re4.yahoo.com>
In-Reply-To: <638607.35479.qm@web55607.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 7, 2010 at 8:54 PM, Lunar Cab <lunarcab@yahoo.com> wrote:
> I need your help to make lm-sensors work on my PC. I have CUSL2 motherboard
> and Asus AGP v8200 graphic card both with working thermal chips. However,
> I cannot get any temperature readings from them in Ubuntu 9.10 Karmic Koala
> (kernel 2.6.31-21-generic). I installed the latest version of lm_sensors and got
> the following after sensors-detect:

See this FAQ:
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

Check in dmesg for a similar warning message. Since this is an Asus
board you can try with asus_atk0110 driver.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
