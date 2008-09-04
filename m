From: kalhan trisal <kalhantrisal@yahoo.com>
Date: Thu, 04 Sep 2008 06:54:09 +0000
Subject: Re: [lm-sensors] need info about sysfs for sensors
Message-Id: <70270.75041.qm@web95204.mail.in2.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 
 I wanted to know how should my sensors be places as my sensors driver takes care of all the sensor devices on the platform.I don't find any class as sensors->accelerometer/gyrometer/ambient light/compass.Is there any existing frame work where I can register my driver and use the interface. 
   If I use Hwmon then my devices are not connected to I2C directly. Can I get some help.

Thanks 
Kalhan  



--- On Tue, 2/9/08, Greg KH <greg@kroah.com> wrote:

> From: Greg KH <greg@kroah.com>
> Subject: Re: need info about sysfs for sensors
> To: "kalhan trisal" <kalhantrisal@yahoo.com>
> Date: Tuesday, 2 September, 2008, 11:53 PM
> On Tue, Sep 02, 2008 at 11:37:39PM +0530, kalhan trisal
> wrote:
> > Hi 
> >   I am new to open source community and the kind of
> work i am doing is related to sensors. 
> >   I have accelerometer/gyrometer/Ambient light
> sensors/thermal/compass some are connected to 12c bussoem are connected > to ADC controller with propritry interface to read and write.
> > If I go to Linux community and define my own class
> then it would be
> > difficult to convince them. Same time  I don't see
> any  class defined
> > for  sensors/accelerometer0 or gyrometer0 where people
> can use
> > existing frame work and write there. 
> 
> Have you brought this up on the hwmon mailing list?  That
> would be the
> proper place for this kind of discussion.
> 
> thanks,
> 
> greg k-h


      Did you know? You can CHAT without downloading messenger. Go to http://in.webmessenger.yahoo.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
