From: Mike Dixon <qualitydixon@gmail.com>
Date: Fri, 06 Jun 2014 17:46:53 +0000
Subject: Re: [lm-sensors] Driver for PC87372
Message-Id: <CAGTLibrfggzqa3-o_ZKHdTwBaWy4-Lp-=MJ03rZmARzCusuHhQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADxL3QmF1q5wmSX=YCCTUc_BREXp2F4khHKdZPTPPuXFUtjLcg@mail.gmail.com>
In-Reply-To: <CADxL3QmF1q5wmSX=YCCTUc_BREXp2F4khHKdZPTPPuXFUtjLcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean, Guenter,

Thanks for the feedback. Some more information on my setup: I am running
CentOS 6.4 / lm_sensors 3.1.1 / sensors detect 1.1. It looks like
sensors-detect does probe the SMBus by default but in my case did not find
an LM85 compatible chip. However, I manually loaded the lm85 kernel module
and that got it working.  So I think I should be able to modify
/etc/sysconfig/lm_sensors to automatically load the lm85 module on bootup?
Also it does return temperatures, fan speeds, voltages, etc.


On Fri, Jun 6, 2014 at 2:36 AM, Jean Delvare <jdelvare@suse.de> wrote:

> On Fri, 6 Jun 2014 00:51:40 -0700, Guenter Roeck wrote:
> > On Fri, Jun 06, 2014 at 09:23:26AM +0200, Jean Delvare wrote:
> > > > Even with a board, I for my part would not have time for writing a
> driver.
> > > > Given the age of the chip, my expectations for finding someone to
> write
> > > > a driver would be quite low. Any chance doing it yourself ?
> > >
> > > Well, before anyone spends time writing a driver, Michael should ensure
> > > that such a driver is really needed. All previous investigations of
> > > PC87372 user cases came to the conclusion that this chip was not used
> > > for monitoring, and instead a dedicated monitoring chip was connected
> > > to the SMBus.
> > >
> > If I remember correctly, the chip only supports fan control, not any
> voltage
> > or temperature monitoring, so that separate chip would be needed anyway.
>
> Ah, right. It's odd then, sensors-detect should have probed the SMBus
> already. Unless Michael explicitly refused that, or is using an old
> version of the script maybe.
>
> --
> Jean Delvare
> SUSE L3 Support
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>



-- 
Mike Dixon
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
