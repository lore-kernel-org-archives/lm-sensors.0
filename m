From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 16 Mar 2013 22:59:48 +0000
Subject: Re: [lm-sensors] Dell Inspiron 530 Chassis Fan Control?
Message-Id: <20130316225948.GA23321@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130316175820.GA979@whitehail.bostoncoop.net>
In-Reply-To: <20130316175820.GA979@whitehail.bostoncoop.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 16, 2013 at 11:16:08PM +0100, Jean Delvare wrote:
> On Sat, 16 Mar 2013 17:01:12 -0400, Adam Rosi-Kessel wrote:
> > On 3/16/2013 4:00 PM, Jean Delvare wrote:
> > >> Sorry -- typo above. It should say I can control *CPU* fans, but can't
> > >> find any documentation as to how to control the *chassis* fan.
> > > On my motherboard, all fan headers have 4 pins, but there is a jumper
> > > to tell the board to treat the case fan headers as 3-pin. This is
> > > rather rare though, most motherboards have it hard-wired
> > Thanks. I will check this. Before I open up my case, is there anywhere I 
> > can/should look in log files or /sys to see if the chassis fan is 
> > controllable? Would this be found in a different place than the CPU fans?
> 
> No, it can't be seen from the logs nor /sys. Only hardware inspection
> can tell you, and not even in all cases.
> 
Inspiron 530 manual (downloadable) says that the processor fan has a 4-pin
connector and the chassis fan has a 3-pin connector.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
