From: fabian.fenaut@free.fr (Fabian Fenaut)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: Sensors (W83627HF) in Tyan S2882
Message-Id: <40842F22.40009@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082387882.4083edaa52780@imp.gcu.info>	<200404191600.i3JG0ElX089970@zone3.gcu-squad.org>	<20040419190133.351d1401.khali@linux-fr.org>	<40840A18.8070907@free.fr>	<20040419195034.24664469.khali@linux-fr.org>	<4084192E.1040708@free.fr> <20040419204911.50cea556.khali@linux-fr.org>
In-Reply-To: <20040419204911.50cea556.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@stimpy.netroedge.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org

Jean Delvare wrote:
>>> Except that it doesn't apply, yes ;)
>>> 
>>> I suspect that your email client is converting tabs to spaces.
>> 
>> Sorry, see attachment.
> 
> 
> I forgot to tell you... Patches are prefered in such a form that
> patch -p1 from inside the linux directory works. Yours don't. I don't
> think Greg will like it. That said, I don't think Greg likes patches
> as attachements anyway ;)


Ok, same player shoot again...


--- linux-2.6.5/drivers/i2c/chips/Kconfig	2004-04-19 21:21:19.000000000 
+0200
+++ edit/drivers/i2c/chips/Kconfig	2004-04-19 21:21:53.000000000 +0200
@@ -163,7 +163,7 @@
  	select I2C_SENSOR
  	help
  	  If you say yes here you get support for the Winbond W8378x series
-	  of sensor chips: the W83781D, W83782D, W83783S and W83682HF,
+	  of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
  	  and the similar Asus AS99127F.
  	
  	  This driver can also be built as a module.  If so, the module
