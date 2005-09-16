From: david.goodenough@btconnect.com (David Goodenough)
Date: Fri, 16 Sep 2005 15:39:04 +0000
Subject: [lm-sensors] sensord and RAM SPD
Message-Id: <200509161438.14352.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050916094258.GA26164@bode.aurel32.net>
In-Reply-To: <20050916094258.GA26164@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 16 September 2005 11:05, Jean Delvare wrote:
> Hi Aurelien,
>
> [Aurelien Jarno]
>
> > > I'd prefer that we plain drop eeprom support from sensord.
> >
> > That's also fine with me. Do you want a patch for that?
>
> Yes please :)
>
> --
> Jean Delvare

One little comment, while eeprom support may not really be a
sensor, it is a almost always there and when someone says that
they can not get sensors working if eeprom works then at least
the basics are working properly, its just a matter of finding the
right chip for sensing (and in many economy boards there are
none).  I think it is useful in initial setup and if it causes no 
problems it should be retained for that reason alone.

David
