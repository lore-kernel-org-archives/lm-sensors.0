From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Thu, 17 Nov 2005 11:03:15 +0000
Subject: [lm-sensors] [RFC] adding back i2c_get_clients
Message-Id: <20051117110226.4493334f@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051117003330.21bfff26@inspiron>
In-Reply-To: <20051117003330.21bfff26@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 16 Nov 2005 23:40:54 -0800
Greg KH <greg@kroah.com> wrote:

> On Thu, Nov 17, 2005 at 12:33:30AM +0100, Alessandro Zummo wrote:
> > 
> >  Hello,
> > 
> >   I'd like to restart a topic that was discussed before, regarding the infrastructure
> >  required to send a command/ioctl directly to an i2c client.
> 
> No, we don't want to allow new ioctls to be created/used.  Please use
> other methods for this.

 You either send a command or an ioctl. To me, it doesn't really matter what
 I'm sending, as long as:

 a) I have a way to send a command directly to my device driver
 b) my device driver will not receive a command it is not supposed to receive, not
 like the i2c_clients_command is currently doing. ioctls would help here.

 Also, I don't want to create new ioctls, just to use existing ones. All
 the media drivers are currently using ioctls.

> >   The topic was discussed in [1] and [2] more than one year ago. This missing
> >  functionality led to all sort of tricks in both i2c rtc drivers and media drivers.
> 
> What exactly is the problem you are trying to solve?

 a) I would like to send specific commands to my driver without having
 to export a function to do that.

 b) I want to have drivers of the same class to respond to a common command
 subset, so that, for example, every i2c driver which is compatible
 with I2C_CLASS_RTC could be used in the same way from the higher layers.

 c) trying to understand and document the way i2c_driver->command should
 be used/abused.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

