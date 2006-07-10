From: mcbrides9@comcast.net (Jerry McBride)
Date: Mon, 10 Jul 2006 12:19:09 +0000
Subject: [lm-sensors] #2090: Request for support of winbon pc87591
Message-Id: <200607100819.09698.mcbrides9@comcast.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sunday 09 July 2006 15:38, lm-sensors wrote:
> #2090: Request for support of winbon pc87591 chipset
> ----------------------------------+----------------------------------------
>- Reporter:  mcbrides9 at comcast.net  |        Owner:  somebody
>     Type:  enhancement            |       Status:  closed
> Priority:  major                  |    Component:  hardware
>  Version:                         |   Resolution:  wontfix
> Keywords:                         |
> ----------------------------------+----------------------------------------
>- Changes (by ruik):
>
>   * status:  new => closed
>   * resolution:  => wontfix
>
> Comment:
>
>  Hello,
>
>  Well bad news for you. We found out that we cannot support the chip. The
>  sensors are connected to the embedded controller, but the interface to
>  host CPU of sensors is not standtized - it depends of embedded cotroller
>  programming.
>
>  I would suggest to use ACPI module called "thermal"
>  modprobe thermal
>  acpi -V
>
>  Those command should show you the CPU temp.
>  I hope it helps,
>
>  Regards
>  Rudolf

Yep. I dug around and pretty much found the same thing. I was hoping that 
someone  on lm-sensors knew how to program the controller...

Thank you, for your time

Jerry


