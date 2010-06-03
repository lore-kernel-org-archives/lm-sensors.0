From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Jun 2010 05:50:27 +0000
Subject: Re: [lm-sensors] Problem with fan speed sensor
Message-Id: <20100603075027.41a18965@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100602000918.jukhybiohcss4k8s@imap.uni-ulm.de>
In-Reply-To: <20100602000918.jukhybiohcss4k8s@imap.uni-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Saquib,

On Wed, 02 Jun 2010 00:09:18 +0200, mohammed.bin@uni-ulm.de wrote:
> My laptop is Sony Vaio vgn aw11m/h. I am using lm-sensors in my ubuntu  
> 10.04 lucid lynx. The cpu temperatue nd the gpu temperature are nicely  
> being monitored. The fan speed sensor however not working.
> 
> I read several articles about it in the web but could not come up with  
> any suitable solution.

It is difficult to help you, given the little detail you provided. "Not
working" isn't a proper way to describe the situation: there are many
ways thing can fail.

So I can only give you this general piece of information: most laptops
don't have a usable hardware monitoring chip and you have to rely on
ACPI for thermal management. The standard ACPI interface provides
temperature values but no fan speed values. We have a few BIOS drivers
for specific vendors, but we don't have any for Sony. So I am not
surprised if you don't get a fan speed reading on your Sony laptop - I
don't get any on mine either.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
