From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 17 Apr 2012 16:09:55 +0000
Subject: Re: [lm-sensors] Need support IBM x3650
Message-Id: <20120417160955.GF14942@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F8C109C.3070604@gmail.com>
In-Reply-To: <4F8C109C.3070604@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 16, 2012 at 02:43:19PM +0200, Jean Delvare wrote:
> On Mon, 16 Apr 2012 19:29:16 +0700, Quang Minh wrote:
> > Hi all,
> > 
> > I have a server IBM x3650 run CentOS. I want check temperature of server.
> > I tried install lm_sensor, run sensors-detect then got error
> >          Sorry, no sensors were detected.
> >          Either your sensors are not supported, or they are connected to an
> >          I2C or SMBus adapter that is not supported. See doc/FAQ,
> >          doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
> >          (FAQ #4.24.3) for further information.
> >          If you find out what chips are on your board, check
> >          http://www.lm-sensors.org/wiki/Devices for driver status.
> > 
> > Can you help me?
> 
> Not if you don't provide additional information:
> * Which kernel are you running?
> * Which version of lm-sensors?
> 
> Please also provide the full output of sensors-detect.
> 
> That being said, on high end servers monitoring is frequently done by
> IPMI, which lm-sensors doesn't support, so the is a chance that
> lm-sensors just won't work on this machine.

That is the case for a x3650.  Please use IPMI to monitor sensors.

--D
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
