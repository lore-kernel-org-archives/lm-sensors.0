From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: RH 7.3 /etc/rc.d/init.d/sensors
Message-Id: <3D167B20.FD5A45A@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200206220315.11079.mike808@users.sourceforge.net>
In-Reply-To: <200206220315.11079.mike808@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I think that's a great idea to make things easier for redhat people.
You called them both sensors, I guess the second one is really
sensors.init?

I'm not a Redhat expert, perhaps you could write a short "README" for us
giving a brief description of what these do, and how to install and
configure them?
Where should we put them - prog/init? We already have something called
sensors there, though, and you're sending 2 more - help :)

Also please verify they're GPL.

thanks
mds


mike808 wrote:
> 
> I've integrated 'sensors' into my RH 7.3 startups in /etc/rc.d/init.d.
> 
> I'm attaching my current sensors script and the related
> /etc/sysconfig/sensors.
> 
> I've got a Asus K7M (Athlon/650) motherboard.
> sensors-detect picks up a w83782d (loads the w83781d driver and a via686a.
> However, the via doesn't ever display anything.
> 
> It's also picking up my monitor with the DDCMON driver (which is kind of neat)
> because I have a Matrox G400-TV video card.
> 
> Also, lots of your links are broken (link rot) or they do not point to the
> "real" www2 server URL.
> 
> Mike808/
> --
> () Join the ASCII ribbon campaign against HTML email and Microsoft-specific
> /\ attachments. If I wanted to read HTML, I would have visited your website!
> Support open standards.
> 
> 
>               Name: sensors
>    sensors    Type: Plain Text (text/plain)
>           Encoding: 7bit
> 
>               Name: sensors
>    sensors    Type: application/x-shellscript
>           Encoding: 7bit
