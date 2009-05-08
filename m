From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 08 May 2009 08:38:11 +0000
Subject: Re: [lm-sensors] Is the F71862FG supported?
Message-Id: <20090508103811.53077d71@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <31073ef90905071414o4c75a208g1e2efd4a593a7a62@mail.gmail.com>
In-Reply-To: <31073ef90905071414o4c75a208g1e2efd4a593a7a62@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Thu, 7 May 2009 14:14:42 -0700, Mark Wagner wrote:
> According to the website, the F71862FG chip is supported "since kernel
> 2.6.29".  However, I'm running 2.6.29 and lm-sensors 3.1.0, and
> "sensors-detect" gives the following output:
> 
> ===============
> Found `Fintek F71862FG Super IO Sensors'                    Success!
>     (address 0x295, driver `to-be-written')
> 
> Driver `to-be-written':
>   * ISA bus, address 0x295
>     Chip `Fintek F71862FG Super IO Sensors' (confidence: 9)
> 
> Note: there is no driver for Fintek F71862FG Super IO Sensors yet.
> Check http://www.lm-sensors.org/wiki/Devices for updates.
> ===============
> 
> Is it supported, or not?

Yes it is, we simply forgot to update sensors-detect when support was
added. This is fixed now, thanks for reporting!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
