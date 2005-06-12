From: clock@twibright.com (Karel Kulhavy)
Date: Sun, 12 Jun 2005 17:50:31 +0000
Subject: [lm-sensors] driver for Twibright I2C2P parallel port adapter
Message-Id: <20050612154940.GB8636@kestrel>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050611114914.GA24384@kestrel>
In-Reply-To: <20050611114914.GA24384@kestrel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 12, 2005 at 12:50:02PM +0200, Jean Delvare wrote:
> Hi Karel,
> 
> > After sending to Jean Delvare, maintainer written in i2c-parports.c,
> > I was told to rewrite it. I rewrote the following:
> > 1) As the device needs three distinctive outs to initialize, the
> >    initializataion was rewritten from .init, .init2 and .init3 to
> >    more general zero-terminated list.
> 
> Looks good. Maybe we can even initialize them inside adapter_parm rather
> than outside. I just posted a query to LKML, we'll see what they say.
> 
> > 2) make menuconfig [Help] was improved
> 
> I think you are misusing this place. There are three places where help
> can be added:
> * configuration menu
> * module info
> * documentation file (Documentation/i2c/busses/i2c-parport)

Should I change it and resend?

CL<
