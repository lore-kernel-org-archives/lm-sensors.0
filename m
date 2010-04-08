From: Lunar Cab <lunarcab@yahoo.com>
Date: Thu, 08 Apr 2010 17:29:22 +0000
Subject: Re: [lm-sensors] lm-sensors on Asus CUSL2 motherboard
Message-Id: <212218.97643.qm@web55605.mail.re4.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7630035201086391740=="
List-Id: <lm-sensors.vger.kernel.org>
References: <638607.35479.qm@web55607.mail.re4.yahoo.com>
In-Reply-To: <638607.35479.qm@web55607.mail.re4.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============7630035201086391740==
Content-Type: multipart/alternative; boundary="0-1698136317-1270747762=:97643"

--0-1698136317-1270747762=:97643
Content-Type: text/plain; charset=us-ascii

Dear Luca,

thank you very much for your reply. Using your advice, I've got the following message from dmesg:

[ 5321.294515] ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe80f] conflicts with ACPI region SM00 [0xe800-0xe806]
[ 5321.294527] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver

So, as you suggested, I probably should enable asus_atk0110 driver. Could you please tell me how to do that?

--- On Wed, 4/7/10, Luca Tettamanti <kronos.it@gmail.com> wrote:

From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [lm-sensors] lm-sensors on Asus CUSL2 motherboard
To: "Lunar Cab" <lunarcab@yahoo.com>
Cc: lm-sensors@lm-sensors.org
Date: Wednesday, April 7, 2010, 1:20 PM

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



      
--0-1698136317-1270747762=:97643
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">Dear Luca,<br><br>thank you very much for your reply. Using your advice, I've got the following message from dmesg:<br><br>[ 5321.294515] ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe80f] conflicts with ACPI region SM00 [0xe800-0xe806]<br>[ 5321.294527] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver<br><br>So, as you suggested, I probably should enable asus_atk0110 driver. Could you please tell me how to do that?<br><br>--- On <b>Wed, 4/7/10, Luca Tettamanti <i>&lt;kronos.it@gmail.com&gt;</i></b> wrote:<br><blockquote style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"><br>From: Luca Tettamanti &lt;kronos.it@gmail.com&gt;<br>Subject: Re: [lm-sensors] lm-sensors on Asus CUSL2 motherboard<br>To: "Lunar Cab" &lt;lunarcab@yahoo.com&gt;<br>Cc: lm-sensors@lm-sensors.org<br>Date:
 Wednesday, April 7, 2010, 1:20 PM<br><br><div class="plainMail">On Wed, Apr 7, 2010 at 8:54 PM, Lunar Cab &lt;<a ymailto="mailto:lunarcab@yahoo.com" href="/mc/compose?to=lunarcab@yahoo.com">lunarcab@yahoo.com</a>&gt; wrote:<br>&gt; I need your help to make lm-sensors work on my PC. I have CUSL2 motherboard<br>&gt; and Asus AGP v8200 graphic card both with working thermal chips. However,<br>&gt; I cannot get any temperature readings from them in Ubuntu 9.10 Karmic Koala<br>&gt; (kernel 2.6.31-21-generic). I installed the latest version of lm_sensors and got<br>&gt; the following after sensors-detect:<br><br>See this FAQ:<br><a href="http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31" target="_blank">http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31</a><br><br>Check in dmesg for a similar warning message. Since this is an Asus<br>board you can try with asus_atk0110
 driver.<br><br>Luca<br></div></blockquote></td></tr></table><br>

      
--0-1698136317-1270747762=:97643--


--===============7630035201086391740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7630035201086391740==--
