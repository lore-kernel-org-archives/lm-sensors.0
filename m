From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Fri, 26 Dec 2008 16:42:38 +0000
Subject: Re: [lm-sensors] Sensors 3.0.3 on CentOS 5.2 (kernel 2.6.18) shows
Message-Id: <4955097E.7070701@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4953F5E1.8050906@Winfirst.Com>
In-Reply-To: <4953F5E1.8050906@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 12/26/08 07:38, Jean Delvare wrote:
> Hi Mark, Hans,
> 
> Le Vendredi 26 Décembre 2008 12:17, Hans de Goede a écrit :

[ snip ]

>> The CentOS 2.6.18 kernel does not have the it87 driver.
> 
> Or, more likely, it has the it87 driver but that driver doesn't yet
> support the ITE IT8716F. Looking at:
>   http://www.lm-sensors.org/wiki/Devices
> it says that support was added in kernel 2.6.19.
> 

Thanks Hans, Jean.

I've installed CentOS from the installation CDs, and upgraded to the latest
packages using 'yum'. How do I get the 2.6.19 kernel? I'm also asking on the
CentOS support forum, but wanted to ask here as I figured you guys run into
this from time to time and may just know.

I searched at pbone.net and Google'd, but didn't find anything.

Thanks,


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
