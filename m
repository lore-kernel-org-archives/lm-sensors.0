From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Feb 2007 16:50:55 +0000
Subject: [lm-sensors] hwmon-vid: Unknown VRM version of your x86 CPU
Message-Id: <20070227175055.ac62e315.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43834A86.6090205@sh.cvut.cz>
In-Reply-To: <43834A86.6090205@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Udo,

On Tue, 27 Feb 2007 17:08:11 +0100, Udo van den Heuvel wrote:
> Jean Delvare wrote:
> >> Same problem as some time ago when
> >> Rudolf Marek wrote:
> >>> Please apply it and see the system log for result. (and of course mail it back)
> >> I now have a VIA Epia EN12000 which shows in dmesg:
> >>
> >> hwmon-vid: Unknown VRM version of your x86 CPU
> >>
> >> # cat /proc/cpuinfo
> >> processor       : 0
> >> vendor_id       : CentaurHauls
> >> cpu family      : 6
> >> model           : 10
> >> model name      : VIA Esther processor 1200MHz
> (....)
> > Indeed we do not support this CPU family at the moment.
> 
> OK. It can be fixed?
>
> >> Need more info?
> > 
> > We'd need to know which VRM standard this CPU wants. Which hardware
> > monitoring chip and driver are you using? 
> 
> driver w83627hf
> chip w83697hf

Unfortunately this chip doesn't have VID pins, so we won't be able to
investigate.

OTOH, the good news is that it means that you can safely ignore the log
message.

-- 
Jean Delvare

