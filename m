From: Timothy Normand Miller <theosib@gmail.com>
Date: Fri, 08 May 2009 02:35:59 +0000
Subject: Re: [lm-sensors] Reboot Problem fancontrol no longer works
Message-Id: <9871ee5f0905071935t5d4ec235s45bc559f29e68765@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2e1931630905071038y63dc19e0ubc289992b93d6514@mail.gmail.com>
In-Reply-To: <2e1931630905071038y63dc19e0ubc289992b93d6514@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/7/09, Julian Gagnon <nongag@googlemail.com> wrote:
> Hi,
>
> I recently put a computer together.  My Mainboard is a Asus P5Q-Pro.  I'm
> loading the module  w83627ehf force_id=0x8860 to be able to read the sensors
> output. I have the stable version from your webpage.  Sudo sensors works,
> and sudo pwmconfig works as well to control my fan speeds.  Unfortunately,
> after a reboot fancontrol no longer works.  Sensors still gives out the
> proper output, only when I start fancontrol, it looks like it's working,
> just the fans don't spin down.  I don't know why.  I know my cpu core temp
> is below the minimum value, and it should just throttle the fan down.  Just
> thought you might be interested.

Sorry.  I don't know the etiquette for this mailing list.

Anyhow, there's a startup program called, I think,
"/etc/init.d/fancontrol".  You need to make sure that this gets run on
boot.  What distro are you using?

-- 
Timothy Normand Miller
http://www.cse.ohio-state.edu/~millerti
Open Graphics Project

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
