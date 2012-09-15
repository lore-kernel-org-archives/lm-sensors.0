From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 15 Sep 2012 14:50:47 +0000
Subject: Re: [lm-sensors] Support for Intel H77
Message-Id: <20120915145047.GA21193@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50542433.6040901@yahoo.com>
In-Reply-To: <50542433.6040901@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 15, 2012 at 09:46:11AM +0300, Jonas Vasiliauskas wrote:
> Hi there,
> 
> I hope you are doing well. Is there full support for intel h77 chip
> ? I'm able to read temperatures using coretemp module, but can't
> anyhow read fan speeds, not sure, maybe there is no support on
> sensors for this chip ? Its one of the most decent, but not sure,
> maybe you guys know how to get fan RPMs on console ? ;)
> 
First of all, that is not a H77 (PCH) question, but a board question, and
primarily depends on the SuperIO chip used on your board. Also, your board
specification will tell you if the board uses the SuperIO chip or MEI for fan
control.

You might want to try running the latest version of sensors-detect (from
http://www.lm-sensors.org/wiki/Download). That should tell you which SuperIO
chip is used. Intel often uses Nuvoton NCT6775F. If so, use the driver at
https://github.com/groeck/nct6775 and check if it handles fan control.
If it does, you are lucky. If not, fan control may be handled by MEI (again,
your motherboard specification should tell you that). In that case, you'll
have to wait for someone to write a MEI fan control driver (or write one
yourself ;).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
