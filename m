From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: lm_sensors 2.8, linux 2.4.22, and a tyan tiger mpx (s2466n-4m)
Message-Id: <3F5B634D.59867BA6@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1062646002.1248.7.camel@mycrondo.mycronite>
In-Reply-To: <1062646002.1248.7.camel@mycrondo.mycronite>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

try loading the w83627hf and i2c-isa drivers first
(to access the 627 HF using the ISA bus), then load
the w83781d driver.


Andrew Pilley wrote:
> 
> Hi,
> 
> i just recently moved to linux 2.4.22, since the XFS patch from sgi has
> been released, and i've noticed a problem that seems to have been
> introduced into the i2c patches available from:
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
> 
> The patches work, in that they do compile, but i can't get the w83781d
> driver to actually activate both of the sensor chips, I'm only getting
> half the readings:
> namely, the one labelled
> 
> w83627hf-i2c-0-2c
> Adapter: SMBus AMD75x adapter at 80e0
> 
> shows up, but the other one (starts with "w83782d-*", forget the full
> string), does not.
> 
> i'm using the sensors.conf provided by tyan on their website, which was
> working fine when i was using 2.4.21-xfs. I've tried it both with and
> without the options tyan ask you to add into modules.conf, and i'm not
> sure what else to try.
> 
> Can you offer any suggestions as to things i can use to track down the
> source of the problem?
> 
> Thanks
> 
> Andrew 'ashridah' Pilley
> 
> --
> I hereby pose this question for analysis.
> Are Microsoft users smarter than hamsters?
> *Bluescreen* Reboot *Bluescreen* Reboot *Bluescreen* Reboot
> Hamsters 1, Users 0.
