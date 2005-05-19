From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: sensors stop working after some hours/days
Message-Id: <3C3BA28A.2087F0F3@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020108220123.CAPS1238.viefep16-int.chello.at@there>
In-Reply-To: <20020108220123.CAPS1238.viefep16-int.chello.at@there>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

use 'i2cdetect 0' and 'i2cdump 0 0x2d' (and check dmesg/syslog) to
attempt to isolate problem to either 756 or 83782.
Send us the output if it looks interesting.
mds

Matthias Meyer wrote:
> 
> Hello
> 
> I've a Motherboard Gigabyte GA-7IXE with
> CHIPSET
>  AMD? 751 (Irongate) North Bridge
>  AMD? 756 (Viper) South Bridge
>  Winbond W83977 I/O set
>  Winbond W83782 health chip
> 
> I use Mandrake 8.1 and so I have linux 2.4.8 with buildin sensors version
> 2.6.1.
> All works fine for a lot of hours.
> But after some time sensors stops reporting possible values. Instead it
> reports 0 for the temperatures and -1 for the fan speed.
> 
> Anybody have a idea ?
> 
> 
>                   Name: sensors.txt
>    sensors.txt    Type: Plain Text (text/plain)
>               Encoding: base64
