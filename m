From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: the lm_sensors-script
Message-Id: <20020904181542.B16408@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020904134728.U16408@Stimpy.netroedge.com>
In-Reply-To: <20020904134728.U16408@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Let's see, on my redhat 7.3 computer I see this:

[root@drtheopolis phil]# rpm -qf /etc/init.d/functions
initscripts-6.67-1

Our lm_sensors.init may require a recient RH7.x distro to work (it
orginally came from Redhat).  Not a problem though, as you can install
and use Lm-sensors on virtually any Linux machine by following the
installation instructions in our package.

Good luck!


Phil

On Thu, Sep 05, 2002 at 02:26:15AM +0200, Christian Eyrich wrote:
> phil@netroedge.com wrote:
> > I'm not familiar with the /etc/init.d/funcitons file nor the 
> > dependancy of our project on it?
> 
> Okay and who knows about it?
> The lm_sensors.init is a script contained in the lm_sensors package from
> the project page.
> 
> Christian

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
